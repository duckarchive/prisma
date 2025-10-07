-- CreateTable
CREATE TABLE "family_search_items" (
    "id" VARCHAR(50) NOT NULL,
    "dgs" VARCHAR(12) NOT NULL,
    "archivalReference" VARCHAR(255),
    "volume" VARCHAR(255),
    "volumes" VARCHAR(255),
    "date" VARCHAR(50),
    "imageCount" INTEGER,
    "projectId" VARCHAR(50) NOT NULL,
    "title" TEXT,
    "creator" VARCHAR(255),
    "indexedChildCount" INTEGER,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "family_search_items_pkey" PRIMARY KEY ("id")
);
