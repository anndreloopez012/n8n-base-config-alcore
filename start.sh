#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

print_step() {
  printf "\n==> %s\n" "$1"
}

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Falta instalar: $1"
    echo "Instala Docker Desktop y vuelve a ejecutar este script."
    exit 1
  fi
}

print_step "Validando Docker"
require_command docker

if ! docker info >/dev/null 2>&1; then
  echo "Docker no esta corriendo."
  echo "Abre Docker Desktop y vuelve a ejecutar: ./start.sh"
  exit 1
fi

print_step "Preparando archivo .env"
if [ ! -f .env ]; then
  ./scripts/setup-env.sh
else
  echo ".env ya existe. Se conserva la configuracion actual."
fi

if grep -q '^POSTGRES_PORT=5432$' .env; then
  sed -i.bak 's/^POSTGRES_PORT=5432$/POSTGRES_PORT=5433/' .env
  rm -f .env.bak
  echo "POSTGRES_PORT actualizado de 5432 a 5433 para evitar conflictos locales."
fi

print_step "Validando docker-compose.yml"
docker compose config --quiet

print_step "Levantando n8n, PostgreSQL y Node.js"
docker compose up -d --build

print_step "Estado de servicios"
docker compose ps

cat <<'INFO'

Listo. Abre estas URLs:

- n8n:              http://localhost:5678
- Node.js API:      http://localhost:3000
- Health check:     http://localhost:3000/health

Comandos utiles:

- Ver logs:         docker compose logs -f
- Apagar:           docker compose down
- Reiniciar n8n:    docker compose restart n8n

Para usar ngrok:

1. Edita .env y coloca NGROK_AUTHTOKEN.
2. Ejecuta: docker compose --profile tunnel up -d
3. Mira la URL: docker compose logs -f ngrok

INFO
