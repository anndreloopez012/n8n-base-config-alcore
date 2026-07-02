# Guia de n8n con ngrok

## Para que sirve ngrok

Cuando trabajas localmente, n8n vive en:

```text
http://localhost:5678
```

Eso funciona en tu computadora, pero servicios externos como GitHub, Stripe, WhatsApp, Discord o formularios externos no pueden llegar a tu `localhost`.

ngrok crea una URL publica temporal que apunta a tu n8n local.

## Cuando necesitas ngrok

Necesitas ngrok si vas a probar:

- Webhooks desde plataformas externas.
- Integraciones que exigen una URL publica.
- Automatizaciones que reciben eventos desde internet.

No necesitas ngrok para:

- Practicar workflows manuales.
- Consultar APIs desde n8n.
- Conectar n8n con la API Node.js local del proyecto.
- Guardar datos en PostgreSQL.

## Configurar ngrok

1. Crea una cuenta gratuita en:

```text
https://ngrok.com
```

2. Copia tu authtoken.

3. Crea `.env` si aun no existe:

```bash
cp .env.example .env
```

4. Edita:

```env
NGROK_AUTHTOKEN=CAMBIAR_POR_TU_TOKEN_GRATUITO_DE_NGROK
```

5. Levanta ngrok:

```bash
docker compose --profile tunnel up -d
```

6. Revisa la URL publica:

```bash
docker compose logs -f ngrok
```

Busca una URL parecida a:

```text
https://abc-123.ngrok-free.app
```

## Conectar la URL publica con n8n

Edita `.env`:

```env
WEBHOOK_URL=https://abc-123.ngrok-free.app/
N8N_EDITOR_BASE_URL=https://abc-123.ngrok-free.app/
```

Reinicia n8n:

```bash
docker compose restart n8n
```

## Probar webhook en n8n

1. En n8n crea un workflow.
2. Agrega un nodo **Webhook**.
3. Metodo: `POST`.
4. Path: `test-campus`.
5. Ejecuta el workflow en modo test.
6. Copia la URL de test.

Desde otra terminal:

```bash
curl -X POST https://abc-123.ngrok-free.app/webhook-test/test-campus \
  -H "Content-Type: application/json" \
  -d '{"mensaje":"hola desde ngrok"}'
```

La URL exacta puede cambiar segun si estas usando webhook de prueba o produccion.

## Errores comunes con ngrok

### El contenedor de ngrok se apaga

Probablemente no configuraste `NGROK_AUTHTOKEN`.

### n8n genera URL con localhost

Actualiza:

```env
WEBHOOK_URL=
N8N_EDITOR_BASE_URL=
```

y reinicia n8n.

### La URL de ngrok cambio

En cuentas gratuitas, la URL puede cambiar al reiniciar. Copia la nueva URL y actualiza `.env`.

