import "dotenv/config";
import { defineConfig, env } from "prisma/config";

export default defineConfig({
  schema: "prisma/duckkey/schema.prisma",
  migrations: {
    path: "prisma/duckkey/migrations",
    seed: "tsup prisma/duckkey/seed.ts",
  },
  datasource: {
    url: env("DUCKKEY_DATABASE_URL"),
  },
});
