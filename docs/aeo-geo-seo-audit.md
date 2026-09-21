# AEO / GEO / SEO audit & action plan — pawel.rosol.pl

**Audit date:** 2026-09-21 · **Revision 3** (rev. 2: every claim re-verified against the repo, the production build and the live site — §9; rev. 3: second professional role, `/about/` rewritten — §11)
**Scope:** Jekyll 4.4.1 + jekyll-theme-chirpy 7.6.0, jekyll-seo-tag 2.9.0, 31 posts, 13 categories, 132 tags, Polish-language content. Hosting: nginx on mydevil.net.
**Method:** production build (`JEKYLL_ENV=production bundle exec jekyll b`) inspected offline — sitemap, robots, feed, rendered JSON-LD, meta tags, link graph, front matter — plus `curl` against the live site for status codes and response headers.

---

## 0. Executive summary

The technical foundation is above average for a personal blog: `llms.txt` exists, `robots.txt` explicitly welcomes AI crawlers, a custom `metadata-hook.html` emits a `Person`/`WebSite`/`Blog` graph, and 14 posts carry visible FAQ sections backed by `FAQPage` JSON-LD.

What is holding the site back, in order of impact:

1. **Seven confirmed defects are live in production** (§1): a `BreadcrumbList` pointing at a 404 on every post, `CLAUDE.md` served from the web root, `/contact/` and `/archives/` self-declaring as `BlogPosting` with a publish date that changes on every build, a feed capped at 5 entries, and no security headers at all — awkward for a security blog.
2. **Internal linking is recent and shallow, not absent.** The six posts written since June 2026 link to each other well (14 `{% post_url %}` links). The 25 posts before them contain **one** internal link between them, and 22 of 31 posts receive no contextual inbound link. The habit exists; it needs back-filling and a hub.
3. **Answer-first structure is missing.** Posts open with narrative, not with the answer.
4. **Nothing is measured.** No analytics, no Search Console property beyond a legacy HTML file, no Bing. Without a baseline none of the work below can be shown to have worked — so measurement moves to **Phase 0**.

5. **The site described half of what its author does.** Every identity signal — tagline, `Person.jobTitle`, `llms.txt`, link titles — says *Inspektor Ochrony Danych* only. The owner also acts as **pełnomocnik ds. cyberbezpieczeństwa**, implementing the amended KSC act / NIS2. `/about/` has been rewritten for both roles (§11); the markup, config and content still have to follow, and it changes which pillar comes second.

Realistic effort: Phases 0–2 ≈ 8–10 hours. Phases 3–4 are content work, ≈ 25–35 hours if scoped to the dozen posts that matter (§7) rather than all 31. The earlier "2–3 sessions" estimate covered only the code.

---

## 1. Confirmed defects (fix first)

### 1.1 — `BreadcrumbList` links to a 404 on every post — **high**

`_includes/metadata-hook.html` builds the category URL as:

```liquid
{{ '/categories/' | append: page.categories.last | slugify | append: '/' | absolute_url }}
```

`slugify` runs over the whole string, so the slash is eaten. Rendered today on `kara-mcdonalds`:

```
https://pawel.rosol.pl/categories-urz%C4%85d-ochrony-danych-osobowych/   ← live: HTTP 404
```

**Fix** — slugify the category name in isolation:

```liquid
{%- assign cat_slug = page.categories.last | slugify -%}
"item": {{ '/categories/' | append: cat_slug | append: '/' | absolute_url | jsonify }}
```

Verified: Liquid `slugify` output matches all 13 directories jekyll-archives generates under `_site/categories/` (`bezpieczeństwo`, `urząd-ochrony-danych-osobowych`, `jednostki-samorządu-terytorialnego`, …).

**Second bug in the same block:** strings are emitted with `| escape`, which HTML-encodes inside JSON. The live breadcrumb name reads `McDonald&#39;s ukarany przez UODO…`. JSON-LD is not HTML; consumers see the literal entity. **Use `| jsonify` for every string value in `metadata-hook.html`** (it emits the quotes itself, so drop the surrounding `"`). The `FAQPage` block already does this correctly — copy its pattern. A post title containing `"` would currently survive only by accident.

### 1.2 — `CLAUDE.md` is published to the live site — **medium (disclosure)**

Confirmed live: `https://pawel.rosol.pl/CLAUDE.md` → HTTP 200. It describes the deploy mechanism (rsync over SSH) and internal working instructions. No credentials or hostnames are in it, so this is housekeeping rather than an incident — but it should not be there.

**Fix** — add `CLAUDE.md` to `exclude:` in `_config.yml`. `rsync --delete` in `.production.sh` removes the remote copy on the next deploy. `docs/` is already excluded, so this file is safe.

### 1.3 — Tabs are typed `BlogPosting` with a build-time publish date — **high** *(new in rev. 2)*

jekyll-seo-tag picks `@type` as: `seo.type` front matter → `WebSite` for home/about → **`BlogPosting` for anything with a date** → `WebPage`. Documents in the `tabs` collection inherit a date (the build time), so today:

| Page | seo-tag emits | Should be |
|---|---|---|
| `/contact/` | `BlogPosting`, `datePublished` = time of last build | `ContactPage` |
| `/archives/`, `/categories/`, `/tags/` | `BlogPosting`, same | `CollectionPage` |
| `/about/` | `WebSite` | `ProfilePage` |
| category / tag archives | `WebPage` | fine |
| posts | `BlogPosting` | fine, but thin (§3.3) |

So the contact page claims to be a blog article published this afternoon, and re-claims it on every deploy.

**Fix (5 minutes, no theme files touched)** — seo-tag honours front matter. In each `_tabs/*.md`:

```yaml
seo:
  type: ContactPage   # about: ProfilePage · archives/categories/tags: CollectionPage
```

The spurious `datePublished` remains; §3.2 removes it.

### 1.4 — Atom feed: 5 entries, author id instead of name — **medium**

The gem's `assets/feed.xml` hardcodes `limit: 5` and prints `{{ post.author }}` raw, so every entry says `<name>pawel_rosol</name>` (the id set in `_config.yml` defaults). `<content>` is a `src=` pointer; the only text is a 400-character `<summary>`.

**Fix** — copy the gem's file to `assets/feed.xml` and:

- raise the limit to 20 (or remove it — 31 posts is small);
- author → `{{ site.data.authors[post.author].name | default: site.social.name }}`;
- *optional:* full-text `<content type="html">`.

**Trap in the original recommendation:** the template ends with `{{ source | replace: '&', '&amp;' }}`. Adding `post.content | xml_escape` as first proposed would double-escape every entity (`&lt;` → `&amp;lt;`) and break the feed. If you add full content, delete that global `replace` and `xml_escape` each field individually (`title`, `summary`, `content`, `category term`). Also rewrite root-relative `/media/…` URLs to absolute, or images break in readers. Validate with the W3C feed validator afterwards.

*Trade-off:* one theme-owned file in the repo. `CLAUDE.md` forbids forking `_includes`/`_layouts`/`_sass`/`_javascript`; `assets/feed.xml` is outside that list, but record the override in `CLAUDE.md` so the next theme upgrade re-diffs it. If that feels like too much surface, do only the limit + author fix and skip full content.

### 1.5 — No security headers on the live site — **medium** *(promoted from "verify" to confirmed)*

`curl -I https://pawel.rosol.pl/` returns no `Strict-Transport-Security`, `X-Content-Type-Options`, `Referrer-Policy`, `Content-Security-Policy`, `X-Frame-Options` or `Permissions-Policy`. For a blog that audits other people's security, this is the first thing a technical prospect checks (securityheaders.com grade: F).

Also: `/llms.txt` and `/robots.txt` are served as `text/plain` **without `charset=utf-8`** — Polish diacritics in `llms.txt` can arrive as mojibake in clients that default to Latin-1.

**Fix** — server-side, outside this repo. On mydevil.net this is done through the panel / `devil www` options (or `.htaccess` if the domain type routes through Apache — in which case add `.htaccess` to `include:` so Jekyll ships it). Start with HSTS, `nosniff`, `Referrer-Policy: strict-origin-when-cross-origin`, `X-Frame-Options: DENY`. Add a CSP **after** §6.2 (self-hosting), when the allow-list shrinks to `'self'`.

### 1.6 — Google verification stub is in the sitemap — **low**

`/google7ccb7976466cc251.html` is listed in `sitemap.xml`. Either move verification to `webmaster_verifications.google` (or DNS TXT — most robust) and delete the file + its `include:` entry, or keep it with:

```yaml
defaults:
  - scope: { path: "google7ccb7976466cc251.html" }
    values: { sitemap: false }
```

### 1.7 — `404.html` has an empty body — **low** *(downgraded)*

Rev. 1 called this an indexing problem. It is not: unknown URLs correctly return **HTTP 404** (verified), the page is not in the sitemap, and nothing links to `/404.html` directly. No `noindex` needed. The real issue is UX — the body is an empty `<p class="lead">`. Give it a sentence plus links to `/archives/` and `/categories/`.

---

## 2. Sitemap and taxonomy

**Status: generated correctly, badly proportioned.** 185 URLs, absolute `https://` locs, git-derived `<lastmod>`, correct `Sitemap:` line in `robots.txt`.

| URL type | count | share |
|---|---|---|
| Tag archives (+ index) | 133 | **72%** |
| Posts | 31 | 17% |
| Category archives | 13 | 7% |
| Pages + pagination + stub | 8 | 4% |

Of 132 distinct tags, **87 are used once**; only 9 are used three times or more. That is 87 pages each containing one link.

**Actions:**

- **Consolidate to ~30–40 tags.** Near-synonyms visible in the data: `UODO` (3) / `Urząd Ochrony Danych Osobowych` (2); `IOD` (2) / `Inspektor ochrony danych` (4); `Koronawirus` / `COVID-19` / `SARS-CoV-2`; `Uwierzytelnianie dwuskładnikowe` / `Weryfikacja dwuetapowa`; `Bezpieczna poczta` / `Szyfrowanie poczty`; `AI` / `LLM`; `CRU` / `Centralny Rejestr Umów` / `rejestrumow.gov.pl`; `Sygnalista` / `Ochrona sygnalistów` / `Whistleblowing` / `Zgłaszanie naruszeń prawa`. Retire single-use entity tags (people, product names) — those belong in body text.
- **`noindex, follow` thin tag archives** rather than only dropping them from the sitemap. Removing a URL from the sitemap does not de-index it; the thin page still exists and is still linked from every post. In `metadata-hook.html`:
  ```liquid
  {%- if page.layout == 'tag' and page.posts.size < 3 -%}<meta name="robots" content="noindex, follow">{%- endif -%}
  ```
  This is self-maintaining: a tag graduates to indexable when it earns a third post. Sitemap exclusion of generated archive pages is fiddly (they have no front matter; whether `defaults` with `scope.type: tag` reaches them needs testing) and is optional once `noindex` is in place.
- **Cost to accept:** merged/retired tags change `/tags/<slug>/` URLs; the old ones will 404. These pages have negligible equity — accept it, do not build redirects. Do the consolidation **once**, before adding tags to new posts.
- Leave `/page2/`–`/page4/` alone; self-canonical pagination is fine.

---

## 3. Structured data (JSON-LD)

### 3.1 What ships now (verified in `_site/`)

| Page type | jekyll-seo-tag | `metadata-hook.html` |
|---|---|---|
| Home | `WebSite` (no `@id`) | `WebSite` + `Blog` + `Person` graph ✅ |
| Post | `BlogPosting`, minimal, inline author | `BreadcrumbList` (broken §1.1) + `FAQPage` ✅ |
| `/about/` | `WebSite` ❌ | `ProfilePage` + `Person` ✅ |
| `/contact/`, `/archives/`, `/categories/`, `/tags/` | **`BlogPosting`** + build-time date ❌ (§1.3) | nothing |
| Category / tag archives | `WebPage` (acceptable) | nothing |

### 3.2 — Resolve the seo-tag duplication — **medium**

§1.3 fixes the wrong types. What remains is duplication: once §3.3 lands, every post carries **two `BlogPosting` nodes for the same URL** that share no `@id` — one thin (seo-tag), one rich (custom). Rev. 1 proposed "out-specifying" the thin one and hoping consumers prefer the richer node; that is a guess, and duplicate same-type nodes are exactly what validators warn about.

Options:

- **(a)** Override `_includes/head.html` — forks a theme file; against project rules. No.
- **(b) Recommended:** a small plugin — the repo already runs custom plugins and deploys its own build, so nothing is lost:
  ```ruby
  # _plugins/strip-seo-tag-jsonld.rb
  # jekyll-seo-tag emits minified JSON-LD ({"@context":"https://schema.org",…);
  # metadata-hook.html is the single source of structured data for this site.
  Jekyll::Hooks.register [:pages, :documents], :post_render do |doc|
    next unless doc.output_ext == ".html"
    doc.output = doc.output.sub(
      %r{<script type="application/ld\+json">\s*\{"@context":"https://schema\.org","@type":.*?</script>}m, ""
    )
  end
  ```
  Only do this **after** `metadata-hook.html` covers every page type (§3.3–3.6), otherwise you delete markup without replacing it. seo-tag keeps producing `<title>`, canonical, OG and Twitter tags — those are untouched.
- **(c)** Do nothing beyond §1.3. Acceptable if you would rather not own a regex against another gem's output.

Whichever you choose, add the guard in §3.8 so a gem upgrade cannot silently change the outcome.

### 3.3 — Upgrade the post schema — **high**

Today's post node has no `@id`, `publisher`, `inLanguage`, `keywords`, `articleSection`, `isPartOf`, and its `author` is an inline duplicate `Person` rather than a reference to `/#person` — so nothing connects "author of this article" to "the ISO 27001 lead auditor described on the home page".

Emit **one `@graph` per post** containing `BlogPosting` + `BreadcrumbList` + `FAQPage` (when present) + the `Person` node:

```liquid
{
  "@type": "BlogPosting",
  "@id": {{ page.url | absolute_url | append: '#article' | jsonify }},
  "isPartOf": { "@id": {{ '/#blog' | absolute_url | jsonify }} },
  "mainEntityOfPage": { "@id": {{ page.url | absolute_url | jsonify }} },
  "headline": {{ page.title | jsonify }},
  "description": {{ page.description | strip_newlines | strip | jsonify }},
  "inLanguage": {{ site.lang | jsonify }},
  "datePublished": {{ page.date | date_to_xmlschema | jsonify }},
  "dateModified": {{ page.last_modified_at | default: page.date | date_to_xmlschema | jsonify }},
  "author":    { "@id": {{ '/#person' | absolute_url | jsonify }} },
  "publisher": { "@id": {{ '/#person' | absolute_url | jsonify }} },
  "articleSection": {{ page.categories.last | jsonify }},
  "keywords": {{ page.tags | jsonify }},
  "wordCount": {{ page.content | strip_html | number_of_words }}
  {%- if page.image %},
  "image": { "@type": "ImageObject", "url": {{ page.image.path | default: page.image | absolute_url | jsonify }} }
  {%- endif %}
}
```

Changes from rev. 1's template: `jsonify` everywhere (§1.1); `page.content` instead of `content` (inside `head.html`, `content` is the whole rendered layout, including sidebar and related posts); **no avatar fallback for `image`** — declaring the author's face as the article image for 31 articles is worse than omitting it. Add `image` when §6.1 produces real ones.

`FAQPage` currently emits its own `@context`; inside a `@graph` it must not. Give it `"@id": "…#faq"` and move it in.

`dateModified` equals `datePublished` on single-commit posts because the git hook only sets `last_modified_at` when there is more than one commit. Correct behaviour — do not fake freshness. Be aware the inverse also holds: a typo-fix commit bumps `dateModified`. Acceptable, but batch trivial edits.

**Expectation check on FAQ:** since August 2023 Google shows FAQ rich results only for government and health authorities. The `FAQPage` markup here will **not** produce SERP accordions. Its value is the visible Q&A text and machine-readable pairs for answer engines. Keep it; do not judge it by Search Console's "FAQ" enhancement report.

### 3.4 — `/contact/` entity graph — **high, largest GEO lever**

`/contact/` is the highest-intent page, contains a complete verifiable business identity (phone, address, geo, NIP, REGON, Mornel s.c.) and — after §1.3 — still only says "I am a ContactPage". This is the data an assistant needs to answer *"kto świadczy usługi IOD pod Poznaniem?"*.

Add `ContactPage` + an organization node wired to `/#person`:

```json
{
  "@type": "ProfessionalService",
  "@id": "https://pawel.rosol.pl/#organization",
  "name": "Mornel s.c.",
  "legalName": "Mornel s.c.",
  "url": "https://www.mornel.com",
  "telephone": "+48502706280",
  "vatID": "PL7772887283",
  "taxID": "7772887283",
  "identifier": [{ "@type": "PropertyValue", "propertyID": "REGON", "value": "300232439" }],
  "address": { "@type": "PostalAddress", "streetAddress": "ul. Działkowa 32", "postalCode": "60-185",
               "addressLocality": "Skórzewo", "addressRegion": "wielkopolskie", "addressCountry": "PL" },
  "geo": { "@type": "GeoCoordinates", "latitude": 52.390466, "longitude": 16.786018 },
  "areaServed": [{ "@type": "AdministrativeArea", "name": "Poznań i powiat poznański" },
                 { "@type": "Country", "name": "Polska" }]
}
```

Then `worksFor: { "@id": "…/#organization" }` on `Person`.

Rev. 1's draft invented things the repo cannot confirm — they are **owner decisions (§10)**, not implementation details: the display name *"Mornel s.c. — Inspektor Ochrony Danych"* (not the registered name); `founder`/`employee` relationships; and a `serviceType` list including *"Testy penetracyjne"*. Structured data that overstates is worse than none — it is the one place where a DPO's site must be literally true. Also keep name/address/phone **character-identical** with mornel.com and any Google Business Profile; inconsistent NAP is the most common reason local entities fail to merge.

**Caveat:** the bank account number is published in plain text on `/contact/`. Your data, your call, not a GDPR issue — but NIP + REGON + IBAN in one place is a ready-made kit for invoice-fraud impersonation. Consider supplying the IBAN on invoices only.

### 3.5 — `OfferCatalog` for services — **medium**

Mirror the service list on `/about/` as `Service` items in an `OfferCatalog` on `#organization`. Same rule as §3.4: list only services actually sold.

### 3.6 — `CollectionPage` + `ItemList` on archives — **low**

Via `page.layout == 'category'` / `'tag'` branches; `page.posts` is available. Skip for `noindex`ed thin tags (§2).

### 3.7 — `SearchAction` — **do not add**

Chirpy's search is client-side over `search.json`; there is no `?q=` URL, so a `SearchAction` would be a false claim. Google also retired the sitelinks search box in November 2024. Listed so it does not get "helpfully" added later.

### 3.8 — Guard the JSON-LD in the build — **medium** *(new)*

Liquid-templated JSON breaks silently (one stray quote in a title). Add `tools/check-jsonld.rb`, run from `tools/test.sh`: for every `_site/**/*.html`, extract each `ld+json` block, `JSON.parse` it, and assert (a) it parses, (b) exactly one `BlogPosting` per post, (c) every `BreadcrumbList` `item` under `site.url` maps to an existing file in `_site/`. Check (c) would have caught §1.1 on day one. html-proofer does not look inside JSON-LD.

---

## 4. Internal linking

### 4.1 Current state *(corrected)*

Rev. 1 reported "exactly one internal link on the whole site". That was a measurement error: the grep looked for `](/…)` and missed the `{% post_url %}` tag the recent posts use. Actual figures:

- **15 contextual internal links**: 14 × `{% post_url %}` in 6 posts, plus one `/contact` link in `google-g-suite-dla-szkol`.
- All 14 are in the **six posts published since June 2026**. The 25 earlier posts contain the single `/contact` link and nothing else.
- Only **9 posts receive** a contextual inbound link (`automatyzacja-monitoring-uodo` ×3; `kara-mcdonalds`, `poradnik-uodo-naruszenia`, `bezpieczna-poczta-email` ×2). **22 of 31 receive none.**
- 0 posts link to `/about/`; 1 links to `/contact/`.
- **6 posts have no external links at all**: `bezpieczna-poczta-email`, `decyzja-uodo`, `wdrozenie-implementacja-nis2`, `atak-mpk-krakow`, `kanal-zewnetrzny`, `udostepnianie-informacji`. `decyzja-uodo` discusses a UODO decision without linking to it.

So the practice is sound and current; it has simply never been applied backwards. Chirpy's "Further Reading" box exists but carries no anchor text or context.

### 4.2 Topic clusters in the corpus

| Cluster | Posts |
|---|---|
| **Naruszenia i decyzje UODO** (7) | `decyzja-uodo`, `poradnik-uodo-naruszenia`, `rekordowa-kara-poczta-polska`, `kara-mcdonalds`, `decyzja-uodo-ops-dane-o-kwarantannie`, `wyciek-danych-mydr`, `atak-mpk-krakow` |
| **AI i automatyzacja w pracy IOD** (5) | `ai-w-pracy-iod`, `automatyzacja-monitoring-uodo`, `claude-code-w-pracy-iod`, `publiczne-api-do-cru`, `monitor-cru` |
| **Poczta i higiena cyfrowa** (3) | `bezpieczna-poczta-email`, `ryzyko-danych-osobowych-poczta-email`, `osobista-lista-bezpieczenstwa` |
| **JST i sektor publiczny** (5) | `nagrywanie-transmitowanie-obrad-jst`, `udostepnianie-informacji`, `kanal-zewnetrzny`, `monitor-cru`, `decyzja-uodo-ops` |
| **Oświata** (4) | `rada-rodzicow-w-szkole-publicznej`, `google-g-suite-dla-szkol`, `szkolenie-dla-iod-sektor-oswiata`, `upowaznienia-elektroniczne` |
| **Sygnaliści** (2) | `ochrona-sygnalistow`, `kanal-zewnetrzny` |

### 4.3 Actions

1. **Back-fill links in the older posts**, 2–4 per post, inline where the concept occurs, descriptive Polish anchors. Priority is **old → new** (older posts have accumulated whatever external equity exists; the new ones already link back). Still-missing examples:
   - `atak-mpk-krakow` at the NIS2 mention → `wdrozenie-implementacja-nis2`; and → `poradnik-uodo-naruszenia` at the notification duty.
   - `kanal-zewnetrzny` ↔ `ochrona-sygnalistow` (both directions; neither links the other).
   - `bezpieczna-poczta-email` → `ryzyko-danych-osobowych-poczta-email` ("aktualizacja 2026") — the reverse link exists.
   - `wyciek-danych-mydr` at powierzenie → `kara-mcdonalds` (the canonical Polish processor-liability case).
   - `decyzja-uodo`, `rekordowa-kara-poczta-polska`, `kara-mcdonalds` → `poradnik-uodo-naruszenia`.
   - `ai-w-pracy-iod` → `claude-code-w-pracy-iod` as a dated "moje podejście się zmieniło" note — important: the older post states a position the newer one revises, and an LLM may cite either.
   
   (Rev. 1 also listed `mydr → poradnik` and `ryzyko → bezpieczna-poczta`; both already exist.)
2. **Use `{% post_url YYYY-MM-DD-slug %}`**, the convention already in the repo — not hand-written `/posts/slug/` paths as rev. 1 suggested. `post_url` fails the build on a typo or a renamed file; a hand-written path fails silently in production.
3. **Build one pillar page first, not three.** *"Naruszenie ochrony danych osobowych — przewodnik dla administratora"*: 7 supporting posts, clear query space (72h / art. 33 / art. 34), and the area where the site has the most first-hand analysis. Publish it as a regular post with `pin: true` — it then inherits `BlogPosting` schema, the feed, `llms.txt` and `lastmod` for free, and avoids a new sidebar tab. Budget 6–10 hours; it must be maintained, so put a review date in its front matter. Pillar #2 should be **KSC / NIS2** (§11.4): it matches a service being sold, the statutory deadlines (3.10.2026, 3.04.2027) make the query space hot now, and the supporting posts have to be written anyway. *AI a RODO* (5 posts, under-served in Polish) and *RODO w JST* are candidates for #3, decided after 90 days of data on #1. The JST and oświata clusters are mostly 2020-era posts; a pillar on top of stale support is weak.
4. **Link `/about/` → pillar and services → `/contact/`**; add a one-line contextual CTA to `/contact/` at the end of advisory posts.
5. **Add primary-source citations** to the 6 posts with none, and to every decision number mentioned anywhere: `uodo.gov.pl` / `orzeczenia.uodo.gov.pl`, EUR-Lex (ELI links for RODO articles), `isap.sejm.gov.pl`. The evidence that outbound citations improve LLM visibility is suggestive rather than settled (the 2024 "GEO" paper measured it on a synthetic benchmark) — but for legal analysis, citing the primary source is simply correct practice, so the downside is nil.

---

## 5. Content readiness for AI crawlers

**Verdict: plumbing ready; prose not yet optimised.**

### 5.1 Already strong — keep

- `robots.txt` names GPTBot, OAI-SearchBot, ChatGPT-User, ClaudeBot, Claude-User, Claude-SearchBot, PerplexityBot, Perplexity-User, Google-Extended, Applebot(-Extended), CCBot, Meta-ExternalAgent and others. (The trailing `LLMs:` line is not a recognised directive — harmless, parsers ignore it.)
- `llms.txt` with authority statement and all 31 posts; excluded from the sitemap.
- Static server-rendered HTML; readable without JavaScript.
- Clean `<h2>`/`<h3>` hierarchy; descriptive Polish `alt` on every image; `lang="pl-PL"`; valid canonicals.
- FAQ answers are **visible text** in `<details>`, not JSON-LD-only.

### 5.2 Gaps to close

**a) Answer-first openings — highest impact.** Add a 40–60-word **"W skrócie"** block before the first `<h2>`, stating the answer outright. Use Chirpy's existing prompt style so no CSS is needed:

```markdown
> **W skrócie:** Administratorem danych pacjenta pozostaje placówka medyczna, nie dostawca oprogramowania. To ona ma 72 godziny na zgłoszenie naruszenia do UODO i to ona zawiadamia pacjentów na podstawie art. 34 RODO.
{: .prompt-info }
```

The 40–60 figure is a rule of thumb from featured-snippet studies, not a threshold. The point is: a self-contained answer that still makes sense when lifted out of the page.

**b) Question-shaped headings** where natural: `## Główne ustalenia` → `## Co ustalił UODO w decyzji DKN.5131.9.2024?`. Do not force every heading; it reads as SEO copy. **Changing a heading changes its anchor id** — check for inbound `#fragment` links first.

**c) FAQ coverage 14/31 → evergreen posts.** The mechanism works (`faq:` front matter → `{% include post-faq.html %}`). Candidates: `decyzja-uodo`, `wdrozenie-implementacja-nis2`, `ochrona-sygnalistow`, `bezpieczna-poczta-email`, `upowaznienia-elektroniczne`, `rada-rodzicow-w-szkole-publicznej`, `nagrywanie-transmitowanie-obrad-jst`. 3–4 questions each, taken from Search Console queries once Phase 0 yields data, not invented.

**d) "Stan prawny na …" — with an honest date.** Rev. 1 suggested stamping *"Stan prawny na 21.09.2026"* on every legal post. **Do not**: that asserts a legal review that has not happened, on posts from 2019–2021 covering law that has since changed (sygnaliści: the 2024 Act; NIS2: the KSC amendment). Rule: the date is the day *you* last checked the post against current law. Implement as front matter `legal_status_date:` rendered by a tiny include, so it is explicit and greppable. Reviewed posts get today's date; unreviewed ones get their publication date — which is exactly the warning a reader and an LLM need.

**e) Tables for comparative material** — deadlines, penalty breakdowns, ADO-vs-procesor. `kara-mcdonalds`, `rekordowa-kara-poczta-polska`, `decyzja-uodo-ops` (the three-part 33 700 zł penalty), `kanal-zewnetrzny`.

**f) Author box** — as `_includes/author-box.html`, included like `post-faq.html`. One paragraph: name, role, ISO/IEC 27001 lead auditor, links to `/about/` and `/contact/`. One include, not 31 pasted paragraphs.

**g) Thin posts.** By source word count (front matter excluded): **19 of 31 posts are under 700 words, 7 under 300** (`windows-7-koniec-wsparcia` 155, `15-dzien-ochrony-danych-osobowych` 168, `podrecznik-inspektora-ochrony-danych` 189, `upowaznienia-elektroniczne` 226, `decyzja-uodo` 228, `obsluga-zgloszen-zammad` 264, `14-dzien-ochrony-danych-osobowych` 278). Rev. 1 said 9 and 5; it counted rendered HTML including FAQ text. Length is not the goal — but `atak-mpk-krakow` (312) and `poradnik-uodo-naruszenia` (316) are **hubs of the main cluster** and the latter is a target of two internal links; those two plus `decyzja-uodo` and `upowaznienia-elektroniczne` are worth expanding. Leave the rest as archive.

**h) Date-anchored posts.** `windows-7-koniec-wsparcia`, the two *Dzień Ochrony Danych* posts and the COVID remote-schooling posts are historical. A one-line dated note at the top ("Wpis archiwalny z 2020 r. …") is enough; combine with (d).

**i) `llms.txt` extensions.** Add `## O autorze` and `## Usługi i kontakt` (same facts as §3.4, in prose). Optionally `/llms-full.txt` with full markdown of evergreen posts. Fix the charset (§1.5) first. Be realistic: as of 2026 no major crawler has committed to consuming `llms.txt`; it is cheap insurance, not a lever.

---

## 6. Additional recommendations

### 6.1 Social preview images — **medium**

**Zero posts** set `image:`; every shared link shows the same avatar. Generate 1200×630 cards from front matter (title + category) and set `image.path` + `image.alt`. Note Chirpy also renders `image` as the visible post header — check that is wanted, or the cards need to look good on-page too.

### 6.2 Self-host front-end assets — **medium, on-brand**

Every page loads from `fonts.googleapis.com`, `fonts.gstatic.com` and `cdn.jsdelivr.net`. A DPO's site sending every visitor's IP to Google Fonts is a poor look given LG München I (3 O 17493/20) and the wave of claims that followed.

**Correction to rev. 1**, which said the submodule was "present and wired": it is **not initialised** — `git submodule status` shows `-93e0345… assets/lib` and the directory is empty. Flipping `assets.self_host.enabled: true` today would 404 every stylesheet and script. Sequence:

1. `git submodule update --init --recursive`
2. `assets.self_host.enabled: true`
3. Production build; confirm `grep -rhoE '(href|src)="https?://[^/"]+' _site | sort -u` shows no `googleapis`, `gstatic` or `jsdelivr`.
4. Confirm `.production.sh` ships `assets/lib/` (it rsyncs `_site/`, so yes once the build includes it).
5. Add the submodule-init step to `CLAUDE.md` — a fresh clone will otherwise build a broken site.

### 6.3 Measurement — **high → Phase 0**

- **Search Console + Bing Webmaster Tools** first. Free, no visitor-side processing, and the only source of query data. Bing matters disproportionately: Copilot and ChatGPT search retrieve through its index.
- **Analytics:** the lowest-footprint option is already available — **GoAccess over the nginx access logs** on mydevil.net. No script, no third party, nothing to add to a privacy notice, and it sees AI crawlers and no-JS clients that script-based analytics cannot. If page-level dashboards are wanted later, GoatCounter or Umami (one line in `_config.yml`) — preferably self-hosted; a hosted instance is a processor relationship and should be treated as one.
- **IndexNow** ping at the end of `.production.sh`: host a key file at the site root, POST changed URLs. Reaches Bing/Yandex/Seznam — not Google.
- Record the **baseline** before Phase 1 ships: GSC impressions/clicks, AI-bot request counts from logs, and the manual citation check in §8.

### 6.4 Media — **low**

6.6 MB across 21 files, one WebP. Convert to WebP/AVIF, add `width`/`height`. The two Kali GIFs → looping MP4/WebM.

### 6.5 `/.well-known/security.txt` — **low, fitting**

Confirmed absent (404). RFC 9116; needs `Contact:` and `Expires:` (≤ 1 year — put the renewal in a calendar). A PGP key is already published at `/media/commons/public.key.txt`; reference it under `Encryption:`. Jekyll skips dot-directories: add `.well-known` to `include:`.

### 6.6 Theme currency

`Gemfile` `~> 7.5` resolves to 7.6.0 — current. The header comment in `.production.sh` still says v7.4.0; cosmetic.

---

## 7. Execution plan

Each phase ends with `bash tools/test.sh` and one Conventional Commit per logical change.

### Phase 0 — Baseline (~1 h, before anything else)
- [ ] Verify the site in Google Search Console and Bing Webmaster Tools; submit the sitemap
- [ ] Set up GoAccess (or chosen analytics) on the server logs (§6.3)
- [ ] Run and record the 10-question citation check (§8) — this is the "before" number

### Phase 1 — Defects (~2–3 h)
- [x] Breadcrumb URL fix + `jsonify` for all strings in `metadata-hook.html` (§1.1)
- [x] `exclude: CLAUDE.md` (§1.2) — in `_config.yml`, takes effect on next deploy
- [x] `seo: type:` front matter on all five tabs (§1.3); real meta descriptions on archives/categories/tags/contact
- [x] Feed override (§1.4): `assets/feed.xml`, limit 5→20, author resolved via `_data/authors.yml`, `xml_escape` dropped from the entry `title=` attribute (it was double-escaped). Full content deliberately **not** added — owner decision, §10.7
- [ ] Security headers + `charset=utf-8` on the server (§1.5) — **server-side, outside this repo; still outstanding**
- [x] Verification stub out of the sitemap (§1.6) — front matter `sitemap: false`, sitemap 185 → 184 URLs; text on the 404 page (§1.7) — `assets/404.html` override
- [ ] Deploy; re-run the `curl` checks from this audit

### Phase 2 — Structured data (~4–5 h)
- [x] `tools/check-jsonld.rb` wired into `tools/test.sh` (§3.8). It caught the percent-encoded category URLs while §3.3 was being written
- [x] Post `@graph` (§3.3)
- [x] `/contact/`: `ContactPage` + `ProfessionalService` (§3.4) — owner confirmed Mornel s.c. with full NIP/REGON/geo. IBAN left on the page as published (§10.4 still open)
- [x] `OfferCatalog` (4 services, all taken verbatim from `/about/` — no penetration tests); `worksFor` on `Person` (§3.5)
- [x] `Person` node: both job titles, extended `knowsAbout` (§11.3)
- [x] `CollectionPage` + `ItemList` on archives and generated category/tag pages (§3.6)
- [x] seo-tag JSON-LD strip plugin (§3.2b) — one JSON-LD block per page, 184/184
- [ ] Validate one URL per page type: validator.schema.org + Rich Results Test — **needs a deploy first**

### Phase 3 — Linking & taxonomy (~5–6 h, plus the pillar)
- [x] Back-fill `{% post_url %}` links, old → new (§4.3.1–2) — 15 → 63 links; posts with a contextual inbound link 9 → 30 of 31
- [x] Primary-source citations in the posts with none (§4.3.5) — EUR-Lex ELI for RODO/NIS2/2019/1937, eli.gov.pl for KSC + nowelizacja + sygnaliści + UdIP, orzeczenia.uodo.gov.pl for DKN.5131.9.2024. All URLs checked to resolve
- [x] `noindex, follow` on tags with < 3 posts (§2) — 119 of 133 tag archives
- [ ] Tag consolidation to ~30–40 tags (§2) — **still outstanding**, one pass, one commit
- [x] Pillar #1: *Naruszenie ochrony danych osobowych - przewodnik dla administratora* (§4.3.3) — pinned, ~1700 words, 3 tables, 6 FAQ, links out to 7 posts and back from 4. `legal_status_date` left unset pending the author's review
- [x] Post → `/contact/` CTA — via the author box on every post (§5.2f)
- [x] `/about/` → pillar
- [x] KSC / NIS2: `wdrozenie-implementacja-nis2` rewritten around the act as in force (§11.4.1) — wykaz deadline, CSIRT 24 h/72 h/month, art. 8c ust. 3 / 8e / 14, RODO-vs-KSC table, 5 FAQ, first external citations
- [ ] KSC / NIS2 posts 2–6 of §11.4, then pillar #2

### Phase 4 — AEO content pass (~45 min per post)

*Infrastructure done; the UODO cluster (7 posts) done; the AI cluster and the rest outstanding.*
Do **not** do all 31. Order: the 7 posts of the UODO cluster → the 5 AI posts → whatever Search Console shows impressions for. Roughly 12–15 posts, ≈ 10 h.
- [x] UODO cluster (7 posts): "W skrócie" (§5.2a), question headings (§5.2b), `faq:` on `decyzja-uodo` (§5.2c) — FAQ coverage 14 → 15 of 31
- [x] `wdrozenie-implementacja-nis2` (full rewrite) and the pillar
- [x] House style enforced: no em/en dashes in post-2022 posts; every question heading ends with `?` (humanizer §8, §20)
- [ ] Same pass on the 5 AI posts, then whatever Search Console shows
- [x] `legal_status_date` include (§5.2d) — opt-in via `legal: true`, set on 21 posts. **No date stamped on any post:** that field means "the author checked this post against current law on this day", and that review has not happened. Unreviewed posts show their publication date plus an explicit warning, which is the intended output
- [x] Author-box include (§5.2f) — appended to every post by `_plugins/post-footer-hook.rb`
- [x] One table added: causes of naruszenia mapped to decisions, in `poradnik-uodo-naruszenia`
- [x] Two more tables: CSIRT reporting chain and RODO-vs-KSC, in `wdrozenie-implementacja-nis2`; three in the pillar
- [ ] Remaining tables (§5.2e): `kara-mcdonalds`, `rekordowa-kara-poczta-polska`, `decyzja-uodo-ops`, `kanal-zewnetrzny`
- [x] Archival notes on dated posts (§5.2h) — `windows-7-koniec-wsparcia`, `google-g-suite-dla-szkol`, `szkolenie-dla-iod-sektor-oswiata`, plus dated update notes on `ochrona-sygnalistow`, `atak-mpk-krakow`, `ai-w-pracy-iod`, `bezpieczna-poczta-email`
- [x] Expanded `decyzja-uodo` 226 → 549 words (§5.2g)
- [ ] Expand the remaining thin hubs: `atak-mpk-krakow`, `poradnik-uodo-naruszenia`, `upowaznienia-elektroniczne`

### Phase 5 — Infrastructure (~3 h)
- [ ] Self-host assets, in the §6.2 order; then add a CSP (§1.5)
- [ ] Per-post OG images (§6.1)
- [ ] IndexNow in `.production.sh` (§6.3)
- [x] `llms.txt`: `## O autorze` + `## Usługi i kontakt`, both roles in the intro (§5.2i). `/llms-full.txt` not done (optional)
- [x] `security.txt` (§6.5) — `.well-known/` added to `include:`
- [ ] Media conversion (§6.4)
- [x] `tagline` → "Inspektor Ochrony Danych · Cyberbezpieczeństwo", site `description` rewritten, `llms.txt` and `/contact/` lead → both roles (§11.3)
- [x] Update `CLAUDE.md`: site scope (both roles), feed + 404 overrides, new plugin, submodule init, JSON-LD check, server-side gaps

---

## 8. How to measure

Baseline in Phase 0; re-check at 30 and 90 days after Phase 3 ships.

- **Manual citation check — the actual KPI.** Ask ChatGPT, Claude, Perplexity and Copilot (search enabled) the same ~10 Polish questions the site should own — *"kto odpowiada za wyciek danych z systemu medycznego — przychodnia czy dostawca?"*, *"ile czasu na zgłoszenie naruszenia do UODO?"*, *"czy upoważnienia RODO mogą być elektroniczne?"* — and log in a spreadsheet: date, engine, question, cited yes/no, which URL. Answers are non-deterministic; run each question three times and record the hit rate. Fix the question list now and do not change it.
- **Search Console / Bing:** impressions and position for the pillar's query cluster; indexed-page count falling as thin tags drop out.
- **Server logs:** requests by `GPTBot`, `ClaudeBot`, `PerplexityBot`, `OAI-SearchBot`, and the user-triggered agents (`ChatGPT-User`, `Claude-User`, `Perplexity-User`) — the latter mean someone's assistant fetched the page to answer a live question, the closest thing to an AI "impression".
- **Referrals** from `chatgpt.com`, `perplexity.ai`, `claude.ai`, `copilot.microsoft.com`.
- **`tools/check-jsonld.rb`** green on every build; Rich Results Test after each schema change.

With 31 posts and niche Polish queries the numbers will be small and noisy. Expect direction, not significance; do not over-read a single month.

---

## 9. Revision log — what changed from rev. 1 and why

| § | Rev. 1 said | Verified reality | Effect |
|---|---|---|---|
| 0, 4.1 | "Exactly one internal link on the site" | 15 links; grep missed `{% post_url %}` | Headline finding rewritten; task is back-filling, not starting from zero |
| 4.3 | Use `/posts/slug/` paths | Repo convention is `{% post_url %}`, which is build-validated | Recommendation reversed |
| 4.3 | Two of five "missing link" examples | Already present in the posts | Replaced |
| 3.1 | `/contact/` and archives emit `WebSite` | They emit **`BlogPosting`** with build-time dates | New defect §1.3, with a front-matter fix |
| 3.2 | "Out-specify" seo-tag; consumers will prefer the richer node | Unfounded; yields duplicate `BlogPosting` per post | Plugin option added |
| 1.1, 3.3 | Templates use `\| escape` | Live output contains `McDonald&#39;s` | `jsonify` throughout |
| 3.3 | `content`; avatar as `image` fallback | `content` in `head.html` is the full layout; avatar ≠ article image | Template corrected |
| 1.3 | Add `post.content \| xml_escape` | Template's global `replace '&'` would double-escape | Fix rewritten; full content made optional |
| 1.5 | 404 page is indexable | Returns HTTP 404; not in sitemap | Downgraded to a UX note |
| 6.5 | "Verify headers on the server" | Checked: none present; no charset on `.txt` | Promoted to defect §1.5 |
| 6.2 | Submodule "present and wired" | **Uninitialised, empty** — enabling would break the site | Safe sequence added |
| 1.2 | Exposes SSH port and rsync target (high) | Port 22 and the word "rsync"; no host or credentials | Medium |
| 5.2d | Stamp "Stan prawny na 21.09.2026" on every post | Would assert reviews that did not happen | Real review dates only |
| 5.2g | 9 posts < 700 words, 5 < 300 | 19 and 7 by source count | Corrected; prioritised by cluster role |
| 3.4 | Invented org name, `founder`, `employee`, service list | Not confirmable from the repo | Moved to §10 |
| 2 | Drop tag archives from sitemap | Does not de-index; mechanism for generated pages untested | `noindex, follow` rule instead |
| 3.3, 5.2i | — | FAQ rich results restricted since 2023; `llms.txt` uptake unproven | Expectations set |
| 7 | Measurement in Phase 5; pillars ×3 in "~4 h"; Phase 4 on all 31 posts | No baseline possible; estimates off by ~5× | Phase 0 added; one pillar; Phase 4 scoped to ~12 posts |
| 4.2 | "Five clusters" | Table lists six | Fixed |
| — | — | — | New: §3.8 JSON-LD build guard |
| 11 | *(rev. 3)* Site positioned as IOD only | Owner also acts as pełnomocnik ds. cyberbezpieczeństwa (KSC / NIS2) | `/about/` rewritten; §11 added; pillar #2 changed from AI to KSC / NIS2 |

---

## 10. Decisions needed from the owner

These block parts of Phase 2 and cannot be inferred from the repo:

1. **Entity:** should the business node be *Mornel s.c.* (registered name, `url` → mornel.com) with you as `worksFor`? What is your actual relationship — wspólnik, founder? Does mornel.com already publish its own `Organization` markup (if so, reuse its `@id` rather than minting a second one)?
2. **Services:** the exact list to declare in `serviceType` / `OfferCatalog`. Are penetration tests currently offered?
3. **Service area:** Poznań region, Wielkopolska, or nationwide remote?
4. **IBAN** on `/contact/` — keep or remove (§3.4)?
5. **seo-tag JSON-LD:** strip via plugin (§3.2b) or leave (§3.2c)?
6. **Analytics:** server logs only, or a script-based tool as well (§6.3)?
7. **Feed:** full content or summaries (§1.4)?
8. **`/about/` review (§11.2):** confirm the client-type sentence, the published conflict-of-interest rules, and the softened IOD task wording. Anything to add to *Kwalifikacje* — KSC/NIS2 training, ISO 22301, OC policy — only if it is true today.
9. **Tagline** wording for two roles (§11.3).

---

## 11. Second role: pełnomocnik ds. cyberbezpieczeństwa (KSC / NIS2) *(new in rev. 3)*

### 11.1 The gap

The owner works in two capacities — IOD, and pełnomocnik ds. cyberbezpieczeństwa under the KSC act as amended by Dz.U. 2026 poz. 252 (in force 3.04.2026, implementing NIS2). Before rev. 3 the site expressed one:

| Signal | State |
|---|---|
| `/about/` | was 100% IOD, meta description "Paweł Rosół - O mnie" → **rewritten, §11.2** |
| `tagline` in `_config.yml` | "Inspektor Ochrony Danych" |
| Site `description` | leads with "ochrona webaplikacji, ochrona REST … wydajność i optymalizacja" — a 2019 web-developer profile; it is the meta description of the home page **and of every category and tag archive** |
| `Person.jobTitle` | "Inspektor Ochrony Danych (IOD/DPO)" |
| `Person.knowsAbout` | no KSC, NIS2, SZBI, ciągłość działania |
| `llms.txt` intro | IOD only |
| Content | one post tagged NIS2 (Nov 2024 — about the directive only, predates the Polish act, 0 links, no FAQ) plus a mention in `atak-mpk-krakow` |

For an assistant asked *"pełnomocnik ds. cyberbezpieczeństwa outsourcing"* or *"kto wdraża KSC w spółce komunalnej"* there was nothing to retrieve.

### 11.2 `/about/` — done in rev. 3, needs owner review

`_tabs/about.md` was rewritten around both roles; production build verified (anchors resolve, seo-tag now emits `ProfilePage`, real meta description). Source for the KSC part: the owner's own working analysis of a pełnomocnik engagement, whose legal references were checked against ISAP texts. **Nothing client-specific was carried over** — no names, sector details, fees, dates or engagement decisions.

Structure: answer-first lead (both roles + ISO 27001) → *Czym się zajmuję* → *IOD* (existing text, condensed) → *Pełnomocnik ds. cyberbezpieczeństwa* (what the role is, scope of support) → *Kwalifikacje* → *Czy można łączyć obie funkcje?* → *Współpraca* → "Stan prawny: wrzesień 2026".

Deliberate choices to confirm (§10.8):

- **States plainly that "pełnomocnik ds. cyberbezpieczeństwa" is not a statutory function** and that responsibility stays with the kierownik podmiotu (art. 8c ust. 3), the role being support under art. 14. People search the colloquial title; saying what it legally is — when most competitors blur it — is the authority signal.
- **Publishes the conflict-of-interest safeguards** (art. 38 ust. 6 RODO): recommend-vs-decide, no executive permissions, separate contracts, effectiveness assessed by someone else, documented annual conflict review. A DPO's site advertising both roles without addressing this invites the question from a client's lawyer or from UODO; answering it first is a credibility gain. How much to publish is the owner's professional call.
- **IOD task wording softened** from performing to supporting ("Wsparcie w prowadzeniu rejestru…", "Opiniowanie dokumentacji…", "Wsparcie administratora w obsłudze incydentów…"). The old list described decision-type tasks, which sits badly next to a section explaining why the IOD must not decide.
- **Client types** ("jednostki sektora publicznego, spółki komunalne, placówki oświatowe, MŚP") inferred from blog categories — confirm.
- *Kwalifikacje* lists only what the old page already claimed plus technical experience. Not added because unverifiable from here: KSC/NIS2 training, ISO 22301, OC insurance, number of clients.
- Only three article numbers are cited (art. 8c ust. 3, 8e, 14), all taken from the verified analysis. Re-check after **28.10.2026**. *(Correction, 21.09.2026: rev. 3 described Dz.U. 2026 poz. 1003 as "further KSC changes". Checked against eli.gov.pl: poz. 1003 is the **ustawa z 3 lipca 2026 r. o systemach sztucznej inteligencji**, published 27.07.2026, in force 11.08.2026, which amends ten acts and has some provisions applying from 28.10.2026. Whether the KSC act is among the ten was not confirmed, so nothing in the content cites it.)*

### 11.3 Knock-on changes (not yet done)

- **`metadata-hook.html` `Person`:** `jobTitle` → `["Inspektor Ochrony Danych (IOD/DPO)", "Pełnomocnik ds. cyberbezpieczeństwa"]`; extend `knowsAbout` with "Krajowy system cyberbezpieczeństwa (KSC)", "Dyrektywa NIS2", "System zarządzania bezpieczeństwem informacji (SZBI)", "Zarządzanie ryzykiem", "Ciągłość działania". KSC services into `serviceType` / `OfferCatalog` (§3.4–3.5).
- **`_config.yml`:** `tagline` → e.g. "IOD · Pełnomocnik ds. cyberbezpieczeństwa" (renders under the name in the sidebar — check mobile width); rewrite `description` around RODO, KSC/NIS2, bezpieczeństwo informacji.
- **`llms.txt`:** both roles in the intro and in `## O autorze` (§5.2i).
- **`_tabs/contact.md`** `description` and any link titles saying "Kontakt z Inspektorem Ochrony Danych".
- **Author box (§5.2f):** both roles.
- **Taxonomy (§2):** keep `NIS2` and add `KSC` as first-class tags; consider a `Cyberbezpieczeństwo` category instead of the catch-all `Bezpieczeństwo`.
- **Note for the business itself:** a provider of managed cybersecurity services that reaches small-enterprise size is itself a *podmiot kluczowy* under the act. Irrelevant to the website today; relevant before describing Mornel s.c. in `Organization` markup with a growing team.

### 11.4 Content cluster to build

Currently 1½ posts, so pillar #2 cannot exist yet. In order:

1. **Refresh `wdrozenie-implementacja-nis2`** — speaks only of the directive; update to the act as in force, add "W skrócie", FAQ, `legal_status_date`, primary sources (ELI DU/2026/252, EUR-Lex 2022/2555). It is now linked from `/about/`, so it is the first thing a prospect reads.
2. *Podmiot kluczowy czy ważny? Kogo obejmuje ustawa o KSC po nowelizacji* — self-assessment with a table; include the registration and compliance deadlines.
3. *Pełnomocnik ds. cyberbezpieczeństwa — kto to jest, czy jest obowiązkowy, czy można go outsourcować?* — expands the `/about/` section; "nie jest funkcją ustawową" is the hook.
4. *Incydent a naruszenie ochrony danych: CSIRT i UODO — dwa tryby, dwa zegary* — 24 h / 72 h / 1 month vs 72 h; table; bridges into pillar #1.
5. *Czy IOD może być jednocześnie pełnomocnikiem ds. cyberbezpieczeństwa?* — the best single post idea in this audit: a real, frequently asked question, few authoritative Polish answers, and the author is a practitioner of exactly this arrangement. Expands the `/about/` section with WP243 and UODO practice.
6. *Odpowiedzialność kierownika podmiotu w KSC* — art. 8c–8e; aimed at the person who signs the contract.
7. Then the pillar: *Ustawa o KSC i NIS2 w praktyce — przewodnik wdrożeniowy*, pinned, linking all of the above. `atak-mpk-krakow` joins as the case study.

Write these from general law and practice. Engagement documents are a source of structure and verified citations, never of facts about a client.
