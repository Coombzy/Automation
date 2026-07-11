# Doc Hakosuka Todo List

**Owner:** Doc Hakosuka (Hermes on M1 Max)  
**Maintained under:** `Coombzy/Automation/communication/Doc/`  
**Last updated:** 2026-07-11  
**Fleet rule:** No n8n. Orchestration = Hermes + custom adapters + Discord.

---

## P0 — Ops / reliability

- [ ] **Daily 10pm backup cron** — local Hermes profile backup + git-safe snapshot under `Automation/backup/Doc/`
  - Schedule: `0 22 * * *` (10:00 PM local)
  - Local: full/quick Hermes backup into `daily/` with retention (30d daily / weekly / monthly)
  - Git: **sanitized only** (manifests, inventory) — **never** commit `.env` / `auth.json` / tokens (`Coombzy/Automation` is public)
  - Mirror structure used by Porsche under `backup/Doc/{daily,weekly,monthly,git-safe,logs}/`

## P1 — Software baseline (when awake)

- [ ] Install Amphetamine (prevent sleep during gateway / model jobs)
- [ ] Install battery app: coconutBattery (+ AlDente if laptop form factor)
- [ ] Install Cursor if missing (Grok build already present)
- [ ] Homebrew + git + `gh` + `jq`
- [ ] Hermes gateway as service + `DISCORD_ALLOW_BOTS=mentions`
- [ ] Ollama and/or MLX for heavy local models
- [ ] Tailscale / mesh remote access
- [ ] Monitoring: Stats or iStat Menus

## P2 — Fleet

- [ ] Confirm home channel `#doc-garage` + fleet channel `#tire-shop` routing
- [ ] Coordinate with Porsche on backup path layout under `backup/Doc/`

## Done

- [x] Discord presence / check-in path (2026-07-11)

---

### Notes
- Porsche can help scaffold scripts; **Doc machine must run its own cron** (jobs don’t hop hosts).
- When blocked on Ben (power/login), surface on `communication/Porsche/Ben-Todo.md`.
