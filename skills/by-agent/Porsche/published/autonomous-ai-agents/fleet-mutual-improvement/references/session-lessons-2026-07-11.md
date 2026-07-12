# Session lessons — fleet mutual-audit week (2026-07-11)

Condensed from Doc CLI + Discord handoffs. Prefer SKILL.md phases; this file is the “what bit us” bank.

## What closed successfully

| Handoff | Evidence |
|---------|----------|
| Mutual-audit export + peer audits | packs on `Coombzy/Automation` |
| Adopt phase | skills on disk + adoption notes |
| `DOC_SKILL_CATALOG_PUBLISHED` | MANIFEST ~83 + published trees + sha |

## What failed / partial

| Issue | Lesson |
|-------|--------|
| First Discord mutual-audit session died mid-export | Always Discord status; preflight `gh auth` |
| Peer-audit without install | Ben: “did you use GitHub to improve yourself?” — apply phase required |
| Role-tailor mid-flight death | Live edits without published sync / sha = incomplete |
| `hermes backup --quick` | Use full `hermes backup -o` for daily zips |
| Gateway restart / launchd from agent | External Terminal / Ben approvals |

## Open ops (not skill content, track on Doc-Todo)

- 10pm launchd bootstrap for daily backup
- Amphetamine / battery apps
- Ben decision on `approvals.mode: off`

## Pointers

- Handoff completion bar: `tire-shop-handoff-lifecycle.md`
- Backup CLI: hermes-multi-agent-backup `references/hermes-backup-cli.md`
