-- Deploy rework_sale
-- requires: table_sale

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    ALTER TABLE sale ALTER COLUMN status DROP DEFAULT,
                     ALTER COLUMN status TYPE TEXT USING status::text;

    DROP TYPE sale_status;

    CREATE TYPE sale_status AS ENUM('new', 'waiting', 'payed', 'sent-email', 'failed');

    ALTER TABLE sale ALTER COLUMN status SET DEFAULT 'new'::sale_status,
                     ALTER COLUMN status TYPE sale_status USING status::sale_status,
                     ADD COLUMN gateway_id TEXT,
                     ADD COLUMN created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
                     ADD COLUMN updated_at TIMESTAMP WITH TIME ZONE DEFAULT now();

COMMIT;
