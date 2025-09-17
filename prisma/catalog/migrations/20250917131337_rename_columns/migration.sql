/*
  -- Migration Warnings::
  --   - `church_administration` will be renamed to `author_administration`
  --   - `church_name` will be renamed to `author`
  --   - `tags` will be added to the `items` table

*/
-- AlterTable
ALTER TABLE "items" RENAME COLUMN "church_administration" TO "author_administration";
ALTER TABLE "items" RENAME COLUMN "church_name" TO "author";
ALTER TABLE "items" ADD COLUMN "tags" TEXT[];
