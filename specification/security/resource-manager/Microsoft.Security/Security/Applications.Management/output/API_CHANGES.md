## Swagger Changes

### Changes for `schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/applications/{applicationId}'].delete.responses.default.schema__added` | added | `{"$ref":"#/definitions/CloudError"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/providers/microsoft.Security/applications/{applicationId}'].delete.responses.default.schema__added` | added | `{"$ref":"#/definitions/CloudError"}` |

### Changes for `ApplicationConditionSets`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationConditionSets__deleted` | deleted | `{"type":"object","description":"List of application's condition sets - OR between ConditionSets, AND...` |

### Changes for `ApplicationConditions`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationConditions__deleted` | deleted | `{"type":"array","description":"Application's conditions","items":{"$ref":"#/definitions/ApplicationC...` |

### Changes for `CloudError`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudError__added` | added | `{"type":"object","description":"Common error response for all Azure Resource Manager APIs to return ...` |

### Changes for `CloudErrorBody`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudErrorBody__added` | added | `{"type":"object","description":"The error detail.","properties":{"code":{"type":"string","descriptio...` |

### Changes for `ErrorAdditionalInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorAdditionalInfo__added` | added | `{"type":"object","description":"The resource management error additional info.","properties":{"type"...` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationProperties.properties.conditionSets.items.$ref__deleted` | deleted | `#/definitions/ApplicationConditionSets` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationProperties.properties.conditionSets.items.type__added` | added | `array` |

### Changes for `items`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationProperties.properties.conditionSets.items.items__added` | added | `{"$ref":"#/definitions/ApplicationCondition"}` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationsList.required__added` | added | `["value"]` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationsList.properties.value.readOnly__deleted` | deleted | `true` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.Application.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/applications'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/applications/{applicationId}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/applications/{applicationId}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/providers/microsoft.Security/applications'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/providers/microsoft.Security/applications/{applicationId}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/providers/microsoft.Security/applications/{applicationId}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |

