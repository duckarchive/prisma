/*
  Warnings:

  - The primary key for the `user_generated_documents` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `created_at` on the `user_generated_documents` table. All the data in the column will be lost.
  - The `id` column on the `user_generated_documents` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "user_generated_documents" DROP CONSTRAINT "user_generated_documents_pkey",
DROP COLUMN "created_at",
ADD COLUMN     "params" JSON,
ADD COLUMN     "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL DEFAULT gen_random_uuid(),
ALTER COLUMN "content" SET DATA TYPE TEXT,
ADD CONSTRAINT "user_generated_documents_pkey" PRIMARY KEY ("id");
