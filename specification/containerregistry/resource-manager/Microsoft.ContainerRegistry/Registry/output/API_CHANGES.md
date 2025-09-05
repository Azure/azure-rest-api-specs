## Swagger Changes

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `info.description__added` | added | `The Microsoft Azure Container Registry management API provides create, read, update, and delete functionality for Azure Container Registry resources including registries, replications, webhooks, tasks, runs, and other registry components.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}'].patch.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}'].put.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/cacheRules/{cacheRuleName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/cacheRules/{cacheRuleName}'].patch.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/cacheRules/{cacheRuleName}'].put.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/connectedRegistries/{connectedRegistryName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/connectedRegistries/{connectedRegistryName}'].patch.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/connectedRegistries/{connectedRegistryName}'].put.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/connectedRegistries/{connectedRegistryName}/deactivate'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/credentialSets/{credentialSetName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/credentialSets/{credentialSetName}'].patch.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/credentialSets/{credentialSetName}'].put.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/exportPipelines/{exportPipelineName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/exportPipelines/{exportPipelineName}'].put.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/generateCredentials'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/importImage'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/importPipelines/{importPipelineName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/importPipelines/{importPipelineName}'].put.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/packages/{packageType}/archives/{archiveName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/packages/{packageType}/archives/{archiveName}'].put.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/packages/{packageType}/archives/{archiveName}/versions/{archiveVersionName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/packages/{packageType}/archives/{archiveName}/versions/{archiveVersionName}'].put.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/pipelineRuns/{pipelineRunName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/pipelineRuns/{pipelineRunName}'].put.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/replications/{replicationName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/replications/{replicationName}'].patch.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/replications/{replicationName}'].put.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/scopeMaps/{scopeMapName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/scopeMaps/{scopeMapName}'].patch.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/scopeMaps/{scopeMapName}'].put.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/tokens/{tokenName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/tokens/{tokenName}'].patch.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/tokens/{tokenName}'].put.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/webhooks/{webhookName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/webhooks/{webhookName}'].patch.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/webhooks/{webhookName}'].put.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.QuarantinePolicy.properties.status.default__deleted` | deleted | `disabled` |
| `definitions.RegistryNameCheckRequest.properties.autoGeneratedDomainNameLabelScope.default__deleted` | deleted | `Unsecure` |
| `definitions.RegistryProperties.properties.adminUserEnabled.default__deleted` | deleted | `false` |
| `definitions.RegistryProperties.properties.anonymousPullEnabled.default__deleted` | deleted | `false` |
| `definitions.RegistryProperties.properties.autoGeneratedDomainNameLabelScope.default__deleted` | deleted | `Unsecure` |
| `definitions.RegistryProperties.properties.metadataSearch.default__deleted` | deleted | `Disabled` |
| `definitions.RegistryProperties.properties.networkRuleBypassAllowedForTasks.default__deleted` | deleted | `false` |
| `definitions.RegistryProperties.properties.networkRuleBypassOptions.default__deleted` | deleted | `AzureServices` |
| `definitions.RegistryProperties.properties.publicNetworkAccess.default__deleted` | deleted | `Enabled` |
| `definitions.RegistryProperties.properties.roleAssignmentMode.default__deleted` | deleted | `LegacyRegistryPermissions` |
| `definitions.RegistryProperties.properties.zoneRedundancy.default__deleted` | deleted | `Disabled` |
| `definitions.RegistryPropertiesUpdateParameters.properties.metadataSearch.default__deleted` | deleted | `Disabled` |
| `definitions.RegistryPropertiesUpdateParameters.properties.networkRuleBypassOptions.default__deleted` | deleted | `AzureServices` |
| `definitions.ReplicationProperties.properties.zoneRedundancy.default__deleted` | deleted | `Disabled` |
| `definitions.RetentionPolicy.properties.status.default__deleted` | deleted | `disabled` |
| `definitions.SoftDeletePolicy.properties.status.default__deleted` | deleted | `disabled` |
| `definitions.TrustPolicy.properties.status.default__deleted` | deleted | `disabled` |
| `paths['/providers/microsoft.ContainerRegistry/operations'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ContainerRegistry/checkNameAvailability'].post.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ContainerRegistry/registries'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}'].delete.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}'].patch.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}'].put.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/importImage'].post.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/listCredentials'].post.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/listUsages'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/privateEndpointConnections'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/privateLinkResources'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/regenerateCredential'].post.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/replications'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/replications/{replicationName}'].delete.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/replications/{replicationName}'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/replications/{replicationName}'].patch.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/replications/{replicationName}'].put.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/webhooks'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/webhooks/{webhookName}'].delete.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/webhooks/{webhookName}'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/webhooks/{webhookName}'].patch.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/webhooks/{webhookName}'].put.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/webhooks/{webhookName}/getCallbackConfig'].post.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/webhooks/{webhookName}/listEvents'].post.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/webhooks/{webhookName}/ping'].post.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v6/type...` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Registry` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Registry` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/cacheRules/{cacheRuleName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/CacheRule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/cacheRules/{cacheRuleName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/CacheRule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/connectedRegistries/{connectedRegistryName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ConnectedRegistry` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/connectedRegistries/{connectedRegistryName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ConnectedRegistry` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/credentialSets/{credentialSetName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/CredentialSet` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/credentialSets/{credentialSetName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/CredentialSet` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/exportPipelines/{exportPipelineName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ExportPipeline` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/importPipelines/{importPipelineName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ImportPipeline` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/packages/{packageType}/archives/{archiveName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Archive` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/packages/{packageType}/archives/{archiveName}/versions/{archiveVersionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ArchiveVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/pipelineRuns/{pipelineRunName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/PipelineRun` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/privateEndpointConnections/{privateEndpointConnectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/PrivateEndpointConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/replications/{replicationName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Replication` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/replications/{replicationName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Replication` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/scopeMaps/{scopeMapName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ScopeMap` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/scopeMaps/{scopeMapName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ScopeMap` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/tokens/{tokenName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Token` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/tokens/{tokenName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Token` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/webhooks/{webhookName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Webhook` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerRegistry/registries/{registryName}/webhooks/{webhookName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Webhook` |

### Changes for `ActiveDirectoryObject`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActiveDirectoryObject__deleted` | deleted | `{"type":"object","properties":{"objectId":{"type":"string"},"tenantId":{"type":"string"}}}` |

### Changes for `OperationDefinition`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationDefinition__deleted` | deleted | `{"type":"object","properties":{"origin":{"type":"string"},"name":{"type":"string"},"display":{"$ref"...` |

### Changes for `OperationDisplayDefinition`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationDisplayDefinition__deleted` | deleted | `{"type":"object","properties":{"provider":{"type":"string"},"resource":{"type":"string"},"operation"...` |

### Changes for `OperationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `OperationLogSpecificationDefinition`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationLogSpecificationDefinition__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"displayName":{"type":"string"},"blobDuratio...` |

### Changes for `OperationMetricSpecificationDefinition`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationMetricSpecificationDefinition__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"displayName":{"type":"string"},"displayDesc...` |

### Changes for `OperationPropertiesDefinition`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationPropertiesDefinition__deleted` | deleted | `{"type":"object","properties":{"serviceSpecification":{"$ref":"#/definitions/OperationServiceSpecifi...` |

### Changes for `OperationServiceSpecificationDefinition`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationServiceSpecificationDefinition__deleted` | deleted | `{"type":"object","properties":{"metricSpecifications":{"type":"array","items":{"$ref":"#/definitions...` |

### Changes for `PackageType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PackageType__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"endpoint":{"type":"string","readOnly":true}...` |

### Changes for `ProxyResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ProxyResource__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string","readOnly":true},"name":{"type":"string","readO...` |

### Changes for `Resource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Resource__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string","readOnly":true},"name":{"type":"string","readO...` |

### Changes for `StorageAccountProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StorageAccountProperties__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string"}},"required":["id"]}` |

### Changes for `SystemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SystemData__deleted` | deleted | `{"type":"object","properties":{"createdBy":{"type":"string"},"createdByType":{"type":"string","enum"...` |

### Changes for `TypeSpec.Http.OkResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['TypeSpec.Http.OkResponse__added']` | added | `{"type":"object"}` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateLinkResource.allOf__added` | added | `[{"$ref":"../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResourc...` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateLinkResource.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateLinkResource.properties.id__deleted` | deleted | `{"type":"string"}` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateLinkResource.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.RegistryNameCheckRequest.properties.type['x-ms-enum'].name__deleted` | deleted | `ContainerRegistryResourceType` |

### Changes for `x-ms-secret`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebhookPropertiesCreateParameters.properties.customHeaders['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.WebhookPropertiesCreateParameters.properties.serviceUri['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.WebhookPropertiesUpdateParameters.properties.customHeaders['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.WebhookPropertiesUpdateParameters.properties.serviceUri['x-ms-secret__deleted']` | deleted | `true` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.Archive.allOf[0].$ref` | `#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.ArchiveVersion.allOf[0].$ref` | `#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.CacheRule.allOf[0].$ref` | `#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.ConnectedRegistry.allOf[0].$ref` | `#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.CredentialSet.allOf[0].$ref` | `#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.ExportPipeline.allOf[0].$ref` | `#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.ImportPipeline.allOf[0].$ref` | `#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.PipelineRun.allOf[0].$ref` | `#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.PrivateEndpointConnection.allOf[0].$ref` | `#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.Registry.allOf[0].$ref` | `#/definitions/Resource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/TrackedResource` |
| `definitions.Replication.allOf[0].$ref` | `#/definitions/Resource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/TrackedResource` |
| `definitions.ScopeMap.allOf[0].$ref` | `#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.Token.allOf[0].$ref` | `#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.Webhook.allOf[0].$ref` | `#/definitions/Resource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/TrackedResource` |
| `paths['/providers/microsoft.ContainerRegistry/operations'].get.responses.200.schema.$ref` | `#/definitions/OperationListResult` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/OperationListResult` |

