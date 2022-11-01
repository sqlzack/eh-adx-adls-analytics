param synapseWorkspaceName string
param location string
param storageAccountName string
param storageAccountContainerName string
param sqlAdministratorLogin string
param synapseWorkspaceNameMRG string
@secure()
param sqlAdministratorLoginPassword string

var dataLakeStorageAccountUrl = 'https://${storageAccountName}.dfs.core.windows.net'

resource r_StorageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    isHnsEnabled: true
    supportsHttpsTrafficOnly: true
  }
}

resource r_StorageAccountBlobSvc 'Microsoft.Storage/storageAccounts/blobServices@2022-05-01' = {
  name: 'default'
  parent: r_StorageAccount
}

resource r_StorageAccountContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
  name: storageAccountContainerName
  parent: r_StorageAccountBlobSvc
  }

resource r_synapseWorkspace 'Microsoft.Synapse/workspaces@2021-06-01' = {
  name: synapseWorkspaceName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    defaultDataLakeStorage: {
      accountUrl: dataLakeStorageAccountUrl
      filesystem: storageAccountContainerName
    }
    managedResourceGroupName: synapseWorkspaceNameMRG
    publicNetworkAccess: 'Enabled'
    sqlAdministratorLogin: sqlAdministratorLogin
    sqlAdministratorLoginPassword: sqlAdministratorLoginPassword
  }
}

resource r_synapseWorkspaceFirewallAllowAll 'Microsoft.Synapse/workspaces/firewallRules@2021-06-01' = {
  name: 'AllowAllNetworks'
  parent: r_synapseWorkspace
  properties:{
    startIpAddress: '0.0.0.0'
    endIpAddress: '255.255.255.255'
  }
}
