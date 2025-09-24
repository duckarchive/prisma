-- AlterTable
ALTER TABLE "cases" ADD COLUMN     "author" TEXT,
ADD COLUMN     "author_administration" TEXT,
ADD COLUMN     "end_year" INTEGER,
ADD COLUMN     "full_code" TEXT NOT NULL DEFAULT '',
ADD COLUMN     "lat" DOUBLE PRECISION,
ADD COLUMN     "lng" DOUBLE PRECISION,
ADD COLUMN     "place" TEXT,
ADD COLUMN     "public_copy_urls" TEXT[],
ADD COLUMN     "radius_m" INTEGER,
ADD COLUMN     "start_year" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "tags" TEXT[];

-- AlterTable
ALTER TABLE "descriptions" ADD COLUMN     "end_year" INTEGER,
ADD COLUMN     "public_copy_urls" TEXT[],
ADD COLUMN     "start_year" INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "funds" ADD COLUMN     "end_year" INTEGER,
ADD COLUMN     "start_year" INTEGER NOT NULL DEFAULT 0;
