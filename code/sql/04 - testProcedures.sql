/* Make sure you're using the nyctaxi database*/
USE nyctaxi;
GO

/* Use this stored procedure to get the filenames of files residing in your raw path*/
exec p_getFiles @storageAccountName = '<storagaccountname>', @fareDataPath = '<containername>/raw/faredata/';

/* Copy one of the filenames from the p_getfiles results into the @fileName parameter below to test this procedure.*/
exec p_createExternalTable @storageAccountName = '<storagaccountname>', @fareDataPath = 's<containername>/raw/faredata/', @fileName = 'sample.csv';

/* This procedure does not require any parameters but it does require the p_createExternalTable procedure to have run at least once to 
successfully run*/
EXEC p_getBatches