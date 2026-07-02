# Contribuir al proyecto

Este repositorio es una base educativa. La prioridad es que sea facil de clonar, levantar y entender.

## Reglas generales

- Trabaja siempre en una rama propia.
- No subas archivos `.env`.
- No subas tokens, claves, passwords reales ni credenciales privadas.
- No borres documentacion base sin explicar el motivo.
- Mantén los ejemplos pensados para entorno local.
- Si agregas servicios nuevos, documenta como se levantan, como se prueban y como se apagan.

## Formato de ramas

Usa nombres claros:

```text
feat/agregar-servicio-redis
fix/corregir-webhook-url
docs/mejorar-guia-ngrok
chore/actualizar-compose
```

## Commits recomendados

Usa commits tipo Conventional Commits:

```text
feat: agregar servicio redis al compose
fix: corregir variable de conexion a postgres
docs: explicar configuracion de ngrok
chore: actualizar gitignore
refactor: simplificar estructura de node-app
test: agregar prueba de health check
```

## Tipos de commit

- `feat`: nueva funcionalidad.
- `fix`: correccion de error.
- `docs`: cambios en documentacion.
- `chore`: tareas de mantenimiento.
- `refactor`: mejora interna sin cambiar comportamiento.
- `test`: pruebas.
- `style`: formato, espacios, nombres o detalles visuales sin cambiar logica.

## Antes de abrir un PR

Ejecuta:

```bash
docker compose config
docker compose up -d
docker compose ps
curl http://localhost:3000/health
```

Si algo falla, revisa `docs/SOLUCION-DE-PROBLEMAS.md`.

