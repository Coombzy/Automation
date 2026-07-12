---
name: macos-security-hardening
description: "Harden macOS for local AI / Hermes travel hosts without killing performance."
version: 1.0.0
author: Porsche (adopted from Doc Hakosuka mutual-audit teachings 2026-07-11)
license: MIT
platforms: [macos]
metadata:
  hermes:
    tags: [macos, security, local-ai, travel, hermes]
    related_skills: [hermes-agent, hermes-multi-agent-backup]
---

# macOS security hardening (local AI hosts)

Use on Porsche (travel M4 Pro) and when reviewing Doc/McKing Mac setups. Goal: safer local AI without destroying performance.

## Principles

1. **Least exposure** — Ollama / local APIs bind to `127.0.0.1` by default; do not LAN-expose without Ben OK + auth.
2. **Job-scoped stay-awake** — prefer `caffeinate` for long jobs over permanently disabling sleep.
3. **No secrets in public git** — Automation is public; never commit `.env`, `auth.json`, profile tarballs.
4. **Ben is decision-maker** on security changes, especially after compromise concerns.
5. **Performance budget** — Full Disk Access / permissions issues are real on this fleet; fix permissions surgically, don’t disable SIP.

## Always-on recipe (safe)

```bash
# Long local job (display + system idle prevention while plugged in)
caffeinate -dims -t 7200 &   # example: 2h

# Or scope to a process
caffeinate -dims ollama serve
```

- Prefer **AC power** for large local models.
- Gateway: run under **launchd/user service** so Discord survives without a GUI session.
- Optional apps (Ben baseline): Amphetamine, coconutBattery; Porsche already has **AlDente** for battery hold ~60% when plugged.

## Local model exposure checklist

Before any non-localhost serve:

- [ ] Ben explicit OK
- [ ] Bind address / firewall reviewed
- [ ] No secrets in model server logs
- [ ] Mesh/VPN preferred over raw public port

## Hermes / disk hygiene

- Profile exports → gitignored `daily/weekly/monthly` only
- git-safe inventories only in `Coombzy/Automation/backup/<Agent>/git-safe/`
- Redact serials, hardware UUIDs, tokens from any public export
- Keep `approvals.mode` per Ben policy (Porsche: off / full autonomy on trusted host)

## Permissions (common fleet pain)

If tools hit **operation not permitted**:

1. System Settings → Privacy & Security → Full Disk Access (Terminal / Hermes / Python as needed)
2. Re-check after macOS updates
3. Prefer operating under allowed home/Documents paths when FDA is flaky

## Do not

- Disable SIP casually
- Store recovery codes / 2FA material in agent memory dumps destined for public git
- Install random “security bypass” hub skills
- Open Ollama to `0.0.0.0` without a plan

## Verification

- `caffeinate` available; gateway service stable
- Ollama only on localhost unless documented exception
- Public Automation tree has no secrets (`git grep` / review before push)
