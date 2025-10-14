/*
  Warnings:

  - You are about to drop the `user_downloads` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `users` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "user_downloads" DROP CONSTRAINT "user_downloads_user_id_fkey";

-- DropTable
DROP TABLE "user_downloads";

-- DropTable
DROP TABLE "users";
