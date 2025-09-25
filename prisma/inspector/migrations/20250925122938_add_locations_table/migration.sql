/*
  Warnings:

  - You are about to drop the column `lat` on the `cases` table. All the data in the column will be lost.
  - You are about to drop the column `lng` on the `cases` table. All the data in the column will be lost.
  - You are about to drop the column `radius_m` on the `cases` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "cases" DROP COLUMN "lat",
DROP COLUMN "lng",
DROP COLUMN "radius_m";

-- CreateTable
CREATE TABLE "locations" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "lat" DOUBLE PRECISION,
    "lng" DOUBLE PRECISION,
    "radius_m" INTEGER,
    "case_id" UUID NOT NULL,

    CONSTRAINT "locations_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "locations" ADD CONSTRAINT "locations_case_id_fkey" FOREIGN KEY ("case_id") REFERENCES "cases"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
