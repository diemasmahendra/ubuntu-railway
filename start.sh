#!/usr/bin/env bash
set -euo pipefail

: "${PORT:=8080}"
: "${USERNAME:?Set USERNAME in Railway Variables}"
: "${PASSWORD:?Set PASSWORD in Railway Variables}"

# Simpan sesi login Remote MCP di Railway Volume yang dipasang pada /data.
mkdir -p /data/desktop-commander-home

(
  export HOME=/data/desktop-commander-home
  while true; do
    desktop-commander remote || true
    echo "Desktop Commander berhenti; mencoba lagi dalam 5 detik..."
    sleep 5
  done
) &

# Terminal web tetap menjadi proses utama container.
exec /bin/ttyd -p "$PORT" -c "$USERNAME:$PASSWORD" /bin/bash
