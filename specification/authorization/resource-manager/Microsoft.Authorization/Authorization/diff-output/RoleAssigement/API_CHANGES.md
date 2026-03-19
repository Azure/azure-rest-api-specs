## Changed Paths

Path: /{scope}/providers/microsoft.Authorization/roleAssignments
Change Type: deleted

Path: /{scope}/providers/microsoft.Authorization/subscriptions/{subscriptionId}/roleAssignments
Change Type: added

Path: /subscriptions/{subscriptionId}/providers/microsoft.Authorization/roleAssignments
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}/providers/microsoft.Authorization/roleAssignments
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Authorization/roleAssignments
Change Type: deleted

## Swagger Changes

### Changes for `/{scope}/providers/microsoft.Authorization/roleAssignments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Authorization/roleAssignments__deleted']` | deleted | `{"get":{"operationId":"RoleAssignments_ListForScope","tags":["RoleAssignments"],"description":"List ...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Authorization/roleAssignments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/roleAssignments__deleted']` | deleted | `{"get":{"operationId":"RoleAssignments_ListForSubscription","tags":["RoleAssignments"],"description"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}/providers/microsoft.Authorization/roleAssignments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}/providers/microsoft.Authorization/roleAssignments__deleted']` | deleted | `{"get":{"operationId":"RoleAssignments_ListForResource","tags":["RoleAssignments"],"description":"Li...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Authorization/roleAssignments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Authorization/roleAssignments__deleted']` | deleted | `{"get":{"operationId":"RoleAssignments_ListForResourceGroup","tags":["RoleAssignments"],"description...` |

### Changes for `/{scope}/providers/microsoft.Authorization/subscriptions/{subscriptionId}/roleAssignments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Authorization/subscriptions/{subscriptionId}/roleAssignments__added']` | added | `{"get":{"operationId":"RoleAssignments_ListForSubscription","tags":["RoleAssignments"],"description"...` |

### Changes for `RoleAssignmentFilter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoleAssignmentFilter__deleted` | deleted | `{"type":"object","description":"Role Assignments filter","properties":{"principalId":{"type":"string...` |

### Changes for `ValidationResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ValidationResponse__deleted` | deleted | `{"type":"object","description":"Validation response","properties":{"isValid":{"type":"boolean","desc...` |

### Changes for `ValidationResponseErrorInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ValidationResponseErrorInfo__deleted` | deleted | `{"type":"object","description":"Failed validation result details","properties":{"code":{"type":"stri...` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoleAssignment.allOf__added` | added | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}]` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoleAssignment.properties.id__deleted` | deleted | `{"type":"string","description":"The role assignment ID.","readOnly":true}` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoleAssignment.properties.name__deleted` | deleted | `{"type":"string","description":"The role assignment name.","readOnly":true}` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoleAssignment.properties.type__deleted` | deleted | `{"type":"string","description":"The role assignment type.","readOnly":true}` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoleAssignmentListResult.required__added` | added | `["value"]` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `paths['/{scope}/providers/microsoft.Authorization/roleAssignments/{roleAssignmentName}'].delete.parameters[1].name` | `roleAssignmentName` | `scope` |
| `paths['/{scope}/providers/microsoft.Authorization/roleAssignments/{roleAssignmentName}'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/roleAssignments/{roleAssignmentName}'].get.parameters[1].name` | `roleAssignmentName` | `scope` |
| `paths['/{scope}/providers/microsoft.Authorization/roleAssignments/{roleAssignmentName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/roleAssignments/{roleAssignmentName}'].put.parameters[1].name` | `roleAssignmentName` | `scope` |
| `paths['/{scope}/providers/microsoft.Authorization/roleAssignments/{roleAssignmentName}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |

