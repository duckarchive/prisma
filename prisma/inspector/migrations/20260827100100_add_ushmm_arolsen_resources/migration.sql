-- insert into the resources table
-- (separate migration from the enum extension: Postgres cannot use a new enum
-- value in the same transaction that added it)
INSERT INTO
  "resources" (code, title, "url", "type")
VALUES
  (
    'ushmm',
    'United States Holocaust Memorial Museum',
    'https://collections.ushmm.org/',
    'USHMM'
  ),
  (
    'arolsen',
    'Arolsen Archives',
    'https://collections.arolsen-archives.org/',
    'AROLSEN'
  );
