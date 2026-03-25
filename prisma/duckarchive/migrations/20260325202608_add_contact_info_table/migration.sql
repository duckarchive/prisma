-- CreateTable
CREATE TABLE "contact_infos" (
    "user_id" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6),
    "full_name" VARCHAR(255),
    "contact_address" VARCHAR(255),
    "contact_phone_number" VARCHAR(50),
    "contact_email" VARCHAR(255)
);

-- CreateIndex
CREATE UNIQUE INDEX "contact_infos_user_id_key" ON "contact_infos"("user_id");

-- AddForeignKey
ALTER TABLE "contact_infos" ADD CONSTRAINT "contact_infos_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
