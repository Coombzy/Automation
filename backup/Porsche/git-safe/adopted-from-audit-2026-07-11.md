# Porsche adopted-from-audit (Doc → Porsche) — 2026-07-11

**Subject:** Porsche  
**Source:** Doc Hakosuka git-safe pack `b798c58` + peer audits  
**Date:** 2026-07-11  

## Adopted (done on Porsche)

| Item | How | Notes |
|------|-----|--------|
| **Architect-cloud / implement-local policy** | MEMORY + `xai-model-selection` skill | Scaled to **24GB** (not Doc’s 35B defaults) |
| **SuperGrok Heavy ≠ model ID** | `xai-model-selection` skill | Prevents bad model.default values |
| **`xai-model-selection` skill** | Created under `~/.hermes/skills/mlops/xai-model-selection/` | Fleet rewrite from Doc’s public AUDIT-PACK teachings |
| **`macos-security-hardening` skill** | Created under `productivity/macos-security-hardening/` | Travel-host focused; no hub “bypass” packages |
| **`sqlalchemy-domain-modeling` skill** | Created under `software-development/` | Project Car domain handoffs Doc↔Porsche |
| **`grok` skill** | Created under `autonomous-ai-agents/grok/` | Grok Build / CLI delegation pattern |
| **Always-on doctrine** | MEMORY + security skill | Job-scoped `caffeinate`; AC for large local; gateway as service; AlDente already present |
| **Inventory shape** | Re-exported `inventory-latest.json` | Now includes hardware, local_llm, always_on_notes, discord_role_notes (Doc-quality fields, **no serials**) |
| **Discord routing** | Already aligned before this audit | `require_mention`, inline bot mentions, `#tire-shop` in `no_thread_channels` |

## Deferred / not applied

| Item | Why |
|------|-----|
| Doc’s exact on-disk original SKILL.md trees | Not available on Porsche disk; public pack is inventory-only. Porsche wrote fleet-local skill rewrites. Optional later: Doc tars skill dirs → private share → diff-merge. |
| Install Doc’s 35B / 26B Ollama models | **RAM mismatch** (Doc 64GB vs Porsche 24GB). Policy adopted; models not pulled. |
| Expose Ollama on LAN | Needs Ben OK + hardening first. |
| Start Ollama server + wire `custom_providers` now | Ollama.app installed; `ollama list` timed out at audit time. Wire when Ben wants local bulk coding on Porsche. |
| Compression retune | Already matches Doc-ish settings (`threshold: 0.5`, `target_ratio: 0.2`). No change. |
| Approvals change | Already `off`/autonomy per Ben on Porsche. |

## Skills count

- Before: **96** (Porsche inventory)  
- After: **100** (+4 adopted skills)

## What Doc should still pull from Porsche (reminder)

1. `project-car`  
2. `token_preflight` + `token_optimizer`  
3. `hermes-multi-agent-backup` + daily backup script  
4. `mission-control-development-heartbeat`  

## Verification

- [x] Skills exist under `~/.hermes/skills/`  
- [x] Memory notes written (routing + adoption)  
- [x] git-safe inventory re-exported  
- [x] This adoption file committed to Automation  

## Next optional (Ben / Doc)

1. Doc shares original skill tarballs if content differs from Porsche rewrites  
2. On Porsche: pick a **small** Ollama model when ready for local implement path  
3. Doc installs Porsche process skills + daily backup cron  

**Status:** Adoption complete for Porsche-side mutual-audit loop (policy + skills + inventory).
