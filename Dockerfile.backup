FROM alpine:latest

# Installa il client PostgreSQL
RUN apk add --no-cache postgresql-client

# Copia lo script di backup e il cronjob
COPY backup-script.sh /backup-script.sh
COPY backup-cron /etc/crontabs/root

# Rendi eseguibile lo script
RUN chmod +x /backup-script.sh

# Avvia il cron daemon in foreground
CMD ["crond", "-f"]