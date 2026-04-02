## Changed Paths

Path: /{denyAssignmentId}
Change Type: deleted

Path: /{scope}/providers/microsoft.Authorization/denyAssignments
Change Type: deleted

Path: /{scope}/providers/microsoft.Authorization/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/{resourceProviderNamespace}/{parentResourcePath}/{resourceType}/{resourceName}/denyAssignments
Change Type: added

Path: /subscriptions/{subscriptionId}/providers/microsoft.Authorization/denyAssignments
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{parentResourcePath}/{resourceType}/{resourceName}/providers/microsoft.Authorization/denyAssignments
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Authorization/denyAssignments
Change Type: deleted

## Swagger Changes

### Changes for `/{denyAssignmentId}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths./{denyAssignmentId}__deleted` | deleted | `{"get":{"operationId":"DenyAssignments_GetById","tags":["DenyAssignments"],"description":"Gets a den...` |

### Changes for `/{scope}/providers/microsoft.Authorization/denyAssignments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Authorization/denyAssignments__deleted']` | deleted | `{"get":{"operationId":"DenyAssignments_ListForScope","tags":["DenyAssignments"],"description":"Gets ...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Authorization/denyAssignments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/denyAssignments__deleted']` | deleted | `{"get":{"operationId":"DenyAssignments_List","tags":["DenyAssignments"],"description":"Gets all deny...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{parentResourcePath}/{resourceType}/{resourceName}/providers/microsoft.Authorization/denyAssignments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{parentResourcePath}/{resourceType}/{resourceName}/providers/microsoft.Authorization/denyAssignments__deleted']` | deleted | `{"get":{"operationId":"DenyAssignments_ListForResource","tags":["DenyAssignments"],"description":"Ge...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Authorization/denyAssignments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Authorization/denyAssignments__deleted']` | deleted | `{"get":{"operationId":"DenyAssignments_ListForResourceGroup","tags":["DenyAssignments"],"description...` |

### Changes for `/{scope}/providers/microsoft.Authorization/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/{resourceProviderNamespace}/{parentResourcePath}/{resourceType}/{resourceName}/denyAssignments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Authorization/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/{resourceProviderNamespace}/{parentResourcePath}/{resourceType}/{resourceName}/denyAssignments__added']` | added | `{"get":{"operationId":"DenyAssignments_ListForResource","tags":["DenyAssignments"],"description":"Ge...` |

### Changes for `DenyAssignmentFilter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DenyAssignmentFilter__deleted` | deleted | `{"type":"object","description":"Deny Assignments filter","properties":{"denyAssignmentName":{"type":...` |

### Changes for `DenyAssignmentPrincipalType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DenyAssignmentPrincipalType__added` | added | `{"type":"string","x-nullable":false}` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DenyAssignment.allOf__added` | added | `[{"$ref":"../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"}]` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DenyAssignment.properties.id__deleted` | deleted | `{"type":"string","description":"The deny assignment ID.","readOnly":true}` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DenyAssignment.properties.name__deleted` | deleted | `{"type":"string","description":"The deny assignment name.","readOnly":true}` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DenyAssignment.properties.type__deleted` | deleted | `{"type":"string","description":"The deny assignment type.","readOnly":true}` |

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DenyAssignment.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v6/types.json#/definitions/systemData","...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DenyAssignmentListResult.required__added` | added | `["value"]` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DenyAssignmentPrincipal.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"DenyAssignmentPrincipalType","modelAsString":true}` |

### Changes for `x-nullable`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DenyAssignmentPrincipal.properties.type['x-nullable__added']` | added | `false` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `paths['/{scope}/providers/microsoft.Authorization/denyAssignments/{denyAssignmentId}'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/denyAssignments/{denyAssignmentId}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/denyAssignments/{denyAssignmentId}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |

