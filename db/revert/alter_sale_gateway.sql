-- Revert alter_sale_gateway

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    ALTER TABLE sale DROP COLUMN gateway;

COMMIT;
