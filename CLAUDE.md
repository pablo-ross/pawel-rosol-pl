# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## About this site

Personal blog of Paweł Rosół, who works in two capacities:

- **Inspektor Ochrony Danych (IOD/DPO)** — GDPR/RODO, outsourced DPO engagements;
- **Pełnomocnik ds. cyberbezpieczeństwa** — the KSC act as amended by Dz.U. 2026 poz. 252 (in force 3 April 2026), implementing NIS2.

Both roles must stay visible in identity signals: `tagline` and `description` in `_config.yml`, `Person.jobTitle` / `knowsAbout` in `_includes/metadata-hook.html`, `llms.txt`, `_tabs/about.md` and `_tabs/contact.md`. Posts are written in Polish. Built on the [Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) Jekyll theme (installed as a gem, not forked).

Claims about qualifications, services and credentials must be literally true — this is a DPO's site, and overstated structured data is worse than none. Do not invent service lists, certifications or client types; take them from `_tabs/about.md` or ask.

## First-time setup

```bash
bundle install
git submodule update --init --recursive   # assets/lib — see "Self-hosted assets"
```

## Commands

### Development

```bash
# Serve locally with live reload
bash tools/run.sh
# or directly:
bundle exec jekyll s -l

# Serve in production mode
bash tools/run.sh --production
```

### Build & Test

```bash
# Build for production + html-proofer + JSON-LD check  ← run this before every commit
bash tools/test.sh

# Build only
JEKYLL_ENV=production bundle exec jekyll b

# Structured data only, against an existing build
ruby tools/check-jsonld.rb _site

# Build and deploy to production server via rsync
bash .production.sh
```

## Architecture

### Content structure

- `_posts/` — blog posts, filename format: `YYYY-MM-DD-slug.md`
- `_tabs/` — static pages rendered as sidebar navigation tabs (about, archives, categories, tags, contact)
- `_data/` — user YAML data files: `authors.yml`, `contact.yml`, `media.yml`, `share.yml`, `locales/pl-PL.yml` (all Polish UI strings — see "Tab titles and UI strings")
- `media/` — images and media assets (referenced via `/media/...` paths)
- `assets/img/favicons/` — site-specific favicons
- `docs/aeo-geo-seo-audit.md` — the AEO/GEO/SEO audit and phased action plan; the source of truth for what is done and what is outstanding. `docs/` is excluded from the build.
- `docs/mydevil-hosting.md` — the production host: what mydevil supports, the current panel settings, what `.htaccess` does and how to roll it back.
- `docs/eeat-plan.md` — the E-E-A-T programme (trust page, review dates, citations, identity graph); extends the audit's §5.2 and §11 and lists the owner decisions it is blocked on.

### Front matter for posts

Required fields:

```yaml
---
title: "Post title"
date: 2025-01-01T10:00:00.00Z
categories:
  - Category Name
tags:
  - tag1
  - tag2
description: "SEO description"
---
```

Optional fields:

- `image`, `pin: true` (pin to home), `toc: false` (disable TOC)
- `faq:` — a list of `question:`/`answer:` pairs, rendered by `_includes/post-faq.html` and emitted as `FAQPage` JSON-LD
- `legal: true` — the post makes claims about the law, so it carries a *Stan prawny* stamp
- `legal_status_date: YYYY-MM-DD` — **the day the author last checked this post against the law as it stands.** Nothing sets it automatically and nothing may set it on the author's behalf. Without it, a `legal: true` post shows its publication date plus an explicit "nie był weryfikowany" warning, which is the honest output for a 2020 post about law that has since changed. Stamping a review that did not happen is worse than showing none.
- `sources:` — a list of `name:`/`url:` pairs, primary sources only (ELI, EUR-Lex, UODO decisions and guidance, standards). Rendered as a visible *Źródła* section by `_includes/post-sources.html` and emitted as `BlogPosting.citation`. Take the URL from the post body; do not add a source the post does not actually rely on
- `post_footer: false` — suppress the source list, the author box and *Stan prawny* stamp on this post

`_tabs/*.md` additionally carry `seo: type:` (`ProfilePage`, `ContactPage`, `CollectionPage`). Without it jekyll-seo-tag types them `BlogPosting` with the build time as `datePublished`.

`zasady.md` at the repo root is `/zasady/` (*Zasady publikacji*): who writes, sources, AI use, what the *Stan prawny* stamp means, corrections, the not-legal-advice line. It is not a sidebar tab. `metadata-hook.html` points `publishingPrinciples` (Blog, BlogPosting) and `correctionsPolicy` (ProfessionalService) at it, and `check-jsonld.rb` fails the build if the URL stops resolving. The AI-use paragraph on that page is a factual claim about how the site is made; keep it true.

### Writing and editing content — use the `humanizer` skill

**Invoke the project-local `humanizer` skill (`.claude/skills/humanizer/SKILL.md`) whenever you write or edit prose in `_posts/`, `_tabs/`, `llms.txt`, or a post's `description:` / `faq:` values — and always before committing a new or rewritten post.** Posts are in Polish and the author is a practising DPO; text that reads as machine-written undermines the site's whole premise, and a plausible-sounding but wrong article number is worse than no post at all.

The skill is adapted from [blader/humanizer](https://github.com/blader/humanizer) (MIT) for this repo: Polish-language tells, this blog's voice, and a set of hard rules that override everything else in it —

- never invent or alter an article number, act name, Dz.U./ELI reference, decision signature, fine amount, date or statutory deadline;
- never touch YAML keys, Liquid tags, `{: .prompt-* }` blocks, code, paths or link targets;
- no em dashes (`—`) or en dashes (`–`) in prose — the house style is a spaced hyphen (` - `);
- Polish typographic quotes `„…"` are correct and must be preserved.

It does not apply to posts published before 30 November 2022: those carry the author's own habits, and normalising them makes the corpus more uniform, not more human. Edit those for links, citations and dated notes only.

### Internal links between posts

Always use `{% post_url YYYY-MM-DD-slug %}`, never a hand-written `/posts/slug/` path. `post_url` fails the build on a typo or a renamed file; a hand-written path fails silently in production.

### Structured data (JSON-LD)

`_includes/metadata-hook.html` is the **single source of structured data** for the site. It emits one `@graph` per page type:

| Page | Nodes |
|---|---|
| home | `WebSite` + `Blog` + `Person` + `ProfessionalService` |
| post | `BlogPosting` (with `citation` if `sources:`) + `BreadcrumbList` + `FAQPage` (if `faq:`) + `Person` |
| `/about/` | `ProfilePage` + `Person` + `ProfessionalService` |
| `/contact/` | `ContactPage` + `ProfessionalService` + `Person` |
| archives / categories / tags / generated archives | `CollectionPage` (+ `ItemList` when the page has posts) |

Rules when editing it:

- **Every string value goes through `| jsonify`**, which supplies its own quotes. Never `| escape` — that HTML-encodes inside JSON, so consumers see literal `&#39;`.
- Slugify a category name **in isolation** (`{% assign cat_slug = page.categories.last | slugify %}`); slugifying `'/categories/' | append: name` eats the slash and produces a 404 URL.
- Stable `@id`s: `/#person`, `/#organization`, `/#website`, `/#blog`, `<post-url>#article`, `#breadcrumb`, `#faq`. Reference nodes elsewhere by `@id` rather than inlining a second copy.
- `Person.knowsAbout` entries carry Wikidata `sameAs` identifiers for disambiguation. Verify an ID against the Wikidata API before adding one; a wrong Q-number points the entity at an unrelated topic. `Person.description` is read from the `/about/` tab's `description:`, so edit it there.
- The `ProfessionalService` node duplicates data published on `/contact/`. Keep name, address and phone **character-identical** with mornel.com and the Google Business Profile — inconsistent NAP is the usual reason local entities fail to merge.
- The file also emits `noindex, follow` on tag archives with fewer than three posts. Self-maintaining: a tag becomes indexable once it earns a third post.

`tools/check-jsonld.rb` (run from `tools/test.sh`) parses every `ld+json` block in `_site/`, rejects duplicate `@id` definitions and more than one `BlogPosting` per page, and verifies that every on-site `item`/`url` resolves to a real file in the build. Liquid-templated JSON breaks silently; html-proofer does not look inside it.

### Plugins

- `_plugins/posts-lastmod-hook.rb` — sets `last_modified_at` on every document (posts and `_tabs`) with more than one git commit, using `git log`. On `/about/` it feeds `ProfilePage.dateModified`; `dateCreated` comes from the tab's `date_created:` front matter.
- `_plugins/post-footer-hook.rb` — appends `{% include post-sources.html %}`, `{% include legal-status.html %}` and `{% include author-box.html %}` to every post. It writes to `doc.content` in `:pre_render`, before Liquid and Markdown run, so the output lands inside the post's `.content` element; appending to `doc.output` would place it after the page footer. One include rather than a block pasted into 31 files.
- `_plugins/strip-seo-tag-jsonld.rb` — removes the thin JSON-LD that jekyll-seo-tag emits, so `metadata-hook.html` is the only source. It matches the gem's *minified* output (`{"@context":"https://schema.org"`); `metadata-hook.html` pretty-prints with a space after each colon, which is what keeps the two apart. Everything else seo-tag produces (`<title>`, canonical, Open Graph, Twitter cards) is untouched. If a gem upgrade changes the formatting, `check-jsonld.rb` fails the build on the duplicate `BlogPosting`.

### Theme

Chirpy is installed as `gem "jekyll-theme-chirpy", "~> 7.5"`. Theme source files (`_includes`, `_layouts`, `_sass`, `_javascript`, `assets/js`) live inside the gem — do not copy them into this repo. To upgrade:

1. Update the version constraint in `Gemfile`, e.g. `"~> 7.5"` → `"~> 7.6"`
2. Run `bundle update jekyll-theme-chirpy`
3. **Re-diff the two theme-owned files this repo overrides** (below) against the gem's copies
4. Test with `bash tools/test.sh`

#### Theme files overridden in this repo

Both live under `assets/`, outside the do-not-fork list, and both are marked with `override:` comments:

- `assets/feed.xml` — entry limit 5 → 20; author resolved through `_data/authors.yml` instead of printing the raw id; `xml_escape` dropped from the entry `title=` attribute, where the template's global `replace: '&', '&amp;'` was double-escaping it. Do **not** add `{{ post.content }}` without first removing that global replace and escaping each field individually — otherwise every entity in the feed is double-escaped.
- `assets/404.html` — Polish text plus links to archives, categories, tags and contact. The gem ships an empty `<p class="lead">`.

### Tab titles and UI strings

`_data/locales/pl-PL.yml` supplies every user-facing theme string. Its `tabs:` map is keyed by **the tab's `title:` in lower case** (the theme's own `<filename_without_extension>` comment is wrong). `_layouts/page.html` falls back to `page.title` when a key is missing, but `_includes/head.html` does not — a missing key ships an empty `<title>`. Adding or renaming a tab means adding the matching key. `tools/test.sh` fails the build if any page has an empty title.

### Site root files

- `llms.txt` — hand-maintained; intro, `## Strony`, `## O autorze`, `## Usługi i kontakt`, generated post list, `## Kanały`. Keep the author/services prose in step with `_tabs/about.md` and the `ProfessionalService` node.
- `.well-known/security.txt` — RFC 9116. `Expires:` is generated as `<current year + 1>-09-01`, so it only refreshes on a build; rebuild and deploy at least annually. `.well-known` is in `include:` because Jekyll skips dot-directories.
- `google7ccb7976466cc251.html` — Google Search Console file verification. It carries front matter so it can be kept out of the sitemap (`sitemap: false`); the body must stay exactly one `google-site-verification:` line.

### Self-hosted assets

`assets/lib` is a git submodule pointing to [chirpy-static-assets](https://github.com/cotes2020/chirpy-static-assets) and is currently **uninitialised**, so `assets.self_host.enabled` in `_config.yml` must stay off. Enabling it without the submodule 404s every stylesheet and script. To switch over: init the submodule, flip the flag, build, then confirm no `googleapis`, `gstatic` or `jsdelivr` remains:

```bash
grep -rhoE '(href|src)="https?://[^/"]+' _site | sort -u
```

### Deployment

`.production.sh`: builds and verifies through `tools/test.sh`, sets file permissions, then rsyncs `_site/` to the remote server over SSH on port 22. `rsync --delete` means removing a file from the build removes it from the server on the next deploy, so the script refuses to deploy a build with no `index.html` or fewer than 50 HTML files. It takes `--dry-run`, `--verbose`, `--skip-tests` and `--help`. The script is gitignored - it carries the server host and path - so changes to it are not version-controlled.

**Server-side** - see `docs/mydevil-hosting.md` for the host's capabilities, the current `devil www` settings and what is still open.

`.htaccess` at the repo root sets the HTTPS redirect, `AddDefaultCharset utf-8` and the security headers (`Strict-Transport-Security`, `X-Content-Type-Options`, `Referrer-Policy`, `X-Frame-Options`, `Permissions-Policy`), plus `Options -Indexes`. Jekyll skips dotfiles, so it ships only because `include:` in `_config.yml` names it. mydevil implements `.htaccess` as an nginx module supporting a documented subset of Apache syntax, and **only on `php`-type sites** - a directive it does not implement returns 500 for the whole site, so check <https://pomoc.mydevil.net/htaccess/> before adding one, keep the file BOM-free with LF endings, and curl the site after deploying. Add a CSP only after the self-hosting switch above.

## Language

**Published content is Polish. Everything else is English.**

Polish: `_posts/`, `_tabs/`, `zasady.md`, `llms.txt`, `_data/locales/pl-PL.yml`, front matter prose values (`title`, `description`, `faq`, `sources[].name`) and any other string a site visitor reads.

English: commit messages, code and configuration comments, `tools/*` scripts and their output, `_plugins/*.rb`, `_includes/metadata-hook.html` comments, `README.md`, `CLAUDE.md`, `.claude/skills/**`, `docs/**`, and issue or PR text. The `humanizer` skill documents Polish prose patterns, so its examples stay Polish; its own instructions are English.

Some older commits are in Polish. Leave them; write new ones in English.

## Commit conventions

Commits follow [Conventional Commits](https://www.conventionalcommits.org/). Types: `feat`, `fix`, `docs`, `perf`, `refactor`, `chore`. Subject and body in English, including for content commits about Polish posts.
