-- insert into the resources table
-- (separate migration from the enum extension: Postgres cannot use a new enum
-- value in the same transaction that added it)
INSERT INTO
  "resources" (code, title, "url", "type")
VALUES
  (
    'nbuv',
    'Національна бібліотека України імені В. І. Вернадського',
    'https://nbuv.gov.ua/',
    'LIBRARY'
  );
