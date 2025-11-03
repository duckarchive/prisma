/*
  Warnings:

  - The primary key for the `case_online_copies` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `api_params_temp` on the `case_online_copies` table. All the data in the column will be lost.
  - Added the required column `api_params` to the `case_online_copies` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "case_online_copies" DROP CONSTRAINT "case_online_copies_pkey";
ALTER TABLE "case_online_copies" RENAME COLUMN "api_params_temp" TO "api_params";
ALTER TABLE "case_online_copies" ADD CONSTRAINT "case_online_copies_pkey" PRIMARY KEY ("resource_id", "case_id", "api_params");
