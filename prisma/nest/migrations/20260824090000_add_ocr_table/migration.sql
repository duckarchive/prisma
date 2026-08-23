-- CreateTable
CREATE TABLE "ocr" (
    "id" SERIAL NOT NULL,
    "url" TEXT NOT NULL,
    "full_code" VARCHAR(255) NOT NULL,
    "raw" JSONB,
    "structured" TEXT,
    "error" TEXT,
    "recognized_at" TIMESTAMP(6),

    CONSTRAINT "ocr_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ocr_url_key" ON "ocr"("url");

-- CreateIndex
CREATE INDEX "ocr_full_code_idx" ON "ocr"("full_code");

-- CreateIndex
CREATE INDEX "ocr_recognized_at_idx" ON "ocr"("recognized_at");

