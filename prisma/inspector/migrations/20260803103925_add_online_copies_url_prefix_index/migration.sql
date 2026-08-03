-- Btree index with text_pattern_ops so the editor's url-prefix search
-- (LIKE 'http…%') stays an index lookup under the ICU collation.
-- IF NOT EXISTS: prod already has this index (created manually with
-- CREATE INDEX CONCURRENTLY right after the online_copies merge).
CREATE INDEX IF NOT EXISTS "online_copies_url_prefix_idx" ON "online_copies"("url" text_pattern_ops);
