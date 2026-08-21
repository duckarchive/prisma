-- Drop the legacy catalog structure (funds → descriptions → cases) WITH DATA.
-- v2 runs on fonds → inventories → files; nothing reads the legacy tables any
-- more, but they were still the most seq-scanned relations in prod
-- (case_online_copies: 3.3M rows, ~820k seq scans; cases: 3M rows, ~1.5M).
-- Backups exist; this is intentionally destructive.
--
-- sync_tasks: its fund_id/description_id columns (all NULL in prod) go away and
-- the unique key is re-scoped to the catalog tree (fond_id/inventory_id).

-- DropForeignKey
ALTER TABLE "funds" DROP CONSTRAINT "funds_archive_id_fkey";
ALTER TABLE "fund_years" DROP CONSTRAINT "fund_years_fund_id_fkey";
ALTER TABLE "descriptions" DROP CONSTRAINT "descriptions_fund_id_fkey";
ALTER TABLE "description_years" DROP CONSTRAINT "description_years_description_id_fkey";
ALTER TABLE "description_online_copies" DROP CONSTRAINT "description_online_copies_resource_id_fkey";
ALTER TABLE "description_online_copies" DROP CONSTRAINT "description_online_copies_description_id_fkey";
ALTER TABLE "cases" DROP CONSTRAINT "cases_description_id_fkey";
ALTER TABLE "case_years" DROP CONSTRAINT "case_years_case_id_fkey";
ALTER TABLE "case_locations" DROP CONSTRAINT "case_locations_case_id_fkey";
ALTER TABLE "case_online_copies" DROP CONSTRAINT "case_online_copies_resource_id_fkey";
ALTER TABLE "case_online_copies" DROP CONSTRAINT "case_online_copies_case_id_fkey";
ALTER TABLE "case_authors" DROP CONSTRAINT "case_authors_case_id_fkey";
ALTER TABLE "case_authors" DROP CONSTRAINT "case_authors_author_id_fkey";
ALTER TABLE "sync_tasks" DROP CONSTRAINT "sync_tasks_fund_id_fkey";
ALTER TABLE "sync_tasks" DROP CONSTRAINT "sync_tasks_description_id_fkey";

-- DropIndex
DROP INDEX "sync_tasks_resource_id_archive_id_fund_id_description_id_ap_key";

-- AlterTable
ALTER TABLE "sync_tasks" DROP COLUMN "description_id",
DROP COLUMN "fund_id";

-- DropTable
DROP TABLE "funds";
DROP TABLE "fund_years";
DROP TABLE "descriptions";
DROP TABLE "description_years";
DROP TABLE "description_online_copies";
DROP TABLE "cases";
DROP TABLE "case_years";
DROP TABLE "case_locations";
DROP TABLE "case_online_copies";
DROP TABLE "case_authors";

-- CreateIndex
CREATE UNIQUE INDEX "sync_tasks_resource_id_archive_id_fond_id_inventory_id_api__key" ON "sync_tasks"("resource_id", "archive_id", "fond_id", "inventory_id", "api_params");
