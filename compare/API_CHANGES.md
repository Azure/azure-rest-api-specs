## Swagger Changes

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
| `paths['/{scope}/providers/microsoft.ManagedIdentity/identities/default'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.ManagedIdentity/operations'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ManagedIdentity/userAssignedIdentities'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ManagedIdentity/userAssignedIdentities'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].patch.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials/{federatedIdentityCredentialResourceName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials/{federatedIdentityCredentialResourceName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials/{federatedIdentityCredentialResourceName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |

