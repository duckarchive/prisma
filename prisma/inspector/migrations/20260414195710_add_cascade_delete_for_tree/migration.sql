-- DropForeignKey
ALTER TABLE "case_locations" DROP CONSTRAINT "case_locations_case_id_fkey";

-- DropForeignKey
ALTER TABLE "case_online_copies" DROP CONSTRAINT "case_online_copies_case_id_fkey";

-- DropForeignKey
ALTER TABLE "case_years" DROP CONSTRAINT "case_years_case_id_fkey";

-- DropForeignKey
ALTER TABLE "description_online_copies" DROP CONSTRAINT "description_online_copies_description_id_fkey";

-- DropForeignKey
ALTER TABLE "description_years" DROP CONSTRAINT "description_years_description_id_fkey";

-- DropForeignKey
ALTER TABLE "file_locations" DROP CONSTRAINT "file_locations_file_id_fkey";

-- DropForeignKey
ALTER TABLE "file_online_copies" DROP CONSTRAINT "file_online_copies_file_id_fkey";

-- DropForeignKey
ALTER TABLE "file_years" DROP CONSTRAINT "file_years_file_id_fkey";

-- DropForeignKey
ALTER TABLE "fond_years" DROP CONSTRAINT "fond_years_fond_id_fkey";

-- DropForeignKey
ALTER TABLE "fund_years" DROP CONSTRAINT "fund_years_fund_id_fkey";

-- DropForeignKey
ALTER TABLE "inventory_online_copies" DROP CONSTRAINT "inventory_online_copies_inventory_id_fkey";

-- DropForeignKey
ALTER TABLE "inventory_years" DROP CONSTRAINT "inventory_years_inventory_id_fkey";

-- AddForeignKey
ALTER TABLE "fund_years" ADD CONSTRAINT "fund_years_fund_id_fkey" FOREIGN KEY ("fund_id") REFERENCES "funds"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "description_years" ADD CONSTRAINT "description_years_description_id_fkey" FOREIGN KEY ("description_id") REFERENCES "descriptions"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "description_online_copies" ADD CONSTRAINT "description_online_copies_description_id_fkey" FOREIGN KEY ("description_id") REFERENCES "descriptions"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "case_years" ADD CONSTRAINT "case_years_case_id_fkey" FOREIGN KEY ("case_id") REFERENCES "cases"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "case_locations" ADD CONSTRAINT "case_locations_case_id_fkey" FOREIGN KEY ("case_id") REFERENCES "cases"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "case_online_copies" ADD CONSTRAINT "case_online_copies_case_id_fkey" FOREIGN KEY ("case_id") REFERENCES "cases"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "fond_years" ADD CONSTRAINT "fond_years_fond_id_fkey" FOREIGN KEY ("fond_id") REFERENCES "fonds"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "inventory_years" ADD CONSTRAINT "inventory_years_inventory_id_fkey" FOREIGN KEY ("inventory_id") REFERENCES "inventories"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "inventory_online_copies" ADD CONSTRAINT "inventory_online_copies_inventory_id_fkey" FOREIGN KEY ("inventory_id") REFERENCES "inventories"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "file_years" ADD CONSTRAINT "file_years_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "file_locations" ADD CONSTRAINT "file_locations_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "file_online_copies" ADD CONSTRAINT "file_online_copies_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files"("id") ON DELETE CASCADE ON UPDATE NO ACTION;
