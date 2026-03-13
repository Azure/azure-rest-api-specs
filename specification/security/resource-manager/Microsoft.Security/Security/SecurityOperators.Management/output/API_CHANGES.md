## Swagger Changes

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

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityOperator.properties.properties__added` | added | `{"type":"object","description":"The resource-specific properties for this resource."}` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityOperator.properties.identity.description__added` | added | `Identity for the resource.` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.SecurityOperator.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.SecurityOperator.properties.identity.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/Identity` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/Identity` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/pricings/{pricingName}/securityOperators'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/pricings/{pricingName}/securityOperators/{securityOperatorName}'].delete.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/pricings/{pricingName}/securityOperators/{securityOperatorName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/pricings/{pricingName}/securityOperators/{securityOperatorName}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |

