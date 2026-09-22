# mydevil.net hosting

What the production host provides, what is configured, and what is left. Server-side
settings live outside this repo, so this file is where they are written down.

Vendor documentation: <https://pomoc.mydevil.net/> (Polish). The `.htaccess` page is
the one that matters most here: <https://pomoc.mydevil.net/htaccess/>.

## The account

| | |
|---|---|
| Server | `s64.mydevil.net`, SSH on port 22 |
| User | `mornel` |
| Document root | `/usr/home/mornel/domains/pawel.rosol.pl/public_html` |
| Site type | **php** |
| Panel CLI | `devil` over SSH; DevilWEB is the web panel |

The account hosts 15 domains. `pawel.rosol.pl` is one of them, so panel-level changes
must name the domain explicitly - `devil www options` with no domain is a syntax error,
not a listing.

### Why the site type matters

mydevil serves every site through nginx. `.htaccess` is not Apache here; it is an
in-house nginx module that implements a subset of the Apache syntax, and the vendor
documents it as supported **on PHP-type sites only**. The site is `php` even though it
serves nothing but static Jekyll output, which is what makes `.htaccess` available. If
the type is ever changed to something else, `/.htaccess` silently stops applying and
every header below disappears.

Site types offered: `php`, `python`, `ruby`, `nodejs`, `proxy`, `pointer`. There is no
`static` type. Dynamic types run behind Phusion Passenger.

## Current panel settings

From `devil www list -v`, as of 22 September 2026:

| Setting | Value |
|---|---|
| GZIP compression | on |
| Force SSL (`sslonly`) | **off** - the redirect is done in `.htaccess` instead |
| Minimum TLS version | 1.2 |
| Block non-Polish traffic (`plnet`) | off |
| Cache | off |
| WAF | on, level 1 |
| Proof of Work | only during an attack |
| Blacklist | on, level 1 |
| PHP `eval` / `exec` | off |

Read them back with:

```bash
ssh mornel@s64.mydevil.net 'devil www list -v' | grep -A18 'pawel.rosol.pl'
```

Options available but not used: `cache control|short|long|purge|off`, `cache_cookie`,
`pow on|always|off`, `blacklist 0-4`, `waf 0-5`, `tls_min`, `stats_anonymize`,
`stats_exclude`, `processes`, `php_openbasedir`. Matomo statistics are offered through
`devil www stats`.

## What `/.htaccess` does

The file is at the repo root and is version-controlled. Jekyll skips dotfiles, so it
ships only because `_config.yml` names it under `include:` alongside `.well-known`.
`rsync` then carries it to the document root like any other built file.

It sets:

1. **HTTPS redirect.** Plain HTTP answered `200` until 22 September 2026, leaving every
   page reachable unencrypted and duplicated for crawlers. `RewriteCond %{HTTPS} off`
   now 301s to HTTPS, with `/.well-known/acme-challenge/` excluded so Let's Encrypt
   renewals keep working over HTTP.
2. **`AddDefaultCharset utf-8`.** `llms.txt` and `.well-known/security.txt` were served
   as `text/plain` with no charset, which mangled Polish diacritics. HTML carries its own
   `meta charset` and was never affected.
3. **Security headers** - `Strict-Transport-Security` (1 year, `includeSubDomains`, no
   `preload`), `X-Content-Type-Options`, `Referrer-Policy`, `X-Frame-Options`,
   `Permissions-Policy`.
4. **`Options -Indexes`**, so directories without an index file return 403 rather than a
   listing. `/posts/` is the visible case.

### Constraints on editing it

- **A syntax error returns 500 for the entire site.** Verify after every deploy.
- Only directives the vendor documents are safe. Confirmed working: `RewriteEngine`,
  `RewriteCond`, `RewriteRule`, `Redirect`, `RedirectMatch`, `AddDefaultCharset`,
  `AddType`, `AddEncoding`, `Header set`, `Header append`, `FilesMatch`, `ExpiresActive`,
  `ExpiresByType`, `ExpiresDefault`, `Options -Indexes`, `RequireAll` / `Require`.
  `Header always set` is *not* documented; plain `Header set` is what is used.
- No BOM, and LF line endings only. `file .htaccess` should say `ASCII text`.

### Rolling back

Delete `.htaccess`, drop the `- .htaccess` line from `include:` in `_config.yml`, and
redeploy. `rsync --delete` removes it from the server.

HSTS is the exception: browsers that have already seen the header keep refusing plain
HTTP for up to a year regardless of what the server sends. Reducing `max-age` to `0` and
leaving it deployed for a while is the only way to unwind it.

## Verifying after a deploy

```bash
curl -sSI https://pawel.rosol.pl/                      # 200 + the five headers + charset
curl -sSI http://pawel.rosol.pl/                       # 301 to https
curl -sSI https://pawel.rosol.pl/llms.txt              # text/plain; charset=utf-8
curl -sS  https://pawel.rosol.pl/llms.txt | grep -m1 ł # diacritics intact
```

`.production.sh` runs the build through `tools/test.sh` before rsyncing, so broken links
and malformed JSON-LD are caught locally. Nothing in that pipeline tests the served
headers - the curl checks above are manual.

## Outstanding

- **Content-Security-Policy.** Not set. The site still loads fonts and scripts from
  `googleapis`, `gstatic` and `jsdelivr`, so a useful CSP is not writable yet. It comes
  after the `assets/lib` submodule is initialised and `assets.self_host.enabled` is
  switched on in `_config.yml` - see the "Self-hosted assets" section of `CLAUDE.md`.
- **`security.txt` expiry.** `Expires:` is generated as `<build year + 1>-09-01`, so the
  site must be rebuilt and redeployed at least once a year or the file goes stale.
- **HSTS preload.** Deliberately not set. Preloading is effectively irreversible and
  would need the apex `rosol.pl` considered too.
- **TLS 1.3 minimum.** `tls_min` is 1.2. Raising it to 1.3 would drop some older clients;
  not obviously worth it for this audience.
- **`.production.sh` is gitignored** (removed in `d4fdcda`, it carries the server host and
  path), so the deploy logic itself is not backed up in this repo. A sanitised
  `production.sh.example` with the host in a variable would fix that.

## Change log

- **22 September 2026** - added `/.htaccess`: HTTPS redirect, `AddDefaultCharset utf-8`,
  five security headers, `Options -Indexes`. Rewrote `.production.sh` to build through
  `tools/test.sh` and to refuse to deploy an incomplete build. Bumped bundler to 4.0.21
  and replaced the deprecated `:mingw, :x64_mingw, :mswin` platform names with
  `:windows` in the `Gemfile`.
