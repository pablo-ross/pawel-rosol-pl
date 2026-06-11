# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## About this site

Personal blog of Paweł Rosół — a Data Protection Officer (IOD/DPO) based in Poland. The site covers GDPR/RODO, cybersecurity, and related topics. Posts are written in Polish. Built on the [Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) Jekyll theme (installed as a gem, not forked).

## Commands

### Development

```bash
# Install Ruby dependencies
bundle install

# Serve locally with live reload
bash tools/run.sh
# or directly:
bundle exec jekyll s -l

# Serve in production mode
bash tools/run.sh --production
```

### Build & Test

```bash
# Build for production + run html-proofer
bash tools/test.sh

# Build only
JEKYLL_ENV=production bundle exec jekyll b

# Build and deploy to production server via rsync
bash .production.sh
```

## Architecture

### Content structure

- `_posts/` — blog posts, filename format: `YYYY-MM-DD-slug.md`
- `_tabs/` — static pages rendered as sidebar navigation tabs (about, archives, categories, tags, contact)
- `_data/` — user YAML data files: `authors.yml`, `contact.yml`, `media.yml`, `share.yml`
- `media/` — images and media assets (referenced via `/media/...` paths)
- `assets/img/favicons/` — site-specific favicons

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

Optional fields: `image`, `pin: true` (pin to home), `toc: false` (disable TOC).

### Theme

Chirpy is installed as `gem "jekyll-theme-chirpy", "~> 7.5"`. All theme source files (_includes, _layouts, _sass, _javascript, assets/js) live inside the gem — do not add them to this repo. To upgrade the theme:
1. Update the version constraint in `Gemfile`, e.g. `"~> 7.5"` → `"~> 7.6"`
2. Run `bundle update jekyll-theme-chirpy`
3. Test with `JEKYLL_ENV=production bundle exec jekyll b`

The `assets/lib` directory is a git submodule pointing to [chirpy-static-assets](https://github.com/cotes2020/chirpy-static-assets).

### Plugin

`_plugins/posts-lastmod-hook.rb` — automatically sets `last_modified_at` on posts that have more than one git commit, using `git log`.

### Deployment

Production deploy runs `.production.sh`: builds with `JEKYLL_ENV=production`, sets file permissions, then rsyncs `_site/` to the remote server over SSH on port 62444.

## Commit conventions

Commits follow [Conventional Commits](https://www.conventionalcommits.org/). Types: `feat`, `fix`, `docs`, `perf`, `refactor`, `chore`.
