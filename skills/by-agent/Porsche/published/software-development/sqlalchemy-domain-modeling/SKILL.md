---
name: sqlalchemy-domain-modeling
description: "Design full SQLAlchemy ORM domain model sets for Project Car / multi-module apps."
version: 1.0.0
author: Porsche (fleet skill from Doc mutual-audit gap fill 2026-07-11)
license: MIT
platforms: [macos, linux, windows]
metadata:
  hermes:
    tags: [sqlalchemy, orm, domain-model, project-car, backend]
    related_skills: [project-car, test-driven-development, writing-plans]
---

# SQLAlchemy domain modeling

Use when designing or reviewing ORM models for Project Car, Mission Control, shop modules, or any multi-aggregate backend.

## Goals

- Clear **aggregates** and bounded contexts
- Migrations-friendly models (Alembic-ready)
- Explicit relationships, cascades, and nullable rules
- Testable domain without leaking HTTP/UI concerns into models

## Workflow

1. **Name the bounded contexts** (e.g. identity, inventory, booking, billing, telemetry).
2. **List aggregates + roots** before tables.
3. **Define invariants** (what must always be true) as domain notes / methods, not only DB constraints.
4. **Map to SQLAlchemy 2.0 style** (`Mapped[]`, `mapped_column`, `relationship`).
5. **Add Alembic migration plan** (expand/contract if live data).
6. **Write model unit tests** for invariants and relationship loading strategy.

## Model conventions

```python
from datetime import datetime
from sqlalchemy import String, ForeignKey, func
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship

class Base(DeclarativeBase):
    pass

class TimestampMixin:
    created_at: Mapped[datetime] = mapped_column(server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(
        server_default=func.now(), onupdate=func.now()
    )
```

- Prefer **UUIDs or bigints** consistently per context; don’t mix casually.
- Use **explicit `lazy`** (`selectin` / `raise` for production paths that must not N+1).
- Soft-delete only when product requires it; index `deleted_at` if used.
- Money: integer cents + currency code, never float.

## Project Car notes

- Prefer **Nextcloud-first / no Google** integration assumptions in domain (external IDs optional).
- Shop modules (hoist booking, tool tracking) stay **separate contexts** until shared kernel is proven.
- Auth identity vs shop customer may differ — model the link, don’t collapse blindly.
- No n8n workflow tables as orchestration source of truth — Hermes/custom adapters own orchestration.

## Handoff pattern (Doc ↔ Porsche)

When handing domain work:

```text
CONTEXT: <bounded context>
AGGREGATES: ...
OPEN QUESTIONS: ...
MIGRATION RISK: none | expand-only | rewrite
DONE-WHEN: models + tests + Alembic revision draft
```

Doc is primary heavy implementer; Porsche reviews architecture and Ben-facing tradeoffs.

## Pitfalls

- God-models with 40 relationships
- Circular imports across contexts (use late mapping / separate modules)
- Cascade delete surprises on production data
- Putting API schemas only (Pydantic) without a real persistence model when multi-module consistency matters

## Verification

- [ ] Each aggregate has a clear root
- [ ] Relationships documented with load strategy
- [ ] Migrations generate cleanly
- [ ] Invariant tests pass without a live server
