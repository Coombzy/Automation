---
name: fleet-pair-checkin
description: "Use for Doc↔Porsche 2x/day collaboration check-in: propose joint work, do bounded local work, write audit report for local-model performance. Prefer qwen3.6:35b on Doc."
version: "1.0"
---

# Fleet pair check-in (Doc ↔ Porsche)

**Who:** Doc runs this cron on Doc host. Porsche is peer (mention in #tire-shop).  
**Model:** **Always local** on Doc — `ollama` / `qwen3.6:35b` (cron-pinned). No Grok unless Ben overrides.  
**Goal:** Sync on **what you two can get done together** this window; execute only **bounded, safe** work; leave an **audit report** so humans/peers can improve local-model performance.

## Charter locks
- Doc = specialist / heavy compute / implementer (64GB).
- Porsche = PA / coordinator (24GB). Do **not** steal her PA todos or become dual-PA.
- Ben = decision-maker (security, spend, architecture).
- Public git (`Coombzy/Automation`) = **no secrets**.

## Schedule (Doc)
```text
0 10,16 * * *
```
10:00 and 16:00 host-local (MDT). Away from 22:00 backup+dream.

## Hard caps (local model must obey)
1. Max wall time intent: **~20–30 min** of work (not open-ended research rabbit holes).
2. Max **3** joint work items proposed; max **1–2** started this run.
3. `session_search` ≤ **4** queries.
4. No full mutual-audit / no skill-count parity / no Nextcloud Docker invent.
5. No secrets in reports or Discord.
6. If nothing to do: still write short report + Discord one-liner `PAIR_CHECKIN_SILENT` if truly idle.

## Steps (IN ORDER)

### 1) Orient (1–2 lines)
- Role: Doc. Model: qwen3.6:35b (local). Window: morning|afternoon from clock.
- Restate goal: pair check-in + optional bounded work + audit report.

### 2) Gather cheap signals
- `date`, disk free (home) — short timeouts
- `hermes cron list` (see dream/backup health)
- Read if present (quick):
  - `~/Desktop/Fleet-Nextcloud/Handoffs/active/` filenames
  - `communication/Doc/Doc-Todo.md` and `communication/Porsche/Porsche-Todo.md` (git pull Automation if cheap)
- Optional: last pair report in `~/Desktop/Fleet-Nextcloud/Heartbeats/Fleet/`

### 3) Propose joint work
Write a short **Joint board** (max 3 items):
| ID | Work | Owner | Blocked? | Why now |
Pick **at most 1–2** Doc can advance **this run** without Ben.

### 4) Execute (bounded)
Only if a clear implement/check task exists (tests, small fix, status verify, pack read, install note).  
Prefer **verify/report** over large new features in this cron.  
If blocked on Porsche/Ben: stop and ask in #tire-shop.

### 5) Write audit report (ALWAYS)
Path:
```text
~/Desktop/Fleet-Nextcloud/Heartbeats/Fleet/pair-checkin-YYYY-MM-DD-HHMM.md
```
Fallback:
```text
~/Desktop/Doc-Pair-Reports/pair-checkin-YYYY-MM-DD-HHMM.md
```

**Required headers (exact):**
```markdown
# Pair check-in audit | Doc | YYYY-MM-DD HH:MM | local qwen3.6:35b

## Window
## Model & routing
- provider: ollama
- model: qwen3.6:35b
- cloud_used: no|yes (should be no)
## Inputs consulted
## Joint board (proposed)
## Work attempted
## Outcomes
- success:
- partial:
- failed:
## Local-model performance notes
- followed_skill_steps: yes|no
- tool_errors:
- hallucination_risks / uncertain claims:
- context_too_long: yes|no
- would_need_stronger_model_for:
## Accuracy self-check
- claims_verified_by_tool:
- claims_unverified:
## Improvements (for next audit)
## Asks for Porsche (max 3)
## Asks for Ben (max 2)
## Metrics
- duration_estimate_min:
- files_written:
- commits: none|sha (public-safe only)
## Silent?
```

### 6) Discord (#tire-shop)
@Porsche with:
- Joint board (short)
- What Doc did / needs from her
- Link/path to audit report
- Explicit: **please reply when Grok/local available** with her side of board

If idle: `PAIR_CHECKIN_SILENT` + report path only (or skip tire-shop if truly nothing — prefer still ping 1 line morning only if Ben wants presence; default: always short status).

### 7) Final response
Report path + 5-line summary.

## Anti-goals
- Burning SuperGrok on this job
- Rewriting USER.md / dual-PA
- Large unplanned refactors
- Pushing secrets to git

## Peer (Porsche) optional mirror
She may run a lighter check-in on local 7–14B or cloud when available; same report headers with `agent: Porsche`. Shared folder when NC syncs: `Heartbeats/Fleet/`.
