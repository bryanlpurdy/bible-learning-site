# Firstlight — CLAUDE.md

## Project Overview

**Brand name: Firstlight** (placeholder — confirm final name before launch).

A beginner-friendly Bible learning site. Goal: welcome newcomers — skeptics, curious beginners, not scholars — with a warm, calm, non-institutional feel. No login required; site is entirely public for now.

Owner: Bryan Purdy (bryan.lee.purdy@gmail.com)

Long-term vision: content-rich learning paths, visual explainers, AI-powered Q&A (isolated to scripture, powered by Claude API), verse personalization, and social sharing.

---

## Current Pages

- **`index.html`** — Homepage: hero → nav strip → popular starting points → visual explainers teaser → verse of the day → footer.

---

## Planned Pages / Features

### Content pages (stub first, build out after homepage)
- **Getting started** — orientation for total beginners
- **Learning paths** — curated reading sequences
- **Search** — scripture and topic search
- **Ask a question** — AI-powered Q&A scoped to scripture (Claude API, future)
- **Visual guides** — illustrated explainers (Trinity, Bible timeline, Old vs. New Testament, etc.)
- **Verse of the day** — potentially personalized; currently static placeholder

### AI Q&A (future)
- Claude API call, system prompt restricts answers strictly to scripture and biblical context
- No general-purpose chat — scoped to "what does the Bible say about X" type questions

---

## Tech Stack

- **Vanilla HTML/CSS/JS — single file per page, no build step, no framework**
- Google Fonts: Cormorant Garamond (hero display), Spectral (section headings, verse text), Work Sans (body/UI)
- No backend yet — no auth, no database, no Supabase
- Static hosting: GitHub Pages

---

## Design Tokens

These exact values are used throughout and should not drift:

| Token | Value |
|---|---|
| Page background | `oklch(0.97 0.012 75)` |
| Surface (cards) | `oklch(0.995 0.004 75)` |
| Border | `oklch(0.9 0.015 70)` |
| Body text | `oklch(0.28 0.02 50)` |
| Muted text | `oklch(0.45 0.02 50)` |
| Muted2 | `oklch(0.5 0.02 50)` |
| Accent (CTA) | `oklch(0.42 0.1 55)` |
| Accent soft (hero CTA, eyebrow) | `oklch(0.42 0.06 55)` |
| Accent hover | `oklch(0.36 0.06 55)` |
| Explainer band | `oklch(0.95 0.025 65)` |
| Hero H1 | `oklch(0.24 0.02 50)` |
| Hero subhead | `oklch(0.36 0.025 50)` |

**Typography scale:**
- Hero H1: Cormorant Garamond 500, `clamp(52px, 6vw, 96px)`, line-height 0.95
- Section H2: Spectral 500, 26–30px
- Verse text: Spectral 400, 26px, line-height 1.5
- Body/UI: Work Sans 400/500/600
- Eyebrow labels: Work Sans 500, 13px, `letter-spacing: 0.18em`, uppercase
- Card titles: Work Sans 500, 17px
- Card descriptions: Work Sans 400, 14px

---

## Git & Deployment

- **Repo:** `https://github.com/bryanlpurdy/bible-learning-site`
- **Branch:** `main`
- **Hosting:** GitHub Pages (auto-deploys from `main` on push — takes ~1 min)
- **Live URL:** TBD (no custom domain yet)
- **Workflow:** edit locally → `git add` → `git commit` → `git push` → GitHub Pages redeploys

No CI, no build step, no package.json. Push and it's live.

---

## Assets

- `images/hero-image.png` — hero background (sunrise/golden-hour, open Bible on a rock at sunrise, AI-generated). Replace with final brand photography when available.
- Visual explainer icons in the current build are CSS-drawn placeholders (circles for Trinity, dots on a line for Bible timeline, split rectangle for Old vs. New). Replace with real illustrations when content is ready.

---

## Design Reference

Original high-fidelity design prototype and README live in `design/design_handoff_homepage/` (excluded from git via `.gitignore`). README is the authoritative spec for the homepage layout, exact copy, and interaction behavior.

---

## AI Coding Guidelines

### Think Before Coding
Don't assume. Before implementing, explicitly state assumptions, flag ambiguity, and ask for clarification when the request could be interpreted multiple ways.

### Surgical Changes
Touch only what you must. Don't improve unrelated sections or refactor working code while fixing something else. Match the existing style.

---

## Known Gotchas

- **`oklch()` colors** — used throughout for the warm, earthy palette. All modern browsers support them. Do not convert to hex or rgb equivalents.
- **No framework, no build step** — resist the urge to introduce npm, bundlers, or component libraries. One file per page.
- **Design folder is gitignored** — `design/` is excluded from the repo. The handoff files live locally only; CLAUDE.md captures the essential spec.
- **"Sign in" link is a stub** — no auth exists yet; keep it in the header as a placeholder for the eventual auth flow.
- **All nav links are `href="#"` stubs** — until content pages are built, these all point to `#`. Wire them to real routes as pages are added.
- **Hamburger dropdown closes on any outside click** — implemented via `document.addEventListener('click', ...)` checking `e.target.closest('.header-right')`. Do not break this by adding elements outside `.header-right` that should keep the dropdown open.
