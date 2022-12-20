CREATE PROCEDURE p_retreiveEventHubBatch (@startValue int, @endValue INT) AS 
;WITH bodyRows AS
(
select  
        bodyRow = 
        '{"Body":"'+
        '{\"medallion\":\"'+TRY_CAST(medallion AS VARCHAR(MAX))+'\",'+
        '\"hack_license\":\"'+TRY_CAST([ hack_license] AS VARCHAR(MAX))+'\",'+
        '\"vendor_id\":\"'+TRY_CAST([ vendor_id] AS VARCHAR(MAX))+'\",'+
        '\"pickup_datetime\":\"'+TRY_CAST([ pickup_datetime] AS VARCHAR(MAX))+'\",'+
        '\"payment_type\":\"'+TRY_CAST([ payment_type] AS VARCHAR(MAX))+'\",'+
        '\"fare_amount\":\"'+TRY_CAST([ fare_amount] AS VARCHAR(MAX))+'\",'+
        '\"surcharge\":\"'+TRY_CAST([ surcharge] AS VARCHAR(MAX))+'\",'+
        '\"mta_tax\":\"'+TRY_CAST([ mta_tax] AS VARCHAR(MAX))+'\",'+
        '\"tip_amount\":\"'+TRY_CAST([ tip_amount] AS VARCHAR(MAX))+'\",'+
        '\"tolls_amount\":\"'+TRY_CAST([ tolls_amount] AS VARCHAR(MAX))+'\",'+
        '\"total_amount\":\"'+TRY_CAST([ total_amount] AS VARCHAR(MAX))+'\"}'+
        '"}'
from fileinprocess
WHERE rowkey BETWEEN @startValue AND @endValue
)
SELECT Body='['+STRING_AGG(bodyRow,',')+']'
FROM bodyRows
