

``` yaml
library-name: StorageMover
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/9c7b8d71061df7e308f1776d558fc56f4a6247a2/specification/storagemover/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

rename-mapping:
  Agent: StorageMoverAgent
  Endpoint: StorageMoverEndpoint
  Project: StorageMoverProject
  AgentPropertiesErrorDetails: StorageMoverAgentPropertiesErrorDetails
  AgentStatus: StorageMoverAgentStatus
  CopyMode: StorageMoverCopyMode
  ProvisioningState: StorageMoverProvisioningState
  Credentials : StorageMoverCredentials
  JobDefinition.properties.agentResourceId: -|arm-id
  JobDefinition.properties.latestJobRunResourceId: -|arm-id
  JobDefinition.properties.targetResourceId: -|arm-id
  JobDefinition.properties.sourceResourceId: -|arm-id
  JobRun.properties.agentResourceId: -|arm-id
  JobRun.properties.sourceResourceId: -|arm-id
  JobRun.properties.targetResourceId: -|arm-id
  JobRunResourceId.jobRunResourceId: -|arm-id
  AzureStorageBlobContainerEndpointProperties.storageAccountResourceId: -|string

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uris': 'Uri'

```
