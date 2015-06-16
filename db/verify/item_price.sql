-- Verify item_price

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    SELECT 1/COUNT(*) FROM item WHERE name = 'L3' AND price = 5.0;
    SELECT 1/COUNT(*) FROM item WHERE name = 'J3' AND price = 5.0;
    SELECT 1/COUNT(*) FROM item WHERE name = 'V1' AND price = 3.0;

ROLLBACK;
