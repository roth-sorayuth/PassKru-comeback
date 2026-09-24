# Project Safety Rules

## Strict Database Prohibition
Never execute any command, script, or tool that touches, modifies, resets, migrates, pushes to, or seeds the database.
- Prohibited: `prisma db push`, `prisma db reset`, `prisma migrate *`, `prisma db seed`, `node manual_migrate.js`, `node seed*.js`, or executing SQL mutations.
- If database changes are needed, provide clear instructions/SQL files for the user to review and run manually. Never run them automatically.
