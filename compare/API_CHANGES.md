## Swagger Changes

### Changes for `x-ms-examples`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/Microsoft.ManagedIdentity/operations'].get['x-ms-examples__deleted']` | deleted | `{"MsiOperationsList":{"$ref":"./examples/MsiOperationsList.json"}}` |

### Changes for `CloudError`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudError__deleted` | deleted | `{"type":"object","properties":{"error":{"$ref":"#/definitions/CloudErrorBody"}},"x-ms-external":true...` |

### Changes for `CloudErrorBody`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudErrorBody__deleted` | deleted | `{"type":"object","properties":{"code":{"type":"string"},"message":{"type":"string"},"target":{"type"...` |

### Changes for `Operation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation__deleted` | deleted | `{"type":"object","title":"Microsoft.ManagedIdentity Operation.","properties":{"name":{"type":"string...` |

### Changes for `OperationDisplay`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationDisplay__deleted` | deleted | `{"type":"object","title":"Operation Display.","properties":{"provider":{"type":"string","title":"Res...` |

### Changes for `OperationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationListResult__deleted` | deleted | `{"type":"object","title":"Operations List.","description":"[Placeholder] Discription for page model"...` |

### Changes for `OperationList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationList__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `Resource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Resource__added` | added | `{"type":"object","properties":{"id":{"type":"string","format":"arm-id","readOnly":true},"name":{"typ...` |

### Changes for `title`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FederatedIdentityCredentialProperties.title__deleted` | deleted | `Federated identity credential properties.` |
| `definitions.SystemAssignedIdentityProperties.title__deleted` | deleted | `System Assigned Identity properties.` |
| `definitions.UserAssignedIdentityProperties.title__deleted` | deleted | `User Assigned Identity properties.` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FederatedIdentityCredentialsListResult.required__added` | added | `["value"]` |
| `definitions.SystemAssignedIdentity.required__deleted` | deleted | `["location"]` |
| `definitions.UserAssignedIdentitiesListResult.required__added` | added | `["value"]` |

### Changes for `x-ms-identifiers`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FederatedIdentityCredentialsListResult.properties.value['x-ms-identifiers__deleted']` | deleted | `["id"]` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Identity.properties.properties.readOnly__deleted` | deleted | `true` |
| `definitions.SystemAssignedIdentity.properties.properties.readOnly__deleted` | deleted | `true` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SystemAssignedIdentity.properties.location__deleted` | deleted | `{"type":"string","x-ms-mutability":["create","read"]}` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SystemAssignedIdentity.properties.tags__deleted` | deleted | `{"type":"object","additionalProperties":{"type":"string"},"x-ms-mutability":["create","read","update...` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SystemAssignedIdentityProperties.properties.clientId.format__deleted` | deleted | `uuid` |
| `definitions.SystemAssignedIdentityProperties.properties.principalId.format__deleted` | deleted | `uuid` |
| `definitions.SystemAssignedIdentityProperties.properties.tenantId.format__deleted` | deleted | `uuid` |
| `definitions.UserAssignedIdentityProperties.properties.clientId.format__deleted` | deleted | `uuid` |
| `definitions.UserAssignedIdentityProperties.properties.principalId.format__deleted` | deleted | `uuid` |
| `definitions.UserAssignedIdentityProperties.properties.tenantId.format__deleted` | deleted | `uuid` |

### Changes for `modelAsExtensible`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UserAssignedIdentityProperties.properties.isolationScope['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.IdentityUpdate.allOf[0].$ref` | `../../../../../common-types/resource-management/v4/types.json#/definitions/Resource` | `#/definitions/Resource` |
| `paths['/{scope}/providers/Microsoft.ManagedIdentity/identities/default'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/Microsoft.ManagedIdentity/identities/default'].get['x-ms-examples'].MsiOperationsList.$ref` | `./examples/SystemAssignedIdentityGet.json` | `./examples/SystemAssignedIdentities_GetByScope.json` |
| `paths['/providers/Microsoft.ManagedIdentity/operations'].get.responses.200.schema.$ref` | `#/definitions/OperationListResult` | `#/definitions/OperationList` |
| `paths['/providers/Microsoft.ManagedIdentity/operations'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.ManagedIdentity/userAssignedIdentities'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.ManagedIdentity/userAssignedIdentities'].get['x-ms-examples'].IdentityListBySubscription.$ref` | `./examples/IdentityListBySubscription.json` | `./examples/UserAssignedIdentities_ListBySubscription.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities'].get['x-ms-examples'].IdentityListByResourceGroup.$ref` | `./examples/IdentityListByResourceGroup.json` | `./examples/UserAssignedIdentities_ListByResourceGroup.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].delete['x-ms-examples'].IdentityDelete.$ref` | `./examples/IdentityDelete.json` | `./examples/UserAssignedIdentities_Delete.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].get['x-ms-examples'].IdentityGet.$ref` | `./examples/IdentityGet.json` | `./examples/UserAssignedIdentities_Get.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].patch.parameters[1].name` | `parameters` | `properties` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].patch.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].patch['x-ms-examples'].IdentityUpdate.$ref` | `./examples/IdentityUpdate.json` | `./examples/UserAssignedIdentities_Update.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].put.parameters[1].name` | `parameters` | `resource` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].put['x-ms-examples'].IdentityCreate.$ref` | `./examples/IdentityCreate.json` | `./examples/UserAssignedIdentities_CreateOrUpdate.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials'].get['x-ms-examples'].FederatedIdentityCredentialList.$ref` | `./examples/FederatedIdentityCredentialList.json` | `./examples/FederatedIdentityCredentials_List.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials/{federatedIdentityCredentialResourceName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials/{federatedIdentityCredentialResourceName}'].delete['x-ms-examples'].FederatedIdentityCredentialDelete.$ref` | `./examples/FederatedIdentityCredentialDelete.json` | `./examples/FederatedIdentityCredentials_Delete.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials/{federatedIdentityCredentialResourceName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials/{federatedIdentityCredentialResourceName}'].get['x-ms-examples'].FederatedIdentityCredentialGet.$ref` | `./examples/FederatedIdentityCredentialGet.json` | `./examples/FederatedIdentityCredentials_Get.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials/{federatedIdentityCredentialResourceName}'].put.parameters[2].name` | `parameters` | `resource` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials/{federatedIdentityCredentialResourceName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials/{federatedIdentityCredentialResourceName}'].put['x-ms-examples'].FederatedIdentityCredentialCreate.$ref` | `./examples/FederatedIdentityCredentialCreate.json` | `./examples/FederatedIdentityCredentials_CreateOrUpdate.json` |

