# Database Safety Rule

CRITICAL DIRECTIVE FROM USER:
NEVER run any command, script, or migration that modifies, pushes to, alters, drops, resets, or affects the database.

Forbidden commands include but are not limited to:
- `npx prisma db push`
- `npx prisma db reset`
- `npx prisma migrate dev` / `npx prisma migrate deploy` / `npx prisma migrate reset`
- `npx prisma db seed`
- Running any script like `manual_migrate.js`, `seed*.js` or any node script that touches PostgreSQL/Supabase
- Executing direct SQL operations on the database

Agents must only show instructions or SQL scripts for the user to review and run manually. Under no circumstances should the agent trigger database alterations.
