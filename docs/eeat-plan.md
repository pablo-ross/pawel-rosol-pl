# E-E-A-T plan - pawel.rosol.pl

**Date:** 2026-09-22 · **Revision 2** (rev. 2: phases E0, E1 and E2 implemented, see §0.1)
**Builds on:** `docs/aeo-geo-seo-audit.md` rev. 4. This plan does not repeat the audit; it takes the E-E-A-T thread (audit §5.2d, §5.2f, §11) and turns it into a dedicated programme. Where the two overlap, the audit's status lines stay authoritative.
**Method:** research against Google's current documentation and the September 2025 Search Quality Rater Guidelines, plus a read of the practitioner consensus on what AI answer engines weight in 2026; then a check of every finding against the repo and the production build in `_site/`.

---

## 0. Summary

E-E-A-T is *Experience, Expertise, Authoritativeness, Trust*. Google's rater guidelines call Trust "the most important member of the family": a page with no visible accountability is low quality however expert it looks. The site is squarely YMYL (law, money, security of other people's data), so the bar is the high one.

Three things changed the practical advice in the last two years, and they set the direction of this plan:

1. **Google now says what it wants, in its own docs.** The helpful-content self-assessment asks three questions verbatim: *Who* made it (a byline that "leads to further information about the author"), *How* it was made (including whether "the use of automation, including AI-generation, is self-evident to visitors"), and *Why*. ProfilePage structured data is a supported feature with documented properties. Article `author.url` must be "a web page that uniquely identifies the author".
2. **AI answer engines reward the visible, not the markup.** The recurring finding across 2026 practitioner data is that cited pages carry a named author with stated credentials, a visible *reviewed on* date distinct from the publish date, primary-source citations, and first-person evidence of having done the thing. Markup helps engines connect those facts; it does not substitute for them.
3. **The 2025 rater guidelines define generative-AI content and tell raters how to grade it.** Undisclosed, generic AI text is rated *Lowest*. Disclosed, author-verified use is not penalised. For a site that is edited with AI tooling, the honest disclosure is a trust asset, and silence is a liability.

### Where the site stands

| Letter | In place | Missing |
|---|---|---|
| **Trust** | Full NAP + NIP/REGON on `/contact/`; one `Person` `@id` referenced from every post; `dateModified` from git; `legal_status_date` mechanism; `security.txt`; CC BY licence | Byline links to the home page, not to `/about/`; **no publishing-principles page** (who/how/why, sources, AI use, corrections); no "nie stanowi porady prawnej" anywhere; no review date set on any of the 22 legal posts; security headers |
| **Experience** | `/about/` says the author practises both roles; author box on every post | **Only 2 of 32 posts contain first-person practice language.** Posts read as commentary on the law, not as reports from someone who applies it |
| **Expertise** | ISO/IEC 27001 lead auditor stated on `/about/`, in `hasCredential`, in the author box; `knowsAbout` list; 14 posts cite ELI / EUR-Lex | Credential is unverifiable (no issuing body, no year); `knowsAbout` are bare strings; citations are in-text only, not in `BlogPosting.citation` |
| **Authoritativeness** | `ProfilePage` on `/about/`; `Person.worksFor` → `ProfessionalService`; `sameAs` GitHub + Bluesky | No LinkedIn; no `rel="me"` back-links, so `sameAs` is one-directional; Bluesky handle lives on a different domain (`pross.cc`); `ProfilePage` lacks `dateCreated`/`dateModified`; `Person` has no `description`; no off-site presence to point at |

Realistic effort: the code and template work in §3 is about 4 hours. The content work (§3.2, review dates, `/about/` facts) is the owner's and cannot be delegated, because every sentence of it is a claim about the owner.


## 0.1 Status - 22.09.2026 *(new in rev. 2)*

Phases E0, E1 and E2 implemented in the repo. `bash tools/test.sh` green: 92 JSON-LD blocks on 92 pages, html-proofer clean. **Not deployed, not committed.** Two items in E1 need the owner's eyes before deploy (below).

| Item | Status |
|---|---|
| T1 byline → `/about/` | done, `_data/authors.yml`; the feed entry `<author>` now carries `<uri>` too |
| T2 `/zasady/` page | **done, needs owner review.** `zasady.md`, `layout: page`, `WebPage` node. The AI paragraph uses draft (b) because the git history shows AI-assisted drafting of posts, so draft (a) would be false. Confirm or reword before deploy |
| T3 wiring | done: author box, both branches of the legal stamp, `/about/`, `llms.txt`; `publishingPrinciples` on `Blog` and `BlogPosting`, `correctionsPolicy` on `ProfessionalService`; `check-jsonld.rb` verifies both URLs resolve |
| T4 disclaimer line | done, one sentence in `legal-status.html`, both branches |
| T5 review dates | owner |
| T6 verifiable credential | owner (issuing body, year) |
| T7 security headers | server-side, unchanged |
| X1, X2, X3 | owner |
| P1 `knowsAbout` with Wikidata | done; ISO/IEC 27001 resolved to Q852641 (verified 22.09.2026). Ustawa o KSC stays a string |
| P2 `sources:` → *Źródła* + `citation` | done: `_includes/post-sources.html`, `post-footer-hook.rb`, `metadata-hook.html`, CSS; populated on **15 posts** (the 14 with ELI/EUR-Lex plus the Poczta Polska decision). Every URL was asserted to exist in the post body before being cited. `check-jsonld.rb` rejects a citation without an absolute URL |
| P3 `/about/` qualifications | owner |
| A1 (d) `rel="me"` | not done: the profile links are rendered by the theme's sidebar, which adds `rel="me"` only for Mastodon; overriding `sidebar.html` is on the do-not-fork list. Revisit if (a)-(c) happen |
| A1 (a)-(c), A2, A4 | owner |
| A3 ProfilePage completeness | done: `dateCreated` from `date_created:` in the tab (first commit, 2020-11-22), `dateModified` from git via the lastmod hook now covering `_tabs`, `Person.description` read from the tab's `description:`, `alternateName` for the two handles, `Person.url` → `/about/` |

### Owner review before deploy

1. `/zasady/`, section *Czy korzystam z AI?* Is draft (b) accurate as written? Edit the paragraph if not.
2. `/zasady/`, section *Czy to porada prawna?* The page does not state whether the author is a qualified lawyer, because the repo does not say. Add one sentence only if it is true.
3. `/zasady/`, section *Skąd biorę informacje?* It claims that article numbers are checked against the consolidated text before publication and that practice examples are anonymised. Both must describe what actually happens.

---

## 1. Principles

These override everything below.

1. **Literally true.** Every credential, number, date and relationship in markup or prose is one the owner can defend on request. Structured data that overstates is worse than none; on a DPO's site it is also a professional-ethics problem.
2. **Visible first, markup second.** Nothing goes into JSON-LD that a reader cannot find on the page. Google's structured-data policy allows a manual action for markup that contradicts the visible page.
3. **Owner-supplied facts stay owner-supplied.** Items marked *owner* in §3 are left as placeholders until the owner answers §6. The implementer does not fill them in.
4. **No stamping.** `legal_status_date` means the author checked the post that day. This plan does not change that rule and does not automate it.
5. **House style applies.** Polish prose goes through the `humanizer` skill; no em dashes; `„…"` quotes preserved.

---

## 2. Diagnosis in detail

Each finding was checked in the repo or the production build.

**2.1 Byline points at the wrong page.** `_data/authors.yml` sets `url: https://pawel.rosol.pl/`, so the *Napisane przez* link on every post goes to the home page. Google's self-assessment asks whether "bylines lead to further information about the author"; the Article docs want `author.url` to uniquely identify the author. `/about/` is that page and already carries `ProfilePage`. One-line fix with the highest ratio of effect to effort on this list.

**2.2 No "how this site is made" page.** There is no place that states who writes, how facts are checked, what the review-date stamp means, whether AI tooling is used, how corrections are handled, or that the posts are not legal advice. Google's *How* question and the 2025 AI-content rules both point at this gap. It is also the natural target for `publishingPrinciples` (on `Blog` and `BlogPosting`) and `correctionsPolicy` (on the organisation node), both of which are currently absent.

**2.3 Experience is nearly invisible.** A grep for first-person practice phrases (*z mojej praktyki*, *u moich klientów*, *w mojej ocenie* and similar) matches 2 posts out of 32. The rater guidelines added Experience in December 2022 precisely to distinguish a practitioner from a summariser; this corpus, read cold, looks like the latter. The `/about/` page carries the practice claims, but a reader or an engine landing on a post sees none of it beyond the author box.

**2.4 Credential is stated, not verifiable.** *Auditor wiodący ISO/IEC 27001* appears in three places but never with the issuing body or year. `hasCredential` has `name` and `credentialCategory` only. Adding `recognizedBy` and a date is the difference between a claim and a checkable claim.

**2.5 Entity is thinly connected.** `sameAs` holds GitHub and Bluesky. Neither profile is confirmed to link back, so an engine cannot verify the identity in both directions. There is no LinkedIn, which in Poland is the profile a B2B prospect checks. `Person` has no `description`; `ProfilePage` has neither `dateCreated` nor `dateModified`, both recommended in Google's ProfilePage docs.

**2.6 Review dates: mechanism without data.** Recorded in the audit (§0.1 item 3). Restated here because "last reviewed" is the freshness signal AI engines look for on legal content, and a stale-or-absent one is read as a negative. Nothing to implement; the owner reviews posts.

**2.7 Citations are not machine-readable.** 14 posts link ELI or EUR-Lex in body text. `BlogPosting` has no `citation` property, so the link between "this post" and "this act" exists only for a reader.

**2.8 Security headers.** Audit §1.5, still open, server-side. A technical prospect checks this first; for a cybersecurity blog it is a trust signal in the literal sense.

---

## 3. Actions

Grouped by letter, Trust first. Each item: what, where, effort, and whether it needs the owner.

### 3.1 Trust

**T1 - Byline → `/about/`.** `_data/authors.yml`: `url: https://pawel.rosol.pl/about/`. The same value feeds `assets/feed.xml` (`<author><uri>`). 5 min. No owner input.

**T2 - Publishing principles page.** New root-level page, e.g. `zasady.md` with `layout: page`, `permalink: /zasady/`, `title: Zasady publikacji`, `seo: type: WebPage`. Not a sidebar tab, so no `tabs:` locale key is needed (`head.html` falls back to `page.title` for non-tab pages; verify the `<title>` guard in `tools/test.sh` is happy). Sections, in Polish:

- *Kto pisze* - one paragraph, both roles, link to `/about/`.
- *Jak powstają wpisy* - sources are primary (Dz.U./ELI, EUR-Lex, UODO decisions, EDPB); every article number is checked against the consolidated text; **the AI-tooling statement, see below**.
- *Stan prawny i przeglądy* - what `legal_status_date` means, what the warning on unreviewed posts means, and that a post is never silently back-dated.
- *Poprawki* - how to report an error, that corrections are made in place with `Aktualizacja` visible, and that substantive corrections get a note in the post.
- *Zastrzeżenie* - the posts are general information, not legal advice for a specific case; the author is a practitioner, not an adwokat/radca prawny (state only what is true).
- *Licencja i kontakt* - CC BY 4.0, link to `/contact/`.

The AI statement has to describe the real process. Two defensible drafts for the owner to choose or amend:

> (a) Teksty piszę sam. Przy redakcji, korekcie i formatowaniu korzystam z narzędzi, w tym asystentów AI. Każde odwołanie do przepisu, decyzji lub kwoty sprawdzam osobiście przed publikacją.

> (b) Przy pisaniu i redagowaniu wpisów korzystam z asystentów AI. Treść merytoryczna, wnioski i każde odwołanie do przepisu są moje i sprawdzam je przed publikacją; wpis, którego nie zweryfikowałem, nie trafia na stronę.

Neither may be published until the owner confirms it is accurate. Effort: 1.5 h including humanizer pass. **Owner: choose the AI statement; confirm the disclaimer wording.**

**T3 - Wire the page in.** Link from `_includes/author-box.html` ("Zasady publikacji"), from `_includes/legal-status.html` (the unreviewed warning links to the explanation), from `_tabs/about.md`, and from `llms.txt` under `## Strony`. In `_includes/metadata-hook.html`: `publishingPrinciples` on `Blog` and `BlogPosting`, `correctionsPolicy` on `ProfessionalService`. Extend `tools/check-jsonld.rb` so both URLs must resolve in the build. 45 min. No owner input.

**T4 - Disclaimer line on legal posts.** One sentence appended to `legal-status.html` on `legal: true` posts: not legal advice, link to `/zasady/`. Keep it to one line; the page carries the detail. 15 min.

**T5 - Review dates.** Owner reviews the twelve priority posts from audit §7 against current law and sets `legal_status_date` where the review actually happened. No implementer action.

**T6 - Verifiable credential.** `hasCredential` gains `recognizedBy: { "@type": "Organization", "name": "<issuing body>" }` and `dateCreated` or a `validFrom`, and `/about/` *Kwalifikacje* states the same body and year. 15 min once the facts arrive. **Owner: issuing body, year, whether a certificate number or a verification URL exists.**

**T7 - Security headers.** Audit §1.5. Server-side.

### 3.2 Experience

**X1 - Author box: one concrete sentence.** Today it names roles and sectors. Add one sentence of practice that a reader can weigh, of the form "od <rok> pełnię funkcję IOD w <n> organizacjach" or "wdrażam KSC w <sektor> od <rok>". Numbers only if true and only if the owner is comfortable publishing them. **Owner.**

**X2 - "Z praktyki" paragraphs in priority posts.** For each of the twelve posts in audit §7, one short paragraph of first-hand observation, anonymised: what the author has seen administrators get wrong, what the author does at that step, what a supervisory authority actually asked for. Rules: no client is identifiable; no case is invented; if there is nothing to say for a post, say nothing. The pattern is a paragraph, not a boxed callout, so it reads as the author's voice rather than a template. This is the single highest-value E-E-A-T change on the list and it is entirely owner-written. Implementer support: a checklist per post of where such a paragraph would fit.

**X3 - The experience post.** Audit §11.4 item 5, *Czy IOD może być jednocześnie pełnomocnikiem ds. cyberbezpieczeństwa?* The author practises the arrangement; the post is first-hand by construction. Already planned; listed here because it is the Experience showcase.

### 3.3 Expertise

**P1 - `knowsAbout` as disambiguated entities.** Replace the bare strings with `{ "@type": "Thing", "name": "...", "sameAs": "https://www.wikidata.org/wiki/Q..." }` where a stable identifier exists. Verified against the Wikidata API on 2026-09-22:

| Topic | Wikidata |
|---|---|
| RODO / GDPR | Q1172506 |
| Cyberbezpieczeństwo | Q3510521 |
| Dyrektywa NIS2 | Q130213702 |
| SZBI / ISMS | Q1662500 |
| Zarządzanie ryzykiem | Q189447 |
| Ciągłość działania | Q831801 |
| Inspektor Ochrony Danych | Q30682903 |
| Bezpieczeństwo informacji | Q189900 |
| Bezpieczeństwo aplikacji webowych | Q1509541 |
| Dane osobowe | Q3702971 |
| ISO/IEC 27001 | **not verified** (API rate-limited); look up before use |
| Ustawa o KSC | no Wikidata item found; keep as plain string |

Keep the Polish `name`; the identifier does the disambiguation. 30 min.

**P2 - `sources:` front matter → visible *Źródła* + `citation`.** A list of `{ name, url }` per post, rendered by a new `_includes/post-sources.html` (appended by `post-footer-hook.rb` before the legal stamp when present) and emitted as `BlogPosting.citation` (`CreativeWork` with `name` + `url`). Populate for the 14 posts that already link ELI / EUR-Lex, taking the links from the post body verbatim. Add a check to `check-jsonld.rb` that `citation[].url` is absolute. 1.5 h. No owner input for the 14; the owner adds sources to new posts as a habit.

**P3 - `/about/` *Kwalifikacje* with facts.** Body and year of the ISO certificate (T6); any KSC/NIS2 training with provider and year; anything else only if it is true today. **Owner.** The audit's §10.8 question is the same question.

### 3.4 Authoritativeness

**A1 - Bidirectional identity.** (a) GitHub profile: set the website field to `https://pawel.rosol.pl` and, if a profile README exists, link `/about/`. (b) Bluesky: the handle `pross.cc` is on a different domain; either add the site URL to the Bluesky bio or, cleaner, verify a `pawel.rosol.pl` handle via DNS and use that. (c) mornel.com should link to `pawel.rosol.pl/about/` as the person behind the IOD service, and its `Organization` markup, if any, should reuse `https://pawel.rosol.pl/#organization` or be referenced from it. (d) `rel="me"` on the site's own links to those profiles: Chirpy adds it only for Mastodon; add it to the two `sameAs` links on `/about/` in the page body. **Owner** for (a)-(c); 15 min for (d).

**A2 - LinkedIn.** If the owner has a profile, add it to `site.social.links` (feeds `sameAs`), to `_data/contact.yml` and to `/about/`. **Owner.**

**A3 - ProfilePage completeness.** `dateCreated` (first commit of `_tabs/about.md` from git, or an owner-chosen date), `dateModified` (git, as for posts: extend `posts-lastmod-hook.rb` to the `tabs` collection or read it inline), `Person.description` (the one-line bio already used as the `/about/` meta description), `Person.alternateName` for the handles. 30 min. No owner input.

**A4 - Off-site.** 2026 citation studies put most AI citations on third-party pages. Realistic, true options: a listing on the UODO-adjacent or industry directories the owner is actually in; conference or webinar appearances; guest posts on sector portals (samorząd, oświata, wod-kan). None can be manufactured from the repo; recorded so the owner can pick one. **Owner.**

---

## 4. Sequence

| Phase | Items | Effort | Blocked on |
|---|---|---|---|
| E0 - quick wins | T1, T3 (schema part), A3, P1 | ~1.5 h | nothing |
| E1 - principles page | T2, T3 (links), T4 | ~2.5 h | owner: AI statement, disclaimer wording |
| E2 - citations & credential | P2, T6 | ~2 h | owner: certificate facts |
| E3 - experience (owner) | X1, X2, X3, T5, P3 | owner time | owner |
| E4 - identity graph | A1, A2 | ~0.5 h + owner | owner |

E0 can ship today. E1 can be built in full with placeholders and shipped the day the owner picks the AI statement. E3 is the work that moves the needle and is the owner's alone.

Each phase ends with `bash tools/test.sh` and one Conventional Commit per logical change. Record status lines in this file, as the audit does, rather than rewriting sections.

---

## 5. Verification

- **Build:** `tools/test.sh` green; `check-jsonld.rb` extended for `publishingPrinciples`, `correctionsPolicy`, `citation[].url`.
- **Google:** Rich Results Test on `/about/` (ProfilePage) and one post; Schema Markup Validator on the home page for the full graph. Manual, after each phase that touches `metadata-hook.html`.
- **Visible check:** open one legal post cold and answer Google's three questions from the page alone: who wrote it, how it was made, why it exists. If any answer needs a click to `/about/`, that is acceptable; if it needs guessing, the phase is not done.
- **AI engines:** repeat the audit's §8 manual citation check (the same five prompts in ChatGPT search, Perplexity, Gemini, Copilot) 30 and 90 days after E1 ships, and note whether the author is named in the answer, not only the site.
- **Search Console:** still the missing baseline (audit Phase 0). E-E-A-T changes are slow and diffuse; without the baseline nothing here can be attributed.

---

## 6. Decisions needed from the owner

1. **AI-tooling statement** - draft (a), draft (b), or your own wording. It will be published on `/zasady/` and must be accurate.
2. **Disclaimer** - confirm "nie stanowi porady prawnej" wording and whether to state the author is not a qualified lawyer (only if true).
3. **ISO/IEC 27001 lead auditor** - issuing body, year, certificate number or verification link, if any.
4. **Practice figures** for the author box - since when, how many organisations, which sectors; or decline and keep the current wording.
5. **LinkedIn** - profile URL, or none.
6. **Bluesky** - keep `pross.cc` and add the site URL to the bio, or verify `pawel.rosol.pl` as the handle.
7. **mornel.com** - can it link back to `/about/`, and does it publish `Organization` markup?
8. **Off-site presence** - any directory, talk or publication that already exists and can be linked.
9. **Twelve priority posts** - which ones you will review for `legal_status_date` and a "z praktyki" paragraph first.

---

## 7. Sources

Primary:

- Google Search Central, *Creating helpful, reliable, people-first content* - the Who/How/Why self-assessment and the byline guidance. https://developers.google.com/search/docs/fundamentals/creating-helpful-content
- Google Search Central, *Profile page (ProfilePage) structured data* - required and recommended properties. https://developers.google.com/search/docs/appearance/structured-data/profile-page
- Google Search Central, *Article structured data* - `author.url`, `author.sameAs`, author best practices. https://developers.google.com/search/docs/appearance/structured-data/article
- Google Search Central Blog, *E-A-T gets an extra E for Experience* (Dec 2022). https://developers.google.com/search/blog/2022/12/google-raters-guidelines-e-e-a-t
- Wikidata API (`wbsearchentities`), queried 2026-09-22 for the identifiers in §3.3 P1.

Secondary (practitioner consensus, 2026; used for direction, not for facts about the site):

- Rankscale, *E-E-A-T signals for AI search* - bylines with credentials, reviewer blocks, visible review dates. https://rankscale.ai/resources/modules/content-gaps/e-e-a-t-signals
- Agenxus, *Author pages that AI trusts* - ProfilePage structure, credentials, disclosures. https://agenxus.com/blog/author-pages-ai-trusts-bios-credentials-citations
- Schemavalidator.org, *Person schema for authors* - `sameAs`, `hasCredential`, `knowsAbout`, stable `@id`. https://schemavalidator.org/guides/person-schema-authors
- seo-kreativ.de, *Google Quality Raters update 9/25* - the September 2025 guideline changes (AI-content definitions, YMYL categories). https://www.seo-kreativ.de/en/blog/google-quality-raters-update_9-25/
- LLMrefs, *Generative Engine Optimization: the 2026 guide* - citation behaviour of AI engines, share of off-site citations. https://llmrefs.com/generative-engine-optimization
