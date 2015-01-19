-- Revert data_items

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    DELETE FROM item WHERE name = 'L1';
    DELETE FROM item WHERE name = 'L2';
    DELETE FROM item WHERE name = 'J1';
    DELETE FROM item WHERE name = 'J2';

COMMIT;
