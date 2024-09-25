import { handler } from './build/handler.js';
import express from 'express';

const app = express();

// Use the SvelteKit handler to serve the app
app.use(handler);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`SvelteKit app running at http://localhost:${PORT}`);
});
