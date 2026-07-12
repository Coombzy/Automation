---
name: xai-model-selection
description: "Use when choosing Grok/xAI models, SuperGrok tiers, multi-agent vs single flagship, or comparing Grok releases for Hermes routing — Doc 64GB specialist: local 26B–35B implement + Grok plan/review."
version: 1.4.0
author: Hermes Agent + fleet (Doc tailored)
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [xAI, Grok, model-selection, routing, SuperGrok, doc]
    related_skills: [grok, token_preflight, token_optimizer, project-car, fleet-mutual-improvement, llama-cpp]
---

# xAI / Grok model selection

## Overview

Pick the right Grok/xAI model and subscription path for the job. xAI ships models and product modes quickly; names collide (4.20 multi-agent vs "420" meme vs SuperGrok Heavy). Keep distinctions clear so Hermes does not recommend the wrong API ID or invent a non-existent "Grok 4.5 multi-agent."

**This copy is tailored for Doc Hakosuka** (specialist / heavy compute / local LLM host / domain implementer on M1 Max **64GB**). Not a second PA. Unique skills are healthy — no skill-count parity with Porsche.

## When to Use

- User asks which Grok / SuperGrok plan / model to use
- Comparing Grok releases (4.5 vs 4.3 vs 4.20 multi-agent, Heavy, Build)
- Routing Hermes or agents across Grok models
- Interpreting Grok launch benchmarks or pricing
- Deciding **local 26B–35B vs Grok** on Doc for implement/plan/review

Don't use for: driving Grok Build CLI (hub `grok` skill), Hermes config (`hermes-agent`), or non-xAI eval harnesses (`evaluating-llms-harness`).

## Identity

- Human is **Ben (Coombsy)** — never call Ben "Doc."
- This agent = **Doc Hakosuka** unless another agent is explicitly speaking.
- SuperGrok Heavy = **tier**, not a model ID.
- **Do not** own Ben’s ops todos / dual-PA work — that stays Porsche.

## Default routing (Ben / fleet)

### Shared cloud / API picks

| Work | Prefer | Fallback |
|---|---|---|
| Architecture, high-level design, hard reasoning | Grok 4.5 (Hermes / API) | 4.20 multi-agent if peer-review debate is the point |
| Built-in multi-agent research | `grok-4.20-multi-agent` | Hermes `delegate_task` with 4.5 workers |
| Long-context cheap volume | Grok 4.3 (recheck price/context) | 4.5 if efficiency wins on $/task |
| Grok Build CLI coding agent | SuperGrok/Premium+ OAuth (`grok` skill) | `XAI_API_KEY` pay-as-you-go |

### Host-specific local bulk (do not mix RAM classes)

| Host | Charter | Local bulk class | Cloud when |
|------|---------|------------------|------------|
| **Doc** (M1 Max **64GB**) | Specialist / domain / bulk implement | **~26B–35B** (`qwen3.6:35b`, Qwen3-Coder 30B A3B, gemma4:26b class) | Architecture, stuck after 2 local fails, review |
| **Porsche** (M4 Pro **24GB**) | PA / coordinator / travel host | **~7B–14B** Ollama only | Decision quality, architecture, hard review, Ben-facing synthesis |
| **McKing** (i9 + RTX 5080) | Coding lab / CUDA / storage | CUDA / vLLM / large local when home | Same Grok plan/review pattern |

**Never** recommend Doc’s 35B class on Porsche 24GB. **Never** make Doc the default PA/todo router.

## Doc specialist job matrix (primary for this host)

Use this table first when **you are Doc**.

| Job class | Prefer | Avoid on Doc |
|-----------|--------|--------------|
| Domain modeling / full SQLAlchemy sets / migrations | **Local** 26B–35B implement (`sqlalchemy-domain-modeling`) | Handing bulk ORM back to Porsche "for parity" |
| Long multi-file refactors / feature implement | **Local** implement under Grok tickets | Burning Grok for every line of code |
| MC / Project Car implement heartbeats | **Local** bulk ticks; Grok for plan/review/stuck | Absorbing Porsche PA todo ownership into heartbeat |
| Architecture / stuck after 2 local fails / hard review | **Grok 4.5** | Infinite local retry without escalations |
| Eval harness / local model quality | **Local first** (`evaluating-llms-harness`) | Cloud eval as default |
| llama.cpp / GGUF / Ollama stack work | **This host** (Doc specialist) | Forcing vLLM as default on Apple Silicon |
| vLLM / CUDA serve | Hand to **McKing** when home; secondary notes only | Treating vLLM as Doc default path |
| Ben ops todos / fleet PA / Discord shopping | **Stay out** — Porsche owns | Dual-PA drift |
| Token preflight before Grok/cloud | **Yes** (`token_preflight`) | Token ceremony on pure local Ollama implement |
| Pure local Ollama implement | Local; **skip** token optimizer ceremony | Treating local draft as final architecture without review when high-risk |

### Plan → local implement → review loop (Doc-shaped)

Ben’s high-leverage pattern: **Grok plans/decomposes/reviews; local 26B–35B does most coding tokens.**

Realistic split with tight tickets: ~**70–85%** implementation on local Qwen; Grok for architecture, hard bugs, and review.

1. **Grok (Doc or Porsche):** goal, non-goals, file map, ordered steps (15–45 min each), acceptance checks per step, risks.
2. **Grok:** each step as a one-screen ticket (paths, deliverable, out-of-scope, verify command).
3. **Local Qwen/Coder on Doc:** implement **one step only** — no epic freestyles.
4. **Grok:** review diff + test output → ship / fix / redesign.
5. **Local:** apply review notes; next step.

Escalate to Grok after **two local failures** on the same step. Vague plans kill local success rate — contracts and tests first.

Local quality ladder **Doc / M1 Max 64GB:** `qwen3.6:35b` (default Hermes implementer) → Qwen3-Coder 30B A3B (pure code) → gemma4:26b class → Grok 4.5 (hard agentic). 480B Coder is not a laptop target.

Local quality ladder **Porsche / M4 Pro 24GB:** 7B–14B drafts only → hand hard implement to Doc or Grok.

## Model map (API)

| Model ID | Role | Multi-agent baked in? |
|---|---|---|
| `grok-4.5` | Coding / agentic / knowledge-work flagship (single model) | No |
| `grok-4.3` | Prior general flagship; often better list $/token and larger context at 4.5 launch | No |
| `grok-4.20-multi-agent` (+ `…-0309` / `…-latest`) | Realtime multi-agent research | Yes |

Pitfall: No documented `grok-4.5-multi-agent` on 4.5 launch day. Multi-agent stayed on the 4.20 multi-agent product line. On that model, `reasoning.effort` controls agent count (roughly 4 vs 16), not single-model thinking depth.

Full landscape: `references/xai-model-landscape.md`.

## SuperGrok Heavy (subscription is not a model)

- SuperGrok / SuperGrok Heavy = tiers (limits, priority, early access, Heavy compute mode).
- Heavy does get 4.5 (usually earliest / highest limits). Not locked out of 4.5.
- Heavy multi-agent mode is not the same as "multi-agent now runs on 4.5 weights" — verify consumer UI; API multi-agent ID remained 4.20-line at launch.
- Hermes pay-per-token API is not free SuperGrok quota. Grok Build OAuth is SuperGrok/Premium+; Hermes xAI OAuth is separate from `~/.grok/auth.json`.

## Benchmark hygiene

1. Prefer official docs + Artificial Analysis over pure social posts.
2. Always note harness (DeepSWE 1.0 vs 1.1 can swing the same model a lot).
3. 4.5 launch story was efficiency / $/task as much as raw pass rate — report both.
4. Day-of numbers go stale; re-fetch before advising a purchase.

## Steps when asked "which Grok?"

1. Clarify job: coding agent, research debate, chat, long docs, or subscription limits.
2. Map to API ID from the table above (never invent multi-agent suffixes without docs).
3. Separate model from tier (SuperGrok Heavy vs `grok-4.5`).
4. Apply **host table** (this host = Doc 64GB bulk implement).
5. Cite current price/context from docs if recommending spend; if tools fail, say so and use last known landscape reference.
6. For Hermes routing, honor Ben's Grok-for-architecture / local-for-implement preference **with RAM-correct local**.

Done when: recommendation names a real model ID (or explicit consumer tier), states multi-agent vs single-model clearly, matches the job, and respects charter/RAM.

## Common Pitfalls

1. Calling SuperGrok Heavy "Grok 4.5 multi-agent." Heavy is a tier; multi-agent API was still 4.20-line at 4.5 launch.
2. Assuming 4.5 replaced multi-agent. Different products.
3. Assuming Hermes xAI auth logs in Grok Build. Separate credentials.
4. Over-trusting day-one benches without harness and cost-per-task context.
5. Calling the user Doc. Human = Ben; agent = Doc Hakosuka / Porsche / McKing as appropriate.
6. Copy-pasting Porsche 7B–14B routing onto Doc 64GB (or forcing 35B on Porsche 24GB).
7. Using this skill to justify dual-PA / skill-count parity / Doc owning ops todos.
8. Skipping Grok review on high-risk architecture while still burning local tokens on vague tickets.

## Verification Checklist

- [ ] Model ID exists in current xAI docs or OpenRouter catalog
- [ ] Multi-agent requests use `grok-4.20-multi-agent` unless docs show a newer multi-agent ID
- [ ] Subscription advice separated from API model advice
- [ ] Host RAM class respected (Doc bulk = 26B–35B class)
- [ ] Architecture/stuck/review escalate to Grok; pure local skips token ceremony
- [ ] Landscape reference updated if IDs/prices/context changed

## References

- `references/xai-model-landscape.md` — IDs, pricing snapshot, SuperGrok Heavy, launch benchmarks (2026-07-08)
