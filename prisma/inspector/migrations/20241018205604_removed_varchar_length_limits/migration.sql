-- AlterTable
ALTER TABLE "descriptions" ALTER COLUMN "code" SET DATA TYPE VARCHAR(20);

-- AlterTable
ALTER TABLE "funds" ALTER COLUMN "code" SET DATA TYPE VARCHAR(20);

-- AlterTable
ALTER TABLE "matches" ALTER COLUMN "api_url" SET DATA TYPE TEXT,
ALTER COLUMN "url" SET DATA TYPE TEXT;
