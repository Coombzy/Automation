# Adopted from audit — Doc (2026-07-11)

**Owner:** Doc Hakosuka  
**Source audits:**
- Porsche → Doc: `backup/Doc/git-safe/peer-audit-of-Doc-2026-07-11.md` (`f7e6e16`)
- Doc → Porsche: `backup/Porsche/git-safe/peer-audit-of-Porsche-2026-07-11.md` (`b798c58`)

**Policy:** Ben remains decision-maker on security, spend, and major architecture. No secrets entered public git.

---

## Adopted

| Item | Action taken | Notes |
|------|----------------|-------|
| Fleet process glue (backup split) | Installed `~/.hermes/scripts/daily-doc-backup.sh` | Local full archive → gitignored `backup/Doc/daily|weekly|monthly/`; never public push of zips |
| 10pm local schedule | Loaded launchd `ai.hermes.doc-daily-backup` (`StartCalendarInterval` 22:00) | Host-local only; not paid cloud agent cron |
| Skill share for Porsche | Pushed non-secret trees under `skills-share/Doc/` + tarball | Unblocks Porsche adoptions of Doc-unique skills |
| Handoff / done-token style | Continuing to mirror Porsche close-outs (`@Porsche`, SHA, URLs, block list) | Already used for push confirm |
| No-n8n / Hermes-only orchestration | Affirmed | No external workflow engines for fleet ops |
| Discord routing trio | Already applied on Doc | `require_mention` + inline bot mention + `#tire-shop` in `no_thread_channels` |
| Job-scoped stay-awake doctrine | Kept | Prefer `caffeinate` for long jobs over global sleep kill |
| Architect-cloud / implement-local cost policy | Affirmed as Doc default | Grok 4.5 plan; Ollama bulk on 64GB |

## Deferred (blocked on peer skill payload)

Porsche’s ordered install list is still **on Porsche disk only** (not in hub, not in git). Doc cannot install until Porsche mirrors the skill-share pattern:

1. `autonomous-ai-agents/project-car`
2. `autonomous-ai-agents/token_preflight`
3. `autonomous-ai-agents/token_optimizer`
4. `hermes-multi-agent-backup`
5. `software-development/mission-control-development-heartbeat`
6. Optional later: `devops/kanban-orchestrator` + `kanban-worker`

**Ask to Porsche:** please drop those under `skills-share/Porsche/` (same layout as Doc) or a tarball, then Doc will install in that order and amend this file.

Interim: Doc will treat `Coombzy/Automation` docs (`Project Car Agent Fleet.md`, `Docs/heartbeat-standards.md`, Architecture/Mission Control trees) as the public canon until the full `project-car` skill lands.

## Deferred (Ben / software baseline)

| Item | Why deferred |
|------|----------------|
| Amphetamine / AlDente / coconutBattery | Not installed on Doc; software baseline is Ben-owned |
| `approvals.mode: off` fleet autonomy | Audit notes Ben wants this on trusted hosts; Doc currently has no `approvals` key in config (missing ≠ confirmed off). **Will not force-change** without Ben confirm if gateways still prompt |
| Heartbeat cron for overnight MC coding | Needs `mission-control-development-heartbeat` skill + explicit Project Car phase task; not enabled blindly |
| Full `hermes profile export` tarball cadence | `hermes backup --quick` is in daily script; full export can be weekly/manual to limit disk |

## Rejected / will not copy

| Item | Why |
|------|-----|
| Become second PA / scheduler | Role mismatch — Doc stays specialist / heavy compute |
| Blind skill-count parity with Porsche’s 96 | Only adopt role-fit + cost/risk reducers |
| Expose Ollama beyond localhost | Requires hardening + Ben OK |
| vLLM as primary on Apple Silicon | Keep Ollama/MLX-class; vLLM knowledge for McKing later |
| Secrets / full profiles into public Automation | Protocol ban |

## Shared outbound (Doc → Porsche)

Published for Porsche install:

```text
skills-share/Doc/productivity/macos-security-hardening/
skills-share/Doc/mlops/xai-model-selection/
skills-share/Doc/autonomous-ai-agents/grok/
skills-share/Doc/software-development/sqlalchemy-domain-modeling/
skills-share/Doc/doc-skills-for-porsche-2026-07-11.tar.gz
skills-share/README.md
```

## Ops verification (Doc host)

- [x] `daily-doc-backup.sh` present + executable
- [x] launchd plist installed for 22:00 local
- [x] Discord routing config already correct
- [x] GitHub write auth works (`gh` as Coombzy)
- [ ] First launchd-fired run after 22:00 (or manual test at adopt time)
- [ ] Porsche skill trees received + installed
- [ ] Amphetamine baseline (Ben)

## Next

1. Porsche installs Doc skill-share; writes own `adopted-from-audit-YYYY-MM-DD.md`
2. Porsche publishes skill-share reverse direction
3. Doc installs + re-exports git-safe inventory **once** after skill installs (no churn before that)
4. Optional: Ben confirms `approvals` policy + Amphetamine install on Doc

**Status:** adopt phase **partial complete** — process/ops + outbound skill share done; inbound Porsche skills still blocked.
