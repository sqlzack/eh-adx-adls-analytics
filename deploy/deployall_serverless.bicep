param eventHubNamespaceName string
param synapseWorkspaceName string
param location string
param storageAccountName string
param storageAccountContainerName string
param sqlAdministratorLogin string
param synapseWorkspaceNameMRG string
param dataExplorerResourceName string

@secure()
param sqlAdministratorLoginPassword string


module m_eventHubDeploy 'modules/eventhub.bicep' = {
  name:'eventHubDeploy'
  params: {
    eventHubNamespaceName: eventHubNamespaceName
    location: location
  }
}

module m_adxStandaloneDeploy 'modules/adxStandalone.bicep' = {
  name:'adxDeploy'
  params: {
    dataExplorerResourceName: dataExplorerResourceName
    location: location
  }
}

module m_synapseDeploy 'modules/synapse_serverless.bicep' = {
  name: 'synapseDeploy'
  params: {
    synapseWorkspaceName: synapseWorkspaceName
    synapseWorkspaceNameMRG: synapseWorkspaceNameMRG
    storageAccountName: storageAccountName
    storageAccountContainerName: storageAccountContainerName
    sqlAdministratorLogin:sqlAdministratorLogin
    location: location
    sqlAdministratorLoginPassword:sqlAdministratorLoginPassword
  }
}
