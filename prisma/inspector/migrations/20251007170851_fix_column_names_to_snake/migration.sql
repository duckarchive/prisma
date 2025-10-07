/*
  Warnings:

  - You are about to drop the column `archivalReference` on the `family_search_items` table. All the data in the column will be lost.
  - You are about to drop the column `imageCount` on the `family_search_items` table. All the data in the column will be lost.
  - You are about to drop the column `indexedChildCount` on the `family_search_items` table. All the data in the column will be lost.
  - You are about to drop the column `projectId` on the `family_search_items` table. All the data in the column will be lost.
  - Added the required column `project_id` to the `family_search_items` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "family_search_items" DROP COLUMN "archivalReference",
DROP COLUMN "imageCount",
DROP COLUMN "indexedChildCount",
DROP COLUMN "projectId",
ADD COLUMN     "archival_reference" VARCHAR(255),
ADD COLUMN     "image_count" INTEGER,
ADD COLUMN     "indexed_child_count" INTEGER,
ADD COLUMN     "project_id" VARCHAR(50) NOT NULL;
