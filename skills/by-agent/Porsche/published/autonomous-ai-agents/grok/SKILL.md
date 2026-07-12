---
name: grok
description: "Delegate coding/build work via xAI Grok CLI / Grok Build patterns from Hermes."
version: 1.0.0
author: Porsche (adopted from Doc Hakosuka mutual-audit 2026-07-11)
license: MIT
platforms: [macos, linux]
metadata:
  hermes:
    tags: [grok, xai, cli, delegation, coding]
    related_skills: [xai-model-selection, hermes-agent, claude-code, codex]
---

# Grok / Grok Build CLI

Use when routing coding or PR-style work through xAI Grok tooling (Grok Build CLI or equivalent) instead of only the Hermes chat loop.

## When to use

- Bulk implementation after architecture is decided on Grok 4.5 in Hermes
- Parallel coding agents alongside Claude Code / Codex / OpenCode
- Doc-style split: **architect in Hermes (Grok)** → **implement via CLI agent**

## Prerequisites

```bash
# Verify xAI auth path used by Hermes (OAuth or API)
hermes auth list 2>/dev/null | head
# Or provider config
hermes model
```

Install/login steps for the current Grok Build CLI change over time — prefer official xAI docs when the binary name differs. Do not invent install URLs.

## Patterns

1. **Write a tight brief** (goal, files, constraints, done-when).
2. **Run CLI in worktree** when parallel to other agents (`hermes -w` or git worktree).
3. **Review diff** before commit; don’t auto-merge hostile/unexpected scope.
4. **Prefer local models** for pure boilerplate if Ollama is healthy (see `xai-model-selection`).

## Hermes integration

```bash
# Example shape — adjust to installed CLI
# terminal(command="grok ...", timeout=600)
```

If CLI is missing: fall back to Hermes tools + `delegate_task`, or install CLI with Ben OK.

## Pitfalls

- Burning SuperGrok quota on tasks a local 14B could finish
- Running two agents on the same branch without worktrees
- Treating tier names as model IDs (see `xai-model-selection`)

## Verification

- CLI responds with version/help
- Auth works for a tiny probe task
- Diff reviewed and tests run before declaring done
