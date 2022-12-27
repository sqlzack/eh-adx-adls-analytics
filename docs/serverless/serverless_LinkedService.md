## Set up Serverless SQL Database and Linked Service

### Summary
This prepares your Synapse Serverless SQL Database to be used as a a source in Synapse Pipelines. 

### Set up Serverless SQL Database and Linked Service
1) Open Synapse Studio and Create a Serverless SQL Database.
   
   ![](../../images/serverless/serverlessIngest00.png)

2) Select Serverless for SQL pool type, name the database nyctaxi, and click Create.
3) Examine the Synapse SQL Pool to collect some details.
    
    ![](../../images/serverless/serverlessIngest01.png)

4) In the Serverless Pool Details copy the Serverless endpoint to a notepad for later use.
    
    ![](../../images/serverless/serverlessIngest02.png)

5) Set up a new Linked Service.
    
    ![](../../images/python/addLinkedService.png)

6) Search for Azure Synapse Analytics and click Continue.
7) Name the service ls_ServerlessSQL and fill in the rest of the fields as they are below. Make sure to copy the endpoint address copied in step 4 to the Fully qualified domain name field. Test the connection and save if successful.
    
    ![](../../images/serverless/serverlessIngest03.png)

8) Publish your Linked Service in preparation for next steps.
    
    ![](../../images/python/addLinkedService03.png)