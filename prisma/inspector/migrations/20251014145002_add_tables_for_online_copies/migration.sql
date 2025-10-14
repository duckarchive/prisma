-- CreateTable
CREATE TABLE "description_online_copies" (
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "resource_id" UUID NOT NULL,
    "description_id" UUID NOT NULL,
    "api_url" TEXT NOT NULL,
    "api_params" VARCHAR(255) NOT NULL,
    "url" TEXT,

    CONSTRAINT "description_online_copies_pkey" PRIMARY KEY ("resource_id","description_id","api_params")
);

-- CreateTable
CREATE TABLE "case_online_copies" (
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "resource_id" UUID NOT NULL,
    "case_id" UUID NOT NULL,
    "api_url" TEXT NOT NULL,
    "api_params" VARCHAR(255) NOT NULL,
    "url" TEXT,

    CONSTRAINT "case_online_copies_pkey" PRIMARY KEY ("resource_id","case_id","api_params")
);

-- AddForeignKey
ALTER TABLE "description_online_copies" ADD CONSTRAINT "description_online_copies_resource_id_fkey" FOREIGN KEY ("resource_id") REFERENCES "resources"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "description_online_copies" ADD CONSTRAINT "description_online_copies_description_id_fkey" FOREIGN KEY ("description_id") REFERENCES "descriptions"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "case_online_copies" ADD CONSTRAINT "case_online_copies_resource_id_fkey" FOREIGN KEY ("resource_id") REFERENCES "resources"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "case_online_copies" ADD CONSTRAINT "case_online_copies_case_id_fkey" FOREIGN KEY ("case_id") REFERENCES "cases"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
