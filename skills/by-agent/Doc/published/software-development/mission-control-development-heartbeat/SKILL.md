---
name: mission-control-development-heartbeat
description: Stateful autonomous development heartbeat for Mission Control / Project Car. Doc owns bulk local implement ticks; Porsche supervises. Read state → local code → git commit → handoff note → Discord report.
version: 1.4
author: Porsche + Doc (fleet role-tailored)
tags: [heartbeat, autonomous, cron, mission-control, project-car, git, stateful]
---

# Mission Control Development Heartbeat

This skill implements a reliable, stateful autonomous development loop for building Mission Control (which evolves into Project Car).

## Fleet split (do not homogenize)

| Agent | Heartbeat role |
|-------|----------------|
| **Doc** | **Bulk implement ticks** on M1 Max 64GB: read note → **local** code (26B–35B when useful) → commit → write note. Grok for plan/review/stuck after 2 local fails. Include hardware line each tick (64GB, which Ollama model). |
| **Porsche** | **Supervise / plan / integrate.** Prioritize backlog, write tickets, small glue commits, Discord, Ben interface. Hand multi-file implement slices to **Doc**. |
| **McKing** | Future coding-lab / GPU heartbeats when online — not default MC owner. |

Hard rules:

- Prefer **local** for implement tokens; cloud only for architecture / two local failures / review
- **No n8n**
- Do **not** absorb Porsche PA todo ownership (`communication/Porsche/*`) into the heartbeat
- Do not pretend Doc is a second PA

## Core Pattern

The heartbeat follows a strict loop on every run:

1. **Read state** — Read `mission-control/HEARTBEAT_NOTE.md`
2. **Read backlog** — Read and update `mission-control/TASKS.md` (enforces priority order)
3. **Do focused work** — Create files, folders, code, Docker configs, integrations. **All automation and orchestration must be done via custom code** — Hermes heartbeats, cron, webhooks, and first-party adapters only. **No n8n or similar no-code workflow tools** (Ben hard ban 2026-07-10; stack already purged). On Doc: prefer bulk domain/backend implement with local models; escalate architecture to Grok.
4. **Git commit** — `git add . && git commit -m "Heartbeat: ..."` (initialize repo if needed)
5. **Write new state** — Update `HEARTBEAT_NOTE.md` with status + next tasks + **hardware line** (e.g. `host=Doc M1 Max 64GB; model=qwen3.6:35b`)
6. **Report** — Deliver structured progress report to Discord

**Path Rule**: All work must use safe, writable paths only (currently `~/Documents/mission-control/`). Never attempt creation in restricted locations.

**Compose services (current scaffold, post-n8n purge):** `postgres`, `nextcloud`, `matrix-synapse` (placeholder), `mission-control-app`. Do **not** add an `n8n` service, `n8n_data` volume, `N8N_*` env vars, or an `n8n/` workflows directory. Dashboard orchestration panel is **Hermes Agents**, not n8n.

**Chat Implementation Rule**: Chat features must be built as native, integrated functionality using Matrix protocol/code components (custom frontend + backend integration). Do not deploy standalone Matrix instances for users to interact with.

**Doc sync on stack changes:** If services or orchestration assumptions change, also update project-car skill references + Desktop + Obsidian (and GitHub `Docs/` when available). See project-car `references/stack-exclusions.md`.

## Priority Order (Strict)

1. Matrix + Nextcloud integration (first)
2. Unified dashboard
3. Calendar / schedule features
4. Tool tracking (late Phase 1)

## Recommended Cron Job Settings

- Interval: Every 2 hours (recommended) — **task-dependent**; complex/high-risk needs supervision
- Delivery: Discord (preferred channel)
- Max runs: Configurable (start with 12–24)
- Model: **Doc implement ticks** → local large (`qwen3.6:35b` class) + Grok for plan/review; Porsche supervise ticks → Grok 4.5
- Cloud fleet crons may be **paused** until Ben re-enables; prefer local-friendly Doc ticks when cloud is paused

## Required Files

- `mission-control/HEARTBEAT_NOTE.md` — State handoff between runs
- `mission-control/TASKS.md` — Prioritized backlog

## Standardized Report Format

```
**Heartbeat Report**
- Run #: [number]
- Host/Model: [Doc M1 Max 64GB / ollama model or Grok]
- Focus: [current priority]
- Status: [what was accomplished]
- Files/Folders Changed: [list]
- Git Commit: [hash or "none"]
- Decisions/Blockers: [any]
- Next Tasks: [from TASKS.md]
```

## Error Handling

- Attempt one retry on failure
- Log error clearly
- Write failure note to `HEARTBEAT_NOTE.md`
- Stop run cleanly
- After two failures on the same implement step → escalate plan/review to Grok (or HANDOFF Porsche for prioritization)

## Pitfalls

1. **Re-adding n8n** — old docs/templates may still tempt it. Reject. Use Hermes/custom adapters only.
2. **Blind global replace of “n8n”** — can turn “no n8n” into nonsense. Prefer targeted edits; leave explicit ban lines intact.
3. **Working only in mission-control/** — architecture/integration text also lives under project-car skill references and Desktop Project-Car-Docs; keep service inventory aligned.
4. **Violating priority order** — never start Tool Tracking or dashboard polish before Matrix + Nextcloud foundation work.
5. **Confusing ops todos with TASKS.md** — Ben’s personal/fleet todos (`Coombzy/Automation/communication/Porsche/*.md`) are separate from MC engineering `TASKS.md`. Heartbeats update `TASKS.md` / `HEARTBEAT_NOTE.md`; ops list changes belong on GitHub ops todos (project-car `references/ops-todos.md`). Doc does **not** become dual PA.
6. **Doc doing Porsche’s job** — fleet PA, shopping, ops-todo ownership instead of implement.
7. **Cloud-only implement ticks on Doc** — wastes specialist RAM; prefer local for bulk code.
8. **Missing hardware line** — every tick should state host + model used.

## Usage

Create or update a cron job using the `cronjob` tool with the prompt pattern from this skill.

Example job name: `mission-control-heartbeat-doc-1`

## Future Improvements

- Multiple specialized heartbeats (integration vs frontend vs planning)
- Milestone approval checkpoints
- Health checks before starting work
- Multi-agent delegation within heartbeats

This pattern enables Doc (bulk implement) and Porsche (supervise) to make consistent, traceable progress on Mission Control without constant user input.
