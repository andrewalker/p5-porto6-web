-- Verify table_item

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    SELECT name FROM item WHERE FALSE;

ROLLBACK;
