# Website & Web App Specification

**Last Updated:** 2026-07-24  
**Status:** Living document  
**Part of:** Project Car documentation hierarchy  
**Maintained with:** Domain acquisition, Cloudflare Tunnel, and public site decisions from 2026-07-24

---

## 1. Purpose

This document covers the public website and any future web application surfaces for Project Car, including:

- Domain strategy and registration
- DNS / Cloudflare configuration
- Current hosting architecture (temporary → permanent)
- Public site status and roadmap
- Related email and supporting services

It sits alongside `high-level-apps-and-business-specification.md`, `integration-plan.md`, and `mission-control-architecture.md`.

---

## 2. Domain

| Item | Detail |
|------|--------|
| **Primary domain** | `projectcar.ca` |
| **Registrar** | Cloudflare Registrar |
| **Registration type** | Personal / Individual (Canadian Presence Requirements) |
| **Term** | 10 years (paid upfront) |
| **Auto-renew** | Enabled |
| **Domain lock** | Enabled by default (Cloudflare Registrar) |
| **2FA** | Required on Cloudflare account |
| **Registered** | 2026-07-24 |

### Notes
- Registered as personal because no corporation exists yet. Can be transferred to a Canadian corporation later via change of registrant if needed.
- Cloudflare chosen for tight integration with DNS, Tunnel, WAF, and at-cost pricing.
- Domain can be transferred to another CIRA-certified registrar after the initial 60-day lock if desired.

---

## 3. Current Hosting Architecture (as of 2026-07-24)

### Temporary setup (Doc)
- **Host:** Doc (M1 Max)
- **Stack location:** `/Users/dochak/hermes-tools/mission-control/website`
- **Runtime:** Docker Compose
- **Web container:** `mission-control-website` (nginx:1.27-alpine)
- **Port:** `8088` (chosen to avoid conflict with Nextcloud on 8080)
- **Local URL:** `http://localhost:8088`
- **Health check:** `http://localhost:8088/healthz` → ok
- **Tunnel target:** `http://host.docker.internal:8088`

### Cloudflare Tunnel
- Tunnel runs on Doc (temporary)
- Public hostnames:
  - `projectcar.ca` → `http://host.docker.internal:8088`
  - `www.projectcar.ca` → `http://host.docker.internal:8088`
- Existing other routes (leave intact):
  - `cloud.` → `:8080` (Nextcloud)
  - `vault.` → `:8222` (Vaultwarden)

### Planned migration
- Entire Docker stack (tunnel + website) will move to **McKing** approximately one month from registration date (when Ben is home).
- Compose uses relative paths (`./html`) so the folder is portable.

---

## 4. Public Site Status

**Live as of 2026-07-24**

- URL: https://projectcar.ca (and www)
- Content: Clean dark “Project Car / Coming soon” landing page
- Tagline: “Built for the work. Tuned for the road.”
- Message: “We’re putting the shop in order. Check back shortly.”
- Stack: Static HTML/CSS served by nginx in Docker

Files of interest:
```
mission-control/website/
  docker-compose.yml
  nginx.conf
  html/index.html
  html/styles.css
  README.md
```

---

## 5. Architecture Principles

- **Local-first origin** — Site originates from the homelab (Doc → McKing).
- **Cloudflare in front** — DNS, Tunnel, SSL, CDN, basic DDoS/WAF via free plan.
- **No open inbound ports** — cloudflared outbound only.
- **Portable Docker** — Compose-based so the same stack can move between machines with minimal change.
- **Performance** — 3 Gb home internet + 10 Gb internal networking is more than sufficient for expected traffic.

Self-hosting cost is effectively electricity only once hardware is in place (near $0/month cash cost vs typical $10–30/month managed hosting).

---

## 6. Email (related)

Decision lean: **Proton Mail Plus** for `@projectcar.ca` (custom domain support, 15 GB is ample when files live on McKing/Nextcloud).

- Nextcloud Mail will act as the client once mailboxes exist.
- Full self-hosted mail (Mailcow etc.) is a later option; migration from managed is medium difficulty and planned as a future step.
- Proton requires Bridge for IMAP/SMTP access from Nextcloud.

*(Final email provider choice still open for confirmation.)*

---

## 7. Agent / API Access

- Hermes (or designated agent) may receive a **scoped Cloudflare API token** focused on DNS + Tunnel management.
- High-risk registrar actions (unlock, ownership changes, deletion) stay manual.
- Global API Key should be avoided in favor of least-privilege tokens where possible.

---

## 8. Roadmap (near term)

| Priority | Item | Status |
|----------|------|--------|
| 1 | Domain registered + locked + 10-year term | Done |
| 2 | Cloudflare Tunnel + basic landing page live | Done (on Doc) |
| 3 | This specification document | Done |
| 4 | Improve landing page content / identity (optional) | Next |
| 5 | Email (`@projectcar.ca`) decision + setup | Pending |
| 6 | Basic uptime monitoring | Pending |
| 7 | Migrate full Docker stack Doc → McKing | ~1 month |
| 8 | Longer-term web app / customer portal direction | Later |

---

## 9. Multiple Tunnels (future note)

One tunnel is sufficient for the current public site. Additional tunnels are likely later for:

- Machine separation (Doc / McKing / Porsche)
- Public vs private service isolation (website vs Mission Control / Vaultwarden / agents)
- Cleaner failure domains

---

## 10. Related Documents

- `high-level-apps-and-business-specification.md`
- `integration-plan.md`
- `mission-control-architecture.md`
- `home-lab-specification.md`
- `security-playbook.md`

---

**Synchronized with Project Car documentation practice.**  
**Initial capture of 2026-07-24 domain + tunnel + live site decisions.**
