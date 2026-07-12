# Doc dream + backup — specialist (thin) · skill: `agent-dream`

**Role lock:** Doc = heavy compute / local LLM / implementer. **Not** second PA.  
**Skill SSOT:** `agent-dream` (live `~/.hermes/skills/.../agent-dream`, shared `skills/shared/agent-dream/`)  
**Updated:** 2026-07-12 — daily light + **Sunday deep** + backup tiers  

---

## Cadence

| When | Backup | Dream mode |
|------|--------|------------|
| **Daily 22:00** | full zip → `backup/Doc/daily/` (keep 30) | **light** |
| **Sunday 22:00** | daily zip + copy → `weekly/` (keep 12) | **deep** |
| **1st of month** | daily zip + copy → `monthly/` (keep 24) | light or deep if Sunday |

Script emits `DREAM_MODE=light|deep` for the agent.

## Cron (Doc live)

| Field | Value |
|-------|--------|
| name | `doc-daily-backup-and-dream` |
| schedule | `0 22 * * *` |
| script | `daily-doc-backup.sh` |
| skills | **`agent-dream`**, `token_preflight`, `project-car`, `xai-model-selection` |
| deliver | `#doc-garage` |
| workdir | `~/hermes-tools/Automation` |
| model | Prefer **local** `qwen3.6:35b` or `gemma4:26b` when pin available |

## Local models

- **Doc 64GB:** `qwen3.6:35b` is appropriate for light **and** deep if checklist is followed.  
- Skill is written as **ordered checklist** so weaker models still work.  
- **Porsche 24GB:** use skill with 7B–14B local for light; deep may need cloud — see skill role matrix.

## Prompt (cron)

```text
Load skill **agent-dream** (and references/checklist-card.md if model is small).

ROLE=Doc. Read pre-script stdout: DREAM_MODE, BACKUP_*, MEMORY_CHARS, WEEKLY_PROMOTED.

Follow agent-dream checklist IN ORDER. Mode = DREAM_MODE from script (deep on Sunday).

Done-when:
1. Honor backup result (do not re-zip if BACKUP_OK=1).
2. Write digest under ~/Desktop/Fleet-Nextcloud/Memory/Dreams/Doc/YYYY-MM-DD.md
3. Prune/promote per skill caps (light ≤5, deep ≤8; MEMORY ~2200 char budget).
4. Metrics section required. Silent nights → DREAM_SILENT.
5. No secrets. No public git digests.
```

## Install / reinstall

```bash
# skill
mkdir -p ~/.hermes/skills/autonomous-ai-agents/agent-dream/references
cp -R skills/shared/agent-dream/* ~/.hermes/skills/autonomous-ai-agents/agent-dream/

# script
cp backup/Doc/git-safe/scripts/daily-doc-backup.sh ~/.hermes/scripts/
chmod +x ~/.hermes/scripts/daily-doc-backup.sh

# cron: remove old M/W/F-only dream; ensure daily job skills include agent-dream
```

## Do not

- Load launchd `ai.hermes.doc-daily-backup` in parallel (double backup).  
- Dual-PA memory.  
- Commit zip archives to public Automation.

— Doc
