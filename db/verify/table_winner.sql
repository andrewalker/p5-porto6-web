-- Verify table_winner

BEGIN;

    SET search_path TO porto6, pg_catalog, public;
    SET client_min_messages TO warning;

    SELECT item, chance, client_email FROM winner WHERE FALSE;

ROLLBACK;
