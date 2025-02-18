# Carica le variabili d'ambiente
PG_URI="postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}"

fulldate = $(date +%Y%m%d%H%M%S)
filename = "${POSTGRES_DB}-${fulldate}.sql"

echo "Starting backup... ${filename}"

# Esegue il backup e lo salva nella cartella /backups
pg_dump "$PG_URI" > "/backups/${filename}"

# Verifica se il backup è stato creato
if [ -f "/backups/${filename}" ]; then
    echo "Backup creato con successo: /backups/${filename}"
else
    echo "Errore durante la creazione del backup"
fi

echo "Backup completato"
