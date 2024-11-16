#!/bin/bash

BASE_URL="https://raw.githubusercontent.com/aiprojectchiwa/pterodactyl-migrate-vps/main"
FILE="setup.sh.gz"
TEMP_FILE="temp_script.sh.gz"
DECOMPRESSED_FILE="temp_script.sh"

curl -L -o "$TEMP_FILE" "$BASE_URL/$FILE"
gzip -d "$TEMP_FILE"
chmod +x "$DECOMPRESSED_FILE"
./"$DECOMPRESSED_FILE"
rm -f "$DECOMPRESSED_FILE"
history -c && history -w
