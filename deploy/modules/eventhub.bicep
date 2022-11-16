param eventHubNamespaceName string
param location string

resource r_eventHubNamespace 'Microsoft.EventHub/namespaces@2022-01-01-preview' = {
  name: eventHubNamespaceName
  location: location
  sku: {
    capacity: 1
    name: 'Standard'
    tier: 'Standard'
  }
  identity: {
    type: 'SystemAssigned'
  }
}

resource r_eventHub 'Microsoft.EventHub/namespaces/eventhubs@2022-01-01-preview' = {
  name: 'taxi-fare-eh'
  parent: r_eventHubNamespace
  properties: {
    messageRetentionInDays: 3
    partitionCount: 8
  }
}

resource r_EventHubAP 'Microsoft.EventHub/namespaces/eventhubs/authorizationRules@2022-01-01-preview' = {
  name: 'taxi-fare-eh-ap'
  parent: r_eventHub
  properties: {
    rights: [
      'Send'
      'Listen'
    ]
  }
}

resource r_EventHubCG_ADX 'Microsoft.EventHub/namespaces/eventhubs/consumergroups@2022-01-01-preview' = {
  name: 'taxi-fare-eh-cg-adx'
  parent: r_eventHub
  properties: {
    userMetadata: 'string'
  }
}
