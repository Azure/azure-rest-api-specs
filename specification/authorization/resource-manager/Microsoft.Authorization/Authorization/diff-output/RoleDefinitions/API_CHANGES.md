## Swagger Changes

### Changes for `x-ms-odata`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Authorization/roleDefinitions'].get['x-ms-odata__deleted']` | deleted | `#/definitions/RoleDefinitionFilter` |

### Changes for `RoleDefinitionFilter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoleDefinitionFilter__deleted` | deleted | `{"type":"object","description":"Role Definitions filter","properties":{"roleName":{"type":"string","...` |

### Changes for `Permission`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Permission__added` | added | `{"type":"object","description":"Role definition permissions.","properties":{"actions":{"type":"array...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PermissionGetResult.required__added` | added | `["value"]` |
| `definitions.RoleDefinitionListResult.required__added` | added | `["value"]` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoleDefinition.allOf__added` | added | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}]` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoleDefinition.properties.id__deleted` | deleted | `{"type":"string","description":"The role definition ID.","readOnly":true}` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoleDefinition.properties.name__deleted` | deleted | `{"type":"string","description":"The role definition name.","readOnly":true}` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoleDefinition.properties.type__deleted` | deleted | `{"type":"string","description":"The role definition type.","readOnly":true}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.PermissionGetResult.properties.value.items.$ref` | `./common-types.json#/definitions/Permission` | `#/definitions/Permission` |
| `definitions.RoleDefinitionProperties.properties.permissions.items.$ref` | `./common-types.json#/definitions/Permission` | `#/definitions/Permission` |
| `paths['/{scope}/providers/microsoft.Authorization/roleDefinitions'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/roleDefinitions/{roleDefinitionId}'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/roleDefinitions/{roleDefinitionId}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/roleDefinitions/{roleDefinitionId}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{parentResourcePath}/{resourceType}/{resourceName}/providers/microsoft.Authorization/permissions'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Authorization/permissions'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |

