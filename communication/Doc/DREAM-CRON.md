# Doc dream + backup cron — specialist / host consolidation (thin)

**Role lock:** Doc = heavy compute / local LLM / implementer.  
**Not** a second PA. Do **not** dream Ben’s full life story or own fleet todos.

**Created:** 2026-07-12  
**Updated:** 2026-07-12 — **daily with backup** (Mon/Wed/Fri-only dream removed)  
**Install on:** Doc host only  

---

## Goals

1. Run **local Hermes backup** first (`~/.hermes/scripts/daily-doc-backup.sh` → gitignored `backup/Doc/daily/`).  
2. Consolidate **host / specialist** facts (Ollama, disk, failed jobs, local routing).  
3. Write a short dream digest:  
   `~/Desktop/Fleet-Nextcloud/Memory/Dreams/Doc/YYYY-MM-DD.md`  
4. Optionally refresh thin Hermes MEMORY (host-only) — never inflate USER into dual-PA.  
5. Scan `Handoffs/active/` for Doc-owned work; if blocked, note one line for Porsche.  
6. **Silent** Discord if nothing important beyond a quiet successful backup (`DREAM_SILENT`).

---

## Schedule (current)

```text
0 22 * * *
```

**Daily 22:00 local** (Doc machine timezone).  
Single Hermes cron job runs **backup script → then dream agent**.

| Field | Value |
|-------|--------|
| name | `doc-daily-backup-and-dream` |
| job_id | `0111562255ba` (as of install; verify with `hermes cron list`) |
| schedule | `0 22 * * *` |
| script | `daily-doc-backup.sh` (under `~/.hermes/scripts/`) |
| skills | `token_preflight`, `project-car`, `xai-model-selection` |
| deliver | `#doc-garage` (`discord:1524975085755170897`) |
| workdir | `/Users/dochak/hermes-tools/Automation` |

**Do not** also load launchd `ai.hermes.doc-daily-backup` for the same 22:00 window — that would double-run the backup zip. Prefer this Hermes cron as the SSOT for daily backup+dream.

---

## Removed (historical)

- `doc-dream-specialist` — `30 23 * * 1,3,5` (Mon/Wed/Fri only) — **removed** 2026-07-12 per Ben (fold into daily backup).

---

## Install / reinstall

```bash
cd /Users/dochak/hermes-tools/Automation
git pull --ff-only origin main

# Remove old M/W/F dream if still present:
# hermes cron list  →  hermes cron remove <old-id>

# Create combined job (agent tool or ask Doc):
# schedule 0 22 * * *
# script: daily-doc-backup.sh
# prompt: see Prompt section below
# skills: token_preflight, project-car, xai-model-selection
# deliver: discord:#doc-garage
# workdir: Automation clone
```

Ensure Nextcloud desktop tree exists (`NEXTCLOUD-DESKTOP-STRUCTURE.md`).

---

## Prompt (cron `prompt` — self-contained)

```text
You are Doc Hakosuka running the scheduled **daily backup + specialist dream** job.

CHARTER LOCK: specialist / heavy compute / local LLM implementer on M1 Max 64GB. You are NOT Porsche (PA/coordinator). Do not own Ben's day-to-day todos. Do not become dual-PA. Thin memory only.

A pre-run script already ran `daily-doc-backup.sh`. Its stdout is in your context (backup log). Do NOT re-run a full hermes backup zip unless the script clearly failed.

## Done-when
1. Confirm backup script outcome from the injected log (success path/bytes, or WARN/fail). If failed, note blocker for Ben; do not invent success.
2. Write dream digest to:
   - Prefer: ~/Desktop/Fleet-Nextcloud/Memory/Dreams/Doc/YYYY-MM-DD.md
   - Fallback: ~/Desktop/Doc-Dreams/YYYY-MM-DD.md if Fleet-Nextcloud missing (note blocker)
3. Optionally consolidate Hermes MEMORY.md host-only facts (Ollama models, bind localhost, always-on). Do NOT rewrite USER.md into a Ben PA profile.
4. Check ~/Desktop/Fleet-Nextcloud/Handoffs/active/ for Doc-owned packets; if any, list status (not started / in progress / blocked).
5. If nothing material beyond a successful quiet backup: write digest with "## Silent" and end with DREAM_SILENT (no fleet spam).
6. Never commit secrets. Never put .env / tokens / serials in digests. Never push private digests to public git.

## Steps
1. Restate charter in one line.
2. Summarize backup result from script output (path, size, retention prune notes).
3. Gather cheap host signals (timeouts short): date, disk free, ollama list (5s), Fleet-Nextcloud exists?, Handoffs/active names only.
4. session_search only if needed for Doc technical decisions last day — not Ben life history.
5. Write digest sections:
   - Backup result
   - What happened (host/work)
   - Local LLM / routing notes
   - Open implement loops
   - MEMORY.md host tweaks (if any)
   - Handoffs status
   - Asks for Porsche (max 3 bullets, only if real)
6. Keep digest under ~80 lines. Prefer facts over prose.
7. Final response: backup one-liner + path to digest + summary, or DREAM_SILENT if silent.

## Anti-goals
- No skill-count parity work
- No full mutual-audit unless separately requested
- No inventing Nextcloud Docker install
- No second backup zip if script already succeeded
- No public git push of private digests
```

---

## Verify

```bash
hermes cron list
# expect: doc-daily-backup-and-dream  |  0 22 * * *  |  script daily-doc-backup.sh
```

Optional dry-run: `hermes cron run <job_id>` when you want a one-shot test (creates a real backup zip + digest).

— Doc · daily backup+dream SSOT
