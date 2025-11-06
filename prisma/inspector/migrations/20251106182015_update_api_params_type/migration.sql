/*
  Warnings:

  - The primary key for the `description_online_copies` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - Changed the type of `api_params` on the `description_online_copies` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "description_online_copies" DROP CONSTRAINT "description_online_copies_pkey",
DROP COLUMN "api_params",
ADD COLUMN     "api_params" JSONB NOT NULL,
ADD CONSTRAINT "description_online_copies_pkey" PRIMARY KEY ("resource_id", "description_id", "api_params");
