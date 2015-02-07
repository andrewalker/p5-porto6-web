-- Deploy table_winner
-- requires: table_chance

BEGIN;

    SET search_path TO porto6, pg_catalog, public;
    SET client_min_messages TO warning;

    CREATE TABLE winner (
        item         TEXT NOT NULL PRIMARY KEY,
        chance       TEXT NOT NULL UNIQUE,
        client_email TEXT NOT NULL UNIQUE,

        FOREIGN KEY (item)         REFERENCES item(name),
        FOREIGN KEY (chance)       REFERENCES chance(code)
    );

COMMIT;
