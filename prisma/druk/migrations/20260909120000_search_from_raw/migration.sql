-- Move the full-text index off "markdown" and onto "raw".
-- "raw" is now TEXT (see 20260909111703_update_raw_type) and holds the OCR text
-- as produced by the recognizer; "markdown" is a derived, post-processed view of
-- it and is no longer the source of truth for search.
--
-- A GENERATED column cannot be redefined in place, so the column is dropped and
-- re-added. This rewrites the whole "pages" table and re-tokenises every row —
-- expect it to take a while on a large table, and it holds an ACCESS EXCLUSIVE
-- lock for the duration. Dropping the column also drops "pages_search_idx", so
-- the GIN index is recreated below.

ALTER TABLE "pages" DROP COLUMN "search";

ALTER TABLE "pages"
  ADD COLUMN "search" tsvector
  GENERATED ALWAYS AS (to_tsvector('simple', druk_fold(coalesce("raw", '')))) STORED;

-- CreateIndex
CREATE INDEX "pages_search_idx" ON "pages" USING GIN ("search");
