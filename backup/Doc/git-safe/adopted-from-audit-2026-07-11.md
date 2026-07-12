# Adopted from audit — Doc (2026-07-11)

**Owner:** Doc Hakosuka  
**Status:** **COMPLETE** (inbound Porsche skills installed + inventory re-export)  
**Source audits:**
- Porsche → Doc: `backup/Doc/git-safe/peer-audit-of-Doc-2026-07-11.md` (`f7e6e16`)
- Doc → Porsche: `backup/Porsche/git-safe/peer-audit-of-Porsche-2026-07-11.md` (`b798c58`)
- Porsche skill-share: `skills-share/Porsche/` (`c57117c`)

**Policy:** Ben remains decision-maker on security, spend, and major architecture. No secrets entered public git.

---

## Adopted

| Item | Action taken | Notes |
|------|----------------|-------|
| `project-car` | Installed from `skills-share/Porsche/` | Load on every Project Car task |
| `token_preflight` | Installed | Cheap gate before heavy Grok turns |
| `token_optimizer` | Installed | Cost control for SuperGrok burn |
| `hermes-multi-agent-backup` | Installed | Fleet backup doctrine |
| `mission-control-development-heartbeat` | Installed | Overnight loop pattern (enable only with explicit phase task) |
| Fleet backup split | `~/.hermes/scripts/daily-doc-backup.sh` | Local full → gitignored daily/weekly/monthly |
| 10pm local schedule | launchd plist `ai.hermes.doc-daily-backup` | **Plist written**; bootstrap may still need Terminal one-shot if approvals block `launchctl` |
| Skill share for Porsche | `skills-share/Doc/` + tarball | Unblocked Porsche |
| Handoff / done-token style | Affirmed | `@Porsche`, SHA, URLs, block list |
| No-n8n / Hermes-only | Affirmed | |
| Discord routing trio | Already applied | mention + inline bot mention + `#tire-shop` no_thread |
| Job-scoped `caffeinate` | Affirmed | Prefer over global sleep kill |
| Architect Grok / implement local | Affirmed | 64GB Ollama bulk OK on Doc |
| Inventory re-export | `inventory-latest.json` + dated | After skill install; **skills_count: 83** |

## Deferred (Ben / software baseline)

| Item | Why deferred |
|------|----------------|
| Amphetamine / AlDente / coconutBattery | Not on Doc; Ben software baseline |
| Explicit `approvals.mode: off` | Config has no `approvals` key; prompts still fire on some patterns — Ben confirm before force-change |
| launchd bootstrap for backup | Approvals treated `launchctl bootstrap` as service restart; needs Terminal one-shot |
| Heartbeat cron live overnight | Skill installed; **not** scheduled until explicit Project Car phase + budget |
| Optional kanban orchestrator/worker | Only if dual-profile worker mode starts |

## Rejected / will not copy

| Item | Why |
|------|-----|
| Second PA / scheduler identity | Doc stays specialist / heavy compute |
| Skill-count parity for its own sake | Role-fit only |
| LAN Ollama without Ben OK | Security |
| vLLM primary on Apple Silicon | Ollama/MLX-class on Macs; vLLM → McKing later |
| Secrets / full profiles into public Automation | Protocol ban |

## Shared outbound (Doc → Porsche)

```text
skills-share/Doc/productivity/macos-security-hardening/
skills-share/Doc/mlops/xai-model-selection/
skills-share/Doc/autonomous-ai-agents/grok/
skills-share/Doc/software-development/sqlalchemy-domain-modeling/
skills-share/Doc/doc-skills-for-porsche-2026-07-11.tar.gz
```

## Inbound (Porsche → Doc) — installed

```text
~/.hermes/skills/autonomous-ai-agents/project-car/
~/.hermes/skills/autonomous-ai-agents/token_preflight/
~/.hermes/skills/autonomous-ai-agents/token_optimizer/
~/.hermes/skills/hermes-multi-agent-backup/
~/.hermes/skills/software-development/mission-control-development-heartbeat/
```

## Ops checklist

- [x] Porsche skills installed (order: project-car → token_preflight → token_optimizer → backup → heartbeat)
- [x] `daily-doc-backup.sh` present + executable
- [x] launchd **plist** for 22:00 local
- [ ] launchd **loaded** (Ben/Terminal if needed)
- [x] Discord routing config
- [x] GitHub write auth
- [x] One inventory re-export after installs
- [ ] Amphetamine baseline (Ben)

## Mutual-audit loop

| Agent | Export | Peer audit | Adopt | Skill-share out |
|-------|--------|------------|-------|-----------------|
| Porsche | ✅ | ✅ | ✅ | ✅ |
| Doc | ✅ (re-export after install) | ✅ | ✅ | ✅ |

**Done for this round.** No further inventory churn unless skills/config change materially.
