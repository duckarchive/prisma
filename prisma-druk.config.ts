import "dotenv/config";
import { defineConfig, env } from "prisma/config";

export default defineConfig({
  schema: "prisma/druk/schema.prisma",
  migrations: {
    path: "prisma/druk/migrations",
  },
  datasource: {
    url: env("DRUK_DATABASE_URL"),
    shadowDatabaseUrl: env("SHADOW_DATABASE_URL"),
  },
});
