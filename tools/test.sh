#!/usr/bin/env bash
#
# Build and test the site content
#
# Requirement: html-proofer, jekyll, ruby (see docs/og-cards.md for the
# Open Graph card generator, which additionally needs headless Chrome)
#
# Usage: See help information

set -eu

SITE_DIR="_site"

_config="_config.yml"

_baseurl=""

help() {
  echo "Build and test the site content"
  echo
  echo "Usage:"
  echo
  echo "   bash $0 [options]"
  echo
  echo "Options:"
  echo '     -c, --config   "<config_a[,config_b[...]]>"    Specify config file(s)'
  echo "     -h, --help               Print this information."
}

read_baseurl() {
  if [[ $_config == *","* ]]; then
    # multiple config
    IFS=","
    read -ra config_array <<<"$_config"

    # reverse loop the config files
    for ((i = ${#config_array[@]} - 1; i >= 0; i--)); do
      _tmp_baseurl="$(grep '^baseurl:' "${config_array[i]}" | sed "s/.*: *//;s/['\"]//g;s/#.*//")"

      if [[ -n $_tmp_baseurl ]]; then
        _baseurl="$_tmp_baseurl"
        break
      fi
    done

  else
    # single config
    _baseurl="$(grep '^baseurl:' "$_config" | sed "s/.*: *//;s/['\"]//g;s/#.*//")"
  fi
}

main() {
  # clean up
  if [[ -d $SITE_DIR ]]; then
    rm -rf "$SITE_DIR"
  fi

  read_baseurl

  # The mechanical part of .claude/skills/humanizer/SKILL.md: dashes in prose,
  # question headings without "?", an H1 in a body, chatbot residue. Runs
  # before the build because it needs no build and fails in a second.
  ruby tools/check-prose.rb

  # build
  JEKYLL_ENV=production bundle exec jekyll b \
    -d "$SITE_DIR$_baseurl" -c "$_config"

  # Open Graph cards are committed, not built by Jekyll: a post whose title
  # changed would keep shipping a card with the old title on it.
  if ! ruby tools/og-cards.rb --check; then
    echo "ERROR: the Open Graph cards above are stale, missing or orphaned —" >&2
    echo "       run 'ruby tools/og-cards.rb' and commit media/og/" >&2
    exit 1
  fi

  # test
  bundle exec htmlproofer "$SITE_DIR" \
    --disable-external \
    --ignore-urls "/^http:\/\/127.0.0.1/,/^http:\/\/0.0.0.0/,/^http:\/\/localhost/"

  # structured data — html-proofer does not look inside JSON-LD
  ruby tools/check-jsonld.rb "$SITE_DIR"

  # the CSP in .htaccess allows one inline script by hash; a theme upgrade that
  # changes that script would break it silently in the browser
  ruby tools/check-csp.rb "$SITE_DIR" .htaccess

  # A post opting into math or mermaid while _config.yml still excludes the
  # self-hosted library would 404 the script with nothing in the build log.
  for _lib in mathjax mermaid; do
    _key="$_lib"
    [[ $_lib == mathjax ]] && _key="math"
    if grep -qE "^ *- *assets/lib/$_lib *$" "$_config" 2>/dev/null &&
      grep -rlE "^$_key: *true" _posts _tabs 2>/dev/null | grep -q .; then
      echo "ERROR: a document sets '$_key: true' but _config.yml excludes" >&2
      echo "       assets/lib/$_lib — remove that exclude line" >&2
      exit 1
    fi
  done

  # A tab whose lower-cased title is missing from _data/locales/*.yml `tabs:`
  # renders as "<title> | Site name". The theme's head.html has no fallback.
  if grep -rlE '<title>[[:space:]]*\|' "$SITE_DIR" --include='*.html'; then
    echo "ERROR: the pages above ship an empty <title>" >&2
    exit 1
  fi
}

while (($#)); do
  opt="$1"
  case $opt in
  -c | --config)
    _config="$2"
    shift
    shift
    ;;
  -h | --help)
    help
    exit 0
    ;;
  *)
    # unknown option
    help
    exit 1
    ;;
  esac
done

main
