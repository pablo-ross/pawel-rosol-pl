# frozen_string_literal: true

# Remove the JSON-LD block emitted by jekyll-seo-tag.
#
# `_includes/metadata-hook.html` is the single source of structured data for
# this site. Without this hook every post would carry two BlogPosting nodes for
# the same URL — a thin one from the gem and the rich one from the hook — which
# share no @id, and the tab pages would carry a BlogPosting node with the build
# time as `datePublished`.
#
# The two are told apart by their formatting, which is stable because each is
# produced by a template we can see:
#   * jekyll-seo-tag minifies: {"@context":"https://schema.org","@type":...
#   * metadata-hook.html pretty-prints, with a space after every colon.
# The regex below therefore only matches the minified form. If a theme upgrade
# ever changes that, tools/check-jsonld.rb fails the build on the duplicate
# BlogPosting rather than letting it ship silently.
#
# Everything else jekyll-seo-tag produces — <title>, canonical, Open Graph and
# Twitter card tags — is untouched.

SEO_TAG_JSONLD = %r{
  <script\s+type="application/ld\+json">\s*
  \{"@context":"https://schema\.org".*?
  </script>
}mx.freeze

Jekyll::Hooks.register %i[pages documents], :post_render do |doc|
  next unless doc.output_ext == ".html"

  doc.output = doc.output.gsub(SEO_TAG_JSONLD, "")
end
