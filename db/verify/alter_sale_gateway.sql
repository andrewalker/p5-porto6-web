-- Verify alter_sale_gateway

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    SELECT gateway FROM sale WHERE FALSE;

ROLLBACK;
