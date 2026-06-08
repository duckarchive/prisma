/*
  Warnings:

  - The primary key for the `file_online_copies` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `inventory_online_copies` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - A unique constraint covering the columns `[resource_id,file_id,parsed,url]` on the table `file_online_copies` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[resource_id,inventory_id,parsed,url]` on the table `inventory_online_copies` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "file_online_copies" DROP CONSTRAINT "file_online_copies_pkey",
ADD COLUMN     "id" UUID NOT NULL DEFAULT gen_random_uuid(),
ADD CONSTRAINT "file_online_copies_pkey" PRIMARY KEY ("id");

ALTER TABLE "file_online_copies" RENAME COLUMN "full_code" TO "parsed";

-- AlterTable
ALTER TABLE "inventory_online_copies" DROP CONSTRAINT "inventory_online_copies_pkey",
ADD COLUMN     "id" UUID NOT NULL DEFAULT gen_random_uuid(),
ADD CONSTRAINT "inventory_online_copies_pkey" PRIMARY KEY ("id");

ALTER TABLE "inventory_online_copies" RENAME COLUMN "full_code" TO "parsed";

-- CreateIndex
CREATE UNIQUE INDEX "file_online_copies_resource_id_file_id_parsed_url_key" ON "file_online_copies"("resource_id", "file_id", "parsed", "url");

-- CreateIndex
CREATE UNIQUE INDEX "inventory_online_copies_resource_id_inventory_id_parsed_url_key" ON "inventory_online_copies"("resource_id", "inventory_id", "parsed", "url");
