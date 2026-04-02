-- CreateIndex
CREATE INDEX "funds_archive_id_idx" ON "public"."funds"("archive_id" ASC);

-- CreateIndex
CREATE INDEX "descriptions_fund_id_idx" ON "public"."descriptions"("fund_id" ASC);

-- CreateIndex
CREATE INDEX "cases_description_id_idx" ON "public"."cases"("description_id" ASC);

-- CreateIndex
CREATE INDEX "cases_info_idx" ON "public"."cases" USING GIN ("info" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "cases_tags_idx" ON "public"."cases" USING GIN ("tags" array_ops);

-- CreateIndex
CREATE INDEX "cases_title_idx" ON "public"."cases" USING GIN ("title" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "case_online_copies_case_id_idx" ON "public"."case_online_copies"("case_id" ASC);

-- CreateIndex
CREATE INDEX "authors_title_idx" ON "public"."authors" USING GIN ("title" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "case_authors_author_id_idx" ON "public"."case_authors"("author_id" ASC);

