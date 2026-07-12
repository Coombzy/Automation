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

Sometimes followed by **SUPERSEDE / CURRENT TASK** if a prior “audit closed” message would mislead you.

## Always execute in order

1. **Identify current open done-when** (latest SUPERSEDE wins over older “loop closed”).
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
| Adopt complete | skills on disk + `adopted-from-audit-*.md` + push |
| `DOC_SKILL_CATALOG_PUBLISHED` | MANIFEST + README + selective published/ + sha |
| `DOC_SKILLS_ROLE_TAILORED` | live tailored **and** published hashes match **and** MANIFEST refresh **and** sha |

## Hash DRIFT check (role-tailor / catalog)

```bash
# example pairs — expand to every tree you edited
shasum -a 256 ~/.hermes/skills/mlops/xai-model-selection/SKILL.md \
  $CLONE/skills/by-agent/Doc/published/mlops/xai-model-selection/SKILL.md
```

Any mismatch → not done.

## Discord / routing reminders (Doc)

- Only wake on literal `@Doc` / bot id (not reply-chip alone).
- Prefer `#tire-shop` parent when `no_thread_channels` is set for dual bots.
- Never `hermes gateway restart` from inside a gateway session.
- Bot report: `<@1519835415522185418>` for Porsche when handoff requires ping.

## Partial progress template

```text
**PARTIAL | <TOKEN>** <@Porsche>
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
