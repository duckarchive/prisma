-- Extensions (pg_trgm is for the future vocabulary/fuzzy table, cheap to enable now)
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- druk_fold(): folds historical Cyrillic orthography so that pre-1918 Russian,
-- Church Slavonic quotes and Ukrainian in older spellings all search the same way.
--   ѣ→е, і/ї/ѵ→и, ѳ→ф, ё→е, ґ→г, ѡ→о, word-final ъ dropped.
-- IMMUTABLE so it can back a generated column. Apply the same function to user
-- queries: to_tsquery('simple', druk_fold($1)).
CREATE OR REPLACE FUNCTION druk_fold(input TEXT) RETURNS TEXT
LANGUAGE sql IMMUTABLE STRICT PARALLEL SAFE AS $$
  SELECT regexp_replace(
    translate(lower(input), 'ѣіїѵѳёґѡ', 'еииифего'),
    'ъ\M', '', 'g'
  );
$$;

-- CreateTable
CREATE TABLE "documents" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "inspector_url" TEXT,
    "online_copy_url" TEXT,
    "updated_at" TIMESTAMP(6),
    "recognized_at" TIMESTAMP(6),

    CONSTRAINT "documents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
-- "search" is maintained by Postgres from "markdown"; the app never writes it.
CREATE TABLE "pages" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "document_id" UUID NOT NULL,
    "page_idx" INTEGER NOT NULL,
    "markdown" TEXT,
    "raw" JSONB,
    "search" tsvector GENERATED ALWAYS AS (to_tsvector('simple', druk_fold(coalesce("markdown", '')))) STORED,

    CONSTRAINT "pages_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "documents_inspector_url_key" ON "documents"("inspector_url");

-- CreateIndex
CREATE UNIQUE INDEX "documents_online_copy_url_key" ON "documents"("online_copy_url");

-- CreateIndex
CREATE INDEX "documents_recognized_at_idx" ON "documents"("recognized_at");

-- CreateIndex
CREATE INDEX "pages_search_idx" ON "pages" USING GIN ("search");

-- CreateIndex
CREATE UNIQUE INDEX "pages_document_id_page_idx_key" ON "pages"("document_id", "page_idx");

-- AddForeignKey
ALTER TABLE "pages" ADD CONSTRAINT "pages_document_id_fkey" FOREIGN KEY ("document_id") REFERENCES "documents"("id") ON DELETE CASCADE ON UPDATE CASCADE;
