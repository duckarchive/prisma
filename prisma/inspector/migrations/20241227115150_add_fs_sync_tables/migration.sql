-- CreateTable
CREATE TABLE "family_search_places" (
    "id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6),
    "title" VARCHAR(255),
    "total_count" INTEGER,

    CONSTRAINT "family_search_places_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "family_search_projects" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6),
    "archive_id" UUID NOT NULL,
    "children_count" INTEGER,

    CONSTRAINT "family_search_projects_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "family_search_projects" ADD CONSTRAINT "family_search_projects_archive_id_fkey" FOREIGN KEY ("archive_id") REFERENCES "archives"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
