## Add Event Hub Connection String to Key Vault
### Summary
Use VS Code to deploy resources to sandbox Resource Group.

### Steps
#### __Add Notebook__
1) Open Synapse Studio through the Azure Portal
2) Go to the Develop Tab and click the "+" button to add a new artifact. Choose the Import option from this menu.
![](../images/eventSender01.png)
3) When the file browser opens, choose the [nb_pythonEventSend.ipynb](../code/notebook/nb_pythonEventSend.ipynb) file contained in this repository. 
4) Your notebook should be available in the Develop tab now.

#### __Add Pipeline__
1) In Synapse Studio go to the Integrate tab and click the "+" button. Choose the Import option from this menu.
![](../images/eventSender02.png)
2) When the file browser opens, choose the [pl_eventSend.zip](../code/pipeline/pl_eventSend.zip) file contained in this repository.
3) Click the Open Pipeline button to add it into the workspace
4) In the open pipeline, select the notebook activity in the design canvas and navigate to the settings menu. Set the settings as shown below and click the Validate button
![](../images/eventSender03.png)
   
#### __Publish Artifacts__
1) Now that you've added a pipeline and a notebook to your workspace click the "Publish All" button to persist them to your workspace. (The number of changes you're publishing will likely say 2...not 4)
![](../images/eventSender04.png)
2) Ensure your publish has succeeded by checking your notifications in the upper right corner of the screen.
![](../images/eventSender05.png)

#### Upload Sample Data
1) Go to the Data tab in Synapse Studios and Select the Linked storage for your workspace Storage Account. Open the Synapse Container.
![](../images/eventSender06.png)
2) In the file browser click the button to add a new folder called "raw". Go into to that directory and create a subfolder called "faredata".
![](../images/eventSender07.png)
1) Navigate to the "faredata" folder you just created and click the Upload button and upload the [sample.csv](../data/sample.csv) file from this repo,
