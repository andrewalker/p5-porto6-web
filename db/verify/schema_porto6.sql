-- Verify schema_porto6

BEGIN;

    SELECT pg_catalog.has_schema_privilege('porto6', 'usage');

ROLLBACK;
