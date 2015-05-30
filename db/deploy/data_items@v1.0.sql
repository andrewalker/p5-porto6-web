-- Deploy data_items
-- requires: table_item

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    INSERT INTO item (name) VALUES ('L1');
    INSERT INTO item (name) VALUES ('L2');
    INSERT INTO item (name) VALUES ('J1');
    INSERT INTO item (name) VALUES ('J2');

COMMIT;
