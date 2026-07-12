# Doc role skill tailoring — 2026-07-12

Ben asked Doc to tailor skills for **specialist / heavy compute / M1 Max 64GB** (mirror of Porsche’s PA/24GB pass).

## Changed (live `~/.hermes/skills` + `skills/by-agent/Doc/published/`)

| Skill | Change |
|-------|--------|
| `xai-model-selection` | Doc 64GB: Grok plan/review; local 26B–35B implement |
| `sqlalchemy-domain-modeling` | Primary implementer + Project Car domain notes |
| `mission-control-development-heartbeat` | Bulk local implement ticks; Porsche supervises |
| `macos-security-hardening` | Always-on lab (+ `references/always-on-lab.md`) |
| `token_preflight` / `token_optimizer` | Skip pure local; cloud/Grok path only |
| `fleet-mutual-improvement` | Sole weekly mutual runbook |
| `fleet-mutual-audit` | Deprecated alias |
| `hermes-multi-agent-backup` | 10pm launchd ops; mutual → improvement only |
| `llama-cpp` / `vllm` / HF / lm-eval / `grok` | Host-true Doc profiles |
| `project-car` | Short implementer overlay; specialist lock |

## Catalog

MANIFEST + published refreshed same session. Done-when: `DOC_SKILLS_ROLE_TAILORED`.
