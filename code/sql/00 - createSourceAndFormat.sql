/* Make sure you're using the nyctaxi database*/
USE nyctaxi
GO
/*Create file format for external tables.*/
IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'filefmt_Parquet') 
CREATE EXTERNAL FILE FORMAT filefmt_Parquet WITH ( FORMAT_TYPE = PARQUET);
GO
/*Create external table location on storage account*/
/*!!!!REPLACE <storageaccountname> and <containername> below with your actual storage and container names!!!!*/
/*To find Storage Account Name, open the Azure Data Lake Linked Service. Examine the url and take the portion between "https://" and "dfs"*/
/*Container is whatever you defined in deployment. In my examples I used synapse*/
IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'src_externalTables') 
CREATE EXTERNAL DATA SOURCE src_externalTables
WITH (LOCATION   = 'https://<storageaccountname>.dfs.core.windows.net/<containername>/externalTables');
