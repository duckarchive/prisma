-- CreateExtension
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- CreateIndex
CREATE INDEX "matches_full_code_idx" ON "matches"("full_code");

-- CreateIndex
CREATE INDEX "full_code_gin_trgm_ops_idx" ON "matches" USING GIN ("full_code" gin_trgm_ops);
