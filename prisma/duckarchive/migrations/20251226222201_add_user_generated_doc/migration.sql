-- CreateTable
CREATE TABLE "user_generated_documents" (
    "id" VARCHAR(255) NOT NULL,
    "user_id" VARCHAR(255) NOT NULL,
    "type" VARCHAR(100) NOT NULL,
    "content" JSONB NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_generated_documents_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "user_generated_documents" ADD CONSTRAINT "user_generated_documents_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
