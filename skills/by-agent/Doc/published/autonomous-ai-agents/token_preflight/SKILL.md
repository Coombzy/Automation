---
name: token_preflight
description: Ultra-lightweight pre-flight checker. Estimates tokens and recommends optimization tier (light/medium/heavy). Doc specialist: run before Grok/cloud; skip pure local Ollama implement.
version: 0.4.0
author: Porsche (for Ben) + Doc host tailoring
license: MIT
metadata:
  hermes:
    tags: [tokens, optimization, preflight, estimation, tier-selection, doc]
    related_skills: [token_optimizer, xai-model-selection]
    category: autonomous-ai-agents
---

# token_preflight

Ultra-light pre-flight gatekeeper. Decides tier before calling heavier optimization skills.

## Tiers
- **light**: Basic hygiene only (< ~600 tokens, simple queries)
- **medium**: Balanced (default for most work, 600–3500 tokens or moderate signals)
- **heavy**: Maximum effort (> 3500 tokens, complex code/multi-step workflows)

## Doc specialist defaults (this host)

| Situation | Action |
|-----------|--------|
| About to call **Grok/cloud** (plan, review, architecture, stuck) | Run preflight; medium/heavy as signals warrant |
| Pure **local Ollama** implement (26B–35B, no cloud) | **Skip** preflight ceremony — return `skip_optimizer_local_only` |
| Eval / llama.cpp local work without cloud | **Skip** |
| Do **not** become PA cost-router for Ben’s day | That stays **Porsche** |
| Ben says `token_light` / `use heavy` | Honor override |

Prefer durable state in **HEARTBEAT notes / TASKS.md / git** instead of re-summarizing long implement context on cloud every turn.

## Procedure (Minimal)
1. **Token Estimation** (character-based): `chars / 4`. Add +15% if code blocks/files detected. Add +10% if multiple tools or "multi-step"/"plan"/"refactor" phrases present. Add +10% if fleet/handoff/tool-spam signals (many parallel tools).
2. **Flags**: `user_override`, `code_detected`, `multi_step`, `context_heavy`, `cloud_path`, `local_only`.
3. If `local_only` and no cloud model about to run → return `recommended_tier: "light"` with reasoning `skip_optimizer_local_only` (callers may no-op).
4. **Decide** using this table (user override takes precedence):

| Estimated Tokens | Signals                          | Tier   |
|------------------|----------------------------------|--------|
| < 600            | No strong signals                | light  |
| 600–3500         | code_detected or multi_step      | medium |
| > 3500           | Any complex signals              | heavy  |

5. Return minimal JSON (or full response if `mode=full`).

## Output (default: minimal)
```json
{
  "recommended_tier": "medium",
  "estimated_tokens": 1240,
  "reasoning": "Moderate task with code and multi-step signals",
  "confidence": "high",
  "key_signals": ["code_detected", "multi_step"],
  "mode": "minimal"
}
```

## Rules
- Pure heuristics only. No model calls in base path.
- Respect explicit user phrases like "use heavy" or "token_light".
- When called internally by other skills, use `mode=minimal`.
- Full examples, detailed rules, and reference material are in `REFERENCE.md` if present.

**v0.4.0** — Doc specialist: skip pure local; cloud/Grok path only; no PA cost-router drift.
