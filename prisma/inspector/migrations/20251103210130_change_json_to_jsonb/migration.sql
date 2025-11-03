/*
  Warnings:

  - Made the column `api_params_temp` on table `case_online_copies` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "case_online_copies" ALTER COLUMN "api_params_temp" SET NOT NULL,
ALTER COLUMN "api_params_temp" SET DATA TYPE JSONB;
