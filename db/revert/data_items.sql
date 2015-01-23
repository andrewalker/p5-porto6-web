-- Revert data_items

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    DELETE FROM chance where item = 'L1';
    DELETE FROM item WHERE name = 'L1';
    DELETE FROM chance where item = 'L2';
    DELETE FROM item WHERE name = 'L2';
    DELETE FROM chance where item = 'J1';
    DELETE FROM item WHERE name = 'J1';
    DELETE FROM chance where item = 'J2';
    DELETE FROM item WHERE name = 'J2';

COMMIT;
