## Ingest data into Azure Data Explorer
### Summary
This walkthrough is to demonstrate how to set up ingestion into an Azure Data Explorer database and table from Azure Event Hubs.

### Steps
#### __Set up Ingestion__
1) Go to the Azure Data Explorer resource in the Azure Portal and follow the steps below. Alternatively you can manually add your cluster at [https://dataexplorer.azure.com/](https://dataexplorer.azure.com/) but following the path below simplifies this step.

    ![](../../images/kusto/adxIngestStandalone01.png)

2) In the Azure Data Explorer studio, right click the nyctaxi database and select "Ingest Data"
3) On the "Destination" tab on the Ingest wizard your Cluster and Database will already be selected. Choose to ingest to a new table called faredata_raw
4) Fill out the source screen by following the screenshot below. The Event System Properties selected are x-opt-enqueued-time and x-opt-offset.

    ![](../../images/kusto/adxIngest03.png)

5) Fill out the schema screen by following the screenshot below and move to the next screen. ___Note: If Sample Data cannot be found for this screen, simply re-run the pipeline you created in [the previous step](./eventSender.md)___ 

    ![](../../images/kusto/adxIngest04.png)

6) Ensure all is well by reviewing the results. If you get an error here follow the directions on [this page](./adxIngestError.md) to resolve.

    ![](../../images/kusto/adxIngest05.png)

7) Go to the Data Explorer Pool resource in the Azure Portal and open the nyctaxi database.

    ![](../../images/kusto/adxIngestStandalone02.png)

8) Then go to Data connections, choose nyc-taxi-fare-eh, and use the System-Assinged value in the Assign managed identity option. Click update and wait for notification verifying update succeeded. This will allow Data Explorer to read events from Event Hub in the event of a key rotation.

    ![](../../images/kusto/adxIngestStandalone03.png)

#### __Test Ingestion__
1) Re-run the pl_eventsend pipeline set up in this step. An easy way to do this with the same parameters is to rerun from the Monitor Tab in Synapse Studio.
   
    ![](../../images/kusto/adxIngest08.png)

2) Once the pipeline has completed, Check that there's data in your faredata_raw table by going to the Query tab in [https://dataexplorer.azure.com](https://dataexplorer.azure.com/) and getting a count of rows. The count of rows in the sample file is 7031.

    ![](../../images/kusto/adxIngestStandalone04.png)

3) Additionally, you can run the below KQL query to preview the data

    ```
    ['faredata_raw']
    | take 100
    ```

