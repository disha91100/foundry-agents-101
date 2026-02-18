@description('Principal ID to assign the role to')
param principalId string

@description('Principal type')
param principalType string = 'ServicePrincipal'

@description('Resource ID of the Foundry account')
param foundryId string

// Cognitive Services User
var cognitiveServicesUserRoleId = 'a97b65f3-24c7-4388-baec-2e87135dc908'

resource foundry 'Microsoft.CognitiveServices/accounts@2025-04-01-preview' existing = {
  name: last(split(foundryId, '/'))
}

resource cognitiveServicesUserRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(foundryId, principalId, cognitiveServicesUserRoleId)
  scope: foundry
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', cognitiveServicesUserRoleId)
    principalId: principalId
    principalType: principalType
  }
}
