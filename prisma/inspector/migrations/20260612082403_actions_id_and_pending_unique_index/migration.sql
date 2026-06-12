-- CreateEnum
CREATE TYPE "ActionType" AS ENUM ('report', 'connect_to_online_copy', 'disconnect_from_online_copy', 'add_online_copy', 'remove_online_copy');

-- CreateTable
CREATE TABLE "inventory_actions" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" VARCHAR(255) NOT NULL,
    "resolved_at" TIMESTAMP(6),
    "resolved_by" VARCHAR(255),
    "type" "ActionType" NOT NULL,
    "note" TEXT,
    "is_rejected" BOOLEAN,
    "online_copy_id" UUID,
    "inventory_id" UUID,

    CONSTRAINT "inventory_actions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "file_actions" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" VARCHAR(255) NOT NULL,
    "resolved_at" TIMESTAMP(6),
    "resolved_by" VARCHAR(255),
    "type" "ActionType" NOT NULL,
    "note" TEXT,
    "is_rejected" BOOLEAN,
    "online_copy_id" UUID,
    "file_id" UUID,

    CONSTRAINT "file_actions_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "inventory_actions_inventory_id_idx" ON "inventory_actions"("inventory_id");

-- CreateIndex
CREATE INDEX "inventory_actions_online_copy_id_idx" ON "inventory_actions"("online_copy_id");

-- CreateIndex
CREATE UNIQUE INDEX "inventory_actions_type_online_copy_id_inventory_id_key" ON "inventory_actions"("type", "online_copy_id", "inventory_id") WHERE (resolved_at IS NULL);

-- CreateIndex
CREATE UNIQUE INDEX "inventory_actions_type_inventory_id_key" ON "inventory_actions"("type", "inventory_id") WHERE (resolved_at IS NULL AND online_copy_id IS NULL);

-- CreateIndex
CREATE UNIQUE INDEX "inventory_actions_type_online_copy_id_key" ON "inventory_actions"("type", "online_copy_id") WHERE (resolved_at IS NULL AND inventory_id IS NULL);

-- CreateIndex
CREATE INDEX "file_actions_file_id_idx" ON "file_actions"("file_id");

-- CreateIndex
CREATE INDEX "file_actions_online_copy_id_idx" ON "file_actions"("online_copy_id");

-- CreateIndex
CREATE UNIQUE INDEX "file_actions_type_online_copy_id_file_id_key" ON "file_actions"("type", "online_copy_id", "file_id") WHERE (resolved_at IS NULL);

-- CreateIndex
CREATE UNIQUE INDEX "file_actions_type_file_id_key" ON "file_actions"("type", "file_id") WHERE (resolved_at IS NULL AND online_copy_id IS NULL);

-- CreateIndex
CREATE UNIQUE INDEX "file_actions_type_online_copy_id_key" ON "file_actions"("type", "online_copy_id") WHERE (resolved_at IS NULL AND file_id IS NULL);

-- AddForeignKey
ALTER TABLE "inventory_actions" ADD CONSTRAINT "inventory_actions_online_copy_id_fkey" FOREIGN KEY ("online_copy_id") REFERENCES "inventory_online_copies"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "inventory_actions" ADD CONSTRAINT "inventory_actions_inventory_id_fkey" FOREIGN KEY ("inventory_id") REFERENCES "inventories"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "file_actions" ADD CONSTRAINT "file_actions_online_copy_id_fkey" FOREIGN KEY ("online_copy_id") REFERENCES "file_online_copies"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "file_actions" ADD CONSTRAINT "file_actions_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files"("id") ON DELETE CASCADE ON UPDATE NO ACTION;
