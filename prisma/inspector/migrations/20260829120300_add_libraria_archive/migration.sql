-- insert into the archives table
-- Like НБУВ, LIBRARIA is not a state archive — the row exists so the scrapper
-- task's `archive` relation supplies the LIBRARIA full_code prefix.
INSERT INTO
  "archives" (code, title)
VALUES
  (
    'LIBRARIA',
    'LIBRARIA — архів української періодики онлайн'
  );
