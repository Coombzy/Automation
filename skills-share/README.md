# Fleet skill share (non-secret)

Public, git-safe skill trees agents may install from each other during mutual audit.

## Layout

```text
skills-share/
  Doc/           # skills authored / refined on Doc Hakosuka
  Porsche/       # (pending) skills authored on Porsche
  McKing/        # (pending)
  README.md
```

## Install (example — Porsche installing Doc skills)

```bash
CLONE="${AUTOMATION_CLONE:-$HOME/Documents/Automation}"
git -C "$CLONE" pull --ff-only

# Option A: tree copy
cp -R "$CLONE/skills-share/Doc/productivity/macos-security-hardening" \
  ~/.hermes/skills/productivity/
cp -R "$CLONE/skills-share/Doc/mlops/xai-model-selection" \
  ~/.hermes/skills/mlops/
cp -R "$CLONE/skills-share/Doc/autonomous-ai-agents/grok" \
  ~/.hermes/skills/autonomous-ai-agents/
cp -R "$CLONE/skills-share/Doc/software-development/sqlalchemy-domain-modeling" \
  ~/.hermes/skills/software-development/

# Option B: tarball
tar -xzf "$CLONE/skills-share/Doc/doc-skills-for-porsche-2026-07-11.tar.gz" \
  -C ~/.hermes/skills
```

## Rules

- **No secrets** in this tree (scan before push).
- Prefer skill content that is useful fleet-wide.
- Role-specific skills are fine; installers should respect peer-audit “do not copy” notes (e.g. RAM-sized models).
- Ben is decision-maker on security-sensitive hardening actions after install.

## Current Doc share (2026-07-11)

| Skill | Path |
|-------|------|
| macos-security-hardening | `Doc/productivity/macos-security-hardening/` |
| xai-model-selection | `Doc/mlops/xai-model-selection/` |
| grok | `Doc/autonomous-ai-agents/grok/` |
| sqlalchemy-domain-modeling | `Doc/software-development/sqlalchemy-domain-modeling/` |
| tarball | `Doc/doc-skills-for-porsche-2026-07-11.tar.gz` |

## Pending from Porsche → Doc

`project-car`, `token_preflight`, `token_optimizer`, `hermes-multi-agent-backup`, `mission-control-development-heartbeat` (and optional kanban pair).
