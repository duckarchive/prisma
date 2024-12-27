-- AlterTable
ALTER TABLE "family_search_projects" ADD COLUMN     "prev_children_count" INTEGER,
ALTER COLUMN "archive_id" DROP NOT NULL;
