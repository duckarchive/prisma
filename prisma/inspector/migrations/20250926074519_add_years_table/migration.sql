/*
  Warnings:

  - You are about to drop the column `end_year` on the `cases` table. All the data in the column will be lost.
  - You are about to drop the column `start_year` on the `cases` table. All the data in the column will be lost.
  - You are about to drop the column `end_year` on the `descriptions` table. All the data in the column will be lost.
  - You are about to drop the column `start_year` on the `descriptions` table. All the data in the column will be lost.
  - You are about to drop the column `end_year` on the `funds` table. All the data in the column will be lost.
  - You are about to drop the column `start_year` on the `funds` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "cases" DROP COLUMN "end_year",
DROP COLUMN "start_year";

-- AlterTable
ALTER TABLE "descriptions" DROP COLUMN "end_year",
DROP COLUMN "start_year";

-- AlterTable
ALTER TABLE "funds" DROP COLUMN "end_year",
DROP COLUMN "start_year";

-- CreateTable
CREATE TABLE "fund_years" (
    "fund_id" UUID NOT NULL,
    "start_year" INTEGER NOT NULL,
    "end_year" INTEGER NOT NULL,

    CONSTRAINT "fund_years_pkey" PRIMARY KEY ("fund_id","start_year","end_year")
);

-- CreateTable
CREATE TABLE "description_years" (
    "description_id" UUID NOT NULL,
    "start_year" INTEGER NOT NULL,
    "end_year" INTEGER NOT NULL,

    CONSTRAINT "description_years_pkey" PRIMARY KEY ("description_id","start_year","end_year")
);

-- CreateTable
CREATE TABLE "case_years" (
    "case_id" UUID NOT NULL,
    "start_year" INTEGER NOT NULL,
    "end_year" INTEGER NOT NULL,

    CONSTRAINT "case_years_pkey" PRIMARY KEY ("case_id","start_year","end_year")
);

-- CreateIndex
CREATE INDEX "fund_years_start_year_end_year_idx" ON "fund_years"("start_year", "end_year");

-- CreateIndex
CREATE INDEX "description_years_start_year_end_year_idx" ON "description_years"("start_year", "end_year");

-- CreateIndex
CREATE INDEX "case_years_start_year_end_year_idx" ON "case_years"("start_year", "end_year");

-- AddForeignKey
ALTER TABLE "fund_years" ADD CONSTRAINT "fund_years_fund_id_fkey" FOREIGN KEY ("fund_id") REFERENCES "funds"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "description_years" ADD CONSTRAINT "description_years_description_id_fkey" FOREIGN KEY ("description_id") REFERENCES "descriptions"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "case_years" ADD CONSTRAINT "case_years_case_id_fkey" FOREIGN KEY ("case_id") REFERENCES "cases"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
