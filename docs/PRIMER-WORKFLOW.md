# Primer workflow recomendado

Este ejercicio confirma que n8n puede comunicarse con la API Node.js del proyecto.

## Objetivo

Crear un workflow manual que llame a:

```text
http://node-app:3000/api/ping
```

## Paso a paso

1. Abre n8n:

```text
http://localhost:5678
```

2. Crea un workflow nuevo.

3. Agrega el nodo **Manual Trigger**.

4. Agrega el nodo **HTTP Request**.

5. Configura:

```text
Method: GET
URL: http://node-app:3000/api/ping
```

6. Ejecuta el workflow.

## Resultado esperado

Debes ver una respuesta parecida a:

```json
{
  "ok": true,
  "message": "pong desde Node.js",
  "receivedAt": "2026-07-02T00:00:00.000Z"
}
```

## Por que se usa node-app y no localhost

Dentro de Docker, cada servicio tiene su propio espacio de red.

Para n8n:

- `localhost` significa el contenedor de n8n.
- `node-app` significa el contenedor de Node.js.
- `postgres` significa el contenedor de PostgreSQL.

Por eso la URL correcta dentro de n8n es:

```text
http://node-app:3000
```

