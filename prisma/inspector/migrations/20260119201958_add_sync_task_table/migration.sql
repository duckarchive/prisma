-- CreateEnum
CREATE TYPE "TaskStatus" AS ENUM ('IDLE', 'QUEUED', 'PROCESSING', 'FAILED', 'COMPLETED');

-- CreateTable
CREATE TABLE "sync_tasks" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "resource_id" UUID NOT NULL,
    "archive_id" UUID,
    "fund_id" UUID,
    "description_id" UUID,
    "status" "TaskStatus" NOT NULL DEFAULT 'IDLE',
    "priority" INTEGER NOT NULL DEFAULT 0,
    "api_url" TEXT NOT NULL,
    "api_params" JSONB NOT NULL,
    "last_run_at" TIMESTAMP(6),
    "next_run_at" TIMESTAMP(6),
    "retry_count" INTEGER NOT NULL DEFAULT 0,
    "error_log" TEXT,

    CONSTRAINT "sync_tasks_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "sync_tasks_resource_id_archive_id_fund_id_description_id_ap_key" ON "sync_tasks"("resource_id", "archive_id", "fund_id", "description_id", "api_params");

-- AddForeignKey
ALTER TABLE "sync_tasks" ADD CONSTRAINT "sync_tasks_resource_id_fkey" FOREIGN KEY ("resource_id") REFERENCES "resources"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sync_tasks" ADD CONSTRAINT "sync_tasks_archive_id_fkey" FOREIGN KEY ("archive_id") REFERENCES "archives"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "sync_tasks" ADD CONSTRAINT "sync_tasks_fund_id_fkey" FOREIGN KEY ("fund_id") REFERENCES "funds"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "sync_tasks" ADD CONSTRAINT "sync_tasks_description_id_fkey" FOREIGN KEY ("description_id") REFERENCES "descriptions"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
