# Azure Synapse Data Explorer - Simple Lamda Architecture

## Summary
This project is meant to demonstrate how Azure Data Explorer (ADX) can be used to continuously ingest a Azure Event Hubs stream to a raw table, a cleaned table, and finally to partitioned Parquet files on Azure Data Lake Storage. The idea behind this concept is this will give you a hot path in the ADX clean table and a cool path (and archive!) in the partitioned Parquet files.

## Simplified Architecture
![picture of base architecture](./images/architecture.png)
### Component Overview
1) __Azure Data Lake Gen 2 (Source)__ - Uploading the NYC Taxi Fare Source CSVs to the Azure Data Lake enables the Python event generator the ability to easily mount the storage to read the CSV and create the events. 
2) __Spark Pool__ - There were two motivations to use a Spark pool to illustrate this use case. First, it is easy to deploy as part of a Synapse Deployment. Second, it can run vanilla Python code which allows us to simulate event generation. __In this example, the Spark pool is not used to perform normal Spark workloads.__ You could move the Python code used in the notebook to another deployment mechanism (Azure App Services, Functions, Kubernetes, VM etc) and get the same result. Ideally, you would use proper Spark AFTER the data has been procesed into partitioned Parquet files.
3) __Azure Event Hubs__ - Event Hubs is used to integrate the NYC Taxi Fare data stream into other big data services. __In a production scenario, this would be the origin of your data.__
4) __Azure Data Explorer__ - ADX provides both hot and cool path processing of the Event Hubs streaming data used in this example. To ease deployment, the Synapse ADX Pool is used. __Synapse ADX is still in Public Preview. If you need more flexibility in VM SKUs or more fulsome features use the standalone Azure Data Explorer Service.__
5) __Azure Data Lake Gen 2 (Destination)__ - This is where the partitioned Parquet files will land via the External Table and Continuous Export features in Azure Data Explorer.

## Pre-requisites 
1) A sandbox Azure Resource Group where the deploying user has Contributor access. [More Info Here](https://learn.microsoft.com/en-us/azure/role-based-access-control/overview#role-assignments)
2) The necessary Resource Providers for Synapse, Event Hubs, Key Vault, and Storage Accounts. [More Info Here](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-providers-and-types)
3) Access to a means to deploy Bicep scripts. [Visual Studio Code](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-vscode) works well to iteratively work through the needed parameters in the event of a a deployment failure. [CLI](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-cli), [Powershell](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-powershell), and [Azure Cloud Shell](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-cloud-shell?tabs=azure-cli) are other options.


## Steps to Create
1) [Clone the repository you're currently viewing into Visual Studio Code](https://learn.microsoft.com/en-us/azure/developer/javascript/how-to/with-visual-studio-code/clone-github-repository?tabs=create-repo-command-palette%2Cinitialize-repo-activity-bar%2Ccreate-branch-command-palette%2Ccommit-changes-command-palette%2Cpush-command-palette)
2) [Deploy resources to Resource Group](./docs/deploy.md)
3) Grant permissions to allow services to work together.
   1) [Synapse Linked Service to Key Vault](./docs/linkedServices.md)
   2) [Add Event Hub Connection String to Key Vault](./docs/eventHubConnStringKV.md)
   3) [Give Synapse permission to Storage Account](./docs/storageAccountPermission.md)
4) [Set up and test Python Event Sender](./docs/eventSender.md)
5) [Set up and test Data Explorer ingestion.](./docs/adxIngest.md)
6) [Set up and test Data Explorer continuous partitioned export.](./docs/adxExport.md)