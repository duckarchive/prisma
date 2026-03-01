/*
  Warnings:

  - You are about to drop the column `api_params` on the `case_online_copies` table. All the data in the column will be lost.
  - You are about to drop the column `api_url` on the `case_online_copies` table. All the data in the column will be lost.
  - You are about to drop the column `api_params` on the `description_online_copies` table. All the data in the column will be lost.
  - You are about to drop the column `api_url` on the `description_online_copies` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "case_online_copies" DROP COLUMN "api_params",
DROP COLUMN "api_url";

-- AlterTable
ALTER TABLE "description_online_copies" DROP COLUMN "api_params",
DROP COLUMN "api_url";
