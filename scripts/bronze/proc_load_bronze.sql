CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    batch_start TIMESTAMP;
    batch_end   TIMESTAMP;
    start_time  TIMESTAMP;
    end_time    TIMESTAMP;
BEGIN
    batch_start := clock_timestamp();

    RAISE NOTICE '========================================';
    RAISE NOTICE 'Loading Bronze Layer';
    RAISE NOTICE '========================================';

    -- =====================================================
    -- CRM TABLES
    -- =====================================================
    RAISE NOTICE 'Loading CRM Tables';

    -- cust_info
    start_time := clock_timestamp();

    RAISE NOTICE 'Truncating bronze.crm_cust_info';
    TRUNCATE TABLE bronze.crm_cust_info;

    RAISE NOTICE 'Loading bronze.crm_cust_info';

    COPY bronze.crm_cust_info
    FROM '/data/source_crm/cust_info.csv'
    WITH (FORMAT csv, HEADER true);

    end_time := clock_timestamp();
    RAISE NOTICE 'Load Duration: % seconds',
        EXTRACT(EPOCH FROM (end_time - start_time));


    -- prd_info
    start_time := clock_timestamp();

    RAISE NOTICE 'Truncating bronze.crm_prd_info';
    TRUNCATE TABLE bronze.crm_prd_info;

    RAISE NOTICE 'Loading bronze.crm_prd_info';

    COPY bronze.crm_prd_info
    FROM '/data/source_crm/prd_info.csv'
    WITH (FORMAT csv, HEADER true);

    end_time := clock_timestamp();
    RAISE NOTICE 'Load Duration: % seconds',
        EXTRACT(EPOCH FROM (end_time - start_time));


    -- sales_details
    start_time := clock_timestamp();

    RAISE NOTICE 'Truncating bronze.crm_sales_details';
    TRUNCATE TABLE bronze.crm_sales_details;

    RAISE NOTICE 'Loading bronze.crm_sales_details';

    COPY bronze.crm_sales_details
    FROM '/data/source_crm/sales_details.csv'
    WITH (FORMAT csv, HEADER true);

    end_time := clock_timestamp();
    RAISE NOTICE 'Load Duration: % seconds',
        EXTRACT(EPOCH FROM (end_time - start_time));


    -- =====================================================
    -- ERP TABLES
    -- =====================================================
    RAISE NOTICE 'Loading ERP Tables';

    -- loc_a101
    start_time := clock_timestamp();

    RAISE NOTICE 'Truncating bronze.erp_loc_a101';
    TRUNCATE TABLE bronze.erp_loc_a101;

    RAISE NOTICE 'Loading bronze.erp_loc_a101';

    COPY bronze.erp_loc_a101
    FROM '/data/source_erp/LOC_A101.csv'
    WITH (FORMAT csv, HEADER true);

    end_time := clock_timestamp();
    RAISE NOTICE 'Load Duration: % seconds',
        EXTRACT(EPOCH FROM (end_time - start_time));


    -- cust_az12
    start_time := clock_timestamp();

    RAISE NOTICE 'Truncating bronze.erp_cust_az12';
    TRUNCATE TABLE bronze.erp_cust_az12;

    RAISE NOTICE 'Loading bronze.erp_cust_az12';

    COPY bronze.erp_cust_az12
    FROM '/data/source_erp/CUST_AZ12.csv'
    WITH (FORMAT csv, HEADER true);

    end_time := clock_timestamp();
    RAISE NOTICE 'Load Duration: % seconds',
        EXTRACT(EPOCH FROM (end_time - start_time));


    -- px_cat_g1v2
    start_time := clock_timestamp();

    RAISE NOTICE 'Truncating bronze.erp_px_cat_g1v2';
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;

    RAISE NOTICE 'Loading bronze.erp_px_cat_g1v2';

    COPY bronze.erp_px_cat_g1v2
    FROM '/data/source_erp/PX_CAT_G1V2.csv'
    WITH (FORMAT csv, HEADER true);

    end_time := clock_timestamp();
    RAISE NOTICE 'Load Duration: % seconds',
        EXTRACT(EPOCH FROM (end_time - start_time));


    -- =====================================================
    -- END BATCH
    -- =====================================================
    batch_end := clock_timestamp();

    RAISE NOTICE '========================================';
    RAISE NOTICE 'Bronze Layer Load Completed';
    RAISE NOTICE 'Total Duration: % seconds',
        EXTRACT(EPOCH FROM (batch_end - batch_start));
    RAISE NOTICE '========================================';

EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '========================================';
    RAISE NOTICE 'ERROR OCCURRED DURING BRONZE LOAD';
    RAISE NOTICE 'SQLSTATE: %', SQLSTATE;
    RAISE NOTICE 'SQLERRM: %', SQLERRM;
    RAISE NOTICE '========================================';
    RAISE;
END;
$$;