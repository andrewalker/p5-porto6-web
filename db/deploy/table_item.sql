-- Deploy table_item
-- requires: schema_porto6

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    CREATE TABLE item (
        name TEXT NOT NULL,
        PRIMARY KEY(name)
    );

COMMIT;
