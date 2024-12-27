/*
  Warnings:

  - You are about to drop the `fetch_results` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `match_results` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "fetch_results" DROP CONSTRAINT "fetch_results_fetch_id_fkey";

-- DropForeignKey
ALTER TABLE "match_results" DROP CONSTRAINT "match_results_match_id_fkey";

-- AlterTable
ALTER TABLE "fetches" ADD COLUMN     "prev_children_count" INTEGER;

-- AlterTable
ALTER TABLE "matches" ADD COLUMN     "prev_children_count" INTEGER;

-- DropTable
DROP TABLE "fetch_results";

-- DropTable
DROP TABLE "match_results";
