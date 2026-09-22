# Open Graph preview cards

What a link to this site looks like when it is pasted into Facebook, LinkedIn,
X, Slack or Signal, how those images are produced, and what to do when one is
wrong.

## The problem this replaced

Chirpy's `head.html` resolves the social preview image from exactly two places:
`page.image` in a post's front matter, and `social_preview_image` in
`_config.yml`. No post here sets `image:`, so every page on the site shared the
same picture - `/media/commons/avatar.jpg`, the 400x400 avatar. Pasted into
Facebook, a 1:1 image in a 1.91:1 slot gets centre-cropped, which turned every
link to the blog into a close-up of a pair of eyes with no title, no date and
no indication of which post it was.

## What happens now

`media/og/<slug>.png` is a 1200x630 card per post, plus `media/og/site.png` for
the home page and every other page. Each card carries the post's category, its
title, the date, the avatar and the domain, set in the site's own fonts and
colours.

Three pieces:

| File | Role |
|---|---|
| `tools/og-card.html` | the card itself: one HTML page, styled with the site's colours and the Source Sans Pro files from `assets/lib` |
| `tools/og-cards.rb` | reads the front matter of every post, fills the template, screenshots it with headless Chrome, writes `media/og/*.png` |
| `_plugins/og-card-hook.rb` | points `og:image` and `twitter:image` at the card at build time |

The PNGs are **committed to the repository**. `jekyll build`, `tools/test.sh`
and a deploy therefore need nothing beyond the usual gems; only *regenerating*
a card needs Chrome.

## Regenerating

```bash
ruby tools/og-cards.rb              # build the cards that are missing or stale
ruby tools/og-cards.rb --check      # list them and exit 1, build nothing
ruby tools/og-cards.rb --force      # rebuild every card
ruby tools/og-cards.rb --only <slug>
```

Then commit `media/og/` together with `tools/og-cards.digest`.

A card is considered stale when the post's title, category or date changed,
when `tools/og-card.html` changed, or when the avatar changed - the digest file
records a hash of all of those per card, so editing one post's title rebuilds
one card rather than all 36.

`tools/test.sh` runs `--check` and fails the build on a stale, missing or
orphaned card, so a renamed post cannot ship a card with the old title on it.
`.production.sh` runs the same check before it builds and, if Chrome is
available, rebuilds the stale cards for you.

### Requirements

Ruby (the one in `.ruby-version`) and a Chrome or Chromium binary. The script
looks for `google-chrome`, `google-chrome-stable`, `chromium` and
`chromium-browser` in that order; `CHROME=/path/to/chrome` overrides it.

```bash
sudo apt install chromium     # Debian/Ubuntu
```

No ImageMagick, no `ruby-vips`, no Node. The fonts come from `assets/lib`, the
self-hosted assets submodule, so the machine needs no fonts installed either -
but a checkout without `git submodule update --init --recursive` renders the
cards in a fallback font.

## Editing the design

`tools/og-card.html` is an ordinary web page at 1200x630 - open it in a browser
to iterate, with the `{{ROOT}}`, `{{KICKER}}`, `{{TITLE}}` and `{{DATE}}`
placeholders replaced by hand. The small script at the bottom shrinks the title
from 66px in 2px steps until it fits above the footer, which is what keeps a
113-character title (the longest on the site) on the card without clipping.

The strings baked into the template - the name, the role line and the domain -
are Polish on purpose: they are rendered into an image that readers see, so the
site's language rule applies to them rather than the one for `tools/`.

After any edit, `ruby tools/og-cards.rb --force` and commit the lot; the
template's own hash is part of every card's digest, so `--check` will flag them
all until you do.

## How the tags get set

Setting `page.image` would have been the obvious route, and it is wrong here:
Chirpy also renders `page.image` as a banner at the top of the post and as a
thumbnail in the post list, and a banner that repeats the title printed on it
is not something to publish 36 times.

So `_plugins/og-card-hook.rb` leaves the page body alone and rewrites the
rendered meta tags instead. For each document it looks for a card
(`media/og/<slug>.png` for posts, `media/og/site.png` for everything else) and,
if one exists:

- replaces the `og:image` and `twitter:image` URLs emitted by `head.html`;
- adds `og:image:width`, `og:image:height`, `og:image:alt` and
  `twitter:image:alt` - the dimensions let Facebook lay the card out before it
  has fetched the file, and the alt text is what a screen reader announces;
- exposes `page.og_card` to Liquid, which `_includes/metadata-hook.html` uses
  as `BlogPosting.image` when the post has no `image:` of its own. Google's
  Article documentation asks for an image at least 1200px wide, and until now
  the node had none.

`twitter:card` is already `summary_large_image`, set by `head.html`; nothing
here changes it.

A document with no card keeps the site-wide default, which is what a checkout
that never ran the generator falls back to.

## Checking a card before it is live

Social networks cache aggressively, and they fetch the *live* URL - there is
nothing to preview until the post is deployed. Locally, open the generated PNG.
After deploying:

- Facebook: <https://developers.facebook.com/tools/debug/> - "Scrape Again"
  clears their cache
- LinkedIn: <https://www.linkedin.com/post-inspector/>
- X: the card is read from the `twitter:*` tags; X dropped its own validator

## If a post still shares the avatar

In order:

1. `ls media/og/<slug>.png` - the generator skips a post whose front matter it
   cannot parse, and says so on stderr.
2. Check the slug. The card file is named after the post's filename minus the
   date, which is also what `permalink: /posts/:title/` uses.
3. `grep 'og:image' _site/posts/<slug>/index.html` - if it still points at
   `avatar.jpg`, the plugin found no card file for that document.
4. If the tag is right and the network is wrong, it is their cache; re-scrape
   with the debuggers above.
