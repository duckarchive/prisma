-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "ActionType" ADD VALUE 'add';
ALTER TYPE "ActionType" ADD VALUE 'remove';
ALTER TYPE "ActionType" ADD VALUE 'change_parent';
ALTER TYPE "ActionType" ADD VALUE 'change_title';
ALTER TYPE "ActionType" ADD VALUE 'change_code';
ALTER TYPE "ActionType" ADD VALUE 'change_info';
ALTER TYPE "ActionType" ADD VALUE 'add_year_range';
ALTER TYPE "ActionType" ADD VALUE 'remove_year_range';
ALTER TYPE "ActionType" ADD VALUE 'connect_to_author';
ALTER TYPE "ActionType" ADD VALUE 'disconnect_from_author';
ALTER TYPE "ActionType" ADD VALUE 'add_author';
ALTER TYPE "ActionType" ADD VALUE 'remove_author';
ALTER TYPE "ActionType" ADD VALUE 'add_location';
ALTER TYPE "ActionType" ADD VALUE 'remove_location';

-- CreateTable
CREATE TABLE "fond_actions" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" VARCHAR(255) NOT NULL,
    "resolved_at" TIMESTAMP(6),
    "resolved_by" VARCHAR(255),
    "type" "ActionType" NOT NULL,
    "note" TEXT,
    "is_rejected" BOOLEAN,
    "fond_id" UUID,

    CONSTRAINT "fond_actions_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "fond_actions_fond_id_idx" ON "fond_actions"("fond_id");

-- CreateIndex
CREATE UNIQUE INDEX "fond_actions_type_fond_id_key" ON "fond_actions"("type", "fond_id") WHERE (resolved_at IS NULL);

-- AddForeignKey
ALTER TABLE "fond_actions" ADD CONSTRAINT "fond_actions_fond_id_fkey" FOREIGN KEY ("fond_id") REFERENCES "fonds"("id") ON DELETE CASCADE ON UPDATE NO ACTION;
