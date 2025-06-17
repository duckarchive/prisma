-- CreateTable
CREATE TABLE "daily_stats" (
    "created_at" TIMESTAMP(4) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "archive_id" UUID NOT NULL,
    "family_search_count" INTEGER NOT NULL DEFAULT 0,
    "archium_count" INTEGER NOT NULL DEFAULT 0,
    "babyn_yar_count" INTEGER NOT NULL DEFAULT 0,
    "wikipedia_count" INTEGER NOT NULL DEFAULT 0,
    "website_count" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "daily_stats_pkey" PRIMARY KEY ("archive_id","created_at")
);

-- AddForeignKey
ALTER TABLE "daily_stats" ADD CONSTRAINT "daily_stats_archive_id_fkey" FOREIGN KEY ("archive_id") REFERENCES "archives"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
