/*
  Warnings:

  - You are about to drop the column `children_count` on the `family_search_projects` table. All the data in the column will be lost.
  - You are about to drop the column `created_at` on the `family_search_projects` table. All the data in the column will be lost.
  - You are about to drop the column `prev_children_count` on the `family_search_projects` table. All the data in the column will be lost.
  - You are about to drop the column `updated_at` on the `family_search_projects` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "family_search_projects" DROP COLUMN "children_count",
DROP COLUMN "created_at",
DROP COLUMN "prev_children_count",
DROP COLUMN "updated_at";

-- AddForeignKey
ALTER TABLE "family_search_items" ADD CONSTRAINT "family_search_items_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "family_search_projects"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
