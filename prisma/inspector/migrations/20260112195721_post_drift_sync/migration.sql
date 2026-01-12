/*
  Warnings:

  - Made the column `api_params` on table `fetches` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "fetches" ALTER COLUMN "api_params" SET NOT NULL;
