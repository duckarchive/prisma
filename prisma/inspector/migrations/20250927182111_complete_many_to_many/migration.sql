/*
  Warnings:

  - You are about to drop the column `case_id` on the `authors` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "authors" DROP CONSTRAINT "authors_case_id_fkey";

-- AlterTable
ALTER TABLE "authors" DROP COLUMN "case_id";

-- CreateTable
CREATE TABLE "case_authors" (
    "case_id" UUID NOT NULL,
    "author_id" UUID NOT NULL,

    CONSTRAINT "case_authors_pkey" PRIMARY KEY ("case_id","author_id")
);

-- AddForeignKey
ALTER TABLE "case_authors" ADD CONSTRAINT "case_authors_case_id_fkey" FOREIGN KEY ("case_id") REFERENCES "cases"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "case_authors" ADD CONSTRAINT "case_authors_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "authors"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
