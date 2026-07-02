import "dotenv/config";
import { defineConfig, env } from "prisma/config";

export default defineConfig({
  schema: "prisma/nest/schema.prisma",
  migrations: {
    path: "prisma/nest/migrations",
  },
  datasource: {
    url: env("NEST_DATABASE_URL"),
  },
});
