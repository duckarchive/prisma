-- DropIndex
DROP INDEX "documents_recognized_at_idx";

-- AlterTable
ALTER TABLE "pages" ALTER COLUMN "raw" SET DATA TYPE TEXT;
