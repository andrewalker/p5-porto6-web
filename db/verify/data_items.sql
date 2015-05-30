-- Verify data_items

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    SELECT 1/COUNT(*) FROM item WHERE name = 'L3';
    SELECT 1/COUNT(*) FROM item WHERE name = 'J3';
    SELECT 1/COUNT(*) FROM item WHERE name = 'V1';

ROLLBACK;
