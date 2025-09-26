/*
  Warnings:

  - You are about to drop the `locations` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "locations" DROP CONSTRAINT "locations_case_id_fkey";

-- DropTable
DROP TABLE "locations";

-- CreateTable
CREATE TABLE "case_locations" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "lat" DOUBLE PRECISION NOT NULL,
    "lng" DOUBLE PRECISION NOT NULL,
    "radius_m" INTEGER NOT NULL DEFAULT 0,
    "case_id" UUID NOT NULL,

    CONSTRAINT "case_locations_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "case_locations" ADD CONSTRAINT "case_locations_case_id_fkey" FOREIGN KEY ("case_id") REFERENCES "cases"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
