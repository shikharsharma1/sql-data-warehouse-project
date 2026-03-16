/*
==============================================================
Stored Procedure: Load Bronze Layer
==============================================================

Script Purpose :
  This stored procedure loads the data into 'bronze' schema from CSV files
  it performs the following actions :
  1. Truncates the bronze tables before loading the data.
  2. Uses the BULK INSERT command to insert the data from csv files to bronze tables.

Parameters :
  None.
  This stored procedure does not accept any values.

Usage Example :
  EXEC bronze.load_bronze
==============================================================
*/
  

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--==================DATA LOADING TO TABLES====================
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN TRY
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	SET @batch_start_time = GETDATE();
	PRINT '+++++++++++++++++++++++++++++++++++';
	PRINT 'LOADING BRONZE LAYER';
	PRINT '+++++++++++++++++++++++++++++++++++';

	PRINT '===================================';
	PRINT 'Loading CRM Tables';
	PRINT '===================================';

	SET @start_time = GETDATE();
	PRINT '>>Truncating Table: bronze.crm_cust_info';
	TRUNCATE TABLE bronze.crm_cust_info;

	PRINT '>>Inserting Data Into: bronze.crm_cust_info';

	BULK INSERT bronze.crm_cust_info
	FROM 'C:\Users\My Rig\Downloads\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT '------------------------------';
	PRINT 'Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '------------------------------';
	SELECT COUNT(*) FROM bronze.crm_cust_info ;

	--++++++++++++++++++++
	SET @start_time = GETDATE();
	PRINT '>>Truncating Table: bronze.crm_prd_info';
	TRUNCATE TABLE bronze.crm_prd_info ;

	PRINT '>>Inserting Data Into: bronze.crm_prd_info';
	BULK INSERT bronze.crm_prd_info
	FROM 'C:\Users\My Rig\Downloads\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT '------------------------------';
	PRINT 'Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '------------------------------';
	SELECT COUNT(*) FROM bronze.crm_prd_info ;

	--++++++++++++++++++++
	SET @start_time = GETDATE();
	PRINT '>>Truncating Table: bronze.crm_sales_details';
	TRUNCATE TABLE bronze.crm_sales_details ;

	PRINT '>>Inserting Data Into: bronze.crm_sales_details';
	BULK INSERT bronze.crm_sales_details
	FROM 'C:\Users\My Rig\Downloads\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT '------------------------------';
	PRINT 'Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '------------------------------';
	SELECT COUNT(*) FROM bronze.crm_sales_details ; 

	--++++++++++++++++++++

	PRINT '===================================';
	PRINT 'Loading ERP Tables';
	PRINT '===================================';

	SET @start_time = GETDATE();
	PRINT '>>Truncating Table: bronze.erp_CUST_AZ12';
	TRUNCATE TABLE bronze.erp_CUST_AZ12 ; 

	PRINT '>>Inserting Data Into: bronze.erp_CUST_AZ12';
	BULK INSERT bronze.erp_CUST_AZ12
	FROM 'C:\Users\My Rig\Downloads\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT '------------------------------';
	PRINT 'Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '------------------------------';
	SELECT COUNT(*) FROM bronze.erp_CUST_AZ12 ;

	--++++++++++++++++++++
	SET @start_time = GETDATE();
	PRINT '>>Truncating Table: bronze.erp_LOC_A101';
	TRUNCATE TABLE bronze.erp_LOC_A101 ;

	PRINT '>>Inserting Data Into: bronze.erp_LOC_A101';
	BULK INSERT bronze.erp_LOC_A101
	FROM 'C:\Users\My Rig\Downloads\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT '------------------------------';
	PRINT 'Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '------------------------------';
	SELECT COUNT(*) FROM bronze.erp_LOC_A101

	--++++++++++++++++++++
	SET @start_time = GETDATE();
	PRINT '>>Truncating Table: bronze.erp_PX_CAT_G1V2';
	TRUNCATE TABLE bronze.erp_PX_CAT_G1V2 ;

	PRINT '>>Inserting Data Into: bronze.erp_PX_CAT_G1V2';
	BULK INSERT bronze.erp_PX_CAT_G1V2
	FROM 'C:\Users\My Rig\Downloads\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT '------------------------------';
	PRINT 'Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '------------------------------';
	SELECT COUNT(*) FROM bronze.erp_PX_CAT_G1V2 ;

PRINT '+++++++++++++++++++++++++++++++++++++++++++++++';
PRINT '============DATA LOADING COMPLETED=============';
PRINT '+++++++++++++++++++++++++++++++++++++++++++++++';

SET @batch_end_time = GETDATE();
PRINT '**************';
PRINT 'BATCH DURATION : ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
PRINT '**************';

END TRY

BEGIN CATCH
		PRINT '+++++++++++++++++++++++++++++++++++++++++++++++';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Number' + CAST(ERROR_MESSAGE() AS NVARCHAR);
		PRINT 'Error State' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '+++++++++++++++++++++++++++++++++++++++++++++++';
END CATCH
--+++++++++++++++++++++++++++++++++++++++++++++++
--============DATA LOADING COMPLETED=============
--+++++++++++++++++++++++++++++++++++++++++++++++
