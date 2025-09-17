/*
  Warnings:

  - You are about to drop the column `confession` on the `items` table. All the data in the column will be lost.
  - You are about to drop the column `record_type` on the `items` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "items" DROP COLUMN "confession",
DROP COLUMN "record_type";
