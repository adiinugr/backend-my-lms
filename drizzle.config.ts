import 'dotenv/config';

import { defineConfig } from 'drizzle-kit';

export default defineConfig({
  schema: './src/drizzle/schema/**.schema.ts',
  out: './src/drizzle/migration',
  dialect: 'postgresql',
  dbCredentials: {
    url: process.env.DATABASE_URL,
  },
});
