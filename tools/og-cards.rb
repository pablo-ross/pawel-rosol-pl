#!/usr/bin/env ruby
# frozen_string_literal: true

# Render the Open Graph preview cards under media/og/.
#
# Social networks fetch og:image from the published HTML; without a per-post
# image every post shares the 400x400 avatar, which Facebook and LinkedIn crop
# into a close-up of a pair of eyes with no title on it. This script renders
# tools/og-card.html - the site's own fonts, colours and avatar - once per post
# and once for the site as a whole, through headless Chrome.
#
# The PNGs are committed, so neither `jekyll build` nor .production.sh depends
# on Chrome being installed; only regenerating them does. A card is rebuilt
# when the post's title, category or date changes, when the template changes,
# or with --force. tools/og-cards.digest records what each card was built from.
#
# Usage:
#   ruby tools/og-cards.rb            # build the cards that are missing or stale
#   ruby tools/og-cards.rb --check    # list them and exit 1, build nothing
#   ruby tools/og-cards.rb --force    # rebuild every card
#   ruby tools/og-cards.rb --only <slug>

require "date"
require "digest"
require "fileutils"
require "yaml"

ROOT = File.expand_path("..", __dir__)
TEMPLATE = File.join(ROOT, "tools", "og-card.html")
DIGEST_FILE = File.join(ROOT, "tools", "og-cards.digest")
OUT_DIR = File.join(ROOT, "media", "og")
AVATAR = File.join(ROOT, "media", "commons", "avatar.jpg")

CHROME = ENV.fetch("CHROME", nil) ||
         %w[google-chrome google-chrome-stable chromium chromium-browser].find do |bin|
           system("command -v #{bin} >/dev/null 2>&1")
         end

MONTHS = %w[
  stycznia lutego marca kwietnia maja czerwca
  lipca sierpnia września października listopada grudnia
].freeze

# The site-wide card, used on the home page, the tabs and anything else that is
# not a post. Its text is the tagline from _config.yml.
SITE_CARD = {
  slug: "site",
  kicker: "Blog",
  title: "RODO, ochrona danych osobowych i cyberbezpieczeństwo w praktyce",
  date: ""
}.freeze

def escape(text)
  text.to_s
      .gsub("&", "&amp;")
      .gsub("<", "&lt;")
      .gsub(">", "&gt;")
end

def polish_date(value)
  date = value.respond_to?(:month) ? value : Date.parse(value.to_s)
  "#{date.day} #{MONTHS[date.month - 1]} #{date.year}"
rescue StandardError
  ""
end

def front_matter(path)
  raw = File.read(path)
  return nil unless raw.start_with?("---")

  yaml = raw.split(/^---\s*$/, 3)[1]
  YAML.safe_load(yaml, permitted_classes: [Date, Time], aliases: true)
rescue StandardError => e
  warn "WARNING: cannot parse the front matter of #{path}: #{e.message}"
  nil
end

def posts
  Dir[File.join(ROOT, "_posts", "*.md")].sort.filter_map do |path|
    data = front_matter(path)
    next if data.nil? || data["title"].to_s.empty?

    slug = File.basename(path, ".md").sub(/\A\d{4}-\d{2}-\d{2}-/, "")
    {
      slug: slug,
      kicker: Array(data["categories"]).last.to_s,
      title: data["title"].to_s,
      date: polish_date(data["date"])
    }
  end
end

def render(card, template)
  template
    .gsub("{{ROOT}}", "file://#{ROOT}")
    .gsub("{{KICKER}}", escape(card[:kicker]))
    .gsub("{{TITLE}}", escape(card[:title]))
    .gsub("{{DATE}}", escape(card[:date]))
end

def screenshot(html, png)
  require "tmpdir"

  Dir.mktmpdir("og-card") do |dir|
    source = File.join(dir, "card.html")
    File.write(source, html)

    ok = system(
      CHROME,
      "--headless=new",
      "--disable-gpu",
      "--hide-scrollbars",
      "--allow-file-access-from-files",
      "--force-device-scale-factor=1",
      "--virtual-time-budget=4000",
      "--window-size=1200,630",
      "--screenshot=#{png}",
      source,
      out: File::NULL, err: File::NULL
    )
    raise "#{CHROME} failed to render #{File.basename(png)}" unless ok && File.exist?(png)
  end
end

def main
  force = ARGV.include?("--force")
  check = ARGV.include?("--check")
  only = ARGV[ARGV.index("--only") + 1] if ARGV.include?("--only")

  template = File.read(TEMPLATE)
  # The avatar and the template are baked into every card, so a change to
  # either has to invalidate all of them.
  common = Digest::SHA256.hexdigest(template + Digest::SHA256.file(AVATAR).hexdigest)

  digests = File.exist?(DIGEST_FILE) ? YAML.safe_load_file(DIGEST_FILE) || {} : {}
  cards = ([SITE_CARD] + posts).reject { |card| only && card[:slug] != only }

  stale = cards.reject do |card|
    png = File.join(OUT_DIR, "#{card[:slug]}.png")
    !force && File.exist?(png) &&
      digests[card[:slug]] == Digest::SHA256.hexdigest(common + card.values.join("\u0000"))
  end

  if check
    stale.each { |card| puts "stale or missing: media/og/#{card[:slug]}.png" }
    orphans = Dir[File.join(OUT_DIR, "*.png")].map { |f| File.basename(f, ".png") } -
              cards.map { |c| c[:slug] }
    orphans.each { |slug| puts "orphaned: media/og/#{slug}.png" }
    exit((stale.empty? && orphans.empty?) ? 0 : 1)
  end

  if stale.empty?
    puts "og cards: up to date (#{cards.size})"
    return
  end

  raise "no Chrome binary found; set CHROME=/path/to/chrome" if CHROME.nil?

  FileUtils.mkdir_p(OUT_DIR)

  stale.each do |card|
    png = File.join(OUT_DIR, "#{card[:slug]}.png")
    screenshot(render(card, template), png)
    digests[card[:slug]] = Digest::SHA256.hexdigest(common + card.values.join("\u0000"))
    puts "og cards: wrote media/og/#{card[:slug]}.png"
  end

  File.write(DIGEST_FILE, digests.sort.to_h.to_yaml)
  puts "og cards: #{stale.size} written, #{cards.size - stale.size} unchanged"
end

main
