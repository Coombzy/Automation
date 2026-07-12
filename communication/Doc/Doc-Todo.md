# Doc Hakosuka Todo List

**Owner:** Doc Hakosuka (Hermes on M1 Max)  
**Maintained under:** `Coombzy/Automation/communication/Doc/`  
**Last updated:** 2026-07-12 (agent-dream skill + daily light / Sunday deep)  
**Fleet rule:** No n8n. Orchestration = Hermes + custom adapters + Discord.

---

## P0 — Ops / reliability

- [x] **Pair check-in cron 2×/day (Ben 2026-07-12)** — `doc-porsche-pair-checkin` (`89e256129ba3`) · `0 10,16 * * *` · model **ollama qwen3.6:35b** · skill `fleet-pair-checkin` · deliver `#tire-shop` · audit reports `~/Desktop/Fleet-Nextcloud/Heartbeats/Fleet/pair-checkin-*.md`
- [x] **Nextcloud host + Desktop structure (2026-07-12)** — `/Users/dochak/Desktop/Fleet-Nextcloud` seeded. Docker NC later.
- [x] **agent-dream skill (fleet)** — local-LLM checklist skill for Doc + Porsche; shared `skills/shared/agent-dream/`; light daily + **Sunday deep**; promote/prune caps; metrics.
- [x] **Daily backup + dream (Ben)** — cron **`doc-daily-backup-and-dream`** (`0111562255ba`) · `0 22 * * *` · script emits `DREAM_MODE=light|deep` · skills include `agent-dream` · digests `~/Desktop/Fleet-Nextcloud/Memory/Dreams/Doc/` · `#doc-garage`. Prefer local **qwen3.6:35b**.
- [x] **Backup tiers** — daily zip (keep 30); **Sunday → weekly/** (keep 12); **1st → monthly/** (keep 24). Spec: `DREAM-CRON.md` + `daily-doc-backup.sh`.
- [x] **Skill role-tailoring / mutual-audit apply** — prior handoffs closed.
- [x] **daily-doc-backup.sh** — `~/.hermes/scripts/`; Porsche wrapper `daily-porsche-backup.sh` for peer install.
- [x] **Hermes cron SSOT for 22:00** — do not also load launchd backup (double-zip).

## P1 — Software baseline (when awake)

- [x] **Amphetamine** — installed and running (Ben confirmed 2026-07-12); `/Applications/Amphetamine.app` present; keep active for gateway + long model jobs
- [ ] Install battery app: **coconutBattery** (+ **AlDente** if always-plugged charge limit desired) — not installed
- [ ] Install **Cursor** if missing (Grok build may already be present)
- [x] Homebrew + git + `gh` + jq path (gh auth working as Coombzy)
- [x] Hermes gateway as service + `DISCORD_ALLOW_BOTS=mentions` (+ tire-shop no_thread)
- [x] Ollama for heavy local models (`qwen3.6:35b`, `gemma4:26b`)
- [ ] Tailscale / mesh remote access (Tailscale launch agent present — verify)
- [ ] Monitoring: Stats or iStat Menus

## P2 — Fleet

- [x] Confirm home channel `#doc-garage` + fleet channel `#tire-shop` routing
- [x] Coordinate backup path layout under `backup/Doc/` (protocol aligned)
- [x] **Live skill align** — `fleet-mutual-improvement` v1.4 + handoff/role-tailoring refs rsynced from `skills/shared/` after `08fd950` pull
- [ ] Optional: merge Porsche original skill tarballs if privately shared
- [ ] Ben decision: `approvals.mode: off` on Doc for fleet autonomy (config currently has **no** `approvals` key; launchd bootstrap already hitting host approval gate)

## Done

- [x] Discord presence / check-in path (2026-07-11)
- [x] First git-safe pack + peer audit of Porsche (commit `b798c58`)
- [x] Adopt process skills from Porsche audit list (Doc-side implementations) (2026-07-11)

---

### Notes
- Porsche can help scaffold scripts; **Doc machine must run its own cron** (jobs don’t hop hosts).
- When blocked on Ben (power/login/approvals), surface on `communication/Porsche/Ben-Todo.md`.
- GitHub todos are source of truth for fleet lists (not chat memory alone).
