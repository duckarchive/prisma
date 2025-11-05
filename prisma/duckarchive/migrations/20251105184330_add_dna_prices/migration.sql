-- CreateTable
CREATE TABLE "dna_prices" (
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "my_heritage" INTEGER NOT NULL,
    "ftdna" INTEGER NOT NULL,
    "ftdna_mtdna" INTEGER NOT NULL,
    "ftdna_y111" INTEGER NOT NULL,
    "ftdna_y37" INTEGER NOT NULL,
    "ftdna_y700" INTEGER NOT NULL,
    "ancestry" INTEGER NOT NULL,
    "ancestry_uk" INTEGER NOT NULL,
    "ancestry_de" INTEGER NOT NULL,

    CONSTRAINT "dna_prices_pkey" PRIMARY KEY ("created_at")
);
