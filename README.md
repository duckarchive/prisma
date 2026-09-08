# Prisma schemas for duckarchive projects

Single place to store Prisma schemas for various duckarchive projects.

Each project has its own Postgres **database** on the shared server (`inspector`, `duckkey`,
`duckarchive`, `nest`, `druk`), its own schema under `prisma/<name>/`, its own migration
history, and its own pair of database roles (see [Database roles](#database-roles)).

# Usage (consumer app)

1. Install the package:
    ```bash
    npm install github:duckarchive/prisma
    ```

2. Update _package.json_ to include the following:
    ```diff
    {
      "scripts": {
    +    "prisma:generate": "prisma generate",
    +    "postinstall": "prisma generate"
      },
    +  "prisma": {
    +    "schema": "node_modules/@duckarchive/prisma/SCHEMA_NAME/schema.prisma"
    +  }
    }
    ```

3. Add the connection string to your `.env` file, using the project's **app role**
   (never the owner role and never `duck_dev`):
    ```env
    DATABASE_URL="postgresql://rubripes:...@db-host:5555/inspector?schema=public"
    ```

4. Run the following command to generate Prisma client:
    ```bash
    # run only once, later it will generate automatically during "npm install":
    npm run prisma:generate
    ```

# Development (this repo)

```bash
cp .env.example .env      # fill in the owner-role and duck_dev passwords
pnpm install
pnpm generate             # all clients, or pnpm generate:<name>
pnpm new:<name>           # prisma migrate dev: create + apply a migration locally
```

`new:<name>` uses `prisma migrate dev`, which needs the `shadow` database and a role that can
recreate it. That is what `duck_dev` is for; it is only ever used from this repo.

## Applying migrations to production / staging

Migrations are applied manually from this repo. `.env` holds the owner-role URLs, so:

```bash
pnpm deploy:druk          # prisma migrate deploy --config prisma-druk.config.ts
pnpm deploy               # all five
```

Migrations that add an untrusted extension (e.g. `postgis`) must be applied by a superuser;
`pg_trgm` is trusted and installs fine as the owner.

