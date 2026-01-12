DROP INDEX "fetches_resource_id_archive_id_fund_id_description_id_case__key";

CREATE UNIQUE INDEX "fetches_resource_id_archive_id_fund_id_description_id_case__key" ON "fetches"(
  "resource_id",
  "archive_id",
  "fund_id",
  "description_id",
  "case_id",
  "api_params"
);

ALTER TABLE
  "fetches"
ALTER COLUMN
  "api_params" TYPE JSONB USING "api_params" :: JSONB;