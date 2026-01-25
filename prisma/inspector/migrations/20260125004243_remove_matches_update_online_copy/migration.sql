/*
  Warnings:

  - The primary key for the `case_online_copies` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `description_online_copies` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the `matches` table. If the table is not empty, all the data it contains will be lost.
  - Made the column `url` on table `case_online_copies` required. This step will fail if there are existing NULL values in that column.
  - Made the column `url` on table `description_online_copies` required. This step will fail if there are existing NULL values in that column.

*/
-- CreateEnum
CREATE TYPE "Availability" AS ENUM ('PUBLIC', 'RESTRICTED');

-- DropForeignKey
ALTER TABLE "matches" DROP CONSTRAINT "matches_archive_id_fkey";

-- DropForeignKey
ALTER TABLE "matches" DROP CONSTRAINT "matches_case_id_fkey";

-- DropForeignKey
ALTER TABLE "matches" DROP CONSTRAINT "matches_description_id_fkey";

-- DropForeignKey
ALTER TABLE "matches" DROP CONSTRAINT "matches_fund_id_fkey";

-- DropForeignKey
ALTER TABLE "matches" DROP CONSTRAINT "matches_resource_id_fkey";

-- DropIndex
DROP INDEX "cases_description_id_idx";

-- AlterTable
ALTER TABLE "case_online_copies" DROP CONSTRAINT "case_online_copies_pkey",
ADD COLUMN     "availability" "Availability",
ALTER COLUMN "url" SET NOT NULL,
ADD CONSTRAINT "case_online_copies_pkey" PRIMARY KEY ("resource_id", "case_id", "url");

-- AlterTable
ALTER TABLE "description_online_copies" DROP CONSTRAINT "description_online_copies_pkey",
ADD COLUMN     "availability" "Availability",
ALTER COLUMN "url" SET NOT NULL,
ADD CONSTRAINT "description_online_copies_pkey" PRIMARY KEY ("resource_id", "description_id", "url");

-- DropTable
DROP TABLE "matches";

-- CreateIndex
CREATE INDEX "cases_full_code_idx" ON "cases"("full_code");

-- CreateIndex
CREATE INDEX "full_code_gin_trgm_ops_idx" ON "cases" USING GIN ("full_code" gin_trgm_ops);
