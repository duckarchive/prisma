/*
  Warnings:

  - You are about to drop the column `public_copy_urls` on the `cases` table. All the data in the column will be lost.
  - You are about to drop the column `public_copy_urls` on the `descriptions` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "cases" DROP COLUMN "public_copy_urls";

-- AlterTable
ALTER TABLE "descriptions" DROP COLUMN "public_copy_urls";
