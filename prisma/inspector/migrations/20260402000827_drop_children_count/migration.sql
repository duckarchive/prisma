/*
  Warnings:

  - You are about to drop the column `children_count` on the `archives` table. All the data in the column will be lost.
  - You are about to drop the column `children_count` on the `descriptions` table. All the data in the column will be lost.
  - You are about to drop the column `children_count` on the `funds` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "archives" DROP COLUMN "children_count";

-- AlterTable
ALTER TABLE "descriptions" DROP COLUMN "children_count";

-- AlterTable
ALTER TABLE "funds" DROP COLUMN "children_count";
