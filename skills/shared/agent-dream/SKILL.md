---
name: agent-dream
description: "Use for scheduled agent dreams (offline memory consolidation): daily light or weekly deep. Works for Doc (specialist, 64GB) and Porsche (PA, 24GB). Prefer local LLM. Backup script first when co-scheduled."
version: "1.0"
---

# Agent Dream (fleet)

**What:** Offline memory consolidation ("dream") — NOT weight training, NOT chat therapy.  
**Who:** Doc *or* Porsche (set role). McKing later.  
**When:** After daily backup (preferred) or standalone maintenance.

## Local model guidance (IMPORTANT)

| Host | RAM | Prefer for dream | Fallback |
|------|-----|------------------|----------|
| **Doc** | 64GB | `qwen3.6:35b` or `gemma4:26b` | Grok only if Ollama down |
| **Porsche** | 24GB | 7B–14B class local if available (Q4/Q5); else light cloud | Do **not** try 35B on 24GB |
| Either | — | Tight checklist below — small models succeed if they **follow steps in order** | |

**Qwen 3.6 35B on Doc:** Yes — strong enough for light *and* deep if steps stay bounded.  
**Porsche smaller models:** Use **light** mode with hard caps; run **deep** only if model ≥~12–14B or use cloud for deep only.

## Role lock (pick ONE)

### Doc (specialist)
- Heavy compute / local LLM / implementer.
- NOT second PA. No Ben life todos. Thin host memory only.
- Digests: `~/Desktop/Fleet-Nextcloud/Memory/Dreams/Doc/YYYY-MM-DD.md`
- Fallback: `~/Desktop/Doc-Dreams/YYYY-MM-DD.md`

### Porsche (orchestrator)
- Ben PA / fleet coordinator / travel host.
- NOT bulk implementer. Propose HANDOFFs for Doc; don't do ORM/35B work.
- Digests: `~/Documents/Fleet-Memory/Dreams/Porsche/YYYY-MM-DD.md`
- When Doc NC up: also mirror to `Fleet-Nextcloud/Memory/Dreams/Porsche/` if reachable.

## Modes

| Mode | When | Goal |
|------|------|------|
| **light** | Daily (with backup) | 24h host/ops snapshot, prune, promote ≤5 facts |
| **deep** | **Sunday** (with weekly backup promote) | Cross-week patterns, lean-check, skill-drift notes, promote ≤8, prune harder |

Detect: if `DREAM_MODE=deep` in backup script output **or** local weekday is Sunday → deep. Else light.

## Hard rules (all models — never violate)

1. **Never** put secrets (tokens, .env, keys, serials, passwords) in digests or MEMORY.
2. **Never** push private digests to public `Coombzy/Automation`.
3. **Never** rewrite USER.md into a dual-PA profile (Doc especially).
4. **Never** re-run full `hermes backup` if script already succeeded.
5. **session_search** max: light **3** queries / **5** sessions; deep **6** queries / **15** sessions.
6. **MEMORY promote cap:** light **≤5** facts; deep **≤8** facts. Prefer replace/shorten over add.
7. **Hot MEMORY budget:** stay under Hermes limit (~2200 chars). If over ~80% (~1760), **prune-first**.
8. **Dates:** ISO `YYYY-MM-DD` only in promoted memory — never "today/yesterday".
9. **Copy-on-write style:** write full digest first; only then apply tiny MEMORY patches via `memory` tool.
10. If nothing material: digest with `## Silent` and final line **`DREAM_SILENT`**.

## Execution checklist (do IN ORDER)

### 0) Charter (1 line)
State role (Doc|Porsche) + mode (light|deep).

### 1) Backup context
If script stdout present: one-line backup result (path, bytes, weekly/monthly promote, FAIL?).  
If backup failed: note blocker; **still continue dream**.

### 2) Host signals (timeouts short)
Run only:
- `date +%Y-%m-%d`
- disk free (home/Desktop) — 5s
- `ollama list` if exists — 5s
- test dream digest parent dir exists
- list `Handoffs/active/` **filenames only** (Doc NC or Porsche Fleet-Memory)

### 3) Gather (bounded)
- light: last **24h** decisions relevant to **this role** only  
- deep: last **7 days** patterns + open loops  
- Use `session_search` sparingly (see caps). No Ben biography crawl on Doc.

### 4) Write digest (always)
Path by role (above). Filename `YYYY-MM-DD.md`.  
If deep Sunday, also write `YYYY-MM-DD.deep.md` **or** same file with `mode: deep` header.

**Required sections (use these headers exactly):**
```markdown
# Dream digest | <Doc|Porsche> | YYYY-MM-DD | <light|deep>

## Backup result
## What happened (window)
## Consolidate (merged / fixed)
## Prune candidates (drop or shorten)
## Promote candidates (≤N; ISO dates)
## MEMORY.md actions taken
## Handoffs / open loops
## Asks for peer (max 3)
## Metrics
- sessions_scanned:
- facts_promoted:
- facts_pruned:
- memory_chars_before:
- memory_chars_after:
- backup_bytes:
## Silent?
```

### 5) Prune pass (mandatory if MEMORY large)
Read `MEMORY.md` size. If > ~1760 chars or deep mode:
- merge duplicates
- drop resolved one-offs
- drop stale paths
- resolve contradictions → keep newer + note supersede in digest

### 6) Promote pass
Apply **at most N** host/role facts via `memory` tool (`replace`/`add`/`remove` batch).  
Write optional promote file: same folder `YYYY-MM-DD.promote.md` listing applied patches.

### 7) Deep-only extras (Sunday)
- Skill drift: 3 bullets max (what skill should change — **do not** bulk-edit skills unless trivial fix)
- Weekly backup confirmed in digest
- Open loops owned by peer as HANDOFF suggestions (Porsche→Doc) or implement asks (Doc→Porsche)
- Lean-check: if still over budget after prune, force more deletes

### 8) Final response
- One-line backup + path to digest + promote count  
- **or** `DREAM_SILENT`

## Anti-goals
- Skill-count parity
- Full mutual-audit (unless separately scheduled)
- Nextcloud Docker invent
- Dual-PA / Ben schedule ownership on Doc
- 35B install guidance on Porsche host
- Public git of digests

## Cron install (hosts)

### Doc — daily light + Sunday deep (one job)
```text
name:     doc-daily-backup-and-dream
schedule: 0 22 * * *
script:   daily-doc-backup.sh
skills:   agent-dream, token_preflight, project-car, xai-model-selection
workdir:  ~/hermes-tools/Automation
deliver:  discord:#doc-garage
model:    prefer local qwen3.6:35b / gemma4:26b if cron model pin available
```
Prompt: "Load skill agent-dream. Role=Doc. Mode from DREAM_MODE in script output (deep on Sunday). Follow skill checklist exactly."

### Porsche — recommended
```text
name:     porsche-daily-backup-and-dream   # or keep dream-only if backup separate
schedule: 0 22 * * *                       # daily light; Sunday deep via DREAM_MODE
# optional lighter: 0 22 * * 1,3,5,0      # M/W/F + Sunday deep
skills:   agent-dream, token_preflight, project-car, fleet-mutual-improvement
model:    local 7B–14B light; deep may use cloud if local too weak
```
Backup script: mirror Doc's script as `daily-porsche-backup.sh` with `AGENT=Porsche` paths under `backup/Porsche/`.

## See also
- `references/checklist-card.md` — ultra-short card for tiny models  
- `references/role-matrix.md` — Doc vs Porsche paths  
- Automation: `communication/Doc/DREAM-CRON.md`
