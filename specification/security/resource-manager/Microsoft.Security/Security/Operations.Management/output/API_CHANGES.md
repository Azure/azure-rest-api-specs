## Swagger Changes

### Changes for `definitions`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions__added` | added | `{}` |

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

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `paths['/providers/microsoft.Security/operations'].get.responses.200.schema.$ref` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/OperationListResult` | `../../../../../../../common-types/resource-management/v6/types.json#/definitions/OperationListResult` |
| `paths['/providers/microsoft.Security/operations'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationResults/{operationId}'].get.parameters[0].$ref` | `../../../../../../common-types/resource-management/v6/types.json#/parameters/LocationParameter` | `../../../../../../../common-types/resource-management/v6/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationResults/{operationId}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationStatuses/{operationId}'].get.parameters[0].$ref` | `../../../../../../common-types/resource-management/v6/types.json#/parameters/LocationParameter` | `../../../../../../../common-types/resource-management/v6/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationStatuses/{operationId}'].get.responses.200.schema.$ref` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/OperationStatusResult` | `../../../../../../../common-types/resource-management/v6/types.json#/definitions/OperationStatusResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{location}/operationStatuses/{operationId}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |

