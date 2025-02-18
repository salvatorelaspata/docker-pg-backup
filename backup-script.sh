# Carica le variabili d'ambiente
PG_URI="postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}"

# Esegue il backup e lo salva nella cartella /backups
pg_dump "$PG_URI" > "/backups/db-$(date +%Y%m%d).sql"