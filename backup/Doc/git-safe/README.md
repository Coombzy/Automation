# Doc Hakosuka git-safe manifests

Export **sanitized** inventory here for mutual audit with Porsche (and later McKing).

See `../../MUTUAL-AUDIT-PROTOCOL.md`.

## Current pack (2026-07-11, re-export after adopt)

- `inventory-latest.json` / `inventory-2026-07-11.json`
- `AUDIT-PACK.md`
- `peer-audit-of-Doc-2026-07-11.md` (by Porsche)
- `adopted-from-audit-2026-07-11.md` (**complete**)
- `scripts/daily-doc-backup.sh`

Peer audits of Doc land as:

- `peer-audit-of-Doc-YYYY-MM-DD.md` (written by Porsche / McKing)

Doc’s audits of peers land under the **subject’s** `git-safe/` folder (protocol default).

## Never commit

- `.env`, `auth.json`, OAuth/API/bot tokens
- Full `hermes profile export` tarballs
- Session DBs / private chat dumps
- Raw security / 2FA / recovery notes
- SSH / mesh private keys
