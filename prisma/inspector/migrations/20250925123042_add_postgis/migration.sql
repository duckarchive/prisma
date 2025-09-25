-- Enable PostGIS extension
CREATE EXTENSION IF NOT EXISTS postgis;

-- Create a geometry column for locations
CREATE INDEX locations_geom_idx
ON locations
USING GIST (ST_SetSRID(ST_MakePoint(lng, lat), 4326));