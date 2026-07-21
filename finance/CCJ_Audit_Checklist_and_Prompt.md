# CCJ Audit Process — Hermes Agent Process

**Version:** 1.2 (2026-07-21)  
**Location:** `Project-Car/finance/`  
**Target log:** `CCJ_Daily_Metrics_Audit_Log.md`  
**Target health:** `CCJ_Process_Health.md`

## Goal
Perform a rigorous, scored review of the most recent CCJ analysis entry and **automatically write the audit results** back into the living log. Designed for a Hermes agent with GitHub write access.

## Fixed Audit Checklist (must complete every run)

- [ ] All 8 core metrics present and sourced
- [ ] Historical deltas calculated (or explicitly marked N/A)
- [ ] Quality Evaluator section completed by the Analysis Automater
- [ ] Analysis Confidence score present (0–100)
- [ ] Narrative references history and/or prior audit feedback
- [ ] No obvious data contradictions between metrics and narrative
- [ ] Anomaly flags (if any) are acknowledged and discussed

## Scoring Guide – Audit Score (1–10)

| Score | Meaning |
|-------|---------|
| 9–10  | Excellent – complete, well-sourced, historically aware, actionable |
| 7–8   | Good – minor gaps only |
| 5–6   | Acceptable – noticeable missing elements or weak historical context |
| 3–4   | Needs improvement – significant gaps or contradictions |
| 1–2   | Poor – major data or process failures |

## Required Steps (execute in order)

1. **Read the living log**  
   Use `github___get_file_contents` on `finance/CCJ_Daily_Metrics_Audit_Log.md` (owner: Coombzy, repo: Project-Car). Examine the newest entry and the previous 2–3 entries for recurring issues.

2. **Complete the Fixed Checklist**  
   Mark every item. Note any failures.

3. **Assign Audit Score (1–10)** using the scoring guide.

4. **Evaluate prediction accuracy (if targets exist)**  
   Compare any 1-week / 1-month / 3-month targets in the analysis against subsequent actual performance (use Polygon for prices). Note hit rate, directional accuracy, and root causes of misses.

5. **Write the full Audit section**  
   Produce clear, constructive notes including:
   - Checklist results
   - Audit Score
   - Recurring issues and whether prior recommendations were addressed
   - Specific improvement suggestions for the Analysis process
   - Overall assessment

6. **Commit the updated log (mandatory)**  
   - Get the current SHA of `CCJ_Daily_Metrics_Audit_Log.md`.  
   - Insert / replace the Audit / Reviewer Notes section for the newest entry.  
   - Use `github___create_or_update_file` (or `github___push_files`) with a clear commit message:  
     `CCJ Audit – YYYY-MM-DD – Score X/10`

7. **Update Process Health**  
   Add or update a line in `finance/CCJ_Process_Health.md`:  
   `Date | Analysis Confidence | Audit Score | Top Issue`

8. **Confirm success**  
   Report the commit confirmation.

## Success Criteria
- [ ] Checklist fully marked
- [ ] Numeric Audit Score (1–10) assigned
- [ ] Recurring issues noted
- [ ] Actionable improvement suggestions written
- [ ] Audit section successfully written and committed to the living log
- [ ] Process Health updated
