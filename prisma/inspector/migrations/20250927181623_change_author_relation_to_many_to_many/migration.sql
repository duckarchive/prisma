-- Rename the table
ALTER TABLE "case_authors" RENAME TO "authors";

-- (Optional) Rename the primary key constraint if you want a clean name
ALTER INDEX "case_authors_pkey" RENAME TO "authors_pkey";

-- (Optional) Rename foreign keys if they exist
ALTER TABLE "authors" RENAME CONSTRAINT "case_authors_case_id_fkey" TO "authors_case_id_fkey";
