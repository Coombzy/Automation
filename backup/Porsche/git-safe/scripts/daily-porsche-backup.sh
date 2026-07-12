#!/usr/bin/env bash
# Wrapper: Porsche host backup + dream pre-script (same logic as Doc)
export FLEET_AGENT=Porsche
export DOC_BACKUP_ROOT="${PORSCHE_BACKUP_ROOT:-$HOME/hermes-tools/Automation/backup/Porsche}"
# Reuse Doc script body with agent override — if missing, fall through
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [[ -f "$SCRIPT_DIR/daily-doc-backup.sh" ]]; then
  exec env FLEET_AGENT=Porsche DOC_BACKUP_ROOT="${DOC_BACKUP_ROOT}" bash "$SCRIPT_DIR/daily-doc-backup.sh" "$@"
fi
echo "ERR: daily-doc-backup.sh missing" >&2
exit 1
