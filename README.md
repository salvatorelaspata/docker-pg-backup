# Docker pg backup

This is a simple docker container project to backup a postgres database.

## Usage

```bash
docker-compose up -d
```

## Environment Variables

- `POSTGRES_URL`: The url of the postgres database to backup.

## Backup Location

The backups are stored in the `backups` directory.

## Cron Job

The cron job is defined in the [backup-cron](backup-cron) file.

## Backup Script

The backup script is defined in the [backup-script.sh](backup-script.sh) file.

## Docker Compose

The docker compose file is defined in the [docker-compose.yml](docker-compose.yml) file.

## Dockerfile

The dockerfile is defined in the [Dockerfile](Dockerfile) file.