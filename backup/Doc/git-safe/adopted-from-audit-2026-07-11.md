# Adopted from mutual audit — Doc (2026-07-11)

**Agent:** Doc Hakosuka  
**Sources:** Porsche git-safe pack + `peer-audit-of-Doc-2026-07-11.md` + fleet docs in `Coombzy/Automation`  
**Date:** 2026-07-11

## Context

Porsche’s skill **payloads** (full original SKILL trees) are not in the public repo—only inventories. Doc therefore:

1. Re-read Porsche’s pack + Porsche→Doc peer audit
2. Re-read fleet docs (`Docs/*`, todos, backup protocol, constitution, heartbeat standards)
3. **Installed Doc-side skill implementations** derived from those public sources + audit “steal” list
4. Added local backup script

## Adopted (done)

| Item | Status | Where |
|------|--------|--------|
| `project-car` skill | **Adopted** | `~/.hermes/skills/autonomous-ai-agents/project-car/` (+ references: constitution, agent-profiles, heartbeat-standards, fleet md) |
| `token_preflight` | **Adopted** | `~/.hermes/skills/autonomous-ai-agents/token_preflight/` |
| `token_optimizer` | **Adopted** | `~/.hermes/skills/autonomous-ai-agents/token_optimizer/` |
| `hermes-multi-agent-backup` | **Adopted** | `~/.hermes/skills/hermes-multi-agent-backup/` |
| `mission-control-development-heartbeat` | **Adopted** | `~/.hermes/skills/software-development/mission-control-development-heartbeat/` |
| `fleet-mutual-audit` | **Already present** | Kept; process skill for exports/peer audits |
| GitHub as todo source of truth | **Adopted (behavior)** | Use `communication/Doc/Doc-Todo.md` + Porsche README-Todos conventions |
| No-n8n / Hermes-only orchestration | **Adopted (behavior)** | Locked into project-car skill + memory |
| Handoff / done-token style | **Adopted (behavior)** | Match Porsche handoffs when Doc owns tasks |
| GitHub write auth on Doc | **Adopted** | `gh` as Coombzy (repo scope) — unblocked after Ben |
| `daily-doc-backup.sh` | **Installed** | `~/.hermes/scripts/daily-doc-backup.sh` (executable) |
| Discord routing (mention / tire-shop no-thread) | **Already applied** | config.yaml |

## Deferred / blocked

| Item | Why |
|------|-----|
| **Bit-identical copy of Porsche’s original skill files** | Not published to public git; only names/descriptions in inventory. Doc versions are faithful fleet adaptations. If Porsche later shares private skill tarballs, re-diff and merge. |
| **launchd 10pm schedule load** | Install command was approval-blocked mid-session. Script is ready; Ben or Doc should run the launchd bootstrap below. |
| **First full local `hermes backup --quick` run** | Same — run via script after schedule install or manually once. |
| **`approvals.mode: off`** | Porsche notes Ben wants fleet autonomy; Doc `config.yaml` has no `approvals` block currently (CLI still prompted for some script patterns). **Not flipped without explicit Ben OK in this pass.** |
| **Amphetamine / AlDente / coconutBattery** | Software baseline still needs human install on Doc. |
| **Kanban orchestrator/worker skills** | Nice-to-have until dual-profile worker mode starts. |

## launchd install (run on Doc, normal Terminal)

```bash
mkdir -p ~/Library/LaunchAgents \
  ~/hermes-tools/Automation/backup/Doc/{daily,weekly,monthly,logs}

cat > ~/Library/LaunchAgents/ai.hermes.doc-daily-backup.plist <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>ai.hermes.doc-daily-backup</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/bash</string>
    <string>/Users/dochak/.hermes/scripts/daily-doc-backup.sh</string>
  </array>
  <key>StartCalendarInterval</key>
  <dict>
    <key>Hour</key><integer>22</integer>
    <key>Minute</key><integer>0</integer>
  </dict>
  <key>StandardOutPath</key>
  <string>/Users/dochak/hermes-tools/Automation/backup/Doc/logs/launchd-stdout.log</string>
  <key>StandardErrorPath</key>
  <string>/Users/dochak/hermes-tools/Automation/backup/Doc/logs/launchd-stderr.log</string>
  <key>EnvironmentVariables</key>
  <dict>
    <key>PATH</key>
    <string>/Users/dochak/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin</string>
    <key>HOME</key>
    <string>/Users/dochak</string>
  </dict>
</dict>
</plist>
EOF

launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/ai.hermes.doc-daily-backup.plist
# test once:
~/.hermes/scripts/daily-doc-backup.sh
```

## Rejected (intentionally)

- Becoming a second PA / scheduler (role mismatch)
- Copying Porsche gaming/red-team/creative sprawl
- Putting full backup zips or secrets in public git
- Blind 1:1 skill count parity (96) without role fit

## Next

1. Ben: approve launchd install + optional `approvals.mode` policy
2. Optional: Porsche private-share original skill trees for merge
3. After schedule works: check Doc-Todo P0 backup item
4. Re-export git-safe inventory when convenient (skills_count will rise)

## Honesty note

Earlier in the mutual-audit, Doc wrote **what to steal** but had not yet **installed** process skills. This document is the apply phase.
