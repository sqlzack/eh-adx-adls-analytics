param eventHubNamespaceName string
param keyVaultName string
param synapseWorkspaceName string
param location string
param storageAccountName string
param storageAccountContainerName string
param sqlAdministratorLogin string
param synapseWorkspaceNameMRG string
param sparkPoolName string
param adxPoolName string
@secure()
param sqlAdministratorLoginPassword string


module m_eventHubDeploy 'modules/eventhub.bicep' = {
  name:'eventHubDeploy'
  params: {
    eventHubNamespaceName: eventHubNamespaceName
    location: location
  }
}

module m_keyVaultDeploy 'modules/keyvault.bicep' = {
  name: 'keyVaultDeploy'
  params: {
    keyVaultName: keyVaultName
    location: location
  }
}

module m_synapseDeploy 'modules/synapse.bicep' = {
  name: 'synapseDeploy'
  dependsOn:[
    m_keyVaultDeploy
  ]
  params: {
    keyVaultName: keyVaultName
    synapseWorkspaceName: synapseWorkspaceName
    synapseWorkspaceNameMRG: synapseWorkspaceNameMRG
    storageAccountName: storageAccountName
    storageAccountContainerName: storageAccountContainerName
    sparkPoolName: sparkPoolName
    sqlAdministratorLogin:sqlAdministratorLogin
    adxPoolName: adxPoolName
    location: location
    sqlAdministratorLoginPassword:sqlAdministratorLoginPassword
  }
}
