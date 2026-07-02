# Instalacion paso a paso

Esta guia esta pensada para estudiantes que quieren levantar el entorno local sin complicarse.

## 1. Instalar Docker Desktop

Docker permite ejecutar n8n, PostgreSQL y Node.js sin instalarlos manualmente en tu sistema.

Descarga Docker Desktop:

```text
https://www.docker.com/products/docker-desktop/
```

Instala Docker y abre la aplicacion.

Validacion:

```bash
docker --version
docker compose version
```

Si ambos comandos responden con una version, Docker esta listo.

## 2. Instalar Git

Descarga Git:

```text
https://git-scm.com/downloads
```

Validacion:

```bash
git --version
```

## 3. Clonar el repositorio

```bash
git clone https://github.com/anndreloopez012/n8n-base-config-alcore.git
cd n8n-base-config-alcore
```

## 4. Crear el archivo .env

Este paso es recomendado, aunque el proyecto puede iniciar sin `.env`.

macOS o Linux:

```bash
chmod +x scripts/setup-env.sh
./scripts/setup-env.sh
```

Windows PowerShell:

```powershell
copy .env.example .env
```

## 5. Levantar el entorno

```bash
docker compose up -d
```

Docker descargara imagenes la primera vez. Puede tardar varios minutos.

## 6. Revisar que todo este corriendo

```bash
docker compose ps
```

Debes ver:

- `alcore-postgres`
- `alcore-n8n`
- `alcore-node-app`

## 7. Abrir n8n

Abre:

```text
http://localhost:5678
```

Crea tu usuario local.

## 8. Probar Node.js

Abre:

```text
http://localhost:3000/health
```

Si ves `status: healthy`, Node.js pudo conectarse a PostgreSQL.

## 9. Crear un workflow basico en n8n

Prueba este flujo:

1. Crea un workflow nuevo.
2. Agrega un nodo **Manual Trigger**.
3. Agrega un nodo **HTTP Request**.
4. Metodo: `GET`.
5. URL:

```text
http://node-app:3000/api/ping
```

Importante: dentro de Docker, n8n debe llamar a Node.js como `node-app`, no como `localhost`.

Ejecuta el workflow. Debes recibir un mensaje `pong desde Node.js`.

## 10. Apagar el entorno

```bash
docker compose down
```

Esto apaga contenedores sin borrar datos.

## 11. Empezar desde cero

Solo si quieres borrar workflows, credenciales y base de datos local:

```bash
./scripts/reset-local.sh
```

