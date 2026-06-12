-- CreateIndex
CREATE INDEX "file_online_copies_parsed_idx" ON "file_online_copies"("parsed");

-- CreateIndex
CREATE INDEX "file_online_copy_parsed_gin_trgm_ops_idx" ON "file_online_copies" USING GIN ("parsed" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "inventory_online_copies_parsed_idx" ON "inventory_online_copies"("parsed");

-- CreateIndex
CREATE INDEX "inventory_online_copy_parsed_gin_trgm_ops_idx" ON "inventory_online_copies" USING GIN ("parsed" gin_trgm_ops);
