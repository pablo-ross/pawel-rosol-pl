#!/usr/bin/env ruby
# frozen_string_literal: true

# Validate the JSON-LD in a built site.
#
# Liquid-templated JSON fails silently: one stray quote in a post title and the
# block stops parsing, with nothing in the build log and nothing html-proofer
# looks at. This script is run from tools/test.sh after the production build.
#
# Checks, per page:
#   1. every <script type="application/ld+json"> block parses as JSON;
#   2. no @id defined twice on one page, and at most one BlogPosting (two would
#      mean the jekyll-seo-tag strip plugin stopped matching). A node counts as
#      a definition only if it carries a @type; bare {"@id": ...} stubs are
#      references and are expected to repeat;
#   3. every BreadcrumbList / ItemList "item"/"url" under site.url resolves to
#      a file that actually exists in the built site.
#
# Usage: ruby tools/check-jsonld.rb [site_dir] [site_url]

require "json"
require "cgi"

SITE_DIR = ARGV[0] || "_site"
SITE_URL = (ARGV[1] || begin
  line = File.read("_config.yml").lines.find { |l| l.start_with?("url:") }
  line.to_s.split(":", 2).last.to_s.strip.delete('"\'')
end).chomp("/")

abort "#{SITE_DIR}: not a directory" unless Dir.exist?(SITE_DIR)
abort "could not determine site url" if SITE_URL.empty?

BLOCK = %r{<script[^>]+type="application/ld\+json"[^>]*>(.*?)</script>}m.freeze

errors = []
pages = 0
blocks = 0

# Does an absolute site URL correspond to something in the built output?
# `absolute_url` percent-encodes non-ASCII path segments (Polish category and
# tag slugs); the directories on disk are literal UTF-8, so decode first.
def resolves?(url)
  path = CGI.unescape(url.sub(SITE_URL, "")).split("#").first.split("?").first
  path = "/" if path.nil? || path.empty?
  candidates = [
    File.join(SITE_DIR, path),
    File.join(SITE_DIR, path, "index.html"),
    File.join(SITE_DIR, "#{path.chomp('/')}.html")
  ]
  candidates.any? { |c| File.file?(c) }
end

# Walk a parsed node tree, yielding every Hash.
def each_node(obj, &block)
  case obj
  when Hash
    block.call(obj)
    obj.each_value { |v| each_node(v, &block) }
  when Array
    obj.each { |v| each_node(v, &block) }
  end
end

Dir.glob(File.join(SITE_DIR, "**", "*.html")).sort.each do |file|
  html = File.read(file)
  found = html.scan(BLOCK).flatten
  next if found.empty?

  pages += 1
  rel = file.sub(%r{\A#{Regexp.escape(SITE_DIR)}/?}, "")
  ids = []
  types = Hash.new(0)

  found.each do |raw|
    blocks += 1
    begin
      parsed = JSON.parse(raw)
    rescue JSON::ParserError => e
      errors << "#{rel}: JSON-LD does not parse — #{e.message.lines.first.strip}"
      next
    end

    each_node(parsed) do |node|
      ids << node["@id"] if node["@id"] && node["@type"]
      Array(node["@type"]).each { |t| types[t] += 1 }

      %w[item url].each do |key|
        value = node[key]
        next unless value.is_a?(String) && value.start_with?(SITE_URL)
        next if resolves?(value)

        errors << "#{rel}: #{node['@type']} \"#{key}\" points at a URL that is " \
                  "not in the build — #{value}"
      end
    end
  end

  dupes = ids.tally.select { |_, n| n > 1 }.keys
  errors << "#{rel}: @id defined more than once — #{dupes.join(', ')}" unless dupes.empty?

  if types["BlogPosting"] > 1
    errors << "#{rel}: #{types['BlogPosting']} BlogPosting nodes — the " \
              "jekyll-seo-tag strip plugin (_plugins/strip-seo-tag-jsonld.rb) " \
              "is probably no longer matching"
  end
end

if errors.empty?
  puts "JSON-LD OK — #{blocks} block(s) on #{pages} page(s)."
  exit 0
end

warn "JSON-LD check failed:"
errors.each { |e| warn "  - #{e}" }
exit 1
