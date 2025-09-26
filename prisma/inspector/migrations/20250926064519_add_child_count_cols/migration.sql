-- AlterTable
ALTER TABLE "archives" ADD COLUMN     "children_count" INTEGER DEFAULT 0;

-- AlterTable
ALTER TABLE "descriptions" ADD COLUMN     "children_count" INTEGER DEFAULT 0;

-- AlterTable
ALTER TABLE "funds" ADD COLUMN     "children_count" INTEGER DEFAULT 0;
