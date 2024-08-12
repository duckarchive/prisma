/*
  Warnings:

  - You are about to drop the column `updated_at` on the `fetch_results` table. All the data in the column will be lost.
  - You are about to drop the column `updated_at` on the `match_results` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[resource_id,archive_id,fund_id,description_id,case_id]` on the table `fetches` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[resource_id,archive_id,fund_id,description_id,case_id]` on the table `matches` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "fetches_resource_id_case_id_key";

-- DropIndex
DROP INDEX "matches_resource_id_case_id_key";

-- AlterTable
ALTER TABLE "fetch_results" DROP COLUMN "updated_at";

-- AlterTable
ALTER TABLE "match_results" DROP COLUMN "updated_at";

-- CreateIndex
CREATE UNIQUE INDEX "fetches_resource_id_archive_id_fund_id_description_id_case__key" ON "fetches"("resource_id", "archive_id", "fund_id", "description_id", "case_id");

-- CreateIndex
CREATE UNIQUE INDEX "matches_resource_id_archive_id_fund_id_description_id_case__key" ON "matches"("resource_id", "archive_id", "fund_id", "description_id", "case_id");
