-- Deploy alter_sale_gateway
-- requires: table_sale

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    ALTER TABLE sale ADD COLUMN gateway TEXT NOT NULL;

COMMIT;
