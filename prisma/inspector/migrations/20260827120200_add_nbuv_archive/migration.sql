-- insert into the archives table
-- НБУВ is not one of the regional/central state archives already seeded in
-- 20240621155425_add_archives — it's the National Library's own fond, added
-- to support the `nbuv` plugin's fond/inventory/file writes.
INSERT INTO
  "archives" (code, title)
VALUES
  (
    'НБУВ',
    'Національна бібліотека України імені В. І. Вернадського'
  );
