-- CreateTable
CREATE TABLE "authors" (
    "id" VARCHAR(255) NOT NULL,
    "name" TEXT,
    "profile_url" TEXT,
    "updated_at" BIGINT,

    CONSTRAINT "authors_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "posts" (
    "id" VARCHAR(255) NOT NULL,
    "group_id" VARCHAR(255),
    "author_id" VARCHAR(255),
    "author_name" TEXT,
    "permalink" TEXT,
    "created_at" BIGINT,
    "text" TEXT,
    "reactions_json" TEXT,
    "comment_count" INTEGER,
    "share_count" INTEGER,
    "state" VARCHAR(255) DEFAULT 'discovered',
    "feed_cursor" TEXT,
    "raw_json" TEXT,
    "scraped_at" BIGINT,
    "updated_at" BIGINT,

    CONSTRAINT "posts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "comments" (
    "id" VARCHAR(255) NOT NULL,
    "post_id" VARCHAR(255) NOT NULL,
    "parent_comment_id" VARCHAR(255),
    "author_id" VARCHAR(255),
    "author_name" TEXT,
    "text" TEXT,
    "created_at" BIGINT,
    "reactions_json" TEXT,
    "depth" INTEGER DEFAULT 0,
    "reply_cursor" TEXT,
    "replies_complete" INTEGER DEFAULT 0,
    "raw_json" TEXT,
    "scraped_at" BIGINT,

    CONSTRAINT "comments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "media" (
    "id" VARCHAR(255) NOT NULL,
    "post_id" VARCHAR(255),
    "comment_id" VARCHAR(255),
    "type" VARCHAR(255) DEFAULT 'image',
    "source_url" TEXT,
    "local_path" TEXT,
    "sha256" VARCHAR(255),
    "width" BIGINT,
    "height" BIGINT,
    "bytes" BIGINT,
    "status" VARCHAR(255) DEFAULT 'pending',
    "error" TEXT,
    "scraped_at" BIGINT,

    CONSTRAINT "media_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "scrape_state" (
    "key" VARCHAR(255) NOT NULL,
    "value" TEXT,

    CONSTRAINT "scrape_state_pkey" PRIMARY KEY ("key")
);

-- CreateTable
CREATE TABLE "scrape_log" (
    "id" BIGSERIAL NOT NULL,
    "ts" BIGINT,
    "level" VARCHAR(255),
    "message" TEXT,
    "context_json" TEXT,

    CONSTRAINT "scrape_log_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "posts_state_idx" ON "posts"("state");

-- CreateIndex
CREATE INDEX "posts_created_at_idx" ON "posts"("created_at");

-- CreateIndex
CREATE INDEX "comments_post_id_idx" ON "comments"("post_id");

-- CreateIndex
CREATE INDEX "comments_parent_comment_id_idx" ON "comments"("parent_comment_id");

-- CreateIndex
CREATE INDEX "media_status_idx" ON "media"("status");

-- CreateIndex
CREATE INDEX "media_sha256_idx" ON "media"("sha256");

-- AddForeignKey
ALTER TABLE "comments" ADD CONSTRAINT "comments_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "media" ADD CONSTRAINT "media_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE CASCADE;
