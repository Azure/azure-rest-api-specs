## Swagger Changes

### Changes for `x-ms-code-generation-settings`

| Path | Change Type | Value |
|------|------------|-------|
| `info['x-ms-code-generation-settings__deleted']` | deleted | `{"name":"StorageSyncManagementClient"}` |

### Changes for `x-typespec-generated`

| Path | Change Type | Value |
|------|------------|-------|
| `info['x-typespec-generated__added']` | added | `[{"emitter":"@azure-tools/typespec-autorest"}]` |

### Changes for `deprecated`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/Microsoft.StorageSync/operations'].get.deprecated__deleted` | deleted | `false` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.StorageSync/storageSyncServices'].get.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/locations/{locationName}/workflows/{workflowId}/operations/{operationId}'].get.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}'].delete.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}'].delete.responses.202.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id"},"x-ms-reques...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}'].get.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}'].patch.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}'].patch.responses.202.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id"},"x-ms-reques...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}'].put.responses.202.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id"},"x-ms-reques...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/privateEndpointConnections'].get.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.202.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id"},"x-ms-reques...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.responses.202.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id"},"x-ms-reques...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/registeredServers'].get.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/registeredServers/{serverId}'].delete.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/registeredServers/{serverId}'].delete.responses.202.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/registeredServers/{serverId}'].get.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/registeredServers/{serverId}'].patch.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/registeredServers/{serverId}'].patch.responses.202.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/registeredServers/{serverId}'].put.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/registeredServers/{serverId}'].put.responses.202.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/registeredServers/{serverId}/triggerRollover'].post.responses.202.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups'].get.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}'].delete.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id"},"x-ms-reques...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}'].get.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}'].put.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints'].get.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}'].delete.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}'].delete.responses.202.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id"},"x-ms-reques...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}'].get.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}'].put.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}'].put.responses.202.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id"},"x-ms-reques...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}/afsShareMetadataCertificatePublicKeys'].get.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}/postbackup'].post.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}/postbackup'].post.responses.202.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}/postrestore'].post.responses.200.headers__added` | added | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}/postrestore'].post.responses.202.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}/prebackup'].post.responses.202.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}/prerestore'].post.responses.200.headers__added` | added | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}/prerestore'].post.responses.202.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}/triggerChangeDetection'].post.responses.200.headers__added` | added | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}/triggerChangeDetection'].post.responses.202.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/serverEndpoints'].get.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/serverEndpoints/{serverEndpointName}'].delete.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/serverEndpoints/{serverEndpointName}'].delete.responses.202.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/serverEndpoints/{serverEndpointName}'].get.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/serverEndpoints/{serverEndpointName}'].patch.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/serverEndpoints/{serverEndpointName}'].patch.responses.202.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/serverEndpoints/{serverEndpointName}'].put.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/serverEndpoints/{serverEndpointName}'].put.responses.202.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/serverEndpoints/{serverEndpointName}/recallAction'].post.responses.202.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/workflows'].get.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/workflows/{workflowId}'].get.responses.200.headers__deleted` | deleted | `{"x-ms-correlation-request-id":{"type":"string","description":"correlation request id."},"x-ms-reque...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationEntityListResult.required__added` | added | `["value"]` |
| `definitions.StorageSyncServiceCreateParameters.required__deleted` | deleted | `["location"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}'].patch.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/serverEndpoints/{serverEndpointName}'].patch.parameters[3].required__added` | added | `true` |

### Changes for `x-ms-pageable`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/privateEndpointConnections'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/registeredServers'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/serverEndpoints'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/workflows'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |

### Changes for `x-ms-long-running-operation`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}'].put['x-ms-long-running-operation__added']` | added | `true` |

### Changes for `202`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}'].put.responses.202__added` | added | `{"description":"ignore"}` |

### Changes for `OperationDisplayResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationDisplayResource__deleted` | deleted | `{"type":"object","properties":{"provider":{"type":"string"},"resource":{"type":"string"},"operation"...` |

### Changes for `PhysicalPath`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PhysicalPath__deleted` | deleted | `{"type":"string"}` |

### Changes for `ResourceId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ResourceId__deleted` | deleted | `{"type":"string"}` |

### Changes for `ResourcesMoveInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ResourcesMoveInfo__deleted` | deleted | `{"type":"object","properties":{"targetResourceGroup":{"type":"string"},"resources":{"type":"array","...` |

### Changes for `SubscriptionState`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SubscriptionState__deleted` | deleted | `{"type":"object","properties":{"state":{"type":"string","enum":["Registered","Unregistered","Warned"...` |

### Changes for `SubscriptionStateProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SubscriptionStateProperties__deleted` | deleted | `{"type":"object"}` |

### Changes for `SyncGroupCreateParametersProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SyncGroupCreateParametersProperties__deleted` | deleted | `{"type":"object","properties":{}}` |

### Changes for `TagsObject`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TagsObject__deleted` | deleted | `{"type":"object"}` |

### Changes for `OkResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OkResponse__added` | added | `{"type":"object"}` |

### Changes for `PrivateEndpointConnection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateEndpointConnection__added` | added | `{"type":"object","properties":{"properties":{"$ref":"../../../../../common-types/resource-management...` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServerEndpointCreateParametersProperties.properties.serverLocalPath.$ref__deleted` | deleted | `#/definitions/PhysicalPath` |
| `definitions.ServerEndpointCreateParametersProperties.properties.serverResourceId.$ref__deleted` | deleted | `#/definitions/ResourceId` |
| `definitions.ServerEndpointProperties.properties.serverLocalPath.$ref__deleted` | deleted | `#/definitions/PhysicalPath` |
| `definitions.ServerEndpointProperties.properties.serverResourceId.$ref__deleted` | deleted | `#/definitions/ResourceId` |
| `definitions.SyncGroupCreateParameters.properties.properties.$ref__deleted` | deleted | `#/definitions/SyncGroupCreateParametersProperties` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServerEndpointCreateParametersProperties.properties.serverLocalPath.type__added` | added | `string` |
| `definitions.ServerEndpointCreateParametersProperties.properties.serverResourceId.type__added` | added | `string` |
| `definitions.ServerEndpointProperties.properties.serverLocalPath.type__added` | added | `string` |
| `definitions.ServerEndpointProperties.properties.serverResourceId.type__added` | added | `string` |
| `definitions.SyncGroupCreateParameters.properties.properties.type__added` | added | `object` |

### Changes for `minimum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServerEndpointCreateParametersProperties.properties.volumeFreeSpacePercent.minimum__deleted` | deleted | `0` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServerEndpointCreateParametersProperties.properties.tierFilesOlderThanDays.default__deleted` | deleted | `0` |

### Changes for `nextlink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StorageSyncServiceArray.properties.nextlink__added` | added | `{"type":"string"}` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SyncGroupCreateParameters.properties.properties.additionalProperties__added` | added | `{}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.StorageSyncServiceProperties.properties.privateEndpointConnections.items.$ref` | `../../../../../common-types/resource-management/v5/privatelinks.json#/definitions/PrivateEndpointConnection` | `#/definitions/PrivateEndpointConnection` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.StorageSync/storageSyncServices'].get['x-ms-pageable'].nextLinkName` | `nextLink` | `nextlink` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices'].get['x-ms-pageable'].nextLinkName` | `nextLink` | `nextlink` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.responses.200.schema.$ref` | `../../../../../common-types/resource-management/v5/privatelinks.json#/definitions/PrivateEndpointConnection` | `#/definitions/PrivateEndpointConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[3].schema.$ref` | `../../../../../common-types/resource-management/v5/privatelinks.json#/definitions/PrivateEndpointConnection` | `#/definitions/PrivateEndpointConnection` |

