/*
  Warnings:

  - Made the column `lat` on table `locations` required. This step will fail if there are existing NULL values in that column.
  - Made the column `lng` on table `locations` required. This step will fail if there are existing NULL values in that column.
  - Made the column `radius_m` on table `locations` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "locations" ALTER COLUMN "lat" SET NOT NULL,
ALTER COLUMN "lng" SET NOT NULL,
ALTER COLUMN "radius_m" SET NOT NULL,
ALTER COLUMN "radius_m" SET DEFAULT 0;
