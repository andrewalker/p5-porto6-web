-- Verify table_client

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    SELECT id, name, phone, email, comments, created_at FROM client WHERE FALSE;

ROLLBACK;
