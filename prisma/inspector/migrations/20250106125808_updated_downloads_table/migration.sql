/*
  Warnings:

  - You are about to drop the column `match_id` on the `user_downloads` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "user_downloads" DROP CONSTRAINT "user_downloads_match_id_fkey";

-- AlterTable
ALTER TABLE "user_downloads" DROP COLUMN "match_id",
ADD COLUMN     "base_url" VARCHAR(255),
ADD COLUMN     "code" VARCHAR(50);
