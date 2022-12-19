/* Make sure you're using the nyctaxi database*/
USE nyctaxi;
GO
/*Create a procedure to split the file in process into batches containing 3,250 rows.
  This is done to support the 1 MB max batch size in Event Hubs. 
*/
CREATE OR ALTER PROCEDURE p_getBatches AS 

DECLARE @maxRowKey INT = (SELECT MAX(ROWKEY) FROM fileinprocess)

;WITH baseQuery AS
(
SELECT  ISNULL(LAG(rowkey)OVER(order by rowkey)+1,1) startId
        ,rowkey endId
FROM fileinprocess
WHERE rowkey % 3250 = 0
),
maxBatch AS 
(
SELECT max(endId) maxBatchId
FROM baseQuery
)
SELECT *
FROM baseQuery
UNION ALL
SELECT maxBatchId+1 startId, @maxRowKey endId
FROM maxBatch
