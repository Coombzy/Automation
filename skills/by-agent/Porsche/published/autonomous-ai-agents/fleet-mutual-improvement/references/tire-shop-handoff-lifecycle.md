# Tire-shop handoff lifecycle (Doc lessons)

## Why this exists

Multi-agent Discord handoffs fail in predictable ways: work starts, session dies, Ben asks “did you do what Porsche asked?” and the truth is partial. This note is the completion bar for fleet HANDOFF messages.

## HANDOFF message shape (expect)

```text
**HANDOFF | <title> | owner: Doc | done-when: TOKEN + sha**
- Git instructions / path in Coombzy/Automation
- Numbered job steps
- Charter lock reminder
— Porsche
```

Sometimes followed by **SUPERSEDE / CURRENT TASK** if a prior “audit closed” message would mislead you. **Latest SUPERSEDE wins.**

## Always execute in order

1. **Identify current open done-when** (SUPERSEDE over older close-outs).
2. **Preflight:** `git pull`, `gh auth status` (or know push will block and say so early).
3. **Do the work** on the correct surface:
   - Mutual-audit packs → `backup/<Agent>/git-safe/`
   - Catalog → `skills/by-agent/<Agent>/`
   - Role-tailor → live `~/.hermes/skills` **then** published + MANIFEST
4. **Verify done-when table** (not vibes).
5. **Commit + push** (or explicit block).
6. **Discord close-out** with done-token + sha via `hermes send` if needed.
7. Temporary instruction files: delete only after **dual ACK**.

## Done-when examples

| Token | Minimum evidence |
|-------|------------------|
| Pack + peer audit | inventory + AUDIT-PACK + peer-audit on origin |
| Adopt complete | skills on disk + `adopted-from-audit-*.md` + push — **not** “will install” prose |
| `DOC_SKILL_CATALOG_PUBLISHED` | MANIFEST + README + selective published/ + sha |
| `DOC_SKILLS_ROLE_TAILORED` | live tailored **and** published hashes match **and** MANIFEST refresh **and** sha |

## Adopt vs peer-audit (Ben will ask)

| Claim | Evidence required |
|-------|-------------------|
| “I audited Porsche” | peer-audit markdown on git |
| “I improved myself from her pack” | live skill/script/config change + adoption note |
| “Role-tailored” | live + published hash match + done-token |

## Hash DRIFT check (role-tailor / catalog)

```bash
shasum -a 256 ~/.hermes/skills/mlops/xai-model-selection/SKILL.md \
  $CLONE/skills/by-agent/Doc/published/mlops/xai-model-selection/SKILL.md
```

Any mismatch → not done. 2026-07-11 role-tailor: live edited; published DRIFT; no done-token sha — **incomplete**.

## Discord / routing reminders (Doc)

- Only wake on literal `@Doc` / bot id (not reply-chip alone).
- Prefer `#tire-shop` parent when `no_thread_channels` is set for dual bots.
- Never `hermes gateway restart` from inside a gateway session.
- Bot report: `<@1519835415522185418>` for Porsche when handoff requires ping.
- Doc clone default: `~/hermes-tools/Automation`.

## Partial progress template

```text
**PARTIAL | <TOKEN>** <@1519835415522185418>
- Done: …
- Not done: published sync / MANIFEST / push / Discord token
- Local evidence: paths…
- Next: resume from step N — do not restart mutual-audit from zero
```

## Anti-patterns

- Closing mutual-audit then ignoring catalog SUPERSEDE.
- “Installed” meaning “wrote install recipe in chat.”
- Regenerating inventory while the only block was git auth.
- Retrying approval-BLOCKED commands with rephrased same script.
- Peer-audit steal list without applying skills (Ben catches this).

## Related

- Parent skill: `fleet-mutual-improvement`
- Session bank: `references/session-lessons-2026-07-11.md`
- Daily zips: hermes-multi-agent-backup `references/hermes-backup-cli.md`
