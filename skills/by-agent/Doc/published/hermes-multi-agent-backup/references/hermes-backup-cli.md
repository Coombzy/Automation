# Hermes backup CLI (fleet daily archives)

## Commands that matter

| Command | Result | Use for fleet daily zip? |
|---------|--------|--------------------------|
| `hermes backup -o /path/to/hermes-full-$STAMP.zip` | Full archive of config/skills/sessions (excludes hermes-agent codebase) at **that path** | **Yes** |
| `hermes backup --quick -o PATH -l label` | **State snapshot** under `~/.hermes/state-snapshots/` (label). Does **not** reliably produce the off-home zip you named with `-o` | **No** for gitignored daily retention |
| `hermes profile export …` | Profile tarball (secrets risk) | Local only — never public git |

## Doc daily script contract

- Path: `~/.hermes/scripts/daily-doc-backup.sh`
- Must `mkdir -p` `backup/Doc/{daily,weekly,monthly,logs}` first
- Call **full** `hermes backup -o "$DAILY_DIR/hermes-full-$STAMP.zip"`
- Retention: keep ~30 daily full zips; promote weekly/monthly copies
- Git: only `git-safe/` inventories — never the full zips (`backup/.gitignore`)

## Launchd

- Label: `ai.hermes.doc-daily-backup`
- Schedule: 22:00 local
- If bootstrap is approval-blocked inside a gateway session, leave plist on disk and ask Ben/Terminal — do not thrash.

## Pitfall from 2026-07-11 session

First script revision used `--quick` and logged “ok” while daily/ stayed empty except `.gitkeep`. Full `hermes backup -o` produced ~65MB zip correctly.
