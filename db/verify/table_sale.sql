-- Verify table_sale

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    SELECT id, client, status FROM sale WHERE FALSE;

ROLLBACK;
