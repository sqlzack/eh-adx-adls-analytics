1. Launch the cloud shell in Azure Portal or Windows Terminal.
2. Run the command below

    ```git clone "https://github.com/Azure/azure-synapse-analytics-end2end.git"```

3. Change directory to the folder you just cloned in step 2 by running below command.

    ```cd ./azure-synapse-analytics-end2end/Deploy/```
    
4. Create a resource group to house the new resources you'll be creating.

    ```az group create --name dev-streaming-adx --location eastus2```

5. 