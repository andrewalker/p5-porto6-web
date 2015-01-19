-- Revert table_client

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    DROP TABLE client;

COMMIT;
