## Steps to Create Serverless Deployment Option
1) [Clone the repository you're currently viewing into Visual Studio Code](https://learn.microsoft.com/en-us/azure/developer/javascript/how-to/with-visual-studio-code/clone-github-repository?tabs=create-repo-command-palette%2Cinitialize-repo-activity-bar%2Ccreate-branch-command-palette%2Ccommit-changes-command-palette%2Cpush-command-palette)
2) Deploy resources to Resource Group
3) Grant permissions to allow services to work together.
   1) [Give Synapse permission to Storage Account](./docs/../serverless_storageAccountPerm.md)
4) [Set up and test Serverless Event Sender](../serverless/eventSender_Serverless.md)
5) [Set up and test Data Explorer ingestion.](../kusto/adxIngest.md)
6) [Set up and test Data Explorer continuous partitioned export.](../kusto/adxExport.md)