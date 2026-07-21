# CCJ Stock Analysis Automater — Hermes Agent Process

**Version:** 1.4 (2026-07-21)  
**Location:** `Project-Car/finance/`  
**Target log:** `CCJ_Daily_Metrics_Audit_Log.md`  
**Target health:** `CCJ_Process_Health.md`

## Goal
Produce a high-quality, structured daily CCJ analysis entry and **automatically commit it** to the living log on GitHub. This process is designed to be run by a Hermes agent that has GitHub write access.

## Preferred Data Sources
1. **Primary (equity data)**: Polygon.io via code_execution + `polygon.RESTClient` (price, volume, OHLCV aggregates, market cap, company details, URA).
2. **U3O8 spot**: Trading Economics / public UxC or TradeTech indicators.
3. **News / catalysts**: Company releases, Yahoo, Polygon news if available.

Always record the primary source for every metric.

## Required Steps (execute in order)

1. **Read prior context**  
   Use `github___get_file_contents` on `finance/CCJ_Daily_Metrics_Audit_Log.md` (owner: Coombzy, repo: Project-Car). Note the most recent entry and any prior audit feedback.

2. **Collect data**  
   Pull latest CCJ and URA data via Polygon. Calculate or retrieve RSI(14), 50-DMA, 200-DMA from aggregates. Get U3O8 and relevant news.

3. **Build the structured entry** using this exact template (newest-first style):

```markdown
### YYYY-MM-DD | HH:MM TZ

#### Metrics
| Metric                        | Value                          | Source / Notes                  |
|-------------------------------|--------------------------------|---------------------------------|
| **1. Audit Timestamp**        | YYYY-MM-DD HH:MM TZ            |                                 |
| **2. CCJ Price Snapshot**     | Close/Last: $XX.XX<br>$ / % change | Day Range + Source             |
| **3. Volume Metrics**         | Vol: X.XM<br>Avg (20d): Y.YM<br>Rel Vol: Z.Zx | Source                        |
| **4. U3O8 Spot Price**        | $XX.XX /lb                     | Daily change                    |
| **5. Market Cap & Valuation** | Mkt Cap: $XX.XB<br>P/E: XX.X   | Source                          |
| **6. Technical Position**     | RSI(14): XX.X<br>vs 50-DMA: ±X%<br>vs 200-DMA: ±X% | Trend                         |
| **7. Sector Relative Perf.**  | CCJ: ±X.X%<br>URA: ±Y.Y%<br>Rel: ±Z.Z% | Source                       |
| **8. Key Catalysts / Sentiment** | • ...<br>Sentiment: ...     |                                 |

**Historical Deltas**: ...  
**Anomaly Flags**: none / ...  
**Data Sources**: Polygon (primary), ...  
**Analysis Confidence**: XX/100  
**Quality Evaluator Score**: X/10

#### Analysis Narrative
[Full narrative referencing metrics, deltas, uranium linkage, and prior feedback. End with key takeaways.]

#### Audit / Reviewer Notes
*(Leave blank or minimal – filled by the Audit process)*
```

4. **Self-critique**  
   Run the Quality Evaluator. If score < 7, improve the entry before committing.

5. **Commit to GitHub (mandatory)**  
   - Get the current file SHA via `github___get_file_contents`.  
   - Prepend the new entry at the top of the existing content.  
   - Use `github___create_or_update_file` (or `github___push_files`) with:  
     - owner: `Coombzy`  
     - repo: `Project-Car`  
     - path: `finance/CCJ_Daily_Metrics_Audit_Log.md`  
     - message: `CCJ Daily Analysis – YYYY-MM-DD HH:MM`  
     - full updated content + correct SHA.

6. **Update Process Health (recommended)**  
   Append or update a one-line entry in `finance/CCJ_Process_Health.md`:
   `Date | Analysis Confidence | (pending audit) | Top note`

7. **Confirm success**  
   Report the commit SHA or confirmation that the log was updated.

## Success Criteria
- [ ] Polygon used as primary equity data source
- [ ] All 8 metrics + sources filled
- [ ] Historical deltas and anomaly flags present
- [ ] Quality Evaluator ≥ 7 and Confidence score assigned
- [ ] New entry successfully prepended and committed to GitHub
- [ ] Process Health updated (optional but preferred)
