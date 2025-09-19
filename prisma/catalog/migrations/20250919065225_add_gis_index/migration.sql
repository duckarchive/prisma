CREATE INDEX items_geom_expr_idx
ON items
USING GIST (ST_SetSRID(ST_MakePoint(lng, lat), 4326));