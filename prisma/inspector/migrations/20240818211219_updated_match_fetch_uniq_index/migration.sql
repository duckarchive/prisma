/*
  Warnings:

  - A unique constraint covering the columns `[resource_id,archive_id,fund_id,description_id,case_id,api_params]` on the table `fetches` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[resource_id,archive_id,fund_id,description_id,case_id,api_params]` on the table `matches` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "fetches_resource_id_archive_id_fund_id_description_id_case__key";

-- DropIndex
DROP INDEX "matches_resource_id_archive_id_fund_id_description_id_case__key";

-- CreateIndex
CREATE UNIQUE INDEX "fetches_resource_id_archive_id_fund_id_description_id_case__key" ON "fetches"("resource_id", "archive_id", "fund_id", "description_id", "case_id", "api_params");

-- CreateIndex
CREATE UNIQUE INDEX "matches_resource_id_archive_id_fund_id_description_id_case__key" ON "matches"("resource_id", "archive_id", "fund_id", "description_id", "case_id", "api_params");
