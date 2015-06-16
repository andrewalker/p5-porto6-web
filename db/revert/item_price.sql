-- Revert item_price

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    ALTER TABLE item DROP COLUMN price;

COMMIT;
