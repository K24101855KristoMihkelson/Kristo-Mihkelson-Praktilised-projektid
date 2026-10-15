#!/bin/bash
LOGFILE="/var/log/master_recovery.log"

echo "=== MASTER-TAASTE ALGAS: $(date) ===" | tee -a "$LOGFILE"

echo "[1/4] Taastan failid..."
bash ./full_restore.sh | tee -a "$LOGFILE"

echo "[2/4] Taastan kasutajad ja süsteemi..."
bash ./restore_users_and_system.sh | tee -a "$LOGFILE"

echo "[3/4] Kontrollin taastamist..."
bash ./verify_restore.sh | tee -a "$LOGFILE"

echo "=== MASTER-TAASTE LÕPPES: $(date) ===" | tee -a "$LOGFILE"
