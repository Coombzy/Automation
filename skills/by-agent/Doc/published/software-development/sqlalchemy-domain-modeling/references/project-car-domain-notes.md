# Project Car domain notes (Doc implementer)

Short entity map for Mission Control / Project Car SQLAlchemy work. Multi-FK discipline still applies everywhere (`references/multi-fk-patterns.md`).

## Core domains (expected modules)

| Domain | Typical entities | Multi-FK watch |
|--------|------------------|----------------|
| **Members / access** | Member, Credential, Reader, AccessEvent, Location | AccessEvent: member + reader + location; Credential issued_by vs used_by |
| **NFC / FOB** | Fob, FobAssignment, ReaderScan | FobAssignment: member + fob + assigned_by |
| **Tokens / economy** | TokenAccount, TokenLedgerEntry, TokenTransfer | Ledger: from_account + to_account + initiated_by |
| **Bookings** | Resource, Booking, BookingParticipant | Booking: resource + booker + cancelled_by |
| **Billing** | Invoice, InvoiceLine, Payment, MembershipPlan | Payment: member + invoice + recorded_by |
| **Incidents** | Incident, IncidentNote, IncidentReview | Incident: subject_member + reported_by + reviewed_by (classic 3-FK to Member) |
| **Hoist / tool inventory** | Tool, ToolCheckout, HoistBay, MaintenanceLog | Checkout: tool + member + checked_out_by vs returned_by |

## Modeling rules for this domain

1. **Separate relationships** for every FK to `Member` (subject vs reporter vs reviewer vs assigned_by).
2. Prefer `nullable=False` + defaults; optional contact fields and soft-delete markers are the main null cases.
3. Natural keys: member email, fob serial, tool asset tag, invoice number — unique indexes.
4. Time-series: AccessEvent / ReaderScan / TokenLedgerEntry — composite indexes on `(entity_id, timestamp)` and status filters.
5. Money: `Numeric` not float; balances default `0`.
6. Alembic: keep `ALL_MODELS` complete; run `python models.py` import sanity before migrate.

## Doc vs Porsche

- **Doc** implements full modules + migrations on this host (local 26B–35B under Grok tickets when large).
- **Porsche** reviews diffs, writes tickets/HANDOFFs, does not own multi-hour ORM builds.
- **McKing** only if explicitly assigned (e.g. load/perf on Linux).
