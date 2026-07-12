# Role-skill tailoring (per-charter skill pass)

Use when Ben or a peer HANDOFF asks an agent to **tailor skills to their charter/hardware** (not weekly mutual-audit alone). Completed pattern: Porsche PA/24GB (2026-07-12), Doc specialist/64GB (2026-07-12). McKing CUDA/storage is the same class later.

## When to use

- Explicit “role-tailor your skills” / temporary instruction file under `communication/<Agent>/`
- After peer published a charter-locked skill fork and you must **mirror structure, invert roles**
- Onboarding a new host (McKing) that must not clone PA or specialist identity

**Don't use for:** skill-count parity installs, rewriting SOUL to match a peer, or dual weekly audit runbooks.

## Charter locks (restate first)

| Agent | Bias when editing skills |
|-------|---------------------------|
| **Porsche** | PA / travel-host / 7B–14B / review+HANDOFF / ops todos |
| **Doc** | Specialist / always-on lab / 26B–35B implement / domain ORM / bulk local heartbeats |
| **McKing** | CUDA / vLLM / storage / heavy code lab when home |

Unique skills are healthy. No parity.

## Ordered workflow (done when: done-token + sha)

1. **Pull + read instructions** — `git pull --ff-only` Automation clone. Doc clone often `/Users/dochak/hermes-tools/Automation`. Read temporary `communication/<Agent>/…INSTRUCTIONS.md` + peer git-safe note under `backup/<Peer>/git-safe/`.
2. **Mirror structure, invert content** — use peer’s published tailored skill as *layout* (tables, sections), flip owner/RAM/default path. Never paste travel-host into lab or 35B onto 24GB.
3. **Edit live first** — all durable text under `~/.hermes/skills/...` on **this** host.
4. **Selective publish** — `cp -R` edited trees → `skills/by-agent/<Agent>/published/` (not full dump). Prefer overlay `cp -R`; avoid destructive full-tree sync that may hit approval friction.
5. **Refresh MANIFEST + README** from live disk:
   - Fields: `name` (frontmatter), `path`, `description`, `bytes`, `sha256_16`, `share_class`, `flags`
   - Under `published/` → prefer `share_class: eligible_full_copy`
   - Charter lock blurb on README
6. **Secret skim** — real `sk-…`/`xox…`/`BEGIN OPENSSH` fail; bare `api_key=` docs and substring false positives on words containing `sk-` are OK if no token shape.
7. **Git-safe note** — short `backup/<Agent>/git-safe/<agent>-role-skill-tailoring-YYYY-MM-DD.md` table of what changed.
8. **Commit + push** — only catalog/published/git-safe/comms (no `.env`/tarballs).
9. **Discord done token** — e.g. `DOC_SKILLS_ROLE_TAILORED <sha>` + bullet summary + peer `<@bot_id>`.
10. **Dual ACK → delete temp instructions** — Porsche or Doc removes the temporary instruction file in a cleanup commit after both confirm.

## Priority skill map (recurring)

| Skill | Porsche bias | Doc bias |
|-------|--------------|----------|
| `xai-model-selection` | 24GB PA + hand-to-Doc | 26B–35B implement + Grok plan/review |
| `sqlalchemy-domain-modeling` | Review / HANDOFF only | Primary implementer + domain notes |
| `mission-control-development-heartbeat` | Supervise / prioritize | Bulk local implement ticks + hardware line |
| `macos-security-hardening` | Travel-host | Always-on lab |
| `token_preflight` / `token_optimizer` | PA cloud bias | Skip pure local; cloud/Grok only |
| Fleet audit | **improvement only** | Deprecate dual `fleet-mutual-audit` weekly |
| Local LLM stack | Do not install for parity | Ollama/llama.cpp primary; vLLM → McKing |

Optional thin new skills only if high value; prefer patching existing umbrellas.

## Pitfalls (session-proven)

1. **Copying peer host defaults** — structure yes; RAM/charter no.
2. **published/ full dump** — catalog lists all; published is selective.
3. **Stale MANIFEST** — hashes must match live after edits.
4. **Dual weekly audit skills** — one runbook: `fleet-mutual-improvement`.
5. **Second constitution** — `project-car` stays Porsche SSOT; Doc gets short implementer overlay only.
6. **Done without dual ACK** — temporary instruction files stay until both agents confirm.
7. **Destructive sync without consent** — prefer `cp -R` overlay over `rsync --delete` when approvals are sticky.

## Done-token shape

```text
DOC_SKILLS_ROLE_TAILORED <sha>

- xai-model-selection: …
- sqlalchemy: …
- MC heartbeat: …
- macos-security: …
- token_*: …
- fleet: mutual-improvement only …
- MANIFEST refreshed: yes
```

Mention peer bot with literal `<@id>`.
