## Swagger Changes

### Changes for `x-typespec-generated`

| Path | Change Type | Value |
|------|------------|-------|
| `info['x-typespec-generated__added']` | added | `[{"emitter":"@azure-tools/typespec-autorest"}]` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/checkNameAvailability'].post.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/usages'].get.parameters[0].name__deleted` | deleted | `location` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/checkNameAvailability'].post.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/usages'].get.parameters[0].in__deleted` | deleted | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CustomCertificateList.required__added` | added | `["value"]` |
| `definitions.CustomDomainList.required__added` | added | `["value"]` |
| `definitions.OperationList.required__added` | added | `["value"]` |
| `definitions.PrivateEndpointConnectionList.required__added` | added | `["value"]` |
| `definitions.PrivateLinkResourceList.required__added` | added | `["value"]` |
| `definitions.ReplicaList.required__added` | added | `["value"]` |
| `definitions.SharedPrivateLinkResourceList.required__added` | added | `["value"]` |
| `definitions.SignalRServiceUsageList.required__added` | added | `["value"]` |
| `definitions.WebPubSubHubList.required__added` | added | `["value"]` |
| `definitions.WebPubSubResourceList.required__added` | added | `["value"]` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/checkNameAvailability'].post.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/usages'].get.parameters[0].required__deleted` | deleted | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/checkNameAvailability'].post.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/usages'].get.parameters[0].type__deleted` | deleted | `string` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/checkNameAvailability'].post.parameters[0].$ref__added` | added | `../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/usages'].get.parameters[0].$ref__added` | added | `../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |

### Changes for `consumes`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/customCertificates/{certificateName}'].put.consumes__deleted` | deleted | `["application/json","text/json"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/customDomains/{name}'].put.consumes__deleted` | deleted | `["application/json","text/json"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/replicas/{replicaName}'].patch.consumes__deleted` | deleted | `["application/json","text/json"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/replicas/{replicaName}'].put.consumes__deleted` | deleted | `["application/json","text/json"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].put.consumes__deleted` | deleted | `["application/json","text/json"]` |

### Changes for `schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/regenerateKey'].post.responses.202.schema__deleted` | deleted | `{"$ref":"#/definitions/WebPubSubKeys"}` |

### Changes for `x-ms-long-running-operation-options`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/replicas/{replicaName}'].patch['x-ms-long-running-operation-options__added']` | added | `{"final-state-via":"azure-async-operation"}` |

### Changes for `minLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources'].get.parameters[0].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources'].get.parameters[1].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].get.parameters[0].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].get.parameters[1].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].get.parameters[2].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].put.parameters[0].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].put.parameters[1].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].put.parameters[2].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/sharedPrivateLinkResources'].get.parameters[0].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].delete.parameters[1].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].get.parameters[1].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].put.parameters[1].minLength__deleted` | deleted | `3` |

### Changes for `maxLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources'].get.parameters[0].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources'].get.parameters[1].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].get.parameters[0].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].get.parameters[1].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].get.parameters[2].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].put.parameters[0].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].put.parameters[1].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].put.parameters[2].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/sharedPrivateLinkResources'].get.parameters[0].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].delete.parameters[1].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].get.parameters[1].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].put.parameters[1].maxLength__deleted` | deleted | `63` |

### Changes for `TypeSpec.Http.NoContentResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['TypeSpec.Http.NoContentResponse__added']` | added | `{"type":"object"}` |

### Changes for `x-ms-client-flatten`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation.properties.properties['x-ms-client-flatten__deleted']` | deleted | `false` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebPubSubKeys.properties.primaryConnectionString.format__added` | added | `password` |
| `definitions.WebPubSubKeys.properties.primaryKey.format__added` | added | `password` |
| `definitions.WebPubSubKeys.properties.secondaryConnectionString.format__added` | added | `password` |
| `definitions.WebPubSubKeys.properties.secondaryKey.format__added` | added | `password` |

