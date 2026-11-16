# CLAUDE.md — cjgregory.dev Portfolio Site

This file gives Claude Code context about this project so it can assist effectively without needing things explained from scratch.

---

## What this project is

A static HTML personal portfolio site for **Chris Gregory**, Senior Technical Delivery Manager, Durham UK. The site bridges professional delivery leadership credentials with hands-on technical depth via personal dev projects.

**Live domain:** `chrisjgregory.dev`
**Deployed via:** Cloudflare Tunnel → nginx container on Mac Mini (Docker)

---

## Owner

- **Name:** Chris Gregory
- **Location:** Durham, UK
- **Email:** chris@thegregorysonline.com
- **LinkedIn:** linkedin.com/in/chris-gregory-durham
- **GitHub:** github.com/gregochr
- **Phone:** +44 (0)793 951 5079
- **Availability:** Office-based NE England; hybrid/remote UK-wide

---

## File inventory

| File | Purpose |
|------|---------|
| `index.html` | Single-page site — all HTML, CSS, JS in one file |
| `favicon.svg` | Burnt orange CG monogram, rounded square |
| `img/` | All images — photos, WebP variants, project logos |
| `sitemap.xml` | Single-page sitemap for Google |
| `robots.txt` | Allows all crawlers, references sitemap |
| `Dockerfile` | nginx:alpine serving all static files |
| `nginx.conf` | Gzip, security headers, 30-day asset cache |
| `docker-compose.yml` | Service: cjgregory-site, port 8080:80 + cloudflared tunnel |
| `.env` | `TUNNEL_TOKEN=` placeholder — **never commit this** |
| `.gitignore` | Excludes `.env`, `.DS_Store`, `.idea/`, `*.iml` |
| `.github/workflows/ci.yml` | HTML lint, Docker build, commitlint on push to main |

---

## Design system ("Build Log", Nov 2026)

| Token | Value |
|-------|-------|
| Background | `#0f1115` (bands `#13161c`, cards `#171a21`, borders `#262b35`) |
| Text / soft / muted | `#e6e8ec` / `#c9ced6` / `#9ba3af` (muted is 7.4:1 on bg) |
| Accent | `#f2a541` amber (hover `#ffd08a`); dark text on amber buttons |
| Status green | `#6ccb8a` |
| Display font | Space Grotesk |
| Body font | Inter |
| Code/label font | JetBrains Mono |
| Theme | Dark, terminal-inspired |

Accessibility: WCAG 2.1 AA throughout. Skip link, `<main id="main">`, aria-labels on all sections, `aria-hidden` on decorative SVGs, `:focus-visible` styles, `prefers-reduced-motion` media query.

---

## Site structure

```
Nav          — "chris@durham:~$ whoami" home link, ./projects ./practice ./outside ./contact (sticky, backdrop-blur)
Hero         — name/tagline/lede/CTAs | CI pipeline panel (figure)
Projects     — 6 cards: PhotoCast · VBGone · Wainwrights · CineLight · CineFilm (in progress) · Liminal
Practice     — "Automate early. Test often. Ship frequently." + 4 practices
Outside      — Photography (Glencoe) · Wainwrights (Derwentwater) · Cricket
Contact      — "$ ping chris" + email / GitHub / LinkedIn (footer)
```

Positioning: builder portfolio, not job-seeking. Chris is Technical Delivery Manager at Euroclear.

---

## Projects showcased

### PhotoCast
AI-powered atmospheric forecasting app for landscape photographers.
- Stack: Java, Spring Boot, React, PostgreSQL, Docker, Claude AI, Open-Meteo, Cloudflare
- First app on the **Nephel platform**
- GitHub: github.com/gregochr/goldenhour

### VBGone
AI-assisted VB.NET → C# migration tool using the Claude API.
- Stack: Claude AI, C#, VB.NET, .NET, Spring Boot, Docker

### CineLight
Plex webhook handler that drives Philips Hue lighting scenes.
- Stack: Java, Spring Boot, Docker, Plex API, Philips Hue, Webhooks

---

## Deployment

```bash
docker compose up -d
# Site: http://localhost:8080
# Public: https://cjgregory.dev (via Cloudflare Tunnel)
```

The `cloudflared` service in `docker-compose.yml` reads `TUNNEL_TOKEN` from `.env`. Never hardcode the token. Get the token value from the Cloudflare Zero Trust dashboard.

---

## Images

Both images have WebP + JPEG versions served via `<picture>` elements:
- `castlerigg` — `loading="eager"` + `fetchpriority="high"` (above the fold)
- `photo` — `loading="lazy"` (below the fold)

Original high-res files kept as `photo_original.jpg` and `castlerigg_original.jpg`.

---

## SEO

- Meta description, canonical URL, Open Graph tags, Twitter card all in `<head>`
- JSON-LD `Person` structured data (name, jobTitle, location, sameAs LinkedIn + GitHub)
- `sitemap.xml` and `robots.txt` served by nginx
- Domain reference throughout: `https://cjgregory.dev` — update via find-and-replace once confirmed

---

## CI pipeline (GitHub Actions)

`.github/workflows/ci.yml` runs on push to `main`:
1. HTML lint (htmlhint)
2. Docker build validation
3. Conventional commit lint (commitlint)
4. JSON-LD structured data JSON validation

Commit style: **Conventional Commits** — e.g. `feat:`, `fix:`, `chore:`, `docs:`

---

## What not to change

- Colour contrast: every text colour above passes WCAG AA on its background — check before adding new shades.
- The `<picture>` elements for images — WebP fallback pattern is intentional.
- The `TUNNEL_TOKEN` must stay in `.env` and out of version control.
- Page has exactly one `<h1>` (the name). Keep it that way.
