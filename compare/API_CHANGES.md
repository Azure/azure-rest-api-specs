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

### Changes for `Azure.Core.uuid`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.Core.uuid__added']` | added | `{"type":"string","format":"uuid"}` |

### Changes for `modelAsExtensible`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UserAssignedIdentityProperties.properties.isolationScope['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `paths['/{scope}/providers/Microsoft.ManagedIdentity/identities/default'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/Microsoft.ManagedIdentity/identities/default'].get['x-ms-examples'].MsiOperationsList.$ref` | `./examples/SystemAssignedIdentityGet.json` | `./examples/SystemAssignedIdentities_GetByScope.json` |
| `paths['/providers/Microsoft.ManagedIdentity/operations'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.ManagedIdentity/userAssignedIdentities'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.ManagedIdentity/userAssignedIdentities'].get['x-ms-examples'].IdentityListBySubscription.$ref` | `./examples/IdentityListBySubscription.json` | `./examples/UserAssignedIdentities_ListBySubscription.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities'].get['x-ms-examples'].IdentityListByResourceGroup.$ref` | `./examples/IdentityListByResourceGroup.json` | `./examples/UserAssignedIdentities_ListByResourceGroup.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].delete['x-ms-examples'].IdentityDelete.$ref` | `./examples/IdentityDelete.json` | `./examples/UserAssignedIdentities_Delete.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].get['x-ms-examples'].IdentityGet.$ref` | `./examples/IdentityGet.json` | `./examples/UserAssignedIdentities_Get.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].patch.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].patch['x-ms-examples'].IdentityUpdate.$ref` | `./examples/IdentityUpdate.json` | `./examples/UserAssignedIdentities_Update.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].put['x-ms-examples'].IdentityCreate.$ref` | `./examples/IdentityCreate.json` | `./examples/UserAssignedIdentities_CreateOrUpdate.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials'].get['x-ms-examples'].FederatedIdentityCredentialList.$ref` | `./examples/FederatedIdentityCredentialList.json` | `./examples/FederatedIdentityCredentials_List.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials/{federatedIdentityCredentialResourceName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials/{federatedIdentityCredentialResourceName}'].delete['x-ms-examples'].FederatedIdentityCredentialDelete.$ref` | `./examples/FederatedIdentityCredentialDelete.json` | `./examples/FederatedIdentityCredentials_Delete.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials/{federatedIdentityCredentialResourceName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials/{federatedIdentityCredentialResourceName}'].get['x-ms-examples'].FederatedIdentityCredentialGet.$ref` | `./examples/FederatedIdentityCredentialGet.json` | `./examples/FederatedIdentityCredentials_Get.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials/{federatedIdentityCredentialResourceName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials/{federatedIdentityCredentialResourceName}'].put['x-ms-examples'].FederatedIdentityCredentialCreate.$ref` | `./examples/FederatedIdentityCredentialCreate.json` | `./examples/FederatedIdentityCredentials_CreateOrUpdate.json` |

