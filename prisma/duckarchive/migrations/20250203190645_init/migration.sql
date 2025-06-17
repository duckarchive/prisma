-- CreateTable
CREATE TABLE "users" (
    "id" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" VARCHAR(255) NOT NULL,
    "is_banned" BOOLEAN NOT NULL DEFAULT false,
    "is_premium" BOOLEAN NOT NULL DEFAULT false,
    "is_admin" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "users_pkey" PRIMARY KEY ("email")
);

-- CreateTable
CREATE TABLE "user_downloads" (
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "count" INTEGER NOT NULL,
    "code" VARCHAR(50),
    "base_url" VARCHAR(255),
    "country" VARCHAR(100),
    "user_id" VARCHAR(255) NOT NULL,

    CONSTRAINT "user_downloads_pkey" PRIMARY KEY ("user_id","created_at")
);

-- CreateTable
CREATE TABLE "lookups" (
    "user_id" VARCHAR(255) NOT NULL,
    "full_code" VARCHAR(255) NOT NULL,
    "note" TEXT,
    "is_online" BOOLEAN NOT NULL DEFAULT false,
    "is_sync_disabled" BOOLEAN NOT NULL DEFAULT false,
    "location_id" VARCHAR(255) NOT NULL,
    "branch_id" VARCHAR(255) NOT NULL,
    "year" INTEGER NOT NULL,

    CONSTRAINT "lookups_pkey" PRIMARY KEY ("user_id","full_code","location_id","branch_id","year")
);

-- CreateTable
CREATE TABLE "locations" (
    "id" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,

    CONSTRAINT "locations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "branches" (
    "id" VARCHAR(255) NOT NULL,
    "user_id" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,

    CONSTRAINT "branches_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_id_key" ON "users"("id");

-- AddForeignKey
ALTER TABLE "user_downloads" ADD CONSTRAINT "user_downloads_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "lookups" ADD CONSTRAINT "lookups_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "lookups" ADD CONSTRAINT "lookups_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "locations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lookups" ADD CONSTRAINT "lookups_branch_id_fkey" FOREIGN KEY ("branch_id") REFERENCES "branches"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "branches" ADD CONSTRAINT "branches_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
