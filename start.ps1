$ErrorActionPreference = "Stop"

function Write-Step {
  param([string]$Message)
  Write-Host ""
  Write-Host "==> $Message"
}

Set-Location $PSScriptRoot

Write-Step "Validando Docker"
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
  Write-Host "Falta instalar Docker Desktop."
  Write-Host "Instala Docker Desktop y vuelve a ejecutar: .\start.ps1"
  exit 1
}

try {
  docker info | Out-Null
} catch {
  Write-Host "Docker no esta corriendo."
  Write-Host "Abre Docker Desktop y vuelve a ejecutar: .\start.ps1"
  exit 1
}

Write-Step "Preparando archivo .env"
if (-not (Test-Path ".env")) {
  Copy-Item ".env.example" ".env"
  Write-Host ".env creado desde .env.example"
} else {
  Write-Host ".env ya existe. Se conserva la configuracion actual."
}

$envContent = Get-Content ".env"
if ($envContent -contains "POSTGRES_PORT=5432") {
  $envContent | ForEach-Object { $_ -replace "^POSTGRES_PORT=5432$", "POSTGRES_PORT=5433" } | Set-Content ".env"
  Write-Host "POSTGRES_PORT actualizado de 5432 a 5433 para evitar conflictos locales."
}

Write-Step "Validando docker-compose.yml"
docker compose config --quiet

Write-Step "Levantando n8n, PostgreSQL y Node.js"
docker compose up -d --build

Write-Step "Estado de servicios"
docker compose ps

Write-Host ""
Write-Host "Listo. Abre estas URLs:"
Write-Host ""
Write-Host "- n8n:              http://localhost:5678"
Write-Host "- Node.js API:      http://localhost:3000"
Write-Host "- Health check:     http://localhost:3000/health"
Write-Host ""
Write-Host "Comandos utiles:"
Write-Host ""
Write-Host "- Ver logs:         docker compose logs -f"
Write-Host "- Apagar:           docker compose down"
Write-Host "- Reiniciar n8n:    docker compose restart n8n"
Write-Host ""
Write-Host "Para usar ngrok:"
Write-Host ""
Write-Host "1. Edita .env y coloca NGROK_AUTHTOKEN."
Write-Host "2. Ejecuta: docker compose --profile tunnel up -d"
Write-Host "3. Mira la URL: docker compose logs -f ngrok"
