-- Deploy table_chance
-- requires: schema_porto6
-- requires: table_item
-- requires: table_sale

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    CREATE TABLE chance (
        code TEXT NOT NULL,
        item TEXT NOT NULL,
        sale UUID NOT NULL,

        FOREIGN KEY (item) REFERENCES item(name),
        FOREIGN KEY (sale) REFERENCES sale(id),
        PRIMARY KEY (code)
    );

COMMIT;
