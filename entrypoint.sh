#!/bin/sh
# ==============================
# DEEIX-Chat Choreo entrypoint
# ==============================

set -e

# Komari agent（可选）
KOMARI_SERVER="${KOMARI_SERVER:-}"
KOMARI_SECRET="${KOMARI_SECRET:-}"

# ==============================
# 1. 可写目录（Choreo 只读 FS → /tmp）
# ==============================
echo "[Init] Preparing /tmp paths..."
mkdir -p /tmp/deeix-data /tmp/deeix-storage /tmp/deeix-cache

# ==============================
# 2. 可选启动 komari-agent
# ==============================
if [ -n "$KOMARI_SERVER" ] && [ -n "$KOMARI_SECRET" ]; then
    echo "[Komari] Starting agent..."
    /app/komari-agent \
        -e "$KOMARI_SERVER" \
        -t "$KOMARI_SECRET" \
        --disable-auto-update >/dev/null 2>&1 &
else
    echo "[Komari] Not configured, skip."
fi

# ==============================
# 3. 启动主应用
# ==============================
echo "[DEEIX] Starting deeix-chat on port ${HTTP_PORT:-8080}..."
echo "[DEEIX] DATABASE_DRIVER=${DATABASE_DRIVER:-} STORAGE_BACKEND=${STORAGE_BACKEND:-} CACHE_DRIVER=${CACHE_DRIVER:-}"

if [ -z "$POSTGRES_DSN" ] && [ "${DATABASE_DRIVER:-postgres}" = "postgres" ]; then
    echo "[WARN] POSTGRES_DSN is empty. Set it in Choreo Secrets before production use."
fi

if [ "${STORAGE_BACKEND:-}" = "s3" ]; then
    if [ -z "${STORAGE_S3_BUCKET:-}" ] || [ -z "${STORAGE_S3_ACCESS_KEY_ID:-}" ] || [ -z "${STORAGE_S3_SECRET_ACCESS_KEY:-}" ]; then
        echo "[WARN] STORAGE_BACKEND=s3 but bucket/credentials incomplete."
    fi
fi

exec "$@"
