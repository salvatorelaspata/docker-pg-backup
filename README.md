# Docker pg backup

This is a simple docker container project to backup a postgres database.

## Usage

```bash
docker-compose up -d --buil
```

## Environment Variables

- `POSTGRES_URL`: The url of the postgres database to backup.

## Backup Location

The backups are stored in the `backups` directory.

## Cron Job

The cron job is defined in the [`backup-cron`](backup-cron) file.

## Backup Script

The backup script is defined in the [`backup-script.sh`](backup-script.sh) file.

[`Dockerfile.backup`](Dockerfile.backup) is the Dockerfile for the backup script.

## Restore Script

The restore script is defined in the [`restore-script.sh`](restore-script.sh) file.

[`Dockerfile.restore`](Dockerfile.restore) is the Dockerfile for the restore script.

## Docker Compose

The docker compose file is defined in the [`compose.yml`](compose.yml) file.

## Cron Job

Struttura di una riga Cron
Ogni riga di un file cron segue questa sintassi:


`MINUTO ORA GIORNO_DEL_MESE MESE GIORNO_DELLA_SETTIMANA COMANDO`

| Campo | Valori possibili | Descrizione |
|-------|------------------|-------------|
| MINUTO | 0-59 | Minuto dell'ora in cui eseguire il comando |
| ORA | 0-23 | Ora del giorno (formato 24h) |
| GIORNO_DEL_MESE | 1-31 | Giorno specifico del mese |
| MESE | 1-12 | Numero del mese (1 = gennaio, 12 = dicembre) |
| GIORNO_DELLA_SETTIMANA | 0-6 | Giorno della settimana (0 = domenica, 6 = sabato) |
| COMANDO | | Il comando da eseguire |

Note:

- Usa * per "qualsiasi valore".
- Usa , per più valori (es. 1,15 per il giorno del mese).
- Usa - per un intervallo (es. 1-5 per lunedì-venerdì).
- Usa / per step (es. */10 per ogni 10 minuti).

📜 Esempi pratici
| Cronjob | Descrizione |
|---------|-------------|
| 0 2 * * * /backup.sh | Esegue il backup ogni giorno alle 2:00 AM |
| */10 * * * * /script.sh | Esegue lo script ogni 10 minuti |
| 30 6 * * 1-5 /job.sh | Esegue alle 6:30 AM dal lunedì al venerdì |
| 0 0 1 * * /report.sh | Esegue a mezzanotte del primo giorno di ogni mese |
| 0 8-18 * * * /script.sh | Esegue ogni ora dalle 8:00 AM alle 6:00 PM |
| 0 2 * * 0 /backup.sh | Esegue la domenica alle 2:00 AM |

