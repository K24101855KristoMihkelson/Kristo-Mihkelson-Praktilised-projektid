#!/bin/bash
# GitHubi repo
REPO_URL="https://github.com/K24101855KristoMihkelson/web.git"
# Ajutine kaust
TMP_DIR="/tmp/web_repo"
# Kliendid
CLIENTS=("pagar" "auto" "advokaat")

echo "Laen GitHubi veebilehe alla..."
# Kui repo on olemas, tee pull. Kui ei ole, tee clone.
if [ -d "$TMP_DIR/.git" ]; then
    cd "$TMP_DIR"
    git pull
else
    rm -rf "$TMP_DIR"
    git clone "$REPO_URL" "$TMP_DIR"
fi

echo "Kopeerin failid klientide kaustadesse..."
# Kopeeri sisu iga kliendi public_html kausta
for client in "${CLIENTS[@]}"; do
    TARGET="/srv/clients/$client/public_html"
    mkdir -p "$TARGET"
    cp -r "$TMP_DIR"/* "$TARGET"/
done
echo "Deploy valmis."
