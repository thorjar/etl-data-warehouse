/*
=============================================================
PostgreSQL DataWarehouse Init Script
=============================================================
Script Purpose:
    Creates schemas for a data warehouse architecture:
    - bronze (raw data)
    - silver (cleaned data)
    - gold (analytics layer)
*/

-- =========================================================
-- OPTIONAL: DROP SCHEMAS IF THEY EXIST
-- =========================================================

DROP SCHEMA IF EXISTS bronze CASCADE;
DROP SCHEMA IF EXISTS silver CASCADE;
DROP SCHEMA IF EXISTS gold CASCADE;

-- =========================================================
-- CREATE SCHEMAS
-- =========================================================

CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;