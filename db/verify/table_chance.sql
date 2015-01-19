-- Verify table_chance

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    SELECT code, item, sale FROM chance WHERE FALSE;

ROLLBACK;
