/*
  Warnings:

  - The primary key for the `file_online_copies` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `inventory_online_copies` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- AlterTable
ALTER TABLE "file_online_copies" DROP CONSTRAINT "file_online_copies_pkey",
ADD COLUMN     "full_code" TEXT NOT NULL DEFAULT '',
ALTER COLUMN "file_id" DROP NOT NULL,
ADD CONSTRAINT "file_online_copies_pkey" PRIMARY KEY ("resource_id", "full_code", "url");

-- AlterTable
ALTER TABLE "inventory_online_copies" DROP CONSTRAINT "inventory_online_copies_pkey",
ADD COLUMN     "full_code" TEXT NOT NULL DEFAULT '',
ALTER COLUMN "inventory_id" DROP NOT NULL,
ADD CONSTRAINT "inventory_online_copies_pkey" PRIMARY KEY ("resource_id", "full_code", "url");
