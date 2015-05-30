-- Verify data_items

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    SELECT 1/COUNT(*) FROM item WHERE name = 'L1';
    SELECT 1/COUNT(*) FROM item WHERE name = 'L2';
    SELECT 1/COUNT(*) FROM item WHERE name = 'J1';
    SELECT 1/COUNT(*) FROM item WHERE name = 'J2';

ROLLBACK;
