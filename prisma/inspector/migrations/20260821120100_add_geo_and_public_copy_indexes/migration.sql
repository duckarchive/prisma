-- Indexes Prisma can't express (expression / partial on a non-unique column).
--
-- Geo-radius search (/api/search lat/lng/radius_m) filters with
--   ST_DWithin(ST_SetSRID(ST_MakePoint(lng, lat), 4326)::geography, target, r)
-- on file_locations and authors. Without an index on that exact expression
-- every radius search computes geography distance for every row. The index
-- expression must match the query text for the planner to use it.
--
-- Resource counters (data/resources.ts) count online_copies per resource where
-- availability = 'PUBLIC' on every catalog page; a partial index makes that an
-- index-only scan instead of a seq scan over ~2.7M rows.
--
-- IF NOT EXISTS so these can be pre-built on prod with CREATE INDEX CONCURRENTLY
-- (recommended — CONCURRENTLY can't run inside the migration transaction).
CREATE INDEX IF NOT EXISTS "file_locations_geog_idx"
  ON "file_locations" USING GIST ((ST_SetSRID(ST_MakePoint("lng", "lat"), 4326)::geography));

CREATE INDEX IF NOT EXISTS "authors_geog_idx"
  ON "authors" USING GIST ((ST_SetSRID(ST_MakePoint("lng", "lat"), 4326)::geography))
  WHERE "lat" IS NOT NULL AND "lng" IS NOT NULL;

CREATE INDEX IF NOT EXISTS "online_copies_public_by_resource_idx"
  ON "online_copies" ("resource_id")
  WHERE "availability" = 'PUBLIC';
