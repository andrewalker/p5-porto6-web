-- Verify rework_sale

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    SELECT created_at, updated_at, gateway_id, 'failed'::sale_status FROM sale WHERE FALSE;

ROLLBACK;
