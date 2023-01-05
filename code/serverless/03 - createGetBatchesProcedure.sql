/* Make sure you're using the nyctaxi database*/
USE nyctaxi;
GO
/*Create a procedure to split the file in process into batches containing 3,250 rows.
  This is done to support the 1 MB max batch size in Event Hubs. 
*/
CREATE OR ALTER PROCEDURE p_getBatches AS 

DECLARE @endRowKey      INT, 
        @startRowKey    INT

SELECT   @endRowKey     = MAX(rowkey)
        ,@startRowKey   = MAX(IIF(rowkey % 3250 = 1, rowkey, 0))
FROM fileInProcess

SELECT  startId    = rowkey - 3249
        ,endId      = rowkey
FROM fileInProcess
WHERE rowkey % 3250 = 0
UNION ALL
SELECT @startRowKey, rowkey
FROM fileInProcess
WHERE rowkey = @endRowKey
  AND rowkey % 3250 <> 0