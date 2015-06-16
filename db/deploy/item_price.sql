-- Deploy item_price
-- requires: data_items

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    ALTER TABLE item ADD COLUMN price DECIMAL (5,2) NOT NULL DEFAULT 5.0;
    UPDATE item SET price = 3.0 WHERE name = 'V1';

COMMIT;
