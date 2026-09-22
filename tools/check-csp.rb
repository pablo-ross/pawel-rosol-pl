#!/usr/bin/env ruby
# frozen_string_literal: true

# Check the Content-Security-Policy in .htaccess against what the build loads.
#
# The CSP allows Chirpy's one inline script by sha256 hash rather than by
# 'unsafe-inline'. That is the stronger policy, and it is also the fragile one:
# a theme upgrade that changes a single character of that script leaves a hash
# that no longer matches, the browser silently refuses to run it, and search
# stops working with nothing in the build log. The same goes for a new embed
# pulling in a host the policy does not list.
#
# Checks:
#   1. every inline <script> in the build (excluding application/ld+json, which
#      is data and not executed) has its sha256 hash listed in the policy;
#   2. every host the build loads a script, stylesheet, font, image or iframe
#      from is named in the policy;
#   3. no hash is listed in the policy that nothing in the build uses.
#
# It does not parse CSP grammar or judge whether the policy is strict enough —
# it only catches the policy and the build drifting apart.
#
# Usage: ruby tools/check-csp.rb [site_dir] [htaccess]

require "digest"
require "base64"
require "uri"

SITE_DIR = ARGV[0] || "_site"
HTACCESS = ARGV[1] || ".htaccess"

# The site's own host is covered by 'self', so absolute self-links are not
# external loads and must not be reported as missing from the policy.
SITE_HOST = begin
  line = File.read("_config.yml").lines.find { |l| l.start_with?("url:") }
  URI.parse(line.to_s.split(":", 2).last.to_s.strip.delete('"\'')).host
rescue StandardError
  nil
end

abort "#{SITE_DIR}: not a directory" unless Dir.exist?(SITE_DIR)
abort "#{HTACCESS}: no such file" unless File.exist?(HTACCESS)

policy = File.read(HTACCESS)[/^\s*Header\s+set\s+Content-Security-Policy\s+"(.*)"\s*$/m, 1]
abort "#{HTACCESS}: no `Header set Content-Security-Policy` line" if policy.nil?

# <script ...>body</script>, non-greedy so adjacent blocks do not merge.
SCRIPT = %r{<script\b([^>]*)>(.*?)</script>}m.freeze
LINK   = /<link\b([^>]*)>/.freeze
SRC    = /\bsrc=["']([^"']+)/.freeze
HREF   = /\bhref=["']([^"']+)/.freeze

errors = []
used_hashes = Hash.new(0)
used_hosts = Hash.new { |h, k| h[k] = [] }
pages = 0

def host_of(url)
  u = URI.parse(url)
  u.host
rescue URI::InvalidURIError
  nil
end

Dir.glob(File.join(SITE_DIR, "**", "*.html")).sort.each do |path|
  html = File.read(path, encoding: "UTF-8", invalid: :replace, undef: :replace)
  rel = path.sub(%r{\A#{Regexp.escape(SITE_DIR)}/?}, "")
  pages += 1

  html.scan(SCRIPT) do |attrs, body|
    if (m = attrs[SRC, 1])
      h = host_of(m)
      used_hosts[h] << rel if h
    elsif !attrs.include?("application/ld+json")
      digest = Base64.strict_encode64(Digest::SHA256.digest(body))
      used_hashes["sha256-#{digest}"] += 1
    end
  end

  html.scan(LINK) do |attrs|
    attrs = attrs.first
    next unless (m = attrs[HREF, 1])
    # preconnect/dns-prefetch only open a connection; they fetch nothing.
    next if attrs =~ /rel=["'][^"']*(preconnect|dns-prefetch)/

    h = host_of(m)
    used_hosts[h] << rel if h
  end

  html.scan(/<(?:img|iframe)\b[^>]*/) do |tag|
    next unless (m = tag[SRC, 1])

    h = host_of(m)
    used_hosts[h] << rel if h
  end
end

used_hashes.each do |hash, count|
  next if policy.include?(hash)

  errors << "inline script on #{count} page(s) is not allowed by the policy; " \
            "add '#{hash}' to script-src in #{HTACCESS}"
end

policy.scan(/'sha256-[A-Za-z0-9+\/=]+'/) do |quoted|
  hash = quoted.delete("'")
  next if used_hashes.key?(hash)

  errors << "#{HTACCESS} allows #{hash}, but no inline script in the build " \
            "produces it — stale hash, remove it"
end

used_hosts.each do |host, pages_using|
  next if host == SITE_HOST
  next if policy.include?(host)

  errors << "#{host} is loaded by #{pages_using.length} page(s) " \
            "(e.g. #{pages_using.first}) but is not named in the policy"
end

if errors.empty?
  external = used_hosts.keys.reject { |h| h == SITE_HOST }
  puts "CSP OK — #{used_hashes.length} inline hash(es), " \
       "#{external.length} external host(s) on #{pages} page(s)" \
       "#{external.empty? ? '' : " (#{external.sort.join(', ')})"}."
  exit 0
end

warn "CSP check failed:"
errors.each { |e| warn "  - #{e}" }
exit 1
