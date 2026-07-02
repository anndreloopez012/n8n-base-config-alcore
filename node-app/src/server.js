import express from 'express';
import pg from 'pg';

const app = express();
const port = Number(process.env.PORT || 3000);
const appName = process.env.APP_NAME || 'alcore-node-app';
const databaseUrl = process.env.DATABASE_URL;

app.use(express.json());

const pool = new pg.Pool({
  connectionString: databaseUrl,
});

app.get('/', (_req, res) => {
  res.json({
    app: appName,
    status: 'ok',
    message: 'API Node.js lista para conectarse con n8n.',
    endpoints: ['/health', '/api/ping', '/api/webhook-test'],
  });
});

app.get('/health', async (_req, res) => {
  try {
    const result = await pool.query('SELECT NOW() AS now');
    res.json({
      status: 'healthy',
      database: 'connected',
      time: result.rows[0].now,
    });
  } catch (error) {
    res.status(500).json({
      status: 'unhealthy',
      database: 'disconnected',
      error: error.message,
    });
  }
});

app.get('/api/ping', (_req, res) => {
  res.json({
    ok: true,
    message: 'pong desde Node.js',
    receivedAt: new Date().toISOString(),
  });
});

app.post('/api/webhook-test', async (req, res) => {
  const payload = req.body || {};

  const result = await pool.query(
    'INSERT INTO learning.webhook_events (source, payload) VALUES ($1, $2) RETURNING id, created_at',
    ['node-app', payload],
  );

  res.status(201).json({
    ok: true,
    message: 'Evento recibido y guardado en PostgreSQL.',
    event: result.rows[0],
    payload,
  });
});

app.listen(port, () => {
  console.log(`${appName} escuchando en http://localhost:${port}`);
});
