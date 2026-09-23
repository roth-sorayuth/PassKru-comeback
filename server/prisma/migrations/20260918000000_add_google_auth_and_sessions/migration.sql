-- Migration: Add Google Auth and Sessions table
-- 1. Add google_id column to users (VARCHAR, UNIQUE, nullable)
ALTER TABLE "users" ADD COLUMN IF NOT EXISTS "google_id" VARCHAR(255);

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'users_google_id_key'
    ) AND NOT EXISTS (
        SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace
        WHERE c.relname = 'users_google_id_key'
    ) THEN
        ALTER TABLE "users" ADD CONSTRAINT "users_google_id_key" UNIQUE ("google_id");
    END IF;
END $$;

-- 2. Make password_hash nullable if it isn't already
ALTER TABLE "users" ALTER COLUMN "password_hash" DROP NOT NULL;

-- 3. Make clerk_id nullable if it isn't already
ALTER TABLE "users" ALTER COLUMN "clerk_id" DROP NOT NULL;

-- 4. Create new sessions table
CREATE TABLE IF NOT EXISTS "sessions" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "user_id" INT4 NOT NULL,
    "expires_at" TIMESTAMP(6) NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "sessions_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "sessions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE
);

-- Index for fast session lookup by user_id
CREATE INDEX IF NOT EXISTS "sessions_user_id_idx" ON "sessions"("user_id");
