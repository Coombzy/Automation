#!/usr/bin/env bash
# daily-doc-backup.sh — Doc host daily backup + dream pre-script
# Emits DREAM_MODE=light|deep for the following agent-dream job.
# Daily zip; Sunday → weekly/; day 01 → monthly/. PUBLIC git: never commit zips/secrets.

set -euo pipefail

export PATH="${HOME}/.hermes/hermes-agent/venv/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:${PATH:-}"

AGENT="${FLEET_AGENT:-Doc}"
HERMES_HOME="${HERMES_HOME:-$HOME/.hermes}"
CLONE="${AUTOMATION_CLONE:-$HOME/hermes-tools/Automation}"
STAMP="$(date +%Y-%m-%d_%H%M%S)"
DAY="$(date +%Y-%m-%d)"
DOW="$(date +%u)"   # 1=Mon … 7=Sun
DOM="$(date +%d)"

LOCAL_ROOT="${DOC_BACKUP_ROOT:-$CLONE/backup/$AGENT}"
DAILY_DIR="$LOCAL_ROOT/daily"
WEEKLY_DIR="$LOCAL_ROOT/weekly"
MONTHLY_DIR="$LOCAL_ROOT/monthly"
LOG_DIR="$LOCAL_ROOT/logs"
GIT_SAFE_DIR="$LOCAL_ROOT/git-safe"

mkdir -p "$DAILY_DIR" "$WEEKLY_DIR" "$MONTHLY_DIR" "$LOG_DIR" "$GIT_SAFE_DIR"
LOG="$LOG_DIR/daily-$DAY.log"

log() { echo "[$(date +%H:%M:%S)] $*" | tee -a "$LOG"; }

# --- Dream mode for agent-dream skill ---
if [[ "$DOW" == "7" ]]; then
  DREAM_MODE="deep"
else
  DREAM_MODE="light"
fi

log "=== $AGENT daily backup start $STAMP ==="
log "DREAM_MODE=$DREAM_MODE"
log "ROLE=$AGENT"
log "DOW=$DOW DOM=$DOM DAY=$DAY"
echo "DREAM_MODE=$DREAM_MODE"
echo "ROLE=$AGENT"
echo "DREAM_DAY=$DAY"

# Ensure dream dirs exist
if [[ "$AGENT" == "Doc" ]]; then
  mkdir -p "$HOME/Desktop/Fleet-Nextcloud/Memory/Dreams/Doc" 2>/dev/null || true
  mkdir -p "$HOME/Desktop/Doc-Dreams" 2>/dev/null || true
elif [[ "$AGENT" == "Porsche" ]]; then
  mkdir -p "$HOME/Documents/Fleet-Memory/Dreams/Porsche" 2>/dev/null || true
  mkdir -p "$HOME/Documents/Fleet-Memory/Handoffs/drafts" 2>/dev/null || true
fi

# --- 1) Local full archive (SENSITIVE — gitignored) ---
OUT_ZIP=""
BYTES=0
if command -v hermes >/dev/null 2>&1; then
  OUT_ZIP="$DAILY_DIR/hermes-full-$STAMP.zip"
  if hermes backup -o "$OUT_ZIP" >>"$LOG" 2>&1; then
    BYTES="$(wc -c <"$OUT_ZIP" 2>/dev/null | tr -d ' ' || echo 0)"
    log "full backup ok: $OUT_ZIP ($BYTES bytes)"
    echo "BACKUP_OK=1"
    echo "BACKUP_PATH=$OUT_ZIP"
    echo "BACKUP_BYTES=$BYTES"
  else
    log "WARN: hermes backup failed"
    echo "BACKUP_OK=0"
    echo "BACKUP_ERROR=hermes_backup_failed"
  fi
else
  log "WARN: hermes not on PATH"
  echo "BACKUP_OK=0"
  echo "BACKUP_ERROR=hermes_not_on_path"
fi

# --- 2) Retention: last 30 daily ---
ls -1t "$DAILY_DIR"/hermes-full-*.zip 2>/dev/null | tail -n +31 | while read -r f; do
  rm -f "$f" && log "pruned daily $f"
done || true

# --- 3) Weekly (Sunday) + Monthly (1st) promotes ---
LATEST="$(ls -1t "$DAILY_DIR"/hermes-full-*.zip 2>/dev/null | head -1 || true)"
WEEKLY_PROMOTED=0
MONTHLY_PROMOTED=0
if [[ -n "${LATEST:-}" ]]; then
  if [[ "$DOW" == "7" ]]; then
    cp -f "$LATEST" "$WEEKLY_DIR/hermes-weekly-$DAY.zip"
    log "weekly promote: $WEEKLY_DIR/hermes-weekly-$DAY.zip"
    echo "WEEKLY_PROMOTE=$WEEKLY_DIR/hermes-weekly-$DAY.zip"
    WEEKLY_PROMOTED=1
    # keep last 12 weeklies
    ls -1t "$WEEKLY_DIR"/hermes-weekly-*.zip 2>/dev/null | tail -n +13 | while read -r f; do
      rm -f "$f" && log "pruned weekly $f"
    done || true
  fi
  if [[ "$DOM" == "01" ]]; then
    cp -f "$LATEST" "$MONTHLY_DIR/hermes-monthly-$DAY.zip"
    log "monthly promote: $MONTHLY_DIR/hermes-monthly-$DAY.zip"
    echo "MONTHLY_PROMOTE=$MONTHLY_DIR/hermes-monthly-$DAY.zip"
    MONTHLY_PROMOTED=1
    ls -1t "$MONTHLY_DIR"/hermes-monthly-*.zip 2>/dev/null | tail -n +25 | while read -r f; do
      rm -f "$f" && log "pruned monthly $f"
    done || true
  fi
fi
echo "WEEKLY_PROMOTED=$WEEKLY_PROMOTED"
echo "MONTHLY_PROMOTED=$MONTHLY_PROMOTED"

# MEMORY size hint for dream
MEM_FILE="$HERMES_HOME/memories/MEMORY.md"
if [[ -f "$MEM_FILE" ]]; then
  MEM_CHARS="$(wc -c <"$MEM_FILE" | tr -d ' ')"
  log "MEMORY_CHARS=$MEM_CHARS"
  echo "MEMORY_CHARS=$MEM_CHARS"
fi

log "=== $AGENT daily backup end DREAM_MODE=$DREAM_MODE ==="
echo "BACKUP_SCRIPT_DONE=1"
