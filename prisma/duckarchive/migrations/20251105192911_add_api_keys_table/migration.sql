-- CreateTable
CREATE TABLE "api_keys" (
    "key" UUID NOT NULL DEFAULT gen_random_uuid(),
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "api_keys_pkey" PRIMARY KEY ("key")
);
