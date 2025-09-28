/*
  Warnings:

  - A unique constraint covering the columns `[title,lat,lng]` on the table `authors` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[case_id,lat,lng,radius_m]` on the table `case_locations` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "authors_title_lat_lng_key" ON "authors"("title", "lat", "lng");

-- CreateIndex
CREATE UNIQUE INDEX "case_locations_case_id_lat_lng_radius_m_key" ON "case_locations"("case_id", "lat", "lng", "radius_m");
