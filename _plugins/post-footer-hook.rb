# frozen_string_literal: true

# Append the legal-status stamp and the author box to every post.
#
# Both are single includes rather than blocks pasted into 31 files. They are
# added to `doc.content` in :pre_render, i.e. before Liquid and Markdown run,
# so the output lands inside the post's `.content` element like any other
# paragraph — appending to `doc.output` instead would place it after the
# page footer.
#
# Posts opt out with `post_footer: false` in front matter.

FOOTER = "\n\n{% include legal-status.html %}\n\n{% include author-box.html %}\n"

Jekyll::Hooks.register :posts, :pre_render do |post|
  next if post.data["post_footer"] == false

  post.content += FOOTER
end
