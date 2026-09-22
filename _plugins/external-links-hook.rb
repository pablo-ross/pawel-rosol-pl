# frozen_string_literal: true

# Open external links in a new tab.
#
# Runs in :post_convert, i.e. after Markdown but before the layout, so it only
# ever sees the document's own content — the theme's own chrome (sidebar,
# footer, sharing buttons) already sets `target` where it wants one and is left
# alone. Links that already carry a `target` are skipped, so an inline
# `<a target="_self">` in a post still wins.
#
# `rel` gets `noopener noreferrer` merged in, keeping whatever the link already
# declared (`nofollow` on a link to a source, say).

SITE_HOSTS = ["pawel.rosol.pl"].freeze
ANCHOR_RE = /<a\b([^>]*)>/i
HREF_RE = /\bhref=(["'])(.*?)\1/i
REL_RE = /\brel=(["'])(.*?)\1/i

def external_href?(href)
  uri = URI.parse(href)
  return false unless %w[http https].include?(uri.scheme)

  !SITE_HOSTS.include?(uri.host&.downcase&.delete_prefix("www."))
rescue URI::InvalidURIError
  false
end

Jekyll::Hooks.register %i[documents pages], :post_convert do |doc|
  doc.content = doc.content.gsub(ANCHOR_RE) do |tag|
    attrs = Regexp.last_match(1)
    next tag if attrs =~ /\btarget=/i

    href = attrs[HREF_RE, 2]
    next tag if href.nil? || !external_href?(href)

    rel = (attrs[REL_RE, 2].to_s.split + %w[noopener noreferrer]).uniq.join(" ")
    attrs = attrs.sub(REL_RE, "").rstrip

    %(<a#{attrs} target="_blank" rel="#{rel}">)
  end
end
