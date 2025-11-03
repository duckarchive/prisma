/*
  Warnings:

  - The primary key for the `case_online_copies` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `api_params` on the `case_online_copies` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "case_online_copies" DROP CONSTRAINT "case_online_copies_pkey",
DROP COLUMN "api_params",
ADD CONSTRAINT "case_online_copies_pkey" PRIMARY KEY ("resource_id", "case_id", "api_params_temp");
