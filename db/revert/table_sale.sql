-- Revert table_sale

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    DROP TABLE sale;
    DROP TYPE sale_status;

COMMIT;
