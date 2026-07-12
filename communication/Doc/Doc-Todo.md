# Doc Hakosuka Todo List

**Owner:** Doc Hakosuka (Hermes on M1 Max)  
**Maintained under:** `Coombzy/Automation/communication/Doc/`  
**Last updated:** 2026-07-12 (daily backup+dream combined cron)  
**Fleet rule:** No n8n. Orchestration = Hermes + custom adapters + Discord.

---

## P0 — Ops / reliability

- [x] **Nextcloud host + Desktop structure (2026-07-12)** — tire-shop `DOC_NEXTCLOUD_STRUCTURE_READY` path `/Users/dochak/Desktop/Fleet-Nextcloud` (Memory/{Shared,Porsche,Doc,McKing,Dreams/*}, Heartbeats, Handoffs, Docs, Inbox/Outbox, Backups, Templates + README; ~926 Gi disk / ~794 Gi free). Spec: `NEXTCLOUD-DESKTOP-STRUCTURE.md`. Docker NC still later.
- [x] **Daily backup + dream (Ben 2026-07-12)** — removed M/W/F-only `doc-dream-specialist`; single Hermes cron **`doc-daily-backup-and-dream`** (`0111562255ba`) · `0 22 * * *` daily 22:00 MT · script `daily-doc-backup.sh` then dream agent · digests `~/Desktop/Fleet-Nextcloud/Memory/Dreams/Doc/` · deliver `#doc-garage`. Spec: `communication/Doc/DREAM-CRON.md`.
- [x] **Skill role-tailoring (2026-07-12)** — live+published+MANIFEST; token `DOC_SKILLS_ROLE_TAILORED` + sha in tire-shop; instruction file deleted after dual ACK
- [x] **Mutual-audit apply phase (2026-07-11)** — installed project-car, token_preflight, token_optimizer, hermes-multi-agent-backup, mission-control-development-heartbeat; wrote `backup/Doc/git-safe/adopted-from-audit-2026-07-11.md`
- [x] **daily-doc-backup.sh installed** — `~/.hermes/scripts/daily-doc-backup.sh` (invoked by Hermes daily cron pre-script)
- [x] **Daily 10pm backup schedule (Hermes cron SSOT)** — do **not** also load launchd `ai.hermes.doc-daily-backup` for the same window (would double-zip). Plist may remain on disk unused.
- [~] **First local backup zip** — `backup/Doc/daily/hermes-full-test.zip` (~65MB, 2026-07-11); next daily run should refresh under same tree

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
