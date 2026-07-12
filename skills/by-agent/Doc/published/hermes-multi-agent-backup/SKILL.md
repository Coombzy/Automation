---
name: hermes-multi-agent-backup
description: "Organize, schedule, and retain Hermes profile backups across multiple agents on different hardware; git-safe mutual-audit packs for public repos; daily/weekly/monthly retention. Doc: 10pm launchd required ops; mutual process → fleet-mutual-improvement only."
version: 2.1.0
author: Agent + Doc host tailoring
license: MIT
platforms: [macos, linux]
metadata:
  hermes:
    tags: [hermes, backup, retention, multi-agent, cron, profile-export, mutual-audit, git-safe, doc]
    related_skills: [hermes-agent, project-car, fleet-mutual-improvement]
---

# Hermes Multi-Agent Backup

Class-level skill for Hermes profile backups when running multiple independent instances (Porsche, Doc Hakosuka, Lightning McKing) on different machines — plus **git-safe mutual audit** when the fleet repo is public.

## Doc host ops (this machine)

- **Daily 10pm launchd** recipe is **required ops**: script `~/.hermes/scripts/daily-doc-backup.sh` + plist `ai.hermes.doc-daily-backup` (`0 22 * * *`). Bootstrap may need Ben host approvals (see `communication/Doc/Doc-Todo.md`).
- Git-safe daily inventory allowed under `backup/Doc/git-safe/` — **never** commit profile tarballs, `.env`, or `auth.json`.
- Mutual-audit **process** points at **`fleet-mutual-improvement` only** (do not run dual weekly with deprecated `fleet-mutual-audit`).

## When to Use
- More than one Hermes agent/profile across hardware.
- Daily + weekly + monthly retention instead of infinite dailies.
- Agents should **peer-review** skills/config/workflows without sharing secrets.
- Exporting inventory to GitHub when the repo is **public** (e.g. `Coombzy/Automation`).

## Two backup layers (hard rule)

| Layer | Typical path | Git? | Contents |
|-------|--------------|------|----------|
| **Full local** | `backup/<Agent>/{daily,weekly,monthly}/` | **No** (gitignore) | `hermes profile export` tarballs (secrets risk) |
| **Git-safe** | `backup/<Agent>/git-safe/` | **Yes** | inventories, skill lists, redacted config, non-secret scripts, peer-audit reports |

**Never** commit: `.env`, `auth.json`, tokens, full profile `.tar.gz`, raw session DBs, detailed security-incident / 2FA recovery notes, mesh/SSH private keys.

Canonical fleet tree (Project Car):

```
Coombzy/Automation/backup/
├── MUTUAL-AUDIT-PROTOCOL.md
├── README.md
├── .gitignore          # daily|weekly|monthly|logs
├── Porsche|Doc|McKing/
│   ├── daily|weekly|monthly|logs/   # local only
│   └── git-safe/
│       ├── inventory-latest.json
│       ├── inventory-YYYY-MM-DD.json
│       ├── AUDIT-PACK.md
│       └── peer-audit-of-*-YYYY-MM-DD.md
```

Protocol detail: `references/mutual-audit-protocol.md`  
Legacy private-tree layout: `references/multi-agent-backup-structure.md`

## Full local backup + retention

### Private-tree layout (optional / older)
```
Porsche-backup/agents/<agent>/{daily,weekly,monthly}/
```

### Retention
- **0–30 days**: keep every daily in `daily/`
- **31–90 days**: weekly (e.g. Mondays) in `weekly/`
- **>90 days**: monthly (1sts) in `monthly/`

### Script responsibilities
1. `mkdir -p` target dirs (daily/weekly/monthly/logs **before** backup)
2. Create a durable archive in the daily folder
3. Apply retention (portable GNU vs BSD `date`)
4. Log; stay idempotent

**CLI detail:** `references/hermes-backup-cli.md` — use full `hermes backup -o` for daily zips; `--quick` is state-snapshots only.

### Cron
Each **machine** runs its own job (jobs do not hop hosts). Fleet target: **10pm local** (`0 22 * * *`) when online. Prefer `no_agent=true` shell scripts for pure backup ticks. Cloud-cost policy (Project Car): pause cloud-dependent agent crons until local LLM ready — pure backup scripts are fine.

**Doc:** use launchd label `ai.hermes.doc-daily-backup` + `daily-doc-backup.sh` (**full** backup into gitignored `daily/` with retention; git-safe inventory only for public repo).

## Git-safe mutual audit

**Canonical weekly procedure:** skill **`fleet-mutual-improvement`** only. Do **not** also run a separate weekly `fleet-mutual-audit` procedure.

### Purpose
Each agent publishes what makes it useful; peers adopt skills/config/workflows **without** secret exfiltration.

### Required files under `git-safe/`
| File | Owner |
|------|--------|
| `inventory-latest.json` | Exporting agent |
| `inventory-YYYY-MM-DD.json` | Exporting agent |
| `AUDIT-PACK.md` | Exporting agent |
| `peer-audit-of-<Subject>-YYYY-MM-DD.md` | Peer reviewer |
| `adopted-from-audit-YYYY-MM-DD.md` | Subject after applying |

### Inventory (safe)
Skill paths + short descriptions; redacted config (scrub key/token/secret/password/auth/credential/api_key/bot fields); non-secret scripts; cron purposes; role/hardware/home channel; memory **hashes + sanitized previews only** (no compromise/2FA detail); strengths + wants-from-peer.

### Peer checklist
Skills peer lacks · scripts/cron patterns · config patterns · workflow conventions · security drift · McKing handoff notes.

### Apply
Subject applies safe items → adoption note. **Ben** decides security/spend/architecture.

### Discord
Short `#tire-shop` HANDOFF with literal `<@bot_id>`; bulk work lives in git packs. 👀 without text → stalled turn, not “ignored” (see project-car `discord-fleet-channels.md`).

## New agent bootstrap (McKing-class)

1. Clean Hermes install; own Discord bot + garage home.
2. `hermes profile create mcking --clone …` for **scaffold** only.
3. Rewrite SOUL + role memory for coding/GPU/storage — do not import full PA persona.
4. Point at Automation + Project-Car-Docs + `backup/McKing/`.
5. Own 10pm backup cron + first git-safe export when online.

Half-fresh beats pure clone **or** pure blank.

## Pitfalls
- Public repo + full profile export = secret leak.
- MEMORY/USER with security-incident detail on git-safe — sanitize.
- Absolute paths break cross-machine scripts.
- macOS vs GNU `date` for retention.
- Cron is per-machine — re-create after migrate.
- Mutual audit ≠ auto-merge of profiles.
- Mega bot briefs often 👀-stall — stage work.

## References
- `references/mutual-audit-protocol.md` — steps + templates
- `references/multi-agent-backup-structure.md` — early private tree notes
- `references/hermes-backup-cli.md` — full vs `--quick` backup; Doc daily script contract
