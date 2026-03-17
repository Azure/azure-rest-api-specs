## Changed Paths

Path: /providers/microsoft.Security/operations
Change Type: deleted

Path: /providers/securityCenter/operations
Change Type: added

## Swagger Changes

### Changes for `definitions`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions__added` | added | `{}` |

### Changes for `/providers/microsoft.Security/operations`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Security/operations__deleted']` | deleted | `{"get":{"operationId":"Operations_List","tags":["Operations"],"description":"Exposes all available o...` |

### Changes for `/providers/securityCenter/operations`

| Path | Change Type | Value |
|------|------------|-------|
| `paths./providers/securityCenter/operations__added` | added | `{"get":{"operationId":"Operations_List","tags":["Operations"],"description":"List the operations for...` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationResults/{operationId}'].get.tags__deleted` | deleted | `["OperationResults"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationStatuses/{operationId}'].get.tags__deleted` | deleted | `["OperationStatuses"]` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationResults/{operationId}'].get.parameters[1].$ref__deleted` | deleted | `../../../../../../common-types/resource-management/v6/types.json#/parameters/OperationIdParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationStatuses/{operationId}'].get.parameters[1].$ref__deleted` | deleted | `../../../../../../common-types/resource-management/v6/types.json#/parameters/OperationIdParameter` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationResults/{operationId}'].get.parameters[1].name__added` | added | `operationId` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationStatuses/{operationId}'].get.parameters[1].name__added` | added | `operationId` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationResults/{operationId}'].get.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationStatuses/{operationId}'].get.parameters[1].in__added` | added | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationResults/{operationId}'].get.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationStatuses/{operationId}'].get.parameters[1].required__added` | added | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationResults/{operationId}'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationStatuses/{operationId}'].get.parameters[1].type__added` | added | `string` |

### Changes for `minLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationResults/{operationId}'].get.parameters[1].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationStatuses/{operationId}'].get.parameters[1].minLength__added` | added | `1` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationResults/{operationId}'].get.responses.202.headers__deleted` | deleted | `{"Location":{"type":"string","description":"URL to query for status of the operation."}}` |

### Changes for `204`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationResults/{operationId}'].get.responses.204__deleted` | deleted | `{"description":"ignore"}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `info.description` | `API spec for Microsoft Defender for Cloud operation statuses.` | `API spec for Microsoft.Security (Azure Security Center) resource provider` |
| `info.title` | `Microsoft Defender for Cloud` | `SecurityCenter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationResults/{operationId}'].get.parameters[0].$ref` | `../../../../../../common-types/resource-management/v6/types.json#/parameters/LocationParameter` | `../../../../../../../common-types/resource-management/v6/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationResults/{operationId}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationStatuses/{operationId}'].get.parameters[0].$ref` | `../../../../../../common-types/resource-management/v6/types.json#/parameters/LocationParameter` | `../../../../../../../common-types/resource-management/v6/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationStatuses/{operationId}'].get.responses.200.schema.$ref` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/OperationStatusResult` | `../../../../../../../common-types/resource-management/v6/types.json#/definitions/OperationStatusResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationStatuses/{operationId}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |

