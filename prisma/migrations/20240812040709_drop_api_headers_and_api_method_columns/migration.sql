/*
  Warnings:

  - You are about to drop the column `api_headers` on the `fetches` table. All the data in the column will be lost.
  - You are about to drop the column `api_method` on the `fetches` table. All the data in the column will be lost.
  - You are about to drop the column `api_headers` on the `matches` table. All the data in the column will be lost.
  - You are about to drop the column `api_method` on the `matches` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "fetches" DROP COLUMN "api_headers",
DROP COLUMN "api_method";

-- AlterTable
ALTER TABLE "matches" DROP COLUMN "api_headers",
DROP COLUMN "api_method";
