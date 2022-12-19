/* Make sure you're using the nyctaxi database*/
USE nyctaxi;
GO
/* Create fileInProcess Stored Procedure*/
/* This procedure will create an External Table from the CSV file that is currently being processed.*/
/* The advantages of doing this are that we physically a row number so it doesn't have to be calculated each time and 
we from CSV to Parquet format which should improve read speeds */
CREATE OR ALTER PROCEDURE p_createExternalTable (@storageAccountName VARCHAR(500),@fareDataPath VARCHAR(500),@fileName VARCHAR(500)) AS

DECLARE @DateTimeStamp varchar(50)= (SELECT CONVERT(VARCHAR, GETDATE(), 112)+'_'+REPLACE(CONVERT(VARCHAR,GETDATE(),108),':',''))

DECLARE @dynamicSQL NVARCHAR(4000)

SET @dynamicSQL = 
'
IF EXISTS (SELECT * FROM sys.external_tables where name = ''fileinprocess'')
BEGIN
    DROP EXTERNAL TABLE fileinprocess
END

CREATE EXTERNAL TABLE fileInProcess 
WITH 
(
LOCATION = ''fileInProcess/'+@DateTimeStamp+'/'',
DATA_SOURCE = src_externalTables,
FILE_FORMAT  = filefmt_Parquet
)
AS
SELECT row_number()OVER(order by [ pickup_datetime],[ hack_license],MEDALLION ) rowkey,*
FROM
    OPENROWSET(
        BULK ''https://'+@storageAccountName+'.dfs.core.windows.net/'+@fareDataPath+''',
        FORMAT = ''CSV'',
        PARSER_VERSION = ''2.0'',
        HEADER_ROW = TRUE
    ) AS [result]
WHERE result.filename() = '''+@fileName+'''
'
exec sp_executesql @dynamicSQL