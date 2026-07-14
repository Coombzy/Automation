# Nextcloud Progress — Project Car fleet hub

**Audience:** Ben + Grok (and fleet agents)  
**Author:** Doc Hakosuka  
**Last updated:** 2026-07-14  
**Repo path:** `communication/Nextcloud-progress.md`  
**Status summary:** Temporary Docker hub **installed and configured on Doc**; **offline right now** until Docker Desktop is running. Core apps **installed**. Fleet seed folder **not yet nested** under Desktop Project Car. Permanent host (**McKing**) not started.

---

## 1. Goal

Self-hosted **Nextcloud** as Project Car fleet memory + collab hub (Files, Talk, Calendar, Deck, Forms, Photos, Passwords). Replaces Google-ish collab for private fleet data. **Not** a public git content store; **not** a replacement for thin Hermes `MEMORY.md` hot facts.

**Orchestration rule:** Hermes + custom code + Discord only — **no n8n**.

---

## 2. Host plan

| Phase | Host | Role |
|-------|------|------|
| **Now (temp)** | **Doc** — M1 Max 64GB, ~1TB | Docker Nextcloud + MariaDB + Redis |
| **Later (perm)** | **Lightning McKing** — CachyOS, i9-9900K + RTX 5080 | Same data migrate; optional Frigate GPU sibling |
| Edge | **Porsche** — M4 Pro 24GB | Client / travel only — **not** primary NC server |

---

## 3. What is done

### 3.1 Docker stack (Doc temporary hub)

| Item | Value |
|------|--------|
| Stack path | `/Users/dochak/hermes-tools/nextcloud-hub/` |
| Compose | `docker-compose.yml` — `nextcloud:30-apache` + `mariadb:11.4` + `redis:7-alpine` |
| Host port | **8080 → 80** |
| Volumes | Host binds: `./data`, `./db`, `./redis` |
| Secrets | `.env` (mode 600, gitignored) — **never** commit to public repos |
| Local credentials pointer | `~/Desktop/Nextcloud-Doc-Credentials.txt` (mode 600, local only) |
| Admin user | `ben` |
| Version when last healthy | Nextcloud **30.0.17** (`installed: true`) |
| Arch notes | Apple Silicon–friendly; Frigate/NVIDIA blocks **commented** for McKing only |
| Desktop compose copy (no secrets) | `~/Desktop/project-car-nextcloud-docker-compose.yml` (for review / Grok analysis) |

Skill / ops docs: Hermes skill **`nextcloud-fleet-hub`** (`references/doc-stack-ops.md`, `references/mcking-migration.md`).

### 3.2 Apps (confirmed installed 2026-07-13 session)

| App | App id | Notes |
|-----|--------|--------|
| Talk | `spreed` | ~20.1.x |
| Calendar | `calendar` | ~5.5.x |
| Deck | `deck` | ~1.14.x |
| Forms | `forms` | ~5.2.x |
| Photos | `photos` | Often pre-enabled on NC 30 |
| Passwords (vault) | `passwords` | ~2026.7.x — **not** `password_policy` |

First install attempt failed with “Could not download app …” (container → apps.nextcloud.com). Retry after store reachable succeeded via `occ app:install` / `app:enable`.

### 3.3 Desktop fleet seed (filesystem, parallel to Docker)

| Item | Value |
|------|--------|
| Path today | `~/Desktop/Fleet-Nextcloud/` |
| Role | Local layout for Dreams / Handoffs / Heartbeats / Memory before (and beside) full NC Files integration |
| Bound into NC volumes? | **No** — not External Storage / not auto-synced into `data/ben` yet |
| Related | Dream + pair-checkin tooling still expect this Desktop path unless updated |

### 3.4 Related Project Car Desktop workspace

Canonical local product tree: `~/Desktop/Project Car/` (docs, ProjectCar-App, Agents, etc.).  
Docker hub **stays outside** that tree on purpose (`hermes-tools/nextcloud-hub`) so large volumes / secrets are not mixed with app docs.

---

## 4. Current runtime state (as of 2026-07-14 check on Doc)

| Check | Result |
|-------|--------|
| Docker Desktop / `docker.sock` | **Not running** |
| `http://localhost:8080` | **Down** (connection refused) |
| On-disk volumes + install | **Intact** (`data/`, `db/`, `redis/`, user `ben` present) |
| Start procedure | `open -a Docker` → wait healthy → `cd …/nextcloud-hub && docker compose --env-file .env up -d` |

So: **setup complete, service stopped** — not a failed install.

---

## 5. Not done / deferred

1. **Bring stack up** when Ben needs UI/API (start Docker Desktop + compose).
2. **Nest seed under Project Car** (Ben request — “not right now” at the time):  
   `~/Desktop/Fleet-Nextcloud` → `~/Desktop/Project Car/Fleet-Nextcloud`  
   Then patch paths in:
   - `agent-dream` skill / dream cron digests  
   - `fleet-pair-checkin` / pair reports under `Heartbeats/Fleet/`  
   - any `daily-doc-backup` / Automation notes that hardcode the old path  
3. **Mount or copy** Fleet seed into Nextcloud user files (optional External Storage or one-time upload) so Talk/Files and agents share one hub.
4. **Remote access:** Tailscale (or similar) hostname in `NEXTCLOUD_TRUSTED_DOMAINS`; **do not** expose bare `:8080` to open internet without TLS + auth.
5. **Passwords app** hygiene / vault use by fleet — installed only; operational policy TBD with Ben.
6. **Hermes ↔ NC integration** deeper than folder paths (Talk bots, WebDAV automation, Calendar/Deck webhooks) — not built yet.
7. **McKing migration** when that host is home/online:
   - `docker compose down` on Doc  
   - rsync `data/`, `db/`, `redis/`, `.env`  
   - run `linux/amd64` (or multi-arch), raise MariaDB buffer if needed  
   - reverse proxy + HTTPS  
   - optional Frigate profile + NVIDIA toolkit (**Linux only**; never on Apple Silicon)  
   - re-point agents/DNS; decommission Doc as primary hub  

---

## 6. Security / hygiene (standing rules)

- **Public repos** (`Coombzy/Project-Car`, `Coombzy/Automation`): no `.env`, no admin passwords, no full `data/` dumps.
- Credentials file stays **local Desktop only** (or later a private vault) — not this markdown.
- Prefer **Tailscale** over port-forwarding for multi-machine access.
- Ollama/local LLMs remain localhost services — unrelated to NC bind.

---

## 7. Quick commands (Doc)

```bash
# Start Docker Desktop first, then:
cd /Users/dochak/hermes-tools/nextcloud-hub
docker compose --env-file .env up -d
docker compose ps
curl -sS http://127.0.0.1:8080/status.php

# App verify (when up)
docker compose exec -T -u www-data nextcloud php occ status
docker compose exec -T -u www-data nextcloud php occ app:list | grep -iE 'spreed|calendar|deck|forms|photos|passwords'

# Stop
docker compose --env-file .env down
```

UI: `http://localhost:8080` — login **`ben`** (password in local credentials file only).

---

## 8. One-liner for Grok

> Project Car Nextcloud **temporary hub on Doc is installed** (NC 30 + MariaDB + Redis on `:8080`, apps Talk/Calendar/Deck/Forms/Photos/Passwords enabled). **Stack is currently stopped** (Docker Desktop off); data volumes intact. Desktop **Fleet-Nextcloud** seed exists separately and is **not yet** under `Project Car/` or bound into NC files. **Permanent hub = McKing later**; Porsche is client-only. Next steps: start Docker when needed, optional seed move + path patches, Tailscale trusted domain, then McKing migration.

---

## 9. Related paths (Doc host)

| Path | Role |
|------|------|
| `/Users/dochak/hermes-tools/nextcloud-hub/` | Live Docker stack + volumes |
| `~/Desktop/Nextcloud-Doc-Credentials.txt` | Local admin URL/user/pass pointer |
| `~/Desktop/project-car-nextcloud-docker-compose.yml` | Secret-free compose for analysis |
| `~/Desktop/Fleet-Nextcloud/` | Agent seed tree (Dreams/Handoffs/Heartbeats) |
| `~/Desktop/Project Car/` | Product/workspace layout (app + docs) |
| Hermes skill `nextcloud-fleet-hub` | Ops + migration SSOT for agents |

---

*End of progress note. Update this file when Docker is re-verified up, seed is moved, remote access is live, or McKing migration starts.*
