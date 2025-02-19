#!/bin/sh
set -e  # Interrompe l'esecuzione in caso di errore

# Trova l'ultimo backup disponibile
LAST_BACKUP=$(ls -t /backups/*.sql 2>/dev/null | head -n 1)

if [ -z "$LAST_BACKUP" ]; then
    echo "❌ Nessun backup trovato!"
    exit 1
fi

echo "✅ Trovato backup: $LAST_BACKUP. Avvio restore..."

# 🕒 Attendi che PostgreSQL sia pronto
until PGPASSWORD=$POSTGRES_PASSWORD psql -h postgres -U $POSTGRES_USER -d $POSTGRES_DB -c "SELECT 1;" >/dev/null 2>&1; do
    echo "⏳ In attesa che PostgreSQL sia pronto..."
    sleep 5
done

echo "🔄 Resettando schema public..."
PGPASSWORD=$POSTGRES_PASSWORD psql -h postgres -U $POSTGRES_USER -d $POSTGRES_DB -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"

echo "🔄 Ripristino del database..."
PGPASSWORD=$POSTGRES_PASSWORD psql -h postgres -U $POSTGRES_USER -d $POSTGRES_DB < "$LAST_BACKUP"

echo "✅ Restore completato con successo!"

# 🔍 Verifica il numero e il nome delle tabelle ripristinate
echo "🔍 Controllando le tabelle ripristinate..."
TABLES=$(PGPASSWORD=$POSTGRES_PASSWORD psql -h postgres -U $POSTGRES_USER -d $POSTGRES_DB -t -c "SELECT tablename FROM pg_tables WHERE schemaname='public';")

TABLE_COUNT=$(echo "$TABLES" | wc -l)

if [ "$TABLE_COUNT" -gt 0 ]; then
    echo "✅ Sono state ripristinate $TABLE_COUNT tabelle:"
    echo "$TABLES"
else
    echo "⚠️ Attenzione: Nessuna tabella trovata!"
    exit 1
fi

# 🗑️ Ripristino del database allo stato iniziale (vuoto)
echo "🗑️ Pulizia finale: resettando database..."
PGPASSWORD=$POSTGRES_PASSWORD psql -h postgres -U $POSTGRES_USER -d $POSTGRES_DB -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"

echo "✅ Il database è stato riportato allo stato iniziale (vuoto)."
