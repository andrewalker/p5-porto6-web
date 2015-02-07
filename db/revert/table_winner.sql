-- Revert table_winner

BEGIN;

    SET search_path TO porto6, pg_catalog, public;
    SET client_min_messages TO warning;

    DROP TABLE winner;

COMMIT;
