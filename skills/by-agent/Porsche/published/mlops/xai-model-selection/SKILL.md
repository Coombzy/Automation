---
name: xai-model-selection
description: "Choose Grok / SuperGrok tiers and multi-agent model routing correctly (tier ≠ model ID)."
version: 1.0.0
author: Porsche (adopted from Doc Hakosuka mutual-audit 2026-07-11)
license: MIT
platforms: [macos, linux, windows]
metadata:
  hermes:
    tags: [xai, grok, model-routing, cost, multi-agent]
    related_skills: [hermes-agent, grok]
---

# xAI / Grok model selection

Use when picking Grok models, SuperGrok plans, or routing work between cloud Grok and local models.

## Critical rules

1. **SuperGrok Heavy is a limits/priority tier, not a model ID.** Never pass `heavy` / `SuperGrok Heavy` as `model.default`.
2. **Current coordinator default (fleet):** `grok-4.5` via `xai-oauth` (or configured xAI provider).
3. **Multi-agent / API line:** stay on documented multi-agent model IDs until a `grok-4.5-multi-agent` (or successor) is explicitly documented. Do not invent multi-agent model strings.
4. Prefer **architect on Grok**, **bulk implement on local** when local models are healthy (see local routing section).

## Routing matrix (fleet)

| Work type | Prefer | Avoid |
|-----------|--------|--------|
| Architecture, planning, ambiguous decisions | Grok 4.5 (cloud) | Burning cloud on pure boilerplate |
| Bulk codegen / long refactors | Local Ollama/MLX when quality OK | Defaulting every line to cloud |
| Security / major Ben decisions | Cloud reasoning + Ben confirm | Silent local-only on irreversible choices |
| Cron / inventory / audits | Local or on-demand; no free cloud burn | Paid cloud cron for mechanical exports |

## Host-sized local defaults

| Host | RAM | Safe local class |
|------|-----|------------------|
| Doc (M1 Max) | 64 GB | 26B–35B Ollama practical |
| Porsche (M4 Pro) | **24 GB** | Prefer ~7B–14B; careful quantized ~20–27B only if monitored; **not** dual 35B |
| McKing (RTX 5080) | GPU desktop | Larger GPU models / vLLM later |

## Hermes config pattern (local OpenAI-compatible)

When Ollama is running:

```yaml
custom_providers:
  - name: ollama
    base_url: http://127.0.0.1:11434/v1
    api_key: ollama
```

Then select model e.g. `qwen2.5:14b` / whatever is installed — **never assume Doc’s 35B set is present on Porsche**.

## Verification

- `hermes model` / config shows real model IDs only
- Ollama: `ollama list` succeeds before routing bulk work local
- No config value named after a billing tier as model id

## Pitfalls

- Copying Doc’s model list onto 24GB → swap thrash / OOM
- Exposing Ollama beyond localhost without hardening + Ben OK
- Treating SuperGrok “Heavy” as something to put in `model.default`
