/*
  Warnings:

  - You are about to drop the column `created_at` on the `archives` table. All the data in the column will be lost.
  - You are about to drop the column `created_at` on the `cases` table. All the data in the column will be lost.
  - You are about to drop the column `created_at` on the `descriptions` table. All the data in the column will be lost.
  - You are about to drop the column `created_at` on the `family_search_places` table. All the data in the column will be lost.
  - You are about to drop the column `created_at` on the `funds` table. All the data in the column will be lost.
  - You are about to drop the column `created_at` on the `resources` table. All the data in the column will be lost.
  - You are about to drop the `fetches` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "fetches" DROP CONSTRAINT "fetches_archive_id_fkey";

-- DropForeignKey
ALTER TABLE "fetches" DROP CONSTRAINT "fetches_case_id_fkey";

-- DropForeignKey
ALTER TABLE "fetches" DROP CONSTRAINT "fetches_description_id_fkey";

-- DropForeignKey
ALTER TABLE "fetches" DROP CONSTRAINT "fetches_fund_id_fkey";

-- DropForeignKey
ALTER TABLE "fetches" DROP CONSTRAINT "fetches_resource_id_fkey";

-- AlterTable
ALTER TABLE "archives" DROP COLUMN "created_at";

-- AlterTable
ALTER TABLE "cases" DROP COLUMN "created_at";

-- AlterTable
ALTER TABLE "descriptions" DROP COLUMN "created_at";

-- AlterTable
ALTER TABLE "family_search_places" DROP COLUMN "created_at";

-- AlterTable
ALTER TABLE "funds" DROP COLUMN "created_at";

-- AlterTable
ALTER TABLE "resources" DROP COLUMN "created_at";

-- AlterTable
ALTER TABLE "sync_tasks" ADD COLUMN     "fond_id" UUID,
ADD COLUMN     "inventory_id" UUID;

-- DropTable
DROP TABLE "fetches";

-- CreateTable
CREATE TABLE "fonds" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "code" VARCHAR(20) NOT NULL,
    "updated_at" TIMESTAMP(6),
    "title" TEXT,
    "info" TEXT,
    "archive_id" UUID NOT NULL,

    CONSTRAINT "fonds_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "fond_years" (
    "fond_id" UUID NOT NULL,
    "start_year" INTEGER NOT NULL,
    "end_year" INTEGER NOT NULL,

    CONSTRAINT "fond_years_pkey" PRIMARY KEY ("fond_id","start_year","end_year")
);

-- CreateTable
CREATE TABLE "inventories" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "code" VARCHAR(20) NOT NULL,
    "updated_at" TIMESTAMP(6),
    "title" TEXT,
    "info" TEXT,
    "fond_id" UUID NOT NULL,

    CONSTRAINT "inventories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "inventory_years" (
    "inventory_id" UUID NOT NULL,
    "start_year" INTEGER NOT NULL,
    "end_year" INTEGER NOT NULL,

    CONSTRAINT "inventory_years_pkey" PRIMARY KEY ("inventory_id","start_year","end_year")
);

-- CreateTable
CREATE TABLE "inventory_online_copies" (
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "checked_availability_at" TIMESTAMP(6),
    "resource_id" UUID NOT NULL,
    "inventory_id" UUID NOT NULL,
    "url" TEXT NOT NULL,
    "availability" "Availability",

    CONSTRAINT "inventory_online_copies_pkey" PRIMARY KEY ("resource_id","inventory_id","url")
);

-- CreateTable
CREATE TABLE "files" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "code" VARCHAR(20) NOT NULL,
    "full_code" TEXT NOT NULL DEFAULT '',
    "updated_at" TIMESTAMP(6),
    "title" TEXT,
    "info" TEXT,
    "tags" TEXT[],
    "inventory_id" UUID NOT NULL,

    CONSTRAINT "files_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "file_years" (
    "file_id" UUID NOT NULL,
    "start_year" INTEGER NOT NULL,
    "end_year" INTEGER NOT NULL,

    CONSTRAINT "file_years_pkey" PRIMARY KEY ("file_id","start_year","end_year")
);

-- CreateTable
CREATE TABLE "file_locations" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "lat" DOUBLE PRECISION NOT NULL,
    "lng" DOUBLE PRECISION NOT NULL,
    "radius_m" INTEGER NOT NULL DEFAULT 0,
    "file_id" UUID NOT NULL,

    CONSTRAINT "file_locations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "file_online_copies" (
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "checked_availability_at" TIMESTAMP(6),
    "resource_id" UUID NOT NULL,
    "file_id" UUID NOT NULL,
    "url" TEXT NOT NULL,
    "availability" "Availability",

    CONSTRAINT "file_online_copies_pkey" PRIMARY KEY ("resource_id","file_id","url")
);

-- CreateTable
CREATE TABLE "file_authors" (
    "file_id" UUID NOT NULL,
    "author_id" UUID NOT NULL,

    CONSTRAINT "file_authors_pkey" PRIMARY KEY ("file_id","author_id")
);

-- CreateIndex
CREATE INDEX "fonds_code_idx" ON "fonds"("code");

-- CreateIndex
CREATE INDEX "fonds_archive_id_idx" ON "fonds"("archive_id");

-- CreateIndex
CREATE UNIQUE INDEX "fonds_code_archive_id_key" ON "fonds"("code", "archive_id");

-- CreateIndex
CREATE INDEX "fond_years_start_year_end_year_idx" ON "fond_years"("start_year", "end_year");

-- CreateIndex
CREATE INDEX "inventories_code_idx" ON "inventories"("code");

-- CreateIndex
CREATE INDEX "inventories_fond_id_idx" ON "inventories"("fond_id");

-- CreateIndex
CREATE UNIQUE INDEX "inventories_code_fond_id_key" ON "inventories"("code", "fond_id");

-- CreateIndex
CREATE INDEX "inventory_years_start_year_end_year_idx" ON "inventory_years"("start_year", "end_year");

-- CreateIndex
CREATE INDEX "files_code_idx" ON "files"("code");

-- CreateIndex
CREATE INDEX "files_inventory_id_idx" ON "files"("inventory_id");

-- CreateIndex
CREATE INDEX "files_full_code_idx" ON "files"("full_code");

-- CreateIndex
CREATE INDEX "file_full_code_gin_trgm_ops_idx" ON "files" USING GIN ("full_code" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "files_title_idx" ON "files" USING GIN ("title" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "files_info_idx" ON "files" USING GIN ("info" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "files_tags_idx" ON "files" USING GIN ("tags");

-- CreateIndex
CREATE UNIQUE INDEX "files_code_inventory_id_key" ON "files"("code", "inventory_id");

-- CreateIndex
CREATE INDEX "file_years_start_year_end_year_idx" ON "file_years"("start_year", "end_year");

-- CreateIndex
CREATE UNIQUE INDEX "file_locations_file_id_lat_lng_radius_m_key" ON "file_locations"("file_id", "lat", "lng", "radius_m");

-- CreateIndex
CREATE INDEX "file_online_copies_file_id_idx" ON "file_online_copies"("file_id");

-- CreateIndex
CREATE INDEX "file_authors_author_id_idx" ON "file_authors"("author_id");

-- AddForeignKey
ALTER TABLE "sync_tasks" ADD CONSTRAINT "sync_tasks_fond_id_fkey" FOREIGN KEY ("fond_id") REFERENCES "fonds"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sync_tasks" ADD CONSTRAINT "sync_tasks_inventory_id_fkey" FOREIGN KEY ("inventory_id") REFERENCES "inventories"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fonds" ADD CONSTRAINT "fonds_archive_id_fkey" FOREIGN KEY ("archive_id") REFERENCES "archives"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "fond_years" ADD CONSTRAINT "fond_years_fond_id_fkey" FOREIGN KEY ("fond_id") REFERENCES "fonds"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "inventories" ADD CONSTRAINT "inventories_fond_id_fkey" FOREIGN KEY ("fond_id") REFERENCES "fonds"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "inventory_years" ADD CONSTRAINT "inventory_years_inventory_id_fkey" FOREIGN KEY ("inventory_id") REFERENCES "inventories"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "inventory_online_copies" ADD CONSTRAINT "inventory_online_copies_resource_id_fkey" FOREIGN KEY ("resource_id") REFERENCES "resources"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "inventory_online_copies" ADD CONSTRAINT "inventory_online_copies_inventory_id_fkey" FOREIGN KEY ("inventory_id") REFERENCES "inventories"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "files" ADD CONSTRAINT "files_inventory_id_fkey" FOREIGN KEY ("inventory_id") REFERENCES "inventories"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "file_years" ADD CONSTRAINT "file_years_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "file_locations" ADD CONSTRAINT "file_locations_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "file_online_copies" ADD CONSTRAINT "file_online_copies_resource_id_fkey" FOREIGN KEY ("resource_id") REFERENCES "resources"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "file_online_copies" ADD CONSTRAINT "file_online_copies_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "file_authors" ADD CONSTRAINT "file_authors_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "file_authors" ADD CONSTRAINT "file_authors_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "authors"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
