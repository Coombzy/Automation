# Role matrix

| | Doc | Porsche |
|--|-----|---------|
| Role | specialist / heavy compute | PA / orchestrator |
| RAM | 64GB — qwen3.6:35b / gemma4:26b | 24GB — 7–14B local or cloud deep |
| Digest | Desktop/Fleet-Nextcloud/Memory/Dreams/Doc/ | Documents/Fleet-Memory/Dreams/Porsche/ |
| Memory focus | host, Ollama, implement loops, handoffs status | fleet todos, decisions, HANDOFF drafts |
| Must not | dual-PA, Ben day plan | bulk ORM, 35B on this host |
| Peer | Porsche | Doc |
| Backup root | Automation/backup/Doc/{daily,weekly,monthly} | Automation/backup/Porsche/{daily,weekly,monthly} |

## Snapshot cadence (both)
- **Daily** zip → daily/
- **Sunday** copy → weekly/
- **1st of month** copy → monthly/
