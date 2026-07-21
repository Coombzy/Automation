# CCJ Stock Analysis Automater — Official Process & Prompt

**Version:** 1.2 (2026-07-21)  
**Location:** `Project-Car/finance/`  
**Target log:** `CCJ_Daily_Metrics_Audit_Log.md`

## Goal
Produce a high-quality, structured daily entry that includes validated metrics, historical context, a self-critique, a confidence score, and an actionable analysis narrative.

## Preferred Data Sources (in order)
1. **Polygon.io** (primary — preconfigured library available)  
   - Use for: CCJ price, OHLCV aggregates, volume, market cap / ticker details, URA performance, historical bars for technicals (RSI, DMAs).
2. Public web sources (Yahoo Finance, Trading Economics) as fallback or for U3O8 / news.
3. Company releases / analyst notes for catalysts.

Always record the primary source for every metric.

## Required Steps (in order)

1. **Data Collection**
   - Pull CCJ and URA data preferentially via Polygon (aggregates, previous close, current if available, volume, ticker details).
   - U3O8 spot → Trading Economics or best available public source.
   - Technicals (RSI-14, 50-DMA, 200-DMA): calculate from Polygon historical bars when possible, or use consistent secondary source.
   - Recent news / catalysts.
   - Record source + timestamp for every metric.

2. **Populate Metrics Table**  
   Use the official 8-metric table. Include source notes.

3. **Calculate Historical Deltas**  
   Compare to the most recent prior entry (and 5-day averages when enough history exists).

4. **Anomaly Detection**  
   Flag if: Rel Vol > 2.0× **and** |price change| > 3%, sudden U3O8 gap > 2%, or other clear outliers.

5. **Quality Evaluator (self-critique)**  
   Score completeness, source attribution, historical comparison, narrative quality (1–10). Rewrite if below threshold.

6. **Assign Analysis Confidence Score (0–100)**

7. **Write Analysis Narrative**  
   Reference metrics, deltas, prior audit feedback. End with takeaways / outlook.

8. **Append to top of `CCJ_Daily_Metrics_Audit_Log.md`** (newest-first).

9. **Update Process Health log** (recommended).

## Prompt Skeleton (for agent use)

```
You are the CCJ Stock Analysis Automater. Follow the official process in finance/CCJ_Analysis_Automater_Prompt.md exactly.

Primary data source is Polygon.io (use the preconfigured library). Fall back to public sources only when necessary.

1. Gather the latest data for the 8 metrics, preferring Polygon for price/volume/aggregates/market data. Record sources.
2. Read the most recent entry in finance/CCJ_Daily_Metrics_Audit_Log.md for historical context and prior audit feedback.
3. Populate the full daily entry template (metrics + historical deltas + anomaly flags + Quality Evaluator + confidence score + narrative).
4. Self-critique via the Quality Evaluator. If overall quality < 7, improve before writing.
5. Append the completed entry at the top of the living log.
6. Optionally log a one-line summary to finance/CCJ_Process_Health.md.

Be precise, cite sources, and prioritize actionable insight over fluff.
```

## Success Criteria
- All 8 metrics filled with sources (Polygon preferred)
- Historical deltas present (or explicitly N/A)
- Quality Evaluator completed with score ≥ 7 (or rewrite performed)
- Confidence score assigned
- Narrative references history / prior feedback when available
- Entry successfully prepended to the living log
