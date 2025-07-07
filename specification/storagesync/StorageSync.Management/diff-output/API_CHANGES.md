## Swagger Changes

### Changes for `x-ms-code-generation-settings`

| Path | Change Type | Value |
|------|------------|-------|
| `info['x-ms-code-generation-settings__deleted']` | deleted | `{"name":"StorageSyncManagementClient"}` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationEntityListResult.required__added` | added | `["value"]` |
| `definitions.StorageSyncServiceCreateParameters.required__deleted` | deleted | `["location"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}'].patch.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/serverEndpoints/{serverEndpointName}'].patch.parameters[3].required__added` | added | `true` |

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

### Changes for `PrivateEndpointConnection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateEndpointConnection__added` | added | `{"type":"object","properties":{"properties":{"$ref":"../../../../../common-types/resource-management...` |

### Changes for `PrivateEndpointConnectionListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateEndpointConnectionListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudEndpointArray.description__added` | added | `[Placeholder] Discription for page model` |
| `definitions.CloudEndpointArray.properties.value.description__added` | added | `[Placeholder] Discription for value property` |
| `definitions.RegisteredServerArray.description__added` | added | `[Placeholder] Discription for page model` |
| `definitions.RegisteredServerArray.properties.value.description__added` | added | `[Placeholder] Discription for value property` |
| `definitions.ServerEndpointArray.description__added` | added | `[Placeholder] Discription for page model` |
| `definitions.ServerEndpointArray.properties.value.description__added` | added | `[Placeholder] Discription for value property` |
| `definitions.StorageSyncServiceArray.description__added` | added | `[Placeholder] Discription for page model` |
| `definitions.StorageSyncServiceArray.properties.value.description__added` | added | `[Placeholder] Discription for value property` |
| `definitions.SyncGroupArray.description__added` | added | `[Placeholder] Discription for page model` |
| `definitions.SyncGroupArray.properties.value.description__added` | added | `[Placeholder] Discription for value property` |
| `definitions.WorkflowArray.description__added` | added | `[Placeholder] Discription for page model` |
| `definitions.WorkflowArray.properties.value.description__added` | added | `[Placeholder] Discription for value property` |

### Changes for `nextLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudEndpointArray.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |
| `definitions.RegisteredServerArray.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |
| `definitions.ServerEndpointArray.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |
| `definitions.StorageSyncServiceArray.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |
| `definitions.SyncGroupArray.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |
| `definitions.WorkflowArray.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SyncGroupCreateParameters.properties.properties.$ref__deleted` | deleted | `#/definitions/SyncGroupCreateParametersProperties` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SyncGroupCreateParameters.properties.properties.type__added` | added | `object` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SyncGroupCreateParameters.properties.properties.additionalProperties__added` | added | `{}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.StorageSyncServiceProperties.properties.privateEndpointConnections.items.$ref` | `../../../../../common-types/resource-management/v5/privatelinks.json#/definitions/PrivateEndpointConnection` | `#/definitions/PrivateEndpointConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/privateEndpointConnections'].get.responses.200.schema.$ref` | `../../../../../common-types/resource-management/v5/privatelinks.json#/definitions/PrivateEndpointConnectionListResult` | `#/definitions/PrivateEndpointConnectionListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.responses.200.schema.$ref` | `../../../../../common-types/resource-management/v5/privatelinks.json#/definitions/PrivateEndpointConnection` | `#/definitions/PrivateEndpointConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[3].schema.$ref` | `../../../../../common-types/resource-management/v5/privatelinks.json#/definitions/PrivateEndpointConnection` | `#/definitions/PrivateEndpointConnection` |

