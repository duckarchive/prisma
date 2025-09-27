/*
  Warnings:

  - You are about to drop the column `author` on the `cases` table. All the data in the column will be lost.
  - You are about to drop the column `author_administration` on the `cases` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "cases" DROP COLUMN "author",
DROP COLUMN "author_administration";

-- CreateTable
CREATE TABLE "case_authors" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "title" TEXT NOT NULL,
    "info" TEXT,
    "lat" DOUBLE PRECISION,
    "lng" DOUBLE PRECISION,
    "tags" TEXT[],
    "case_id" UUID NOT NULL,

    CONSTRAINT "case_authors_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "case_authors" ADD CONSTRAINT "case_authors_case_id_fkey" FOREIGN KEY ("case_id") REFERENCES "cases"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
