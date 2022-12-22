/* Make sure you're using the nyctaxi database*/
USE nyctaxi;
GO
/* Create getFiles Stored Procedure - This will be used to get all the file names in the path specified in the parameters*/
CREATE OR ALTER PROCEDURE p_getFiles (@storageAccountName VARCHAR(500),@fareDataPath VARCHAR(500)) as

DECLARE @dynamicSQL NVARCHAR(4000)

SET @dynamicSQL = 
'
SELECT DISTINCT result.filename() fileName
FROM
    OPENROWSET(
        BULK ''https://'+@storageAccountName+'.dfs.core.windows.net/'+@fareDataPath+''',
        FORMAT = ''CSV'',
        PARSER_VERSION = ''2.0'',
        HEADER_ROW = TRUE
    ) AS [result]
'
exec sp_executesql @dynamicSQL




