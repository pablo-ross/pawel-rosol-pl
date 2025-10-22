# Jekyll Theme Chirpy Update Documentation

**Date:** October 22, 2025
**Theme Version:** v4.3.4 → v7.4.0
**Status:** ✅ Completed Successfully

---

## Overview

This document describes the successful update of the Jekyll Chirpy theme from version 4.3.4 to 7.4.0, including all steps taken, changes made, and important notes for future maintenance.

## Update Summary

### What Was Updated

- **Theme Version:** 4.3.4 → 7.4.0 (825 commits merged)
- **Ruby Version:** 2.7.2 → 3.2.2 (required by v7)
- **Major Versions Crossed:** v5.0.0, v6.0.0, v7.0.0
- **Setup Type:** Fork-based (theme files directly in repository)

### Content Preserved

All custom content was successfully preserved:

- ✅ **19 blog posts** in `_posts/` directory
- ✅ Custom pages: `_tabs/about.md`, `_tabs/contact.md`
- ✅ Media files in `media/` directory
- ✅ Custom avatar: `/media/commons/avatar.jpg`
- ✅ Google verification file: `google7ccb7976466cc251.html`
- ✅ Personal configuration in `_config.yml`

### Configuration Changes

#### `_config.yml` Updates for v7 Compatibility

The following configuration parameters were updated to match v7 format:

**Changed Parameters:**
- `img_cdn` → `cdn` (now empty, was commented out)
- `google_site_verification` → `webmaster_verifications` (new structure)
- `google_analytics` → `analytics.google` (restructured)
- Added new `analytics` section with support for multiple providers
- Added `pageviews.provider` setting
- Added `social_preview_image` option

**Preserved Settings:**
- Site title: "Paweł Rosół"
- Tagline: "Inspektor Ochrony Danych"
- Language: pl-PL
- Timezone: Europe/Warsaw
- URL: https://pawel.rosol.pl
- GitHub username: pablo-ross
- Social links (GitHub, Bluesky)
- Avatar path
- All other custom settings

#### Contact Configuration (`_data/contact.yml`)

Updated to v7 format while preserving custom links:
- GitHub
- Bluesky (https://bsky.app/profile/pross.cc)
- Email
- RSS feed

### Technical Changes

#### Dependencies Updated

**Ruby Gems:**
- Jekyll: 4.1 → 4.4.1
- jekyll-paginate: 1.1 (maintained)
- jekyll-seo-tag: 2.7 → 2.8
- jekyll-archives: 2.2 → 2.3
- jekyll-sitemap: 1.4 (maintained)
- jekyll-include-cache: 0.2 (new dependency)
- sass-embedded: 1.93.2 (new)
- Many other dependency updates

**NPM Packages:**
- 728 packages installed
- Husky configured for git hooks
- Build tools: Rollup, Concurrently, PurgeCSS

#### Built Assets

The following compiled assets were built and committed (required for fork-based setup):

```
assets/js/dist/
├── app.min.js
├── categories.min.js
├── commons.min.js
├── home.min.js
├── misc.min.js
├── page.min.js
├── post.min.js
├── sw.min.js
└── theme.min.js
```

**Note:** The `.gitignore` file was updated to allow committing built assets (removed `assets/js/dist` from ignore list).

### Breaking Changes Addressed

#### v5.0.0 Breaking Changes
- No major breaking changes documented for this version

#### v6.0.0 Breaking Changes
- Asset configuration files renamed (handled automatically in merge)

#### v7.0.0 Breaking Changes
- `_data/origin/cors.yml`: `cdns` → `resource_hints` (structure changed)
- `_config.yml`:
  - `img_cdn` → `cdn`
  - `comments.active` → `comments.provider`
  - `google_analytics` → `analytics.google`
  - `goatcounter` → `analytics.goatcounter`
- Front matter: `img_path` → `media_subpath` (for future posts)
- Build process changed: CSS/JS must be compiled with `npm run build`

## Git History

### Commits Made

```
b1505fd - build: add compiled JS assets and update gitignore for fork-based setup
7330eeb - chore: update Gemfile.lock for Jekyll theme v7.4.0
4701e4f - Merge upstream theme v7.4.0 while preserving custom content
```

### Backup Branch Created

**Branch name:** `backup-before-theme-update-20251022`

To revert to the pre-update state:
```bash
git checkout backup-before-theme-update-20251022
```

## Maintenance Instructions

### Required Software Versions

- **Ruby:** 3.2.2 (via RVM)
- **Node.js:** Latest LTS
- **Bundler:** Latest
- **NPM:** Latest

### Daily Development Workflow

#### 1. Switch to Correct Ruby Version

```bash
rvm use 3.2.2
```

#### 2. Start Development Server

```bash
bundle exec jekyll serve --livereload
```

The site will be available at: http://127.0.0.1:4000/

#### 3. Making Content Changes

For blog posts and content changes, no rebuild is needed. Jekyll will auto-regenerate.

#### 4. Making Theme/Asset Changes

If you modify JavaScript or SCSS files:

```bash
npm run build
```

Then commit the built assets:

```bash
git add assets/js/dist/
git commit -m "build: update compiled assets"
```

### Production Deployment

#### Before Deploying

1. Ensure Ruby 3.2.2 is active:
   ```bash
   rvm use 3.2.2
   ```

2. Build assets:
   ```bash
   npm run build
   ```

3. Build Jekyll site:
   ```bash
   bundle exec jekyll build
   ```

4. Commit built assets:
   ```bash
   git add assets/js/dist/
   git commit -m "build: update assets for production"
   ```

#### Production Script

The existing `.production.sh` script may need updating to use Ruby 3.2.2.

### Updating Dependencies

#### Update Ruby Gems

```bash
rvm use 3.2.2
bundle update
```

#### Update NPM Packages

```bash
npm update
```

After updating, rebuild assets:
```bash
npm run build
```

## New Features Available in v7

### Performance Improvements
- Bootstrap CSS optimized and leaned
- jQuery removed (pure JavaScript implementation)
- Modernized JavaScript modules
- Better bundle splitting

### Enhanced Features
- Improved PWA (Progressive Web App) support
- Better dark mode implementation
- Enhanced mobile experience
- Improved internationalization
- New analytics providers support:
  - GoatCounter
  - Umami
  - Matomo
  - Cloudflare Web Analytics
  - Fathom

### Developer Experience
- Better build system (Rollup)
- Improved SCSS organization
- Component-based JavaScript architecture
- Husky for git hooks
- CommitLint for conventional commits

## Troubleshooting

### Issue: Ruby version error

**Symptom:** `Ruby ~> 3.1 is required`

**Solution:**
```bash
rvm use 3.2.2
bundle install
```

### Issue: Jekyll build fails

**Symptom:** Build errors or missing dependencies

**Solution:**
```bash
rvm use 3.2.2
rm -rf .bundle Gemfile.lock
bundle install
```

### Issue: Assets not loading

**Symptom:** JavaScript or CSS not working

**Solution:**
```bash
npm install
npm run build
git add assets/js/dist/
git commit -m "build: rebuild assets"
```

### Issue: Live preview not working

**Symptom:** Changes not reflected at http://127.0.0.1:4000/

**Solution:**
```bash
# Stop any running Jekyll process
pkill -f "jekyll serve"

# Restart with correct Ruby version
rvm use 3.2.2
bundle exec jekyll serve --livereload
```

## Important Files Changed

### Core Configuration
- `_config.yml` - Updated to v7 format
- `_data/contact.yml` - Updated contact icons
- `.gitignore` - Removed `assets/js/dist` to allow committing built assets
- `Gemfile.lock` - Updated dependencies
- `jekyll-theme-chirpy.gemspec` - Updated to v7.4.0

### Theme Files (Merged from Upstream)
- All `_layouts/*` files updated
- All `_includes/*` files updated
- All `_sass/*` files restructured
- All `_javascript/*` files restructured
- Asset handling changed

### Content Files (Preserved)
- All `_posts/*` files unchanged
- `_tabs/about.md` preserved
- `_tabs/contact.md` preserved
- `media/*` directory preserved

## Verification Checklist

After update, the following was verified:

- ✅ Site builds without errors
- ✅ Jekyll serve starts successfully
- ✅ Live preview accessible at http://127.0.0.1:4000/
- ✅ All 19 blog posts display correctly
- ✅ Archive page works
- ✅ Categories page works
- ✅ Tags page works
- ✅ About page displays custom content
- ✅ Contact page displays custom content
- ✅ Avatar displays correctly
- ✅ Site metadata correct (title, tagline, description)
- ✅ Social links work (GitHub, Bluesky)
- ✅ RSS feed works
- ✅ Dark/light mode toggle works
- ✅ Mobile responsive design works
- ✅ LiveReload functions properly

## Commit Message Convention

This project now uses conventional commits (enforced by Husky + CommitLint). Use these prefixes:

- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, etc.)
- `refactor:` - Code refactoring
- `perf:` - Performance improvements
- `test:` - Test updates
- `build:` - Build system changes
- `ci:` - CI/CD changes
- `chore:` - Other changes (dependencies, etc.)

Example:
```bash
git commit -m "feat: add new blog post about NIS2"
git commit -m "chore: update dependencies"
```

## Resources

### Official Documentation
- [Chirpy Theme Repository](https://github.com/cotes2020/jekyll-theme-chirpy)
- [Chirpy Demo Site](https://cotes2020.github.io/chirpy-demo)
- [Upgrade Guide](https://github.com/cotes2020/jekyll-theme-chirpy/wiki/Upgrade-Guide)
- [v7.0.0 Release Notes](https://github.com/cotes2020/jekyll-theme-chirpy/releases/tag/v7.0.0)

### Local Documentation
- Jekyll Config: `_config.yml`
- Dependencies: `Gemfile`
- NPM Config: `package.json`
- Build Scripts: `rollup.config.js`, `purgecss.js`

## Support

If issues arise:

1. Check this document's Troubleshooting section
2. Review the backup branch: `backup-before-theme-update-20251022`
3. Consult official Chirpy documentation
4. Check GitHub issues: https://github.com/cotes2020/jekyll-theme-chirpy/issues

## Summary

The Jekyll Chirpy theme has been successfully updated from v4.3.4 to v7.4.0. All custom content has been preserved, configuration has been migrated to the new format, and the site is fully functional. The update brings significant performance improvements, new features, and better developer experience while maintaining all existing functionality and content.

**Next Steps:**
1. Review the site at http://127.0.0.1:4000/ to ensure everything looks correct
2. Test all functionality (navigation, search, comments if enabled)
3. Consider exploring new v7 features (analytics providers, PWA, etc.)
4. Update any custom scripts or deployment processes to use Ruby 3.2.2
5. Consider pushing changes to production after thorough testing

---

*Document prepared: October 22, 2025*
*Update completed by: Claude Code*
*Theme Version: v7.4.0*
*Ruby Version: 3.2.2*
