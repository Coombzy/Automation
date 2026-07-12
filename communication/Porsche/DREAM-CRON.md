# Porsche dream + backup — orchestrator · skill: `agent-dream`

**Role lock:** Porsche = Ben PA / fleet planner / travel host (M4 Pro **24GB**).  
**Not** Doc. Do not bulk-implement or run 35B on this host.  
**Skill SSOT:** `agent-dream` (install from `skills/shared/agent-dream/` or Doc published copy)  
**Updated:** 2026-07-12 — aligned with Doc daily light + **Sunday deep** + backup tiers  

---

## Cadence (recommended)

| When | Backup | Dream |
|------|--------|-------|
| Daily 22:00 | `daily-porsche-backup.sh` → `backup/Porsche/daily/` | **light** (local 7–14B if possible) |
| Sunday 22:00 | + weekly promote | **deep** (use cloud if local model too small) |
| 1st of month | + monthly promote | per day |

If cloud cost is a concern: `0 22 * * 1,3,5,0` (M/W/F light + Sunday deep) instead of every day.

## Local models (24GB)

| Mode | Prefer |
|------|--------|
| light | Local 7B–14B Q4/Q5 (if installed); follow `references/checklist-card.md` first |
| deep | ≥12–14B local **or** Grok/cloud; do **not** load 35B on Porsche |

**Install skill from Doc share:**
```bash
mkdir -p ~/.hermes/skills/autonomous-ai-agents/agent-dream/references
cp -R ~/hermes-tools/Automation/skills/shared/agent-dream/* \
  ~/.hermes/skills/autonomous-ai-agents/agent-dream/
# backup wrapper
cp backup/Porsche/git-safe/scripts/daily-porsche-backup.sh ~/.hermes/scripts/
chmod +x ~/.hermes/scripts/daily-porsche-backup.sh
# requires daily-doc-backup.sh present (generic FLEET_AGENT) OR inline copy
cp backup/Doc/git-safe/scripts/daily-doc-backup.sh ~/.hermes/scripts/
```

## Cron fields

| Field | Value |
|-------|--------|
| name | `porsche-daily-backup-and-dream` (or keep separate backup + dream) |
| schedule | `0 22 * * *` (or M/W/F+Sun) |
| script | `daily-porsche-backup.sh` |
| skills | `agent-dream`, `token_preflight`, `project-car`, `fleet-mutual-improvement` |
| deliver | `#porsche-garage`; tire-shop only if HANDOFF for Doc |
| workdir | Automation clone |

## Prompt

```text
Load skill agent-dream. ROLE=Porsche. Mode from DREAM_MODE in script (deep Sunday).
Follow checklist in order. Digests: ~/Documents/Fleet-Memory/Dreams/Porsche/YYYY-MM-DD.md
Propose Doc HANDOFFs; do not bulk-implement. Caps: light≤5 promote, deep≤8. No secrets.
```

## Digests until Doc NC sync

Local: `~/Documents/Fleet-Memory/Dreams/Porsche/`  
Later mirror to Doc `Fleet-Nextcloud/Memory/Dreams/Porsche/`.

— Porsche-facing spec (maintained with Doc agent-dream skill)
