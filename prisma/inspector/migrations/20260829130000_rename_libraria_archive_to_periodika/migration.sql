-- Rename the LIBRARIA archive to the Cyrillic ПЕРІОДИКА.
--
-- Catalog codes are Cyrillic/digits throughout: the inspector rejects any path
-- segment containing a Latin letter (CATALOG_CODE = /^[^A-Za-z]{1,40}$/), so
-- /archives/LIBRARIA answered 400 and rendered blank, and `parseCode` folds
-- Latin into Cyrillic anyway. The archive is named for what it holds
-- (periodicals) rather than for the site, since the code is the prefix of every
-- full_code beneath it.
--
-- The three UPDATEs are ordered archive → files → copies but are independent;
-- the code prefix is rewritten in place so existing file_id links are untouched.
UPDATE "archives"
SET code = 'ПЕРІОДИКА', title = 'Періодичні видання'
WHERE code = 'LIBRARIA';

UPDATE "files"
SET full_code = 'ПЕРІОДИКА' || substring(full_code from 9)
WHERE full_code LIKE 'LIBRARIA-%';

UPDATE "online_copies"
SET parsed = 'ПЕРІОДИКА' || substring(parsed from 9)
WHERE parsed LIKE 'LIBRARIA-%';
