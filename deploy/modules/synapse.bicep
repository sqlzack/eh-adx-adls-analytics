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

resource r_sparkPool 'Microsoft.Synapse/workspaces/bigDataPools@2021-06-01' = {
  name: sparkPoolName
  location: location
  parent: r_synapseWorkspace
  properties: {
    autoPause: {
      delayInMinutes: 30
      enabled: true
    }
    autoScale: {
      enabled: false
    }
    cacheSize: 0
    dynamicExecutorAllocation: {
      enabled: false
    }
    nodeCount: 3
    nodeSize: 'Small'
    nodeSizeFamily: 'MemoryOptimized'
    sparkVersion: '3.2'
  }
}

resource r_adxPool 'Microsoft.Synapse/workspaces/kustoPools@2021-06-01-preview' = {
  name: adxPoolName
  location: location
  sku: {
    capacity: 2
    name: 'Compute optimized'
    size: 'Extra small'
  }
  parent: r_synapseWorkspace
  properties: {
    enablePurge: false
    enableStreamingIngest: false
    optimizedAutoscale: {
      isEnabled: false
      maximum: 1
      minimum: 1
      version: 1
    }
    workspaceUID:r_synapseWorkspace.properties.workspaceUID
  }
}

resource r_keyVault 'Microsoft.KeyVault/vaults@2022-07-01' existing = {
  name: keyVaultName
}

resource akvSynapseAP 'Microsoft.KeyVault/vaults/accessPolicies@2022-07-01' = {
  name: 'add'
  parent: r_keyVault
  properties: {
    accessPolicies: [
      {
        objectId: r_synapseWorkspace.identity.principalId
        permissions: {
          secrets: [
            'get'
            'list'
          ]
        }
        tenantId: subscription().tenantId
      }
    ]
  }
}

resource r_adxDatabase 'Microsoft.Synapse/workspaces/kustoPools/databases@2021-06-01-preview' = {
  name: 'nyctaxi'
  location: location
  kind: 'ReadWrite'
  parent: r_adxPool
}
