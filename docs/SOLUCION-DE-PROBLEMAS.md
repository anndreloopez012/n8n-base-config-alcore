# Solucion de problemas

## Docker no reconoce el comando

Error comun:

```text
docker: command not found
```

Solucion:

1. Instala Docker Desktop.
2. Abre Docker Desktop.
3. Cierra y abre la terminal.
4. Ejecuta:

```bash
docker --version
```

## El puerto 5678 esta ocupado

Error comun:

```text
port is already allocated
```

Solucion rapida:

1. Edita `.env`.
2. Cambia:

```env
N8N_PORT=5679
```

3. Levanta otra vez:

```bash
docker compose up -d
```

4. Abre:

```text
http://localhost:5679
```

## PostgreSQL local y puertos

Por defecto este proyecto publica PostgreSQL en `localhost:5433` para evitar conflictos con instalaciones locales que ya usan `5432`.

Dentro de Docker, n8n y Node.js siguen usando `postgres:5432`. No cambies ese valor dentro de los servicios.

Si tambien tienes ocupado el puerto `5433`, cambia el puerto externo:

Solucion:

```env
POSTGRES_PORT=5434
```

Luego:

```bash
docker compose up -d
```

Desde otros contenedores, n8n seguira usando `postgres:5432`. El cambio solo afecta el acceso desde tu computadora.

## n8n no conecta a PostgreSQL

Revisa estado:

```bash
docker compose ps
```

Revisa logs:

```bash
docker compose logs -f postgres
docker compose logs -f n8n
```

Si cambiaste usuario, password o base de datos despues de crear el volumen, PostgreSQL puede conservar la configuracion anterior.

Para empezar desde cero:

```bash
./scripts/reset-local.sh
docker compose up -d
```

## Node.js dice database disconnected

Revisa:

```bash
docker compose logs -f node-app
```

Valida que PostgreSQL este saludable:

```bash
docker compose ps postgres
```

Luego prueba:

```bash
curl http://localhost:3000/health
```

## Cambie N8N_ENCRYPTION_KEY y perdi credenciales

`N8N_ENCRYPTION_KEY` se usa para cifrar credenciales internas de n8n.

Regla:

- Si ya guardaste credenciales reales, no cambies esa variable.
- Si estas en practica y no importa borrar datos, puedes reiniciar volumenes.

## Quiero ver todo lo que pasa

```bash
docker compose logs -f
```

Para ver solo n8n:

```bash
docker compose logs -f n8n
```

Para ver solo Node:

```bash
docker compose logs -f node-app
```

Para ver solo PostgreSQL:

```bash
docker compose logs -f postgres
```

## Quiero borrar todo y empezar otra vez

```bash
./scripts/reset-local.sh
docker compose up -d
```

Esto borra:

- Workflows locales de n8n.
- Credenciales locales de n8n.
- Datos de PostgreSQL.

Usalo con cuidado.
