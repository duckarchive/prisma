-- Merge inventory_online_copies + file_online_copies into a single online_copies
-- table with two nullable parent FKs. Data-preserving: rows (incl. ids) are
-- copied over, then inventory_actions/file_actions FKs are retargeted and the
-- old tables dropped.

-- CreateTable
CREATE TABLE "online_copies" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "checked_availability_at" TIMESTAMP(6),
    "resource_id" UUID NOT NULL,
    "inventory_id" UUID,
    "file_id" UUID,
    "url" TEXT NOT NULL,
    "availability" "Availability",
    "parsed" TEXT NOT NULL DEFAULT '',

    CONSTRAINT "online_copies_pkey" PRIMARY KEY ("id"),
    -- a copy belongs to at most one parent (not expressible in Prisma schema)
    CONSTRAINT "online_copies_single_parent_check" CHECK ("inventory_id" IS NULL OR "file_id" IS NULL)
);

-- Copy data (ids preserved — actions rows point at them)
INSERT INTO "online_copies" ("id", "updated_at", "checked_availability_at", "resource_id", "inventory_id", "url", "availability", "parsed")
SELECT "id", "updated_at", "checked_availability_at", "resource_id", "inventory_id", "url", "availability", "parsed"
FROM "inventory_online_copies";

INSERT INTO "online_copies" ("id", "updated_at", "checked_availability_at", "resource_id", "file_id", "url", "availability", "parsed")
SELECT "id", "updated_at", "checked_availability_at", "resource_id", "file_id", "url", "availability", "parsed"
FROM "file_online_copies";

-- Sanity check: nothing lost
DO $$
DECLARE
    merged bigint;
    original bigint;
BEGIN
    SELECT count(*) INTO merged FROM "online_copies";
    SELECT (SELECT count(*) FROM "inventory_online_copies") + (SELECT count(*) FROM "file_online_copies") INTO original;
    IF merged <> original THEN
        RAISE EXCEPTION 'online_copies merge row count mismatch: % merged vs % original', merged, original;
    END IF;
END $$;

-- CreateIndex (after data load)
CREATE INDEX "online_copies_parsed_idx" ON "online_copies"("parsed");

-- CreateIndex
CREATE INDEX "online_copy_parsed_gin_trgm_ops_idx" ON "online_copies" USING GIN ("parsed" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "online_copies_inventory_id_idx" ON "online_copies"("inventory_id");

-- CreateIndex
CREATE INDEX "online_copies_file_id_idx" ON "online_copies"("file_id");

-- CreateIndex
CREATE UNIQUE INDEX "online_copies_resource_id_inventory_id_file_id_parsed_url_key" ON "online_copies"("resource_id", "inventory_id", "file_id", "parsed", "url");

-- AddForeignKey
ALTER TABLE "online_copies" ADD CONSTRAINT "online_copies_resource_id_fkey" FOREIGN KEY ("resource_id") REFERENCES "resources"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "online_copies" ADD CONSTRAINT "online_copies_inventory_id_fkey" FOREIGN KEY ("inventory_id") REFERENCES "inventories"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "online_copies" ADD CONSTRAINT "online_copies_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- Retarget actions FKs to the merged table
-- DropForeignKey
ALTER TABLE "inventory_actions" DROP CONSTRAINT "inventory_actions_online_copy_id_fkey";

-- DropForeignKey
ALTER TABLE "file_actions" DROP CONSTRAINT "file_actions_online_copy_id_fkey";

-- AddForeignKey
ALTER TABLE "inventory_actions" ADD CONSTRAINT "inventory_actions_online_copy_id_fkey" FOREIGN KEY ("online_copy_id") REFERENCES "online_copies"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "file_actions" ADD CONSTRAINT "file_actions_online_copy_id_fkey" FOREIGN KEY ("online_copy_id") REFERENCES "online_copies"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- DropTable (own FK constraints to resources/inventories/files drop with them)
DROP TABLE "inventory_online_copies";

-- DropTable
DROP TABLE "file_online_copies";
