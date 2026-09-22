#!/usr/bin/env bash
#
# Build, verify and deploy pawel.rosol.pl to the production server.
#
# The build is the one tools/test.sh produces, so nothing reaches the server
# that has not passed html-proofer and tools/check-jsonld.rb first.
#
# Usage:
#   bash .production.sh              build, verify, deploy
#   bash .production.sh --dry-run    everything except writing to the server
#   bash .production.sh --verbose    list every transferred file
#   bash .production.sh --skip-tests build without html-proofer/JSON-LD checks
#
# Build-time requirements, all checked before anything is built:
#   git, rsync, ssh          - version check and transfer
#   rvm + the .ruby-version  - the Ruby the Gemfile.lock was resolved against
#   bundler + the bundle     - jekyll, the Chirpy gem, html-proofer
#   assets/lib (submodule)   - the self-hosted fonts, styles and scripts
#   a Chrome binary          - only to rebuild stale Open Graph cards,
#                              see docs/og-cards.md

set -euo pipefail

REMOTE="mornel@s64.mydevil.net"
REMOTE_PATH="/home/mornel/domains/pawel.rosol.pl/public_html"
SSH_PORT="22"
SITE_DIR="_site"

# rsync runs with --delete: a truncated build would empty the live site.
# Refuse to deploy anything that does not look like a full build.
MIN_HTML_FILES=50

dry_run=false
verbose=false
skip_tests=false

while (($#)); do
  case "$1" in
  -n | --dry-run) dry_run=true ;;
  -v | --verbose) verbose=true ;;
  --skip-tests) skip_tests=true ;;
  -h | --help)
    sed -n '2,21p' "$0" | sed 's/^# \?//'
    exit 0
    ;;
  *)
    echo "ERROR: unknown option '$1' (try --help)" >&2
    exit 1
    ;;
  esac
  shift
done

cd "$(dirname "$0")"

# Everything the build needs, checked up front: a missing tool half way through
# leaves a partial _site that the next run would happily deploy.
missing=()
for _cmd in git rsync ssh; do
  command -v "$_cmd" >/dev/null 2>&1 || missing+=("$_cmd")
done
if ((${#missing[@]})); then
  echo "ERROR: missing required command(s): ${missing[*]}" >&2
  echo "       install them (Debian/Ubuntu: sudo apt install ${missing[*]}) and re-run" >&2
  exit 1
fi

if [[ ! -f ~/.rvm/scripts/rvm ]]; then
  echo "ERROR: RVM not found at ~/.rvm/scripts/rvm" >&2
  echo "       this script selects the Ruby named in .ruby-version through RVM;" >&2
  echo "       install RVM (https://rvm.io) or build with 'bash tools/test.sh' by hand" >&2
  exit 1
fi

# assets/lib is a git submodule. Without it every stylesheet, font and script
# 404s on the live site, and nothing in the build log says so.
if [[ ! -d assets/lib/fonts ]]; then
  echo "ERROR: assets/lib is empty - the self-hosted assets submodule is not initialised" >&2
  echo "       run: git submodule update --init --recursive" >&2
  exit 1
fi

# The Open Graph cards are committed, so Chrome is only needed when a title,
# a category or the card template changed. Fail here rather than inside the
# build, where the message is easy to miss.
if ! ruby tools/og-cards.rb --check >/dev/null 2>&1; then
  if [[ -z "${CHROME:-}" ]] &&
    ! command -v google-chrome >/dev/null 2>&1 &&
    ! command -v google-chrome-stable >/dev/null 2>&1 &&
    ! command -v chromium >/dev/null 2>&1 &&
    ! command -v chromium-browser >/dev/null 2>&1; then
    echo "ERROR: the Open Graph cards in media/og/ are stale or missing, and no" >&2
    echo "       Chrome binary was found to rebuild them. Install one (Debian/Ubuntu:" >&2
    echo "       sudo apt install chromium) or set CHROME=/path/to/chrome." >&2
    echo "       See docs/og-cards.md." >&2
    exit 1
  fi
  echo "==> Rebuilding stale Open Graph cards..."
  ruby tools/og-cards.rb
  echo "    remember to commit media/og/ and tools/og-cards.digest."
fi

echo "==> Selecting Ruby $(cat .ruby-version)..."
# RVM's own scripts read unset variables, so -u has to come off around them.
set +u
# shellcheck source=/dev/null
source ~/.rvm/scripts/rvm
rvm use "$(cat .ruby-version)"
set -u

echo "==> Checking gem dependencies..."
if ! command -v bundle >/dev/null 2>&1; then
  echo "ERROR: bundler is not installed for this Ruby - run: gem install bundler" >&2
  exit 1
fi
bundle check || bundle install

# Deploying code that is not in git makes a rollback guesswork.
if [[ -n "$(git status --porcelain)" ]]; then
  echo "WARNING: working tree is dirty - deploying uncommitted changes:" >&2
  git status --short >&2
fi
if [[ -n "$(git log --branches --not --remotes --oneline)" ]]; then
  echo "WARNING: local commits are not pushed to origin:" >&2
  git log --branches --not --remotes --oneline >&2
fi

if [[ $skip_tests == true ]]; then
  echo "==> Building (tests skipped)..."
  rm -rf "$SITE_DIR"
  JEKYLL_ENV=production bundle exec jekyll build
else
  echo "==> Building and verifying (jekyll + html-proofer + JSON-LD)..."
  bash tools/test.sh
fi

echo "==> Checking the build looks complete..."
html_count=$(find "$SITE_DIR" -type f -name '*.html' | wc -l)
if [[ ! -f "$SITE_DIR/index.html" ]]; then
  echo "ERROR: $SITE_DIR/index.html is missing - refusing to deploy" >&2
  exit 1
fi
if ((html_count < MIN_HTML_FILES)); then
  echo "ERROR: only $html_count HTML files in $SITE_DIR (expected >= $MIN_HTML_FILES)" >&2
  echo "       refusing to deploy, as --delete would strip the live site" >&2
  exit 1
fi
echo "    $html_count HTML files, index.html present."

echo "==> Setting permissions..."
find "$SITE_DIR" -type d -exec chmod 755 {} +
find "$SITE_DIR" -type f -exec chmod 644 {} +

# --checksum: every rebuild rewrites mtimes, so without it rsync re-sends the
# whole site each time even when nothing changed.
rsync_opts=(-az --checksum --delete --human-readable -e "ssh -p $SSH_PORT")
if [[ $verbose == true ]]; then
  rsync_opts+=(-v)
else
  rsync_opts+=(--info=stats1)
fi
if [[ $dry_run == true ]]; then
  rsync_opts+=(--dry-run --itemize-changes)
  echo "==> DRY RUN - showing what would change on the server..."
else
  echo "==> Deploying to $REMOTE:$REMOTE_PATH..."
fi

rsync "${rsync_opts[@]}" "$SITE_DIR/" "$REMOTE:$REMOTE_PATH"

if [[ $dry_run == true ]]; then
  echo "==> Dry run finished - nothing was written to the server."
else
  echo "==> Production deployment completed successfully!"
fi
