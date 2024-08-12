/*
  Warnings:

  - You are about to drop the column `last_count` on the `fetches` table. All the data in the column will be lost.
  - You are about to drop the column `last_count` on the `matches` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "fetches" DROP COLUMN "last_count";

-- AlterTable
ALTER TABLE "matches" DROP COLUMN "last_count";
