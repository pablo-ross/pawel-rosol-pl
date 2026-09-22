#!/usr/bin/env ruby
#
# Set `last_modified_at` from git on every document with more than one commit:
# posts (BlogPosting.dateModified, the "Aktualizacja" line) and the _tabs
# pages (ProfilePage.dateModified on /about/). `:documents` covers both
# collections; the theme's sidebar "Ostatnia aktualizacja" panel still reads
# posts only.

Jekyll::Hooks.register :documents, :post_init do |doc|

  commit_num = `git rev-list --count HEAD "#{ doc.path }"`

  if commit_num.to_i > 1
    lastmod_date = `git log -1 --pretty="%ad" --date=iso "#{ doc.path }"`
    doc.data['last_modified_at'] = lastmod_date
  end

end
