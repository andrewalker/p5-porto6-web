-- Revert rework_sale

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    ALTER TABLE sale DROP COLUMN created_at,
                     DROP COLUMN updated_at,
                     DROP COLUMN gateway_id,
                     ALTER COLUMN status DROP DEFAULT,
                     ALTER COLUMN status TYPE TEXT USING status::text;

    DROP TYPE sale_status;

    CREATE TYPE sale_status AS ENUM('new', 'waiting', 'payed', 'sent-email');
    ALTER TABLE sale ALTER COLUMN status TYPE sale_status USING status::sale_status,
                     ALTER COLUMN status SET DEFAULT 'new'::sale_status;

COMMIT;
