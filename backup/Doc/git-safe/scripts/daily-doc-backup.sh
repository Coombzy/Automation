#!/usr/bin/env bash
# daily-doc-backup.sh — Doc Hakosuka local + optional git-safe retention helper
# Schedule target: 10:00 PM local (0 22 * * *) via launchd on THIS host only.
# Coombzy/Automation is PUBLIC — never push full/quick zips or secrets.
#
# Shared copy for peer review (non-secret). Live path: ~/.hermes/scripts/daily-doc-backup.sh

set -euo pipefail

AGENT="Doc"
HERMES_HOME="${HERMES_HOME:-$HOME/.hermes}"
CLONE="${AUTOMATION_CLONE:-$HOME/hermes-tools/Automation}"
STAMP="$(date +%Y-%m-%d_%H%M%S)"
DAY="$(date +%Y-%m-%d)"
LOCAL_ROOT="${DOC_BACKUP_ROOT:-$CLONE/backup/$AGENT}"
DAILY_DIR="$LOCAL_ROOT/daily"
WEEKLY_DIR="$LOCAL_ROOT/weekly"
MONTHLY_DIR="$LOCAL_ROOT/monthly"
LOG_DIR="$LOCAL_ROOT/logs"
GIT_SAFE_DIR="$LOCAL_ROOT/git-safe"

mkdir -p "$DAILY_DIR" "$WEEKLY_DIR" "$MONTHLY_DIR" "$LOG_DIR" "$GIT_SAFE_DIR"
LOG="$LOG_DIR/daily-$DAY.log"

log() { echo "[$(date +%H:%M:%S)] $*" | tee -a "$LOG"; }

log "=== Doc daily backup start $STAMP ==="

# --- 1) Local quick archive (SENSITIVE — local/gitignored only) ---
if command -v hermes >/dev/null 2>&1; then
  OUT_QUICK="$DAILY_DIR/hermes-quick-$STAMP.zip"
  if hermes backup --quick -o "$OUT_QUICK" -l "doc-daily" >>"$LOG" 2>&1; then
    log "quick backup ok: $OUT_QUICK ($(wc -c <"$OUT_QUICK" | tr -d ' ') bytes)"
  else
    log "WARN: hermes backup --quick failed"
  fi
else
  log "WARN: hermes not on PATH"
fi

# --- 2) Retention: keep last 30 daily zips ---
ls -1t "$DAILY_DIR"/hermes-quick-*.zip 2>/dev/null | tail -n +31 | while read -r f; do
  rm -f "$f" && log "pruned daily $f"
done || true

# Promote first-of-week / first-of-month copies (simple)
DOW="$(date +%u)"   # 1=Mon
DOM="$(date +%d)"
LATEST="$(ls -1t "$DAILY_DIR"/hermes-quick-*.zip 2>/dev/null | head -1 || true)"
if [[ -n "${LATEST:-}" ]]; then
  if [[ "$DOW" == "7" ]]; then
    cp -f "$LATEST" "$WEEKLY_DIR/hermes-weekly-$DAY.zip" && log "weekly promote"
  fi
  if [[ "$DOM" == "01" ]]; then
    cp -f "$LATEST" "$MONTHLY_DIR/hermes-monthly-$DAY.zip" && log "monthly promote"
  fi
fi

# --- 3) Optional git-safe re-export when DOC_BACKUP_GITSAFE=1 ---
# Default off for unattended cron (needs careful secret-free inventory script).
# Manual: DOC_BACKUP_GITSAFE=1 ~/.hermes/scripts/daily-doc-backup.sh
if [[ "${DOC_BACKUP_GITSAFE:-0}" == "1" ]]; then
  log "git-safe export requested — run fleet-mutual-improvement inventory path manually if not automated"
  if [[ -d "$CLONE/.git" ]]; then
    git -C "$CLONE" pull --ff-only >>"$LOG" 2>&1 || log "WARN: git pull failed"
  fi
fi

log "=== Doc daily backup end ==="
