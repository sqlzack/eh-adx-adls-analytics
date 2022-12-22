/*!!!!!! THERE ARE DEPENDENCIES BETWEEN THE PROCEDURES SO RUN THESE STATEMENTS INDIVIDUALLY !!!!*/

/* Make sure you're using the nyctaxi database*/
USE nyctaxi;

/* Use this stored procedure to get the filenames of files residing in your raw path*/
exec p_getFiles @storageAccountName = '<storagaccountname>', @fareDataPath = '<containername>/raw/faredata/';

/* Copy one of the filenames from the p_getfiles results into the @fileName parameter below to test this procedure.*/
exec p_createExternalTable @storageAccountName = '<storagaccountname>', @fareDataPath = '<containername>/raw/faredata/', @fileName = '<filename.csv>';

/* This procedure does not require any parameters but it does require the p_createExternalTable procedure to have run at least once to 
successfully run*/
EXEC p_getBatches

/*You can use any startId and endId in the from the p_getBatches procedure in the below query*/
/*I hard-coded the normal first batch in*/
EXEC p_retreiveEventHubBatch @startValue =1, @endValue=3250