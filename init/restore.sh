#!/bin/bash
set -e

echo "Restoring unified ML database..."

pg_restore \
  --username="$POSTGRES_USER" \
  --dbname="$POSTGRES_DB" \
  --no-owner \
  --no-privileges \
  --exit-on-error \
  /backups/unified_ml_database.backup

echo "Database restored successfully."