#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="$ROOT_DIR/.env"
EXAMPLE_FILE="$ROOT_DIR/.env.example"

if [ -f "$ENV_FILE" ]; then
  echo "Ya existe .env. No se sobrescribio nada."
  echo "Archivo: $ENV_FILE"
  exit 0
fi

cp "$EXAMPLE_FILE" "$ENV_FILE"

if command -v openssl >/dev/null 2>&1; then
  KEY="$(openssl rand -hex 24)"
  sed -i.bak "s/N8N_ENCRYPTION_KEY=.*/N8N_ENCRYPTION_KEY=$KEY/" "$ENV_FILE"
  rm -f "$ENV_FILE.bak"
fi

echo ".env creado correctamente."
echo "Siguiente paso:"
echo "docker compose up -d"
