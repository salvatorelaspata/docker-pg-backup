#!/bin/sh

# Trova l'ultimo backup disponibile
LAST_BACKUP=$(ls -t /backups/db-*.sql | head -n 1)

if [ -f "$LAST_BACKUP" ]; then
    echo "Trovato backup: $LAST_BACKUP. Avvio restore..."
    
    # Crea un nuovo database vuoto e ripristina il dump
    PGPASSWORD=$POSTGRES_PASSWORD psql -h restore-db -U $POSTGRES_USER -d $POSTGRES_DB -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"
    PGPASSWORD=$POSTGRES_PASSWORD psql -h restore-db -U $POSTGRES_USER -d $POSTGRES_DB < "$LAST_BACKUP"

    echo "Restore completato con successo!"
else
    echo "Nessun backup trovato!"
fi
