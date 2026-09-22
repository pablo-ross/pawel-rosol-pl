# frozen_string_literal: true

# Point og:image and twitter:image at the per-post preview card.
#
# Chirpy's head.html knows two sources for the social preview image:
# `page.image` and `site.social_preview_image`. The first also renders the
# image as a banner at the top of the post and as a thumbnail in the post list,
# which is wrong for a card that already carries the post's title; the second
# is one image for the whole site - the square avatar, which Facebook and
# LinkedIn crop into a close-up of a pair of eyes.
#
# So the cards are wired in here instead: the rendered meta tags are rewritten
# to the card built by tools/og-cards.rb for this document, and nothing about
# the page body changes. A post with no card in media/og/ keeps the site-wide
# default, which is what happens on a checkout where the cards were never
# regenerated.
#
# `page.og_card` is also exposed to Liquid, where _includes/metadata-hook.html
# reads it as BlogPosting.image.

require "cgi"

module OgCard
  CARD_DIR = "media/og"

  # The same attribute order jekyll-seo-tag and Chirpy's head.html emit.
  OG_IMAGE = %r{<meta property="og:image" content="[^"]*" />}.freeze
  TWITTER_IMAGE = %r{<meta property="twitter:image" content="[^"]*" />}.freeze

  module_function

  # Posts get their own card; everything else shares the site card.
  def slug_for(doc)
    doc.respond_to?(:type) && doc.type == :posts ? doc.data["slug"] : "site"
  end

  def path_for(site, doc)
    slug = slug_for(doc)
    return nil if slug.to_s.empty?
    return nil unless File.exist?(File.join(site.source, CARD_DIR, "#{slug}.png"))

    "/#{CARD_DIR}/#{slug}.png"
  end

  def absolute(site, path)
    "#{site.config["url"]}#{site.config["baseurl"]}#{path}"
  end
end

Jekyll::Hooks.register %i[pages documents], :pre_render do |doc|
  card = OgCard.path_for(doc.site, doc)
  doc.data["og_card"] = card if card
end

Jekyll::Hooks.register %i[pages documents], :post_render do |doc|
  next unless doc.output_ext == ".html"

  card = doc.data["og_card"]
  next if card.nil?

  url = OgCard.absolute(doc.site, card)
  alt = doc.data["title"].to_s

  doc.output = doc.output
                  .sub(OgCard::OG_IMAGE,
                       %(<meta property="og:image" content="#{url}" />) +
                       %(<meta property="og:image:width" content="1200" />) +
                       %(<meta property="og:image:height" content="630" />) +
                       %(<meta property="og:image:alt" content="#{CGI.escapeHTML(alt)}" />))
                  .sub(OgCard::TWITTER_IMAGE,
                       %(<meta property="twitter:image" content="#{url}" />) +
                       %(<meta name="twitter:image:alt" content="#{CGI.escapeHTML(alt)}" />))
end
