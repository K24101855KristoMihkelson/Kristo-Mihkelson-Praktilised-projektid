#!/bin/bash
CLIENTS=("pagar" "auto" "advokaat")

for client in "${CLIENTS[@]}"; do
    BASE="/srv/clients/$client"
    LOGFILE="$BASE/admin_logs/system_audit.log"
    echo "Kontrollin $client kausta..." >> "$LOGFILE"
    
    # Leia failid, millel on 777 õigused
    find "$BASE" -type f -perm 777 | while read file; do
        chmod 750 "$file"
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Parandasin 777 õigused failil: $file" >> "$LOGFILE"
    done
done
