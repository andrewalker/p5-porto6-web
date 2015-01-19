-- Deploy table_sale
-- requires: schema_porto6
-- requires: table_client

BEGIN;

    SET search_path TO porto6, public, pg_catalog;
    SET client_min_messages TO 'warning';

    CREATE TYPE sale_status AS ENUM('new', 'waiting', 'payed', 'sent-email');

    CREATE TABLE sale (
        id UUID NOT NULL,
        client INTEGER NOT NULL,
        status sale_status NOT NULL DEFAULT 'new'::sale_status,
        FOREIGN KEY (client) REFERENCES client(id),
        PRIMARY KEY (id)
    );

COMMIT;
