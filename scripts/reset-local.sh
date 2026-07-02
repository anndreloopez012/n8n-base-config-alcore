#!/usr/bin/env bash
set -euo pipefail

echo "Esto eliminara contenedores y volumenes locales de este proyecto."
echo "Usalo solo cuando quieras empezar desde cero."
read -r -p "Escribe RESET para continuar: " CONFIRMATION

if [ "$CONFIRMATION" != "RESET" ]; then
  echo "Cancelado."
  exit 0
fi

docker compose down -v
echo "Entorno reiniciado. Puedes levantarlo otra vez con: docker compose up -d"
