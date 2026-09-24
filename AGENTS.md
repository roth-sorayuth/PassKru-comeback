# Project Agent Rules & Safety Guidelines

## 🚨 STRICT DATABASE POLICY (CRITICAL)

**NEVER execute any command, script, or tool that affects, mutates, migrates, pushes to, resets, or seeds the database.**

### 🚫 Strictly Prohibited Actions for Agents:
1. **Never run Prisma database commands:**
   - `npx prisma db push`
   - `npx prisma db reset`
   - `npx prisma migrate ...` (dev, deploy, resolve, reset)
   - `npx prisma db seed`
2. **Never execute seed scripts or manual migration scripts:**
   - E.g., `node seed.js`, `node manual_migrate.js`, `node seed_exams.js`, or any custom script that writes/modifies database tables or rows.
3. **Never run raw SQL queries or DDL/DML commands** (e.g. `DROP`, `TRUNCATE`, `ALTER`, `UPDATE`, `DELETE`, `INSERT`) against the connected database.
4. **Never run any command that prompts or could lead to data loss** (`--accept-data-loss`, `--force-reset`, etc.).

### ✅ Required Procedure for Any Database Changes:
- If a schema or database change is required, the agent must **ONLY** provide the proposed code/SQL/schema changes as text instructions or SQL files for the **USER to inspect and run manually**.
- The agent must **NEVER** run database-affecting commands autonomously.
