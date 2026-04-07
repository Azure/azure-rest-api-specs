## Swagger Changes

### Changes for `contact`

| Path | Change Type | Value |
|------|------------|-------|
| `info.contact__deleted` | deleted | `{"name":"Microsoft Defender for Cloud Support","url":"https://docs.microsoft.com/azure/defender-for-...` |

### Changes for `x-ms-parameter-grouping`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}'].delete.parameters[0]['x-ms-parameter-grouping__deleted']` | deleted | `{"name":"private-link-parameters"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}'].get.parameters[0]['x-ms-parameter-grouping__deleted']` | deleted | `{"name":"private-link-parameters"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}'].head.parameters[0]['x-ms-parameter-grouping__deleted']` | deleted | `{"name":"private-link-parameters"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}'].patch.parameters[0]['x-ms-parameter-grouping__deleted']` | deleted | `{"name":"private-link-parameters"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}'].put.parameters[0]['x-ms-parameter-grouping__deleted']` | deleted | `{"name":"private-link-parameters"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateEndpointConnections'].get.parameters[0]['x-ms-parameter-grouping__deleted']` | deleted | `{"name":"private-link-parameters"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[0]['x-ms-parameter-grouping__deleted']` | deleted | `{"name":"private-link-parameters"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0]['x-ms-parameter-grouping__deleted']` | deleted | `{"name":"private-link-parameters"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0]['x-ms-parameter-grouping__deleted']` | deleted | `{"name":"private-link-parameters"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateLinkResources'].get.parameters[0]['x-ms-parameter-grouping__deleted']` | deleted | `{"name":"private-link-parameters"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateLinkResources/{groupId}'].get.parameters[0]['x-ms-parameter-grouping__deleted']` | deleted | `{"name":"private-link-parameters"}` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/PrivateLinkResource` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateEndpointConnections/{privateEndpointConnectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `../../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateEndpointConnection` |

### Changes for `Location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}'].delete.responses.202.headers.Location__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.202.headers.Location__deleted` | deleted | `{"type":"string"}` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}'].head.tags__added` | added | `["PrivateLinkResources"]` |

### Changes for `200`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}'].head.responses.200__deleted` | deleted | `{"description":"ignore"}` |

### Changes for `204`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}'].head.responses.204__added` | added | `{"description":"ignore"}` |

### Changes for `404`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}'].head.responses.404__added` | added | `{"description":"ignore"}` |

### Changes for `PrivateEndpointConnectionListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateEndpointConnectionListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `PrivateLinkResourceAutoGenerated`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateLinkResourceAutoGenerated__added` | added | `{"type":"object","description":"A private link resource.","properties":{"properties":{"$ref":"../../...` |

### Changes for `PrivateLinkResourceAutoGeneratedListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateLinkResourceAutoGeneratedListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.PrivateLinkProperties.properties.privateEndpointConnections.items.$ref` | `../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateEndpointConnection` | `../../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateEndpointConnection` |
| `definitions.PrivateLinkProperties.properties.privateLinkResources.items.$ref` | `../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateLinkResource` | `#/definitions/PrivateLinkResourceAutoGenerated` |
| `definitions.PrivateLinkResource.allOf[0].$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/TrackedResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/TrackedResource` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/privateLinks'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `URL to query for status of the operation.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}'].delete.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}'].head.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}'].patch.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}'].put.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateEndpointConnections'].get.responses.200.schema.$ref` | `../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateEndpointConnectionListResult` | `#/definitions/PrivateEndpointConnectionListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateEndpointConnections'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].$ref` | `../../../../../common-types/resource-management/v6/privatelinks.json#/parameters/PrivateEndpointConnectionName` | `../../../../../../common-types/resource-management/v6/privatelinks.json#/parameters/PrivateEndpointConnectionName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `URL to query for status of the operation.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].$ref` | `../../../../../common-types/resource-management/v6/privatelinks.json#/parameters/PrivateEndpointConnectionName` | `../../../../../../common-types/resource-management/v6/privatelinks.json#/parameters/PrivateEndpointConnectionName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.responses.200.schema.$ref` | `../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateEndpointConnection` | `../../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateEndpointConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[1].$ref` | `../../../../../common-types/resource-management/v6/privatelinks.json#/parameters/PrivateEndpointConnectionName` | `../../../../../../common-types/resource-management/v6/privatelinks.json#/parameters/PrivateEndpointConnectionName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[2].schema.$ref` | `../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateEndpointConnection` | `../../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateEndpointConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.responses.200.schema.$ref` | `../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateEndpointConnection` | `../../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateEndpointConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.responses.201.schema.$ref` | `../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateEndpointConnection` | `../../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateEndpointConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateLinkResources'].get.responses.200.schema.$ref` | `../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateLinkResourceListResult` | `#/definitions/PrivateLinkResourceAutoGeneratedListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateLinkResources'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateLinkResources/{groupId}'].get.responses.200.schema.$ref` | `../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateLinkResource` | `#/definitions/PrivateLinkResourceAutoGenerated` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/privateLinks/{privateLinkName}/privateLinkResources/{groupId}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |

