import "dotenv/config";
import { PrismaClient } from "@prisma/client";
import { PrismaPg } from "@prisma/adapter-pg";
import pg from "pg";

const connectionString = process.env.DATABASE_URL || process.env.DIRECT_URL;
const pool = new pg.Pool({
  connectionString,
  max: 10,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 10000,
});

pool.on("error", (err) => {
  console.warn("Notice: Idle database client disconnected:", err.message);
});

const adapter = new PrismaPg(pool);

export const prisma = new PrismaClient({ adapter });

