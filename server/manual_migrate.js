import fs from 'fs';
import path from 'path';
import pg from 'pg';
import dotenv from 'dotenv';
import { fileURLToPath } from 'url';

dotenv.config();

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const pool = new pg.Pool({
  connectionString: process.env.DATABASE_URL
});

async function runMigrations() {
  const migrationsDir = path.join(__dirname, 'prisma', 'migrations');
  const dirs = fs.readdirSync(migrationsDir).filter(f => fs.statSync(path.join(migrationsDir, f)).isDirectory());
  
  // sort by name (which starts with timestamp or 0_)
  dirs.sort();

  for (const dir of dirs) {
    const sqlFile = path.join(migrationsDir, dir, 'migration.sql');
    if (fs.existsSync(sqlFile)) {
      console.log(`Running migration: ${dir}`);
      const sql = fs.readFileSync(sqlFile, 'utf8');
      try {
        await pool.query(sql);
        console.log(`Successfully applied ${dir}`);
      } catch (err) {
        console.error(`Error applying ${dir}:`, err);
        process.exit(1);
      }
    }
  }
  
  console.log('All migrations applied!');
  await pool.end();
}

runMigrations();
