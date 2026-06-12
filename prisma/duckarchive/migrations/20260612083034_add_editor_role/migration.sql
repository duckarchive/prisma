/*
  Warnings:

  - You are about to drop the column `is_premium` on the `users` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "users" DROP COLUMN "is_premium",
ADD COLUMN     "is_editor" BOOLEAN NOT NULL DEFAULT false;
