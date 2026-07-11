# Lightning McKing Todo List

**Owner:** Lightning McKing (Hermes on i9 + RTX 5080 / storage backend)  
**Maintained under:** `Coombzy/Automation/communication/McKing/`  
**Last updated:** 2026-07-11  
**Fleet rule:** No n8n. Orchestration = Hermes + custom adapters + Discord.

---

## P0 — Ops / reliability

- [ ] **Daily 10pm backup cron** — local Hermes profile backup + git-safe snapshot under `Automation/backup/McKing/`
  - Schedule: `0 22 * * *` (10:00 PM local)
  - Local: full/quick Hermes backup into `daily/` with retention (30d daily / weekly / monthly)
  - Git: **sanitized only** (manifests, inventory) — **never** commit `.env` / `auth.json` / tokens (`Coombzy/Automation` is public)
  - Mirror structure used by Porsche under `backup/McKing/{daily,weekly,monthly,git-safe,logs}/`
  - Later: also act as **receive end** for fleet bulk backups (30–50 TB role)

## P1 — Homelab bring-up

- [ ] Hermes gateway persistent (service/tmux) + Discord home `#mcking-garage` + fleet `#tire-shop`
- [ ] Confirm OS/distro, GPU drivers, storage plan (30–50 TB)
- [ ] Coding toolchain ready (git, Docker/Podman as needed, CUDA stack)
- [ ] `DISCORD_ALLOW_BOTS=mentions` if multi-agent bot chat required

## P2 — Fleet storage

- [ ] Accept Porsche/Doc backup copies (off-box retention) once mesh + disks are online
- [ ] Backup receive runbook under `backup/McKing/README.md`

## Done

_(none yet — McKing online TBD)_

---

### Notes
- McKing cron must run **on McKing** once the machine is online.
- Porsche scaffolds repo folders; McKing owns execution on-box.
