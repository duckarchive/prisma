-- Stable claim identity for online_copies (scrapper ↔ inspector contract).
--
-- Why: a row is one (url ↔ catalog node) edge, but its identity was
-- (resource_id, parsed, url) and `parsed` is the scrapper's textual claim.
-- FamilySearch derives it from editor-maintained metadata that gets reworded
-- between syncs ("37_3_104" → "37-3-104_1805", Latin → Cyrillic, a title filled
-- in later), so every re-sync inserted an unlinked twin next to the human-linked
-- row: 32,148 redundant linked rows in 21,713 groups as of 2026-08-31,
-- regenerating every cycle (inspector migration/2026-08-31-oc-link-round2/README.md).
-- The old unique (resource_id, inventory_id, file_id, parsed, url) never fired at
-- all: one FK is always NULL (single-parent CHECK) and NULLs are distinct.
--
-- What:
--   * source_key — the scrapper's stable id of a claim within (resource_id, url):
--     the source's native item id where it has one (FamilySearch image-group id,
--     libraria number id, …), otherwise the code text itself. NULL = not written
--     by the scrapper (manual adds, editor imports, demoted second edges).
--     `parsed` becomes the mutable claim text, refreshed in place by every sync.
--   * UNIQUE (resource_id, url, source_key)                 — claim identity
--   * UNIQUE (resource_id, url, file_id)      WHERE NOT NULL — one edge per url ↔ file
--   * UNIQUE (resource_id, url, inventory_id) WHERE NOT NULL — one edge per url ↔ inventory
--   * created_at, backfilled from updated_at (the closest proxy: the scrapper only
--     moved updated_at on availability changes)
--   * file_actions/inventory_actions.online_copy_id ON DELETE CASCADE → SET NULL
--     (deleting a copy no longer erases its action history; column already nullable)
--
-- Data steps — intentionally destructive, action history is repointed first:
--   A. edge duplicates: several rows on one (resource_id, url) linked to the SAME
--      target (the parsed-drift twins) → keep the row the scrapper still maintains
--      (latest checked_availability_at), delete the rest.
--   B. exact claim duplicates (resource_id, url, parsed): unlinked / same-parent
--      twins collapse into the linked-or-latest row; twins linked to DIFFERENT
--      parents are kept as second edges but demoted (they never get a source_key).
--   C. pending actions that would collide on the actions' pending-uniques after
--      repointing are thinned to one per (survivor, type, target); every other
--      action of a loser is repointed to the survivor; then the losers are deleted.
--   D. one whole-table rewrite sets created_at and source_key = parsed for every
--      remaining scrapper row (parsed <> ''). The first post-migration sync of each
--      plugin swaps that legacy key for the plugin's native key in place
--      ("adoption" in scrapper src/core/online-copies.ts).
--   E. rebuild the indexes; the three CREATE UNIQUE INDEX statements are the hard
--      assertion that A/B left no violators — they name the offending key if not.
--
-- Shape (performance): the first attempt on prod (2026-09-01) ran 40+ minutes
-- without finishing the first of two whole-table UPDATEs — every rewritten row
-- had to be inserted into 8 live indexes, the GIN trigram index on `parsed`
-- dominating. This version drops the FKs and every secondary index up front,
-- does the dedup and ONE combined rewrite with only the primary key alive, and
-- rebuilds the indexes from scratch at the end (a fresh GIN build over the whole
-- table is minutes; millions of incremental GIN inserts were the hour).
--
-- Operations: one transaction; the ACCESS EXCLUSIVE lock of the first ALTER is
-- held throughout (inspector reads of online_copies queue behind it). Run with the
-- scrapper STOPPED (its previous sink would insert NULL-key rows) and deploy the
-- scrapper + inspector builds that know source_key right after. Pre-flight
-- queries, the runbook and the one-time post-sync sweep live in the inspector
-- repo, migration/2026-09-01-oc-source-key-cutover/. Expect ~15–20 minutes: two
-- whole-table sorts, one rewrite, nine index builds. VACUUM ANALYZE online_copies
-- afterwards.

SET LOCAL work_mem = '256MB';              -- the two window sorts
SET LOCAL maintenance_work_mem = '512MB';  -- the index builds, GIN especially

-- AlterTable (PG11+: a non-volatile default is metadata-only — no rewrite here)
ALTER TABLE "online_copies" ADD COLUMN     "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "source_key" TEXT;

-- FKs off (they come back as SET NULL in E) and secondary indexes off: nothing
-- but the primary key is maintained during the dedup and the rewrite.

-- DropForeignKey
ALTER TABLE "inventory_actions" DROP CONSTRAINT "inventory_actions_online_copy_id_fkey";

-- DropForeignKey
ALTER TABLE "file_actions" DROP CONSTRAINT "file_actions_online_copy_id_fkey";

-- DropIndex
DROP INDEX "online_copies_resource_id_inventory_id_file_id_parsed_url_key";
DROP INDEX "online_copies_parsed_idx";
DROP INDEX "online_copy_parsed_gin_trgm_ops_idx";
DROP INDEX "online_copies_inventory_id_idx";
DROP INDEX "online_copies_file_id_idx";
DROP INDEX IF EXISTS "online_copies_url_prefix_idx";
DROP INDEX IF EXISTS "online_copies_public_by_resource_idx";

-- A. edge duplicates: survivor = latest checked (NULL partition keys group
--    together in window functions, so this is per (resource, url, target)).
CREATE TEMP TABLE oc_edge_losers ON COMMIT DROP AS
WITH ranked AS (
  SELECT id,
         row_number() OVER w AS rn,
         first_value(id) OVER w AS survivor_id
  FROM "online_copies"
  WHERE file_id IS NOT NULL OR inventory_id IS NOT NULL
  WINDOW w AS (PARTITION BY resource_id, url, file_id, inventory_id
               ORDER BY checked_availability_at DESC NULLS LAST, updated_at DESC, id)
)
SELECT id AS loser_id, survivor_id FROM ranked WHERE rn > 1;
CREATE INDEX ON oc_edge_losers (loser_id);
ANALYZE oc_edge_losers;

-- B. exact claim duplicates among the rows that survive A: survivor = linked
--    first, then latest checked. 'collapse' = unlinked twin or same parent;
--    'demote' = linked to a different parent (a legitimate second edge of the
--    same claim: kept, never keyed).
CREATE TEMP TABLE oc_claim_losers ON COMMIT DROP AS
WITH live AS (
  SELECT o.id, o.resource_id, o.url, o.parsed, o.file_id, o.inventory_id,
         o.checked_availability_at, o.updated_at
  FROM "online_copies" o
  WHERE o.parsed <> ''
    AND NOT EXISTS (SELECT 1 FROM oc_edge_losers e WHERE e.loser_id = o.id)
),
ranked AS (
  SELECT id, file_id, inventory_id,
         row_number() OVER w AS rn,
         first_value(id) OVER w AS survivor_id
  FROM live
  WINDOW w AS (PARTITION BY resource_id, url, parsed
               ORDER BY (file_id IS NULL AND inventory_id IS NULL),
                        checked_availability_at DESC NULLS LAST, updated_at DESC, id)
)
SELECT l.id AS loser_id,
       l.survivor_id,
       CASE
         WHEN l.file_id IS NULL AND l.inventory_id IS NULL THEN 'collapse'
         WHEN l.file_id IS NOT DISTINCT FROM s.file_id
          AND l.inventory_id IS NOT DISTINCT FROM s.inventory_id THEN 'collapse'
         ELSE 'demote'
       END AS kind
FROM ranked l
JOIN ranked s ON s.id = l.survivor_id
WHERE l.rn > 1;
CREATE INDEX ON oc_claim_losers (loser_id);
ANALYZE oc_claim_losers;

-- doomed rows, with one level of survivor chaining (an A-survivor may itself
-- collapse in B)
CREATE TEMP TABLE oc_doomed ON COMMIT DROP AS
SELECT e.loser_id,
       COALESCE(
         (SELECT c.survivor_id FROM oc_claim_losers c
          WHERE c.loser_id = e.survivor_id AND c.kind = 'collapse'),
         e.survivor_id) AS survivor_id
FROM oc_edge_losers e
UNION ALL
SELECT loser_id, survivor_id FROM oc_claim_losers WHERE kind = 'collapse';
CREATE INDEX ON oc_doomed (loser_id);
ANALYZE oc_doomed;

-- C. action history. Pending actions of a group that would collide on the
--    pending-uniques once they all point at the survivor are thinned to one per
--    (survivor, type, target) — the survivor's own action wins, else the oldest.
WITH members AS (
  SELECT survivor_id, loser_id AS member_id FROM oc_doomed
  UNION
  SELECT DISTINCT survivor_id, survivor_id FROM oc_doomed
),
ranked AS (
  SELECT fa.id,
         row_number() OVER (PARTITION BY m.survivor_id, fa.type, fa.file_id
                            ORDER BY (fa.online_copy_id = m.survivor_id) DESC, fa.created_at, fa.id) AS rn
  FROM "file_actions" fa
  JOIN members m ON m.member_id = fa.online_copy_id
  WHERE fa.resolved_at IS NULL
)
DELETE FROM "file_actions" WHERE id IN (SELECT id FROM ranked WHERE rn > 1);

WITH members AS (
  SELECT survivor_id, loser_id AS member_id FROM oc_doomed
  UNION
  SELECT DISTINCT survivor_id, survivor_id FROM oc_doomed
),
ranked AS (
  SELECT ia.id,
         row_number() OVER (PARTITION BY m.survivor_id, ia.type, ia.inventory_id
                            ORDER BY (ia.online_copy_id = m.survivor_id) DESC, ia.created_at, ia.id) AS rn
  FROM "inventory_actions" ia
  JOIN members m ON m.member_id = ia.online_copy_id
  WHERE ia.resolved_at IS NULL
)
DELETE FROM "inventory_actions" WHERE id IN (SELECT id FROM ranked WHERE rn > 1);

UPDATE "file_actions" fa
SET online_copy_id = d.survivor_id
FROM oc_doomed d
WHERE fa.online_copy_id = d.loser_id;

UPDATE "inventory_actions" ia
SET online_copy_id = d.survivor_id
FROM oc_doomed d
WHERE ia.online_copy_id = d.loser_id;

DELETE FROM "online_copies" oc
USING oc_doomed d
WHERE oc.id = d.loser_id;

-- D. the one rewrite: created_at + source_key together; demoted second edges
--    stay NULL, so do rows without a claim text (manual adds)
UPDATE "online_copies" oc
SET created_at = oc.updated_at,
    source_key = CASE
      WHEN oc.parsed <> ''
       AND NOT EXISTS (SELECT 1 FROM oc_claim_losers c WHERE c.loser_id = oc.id AND c.kind = 'demote')
      THEN oc.parsed
    END;

-- Sanity report (the unique indexes below are the actual assertion)
DO $$
DECLARE
    edge_losers bigint;
    claim_collapsed bigint;
    claim_demoted bigint;
    keyless bigint;
BEGIN
    SELECT count(*) INTO edge_losers FROM oc_edge_losers;
    SELECT count(*) INTO claim_collapsed FROM oc_claim_losers WHERE kind = 'collapse';
    SELECT count(*) INTO claim_demoted FROM oc_claim_losers WHERE kind = 'demote';
    SELECT count(*) INTO keyless FROM "online_copies" WHERE parsed <> '' AND source_key IS NULL;
    RAISE NOTICE 'online_copies: % edge twins deleted, % exact claim twins collapsed, % demoted (kept, source_key NULL); % scrapper rows left keyless',
        edge_losers, claim_collapsed, claim_demoted, keyless;
END $$;

-- E. rebuild the secondary indexes exactly as before, add the identity + edge
--    uniques, re-add the FKs as SET NULL

-- CreateIndex
CREATE INDEX "online_copies_parsed_idx" ON "online_copies"("parsed");

-- CreateIndex
CREATE INDEX "online_copy_parsed_gin_trgm_ops_idx" ON "online_copies" USING GIN ("parsed" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "online_copies_inventory_id_idx" ON "online_copies"("inventory_id");

-- CreateIndex
CREATE INDEX "online_copies_file_id_idx" ON "online_copies"("file_id");

-- CreateIndex (text_pattern_ops: the editor's url-prefix search, see 20260803103925)
CREATE INDEX "online_copies_url_prefix_idx" ON "online_copies"("url" text_pattern_ops);

-- CreateIndex (partial: per-resource public counters, see 20260821120100)
CREATE INDEX "online_copies_public_by_resource_idx"
  ON "online_copies" ("resource_id")
  WHERE "availability" = 'PUBLIC';

-- CreateIndex
CREATE UNIQUE INDEX "online_copies_resource_id_url_source_key_key" ON "online_copies"("resource_id", "url", "source_key");

-- CreateIndex
CREATE UNIQUE INDEX "online_copies_resource_id_url_file_id_key" ON "online_copies"("resource_id", "url", "file_id") WHERE (file_id IS NOT NULL);

-- CreateIndex
CREATE UNIQUE INDEX "online_copies_resource_id_url_inventory_id_key" ON "online_copies"("resource_id", "url", "inventory_id") WHERE (inventory_id IS NOT NULL);

-- AddForeignKey
ALTER TABLE "inventory_actions" ADD CONSTRAINT "inventory_actions_online_copy_id_fkey" FOREIGN KEY ("online_copy_id") REFERENCES "online_copies"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "file_actions" ADD CONSTRAINT "file_actions_online_copy_id_fkey" FOREIGN KEY ("online_copy_id") REFERENCES "online_copies"("id") ON DELETE SET NULL ON UPDATE NO ACTION;
