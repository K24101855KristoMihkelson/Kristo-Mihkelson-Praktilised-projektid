#!/bin/bash
BACKUP_DIR="/srv/backups"
CLIENTS=("pagar" "auto" "advokaat")
DATE=$(date +%Y-%m-%d)

mkdir -p "$BACKUP_DIR"

for client in "${CLIENTS[@]}"; do
    TARGET="/srv/clients/$client"
    BACKUP_FILE="$BACKUP_DIR/backup_${client}_${DATE}.tar.gz"
    echo "Teen varukoopia: $client"
    tar -czf "$BACKUP_FILE" "$TARGET"
done

# Kustuta varukoopiad, mis on vanemad kui 7 päeva
find "$BACKUP_DIR" -type f -mtime +7 -name "*.tar.gz" -delete
echo "Varundamine valmis."
