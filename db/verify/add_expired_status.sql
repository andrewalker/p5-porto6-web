-- Verify add_expired_status

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    SELECT 'expired'::sale_status WHERE FALSE;

ROLLBACK;
