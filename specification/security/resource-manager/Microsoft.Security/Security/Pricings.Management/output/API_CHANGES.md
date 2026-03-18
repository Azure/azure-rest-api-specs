## Swagger Changes

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scopeId}/providers/microsoft.Security/pricings'].get.parameters[0].$ref__deleted` | deleted | `./common/v1/types.json#/parameters/ScopeId` |
| `paths['/{scopeId}/providers/microsoft.Security/pricings'].get.parameters[1].$ref__deleted` | deleted | `./common/v1/types.json#/parameters/ODataFilter` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scopeId}/providers/microsoft.Security/pricings'].get.parameters[0].name__added` | added | `scopeId` |
| `paths['/{scopeId}/providers/microsoft.Security/pricings'].get.parameters[1].name__added` | added | `$filter` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scopeId}/providers/microsoft.Security/pricings'].get.parameters[0].in__added` | added | `path` |
| `paths['/{scopeId}/providers/microsoft.Security/pricings'].get.parameters[1].in__added` | added | `query` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scopeId}/providers/microsoft.Security/pricings'].get.parameters[0].required__added` | added | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Extension.properties.operationStatus.type__deleted` | deleted | `object` |
| `paths['/{scopeId}/providers/microsoft.Security/pricings'].get.parameters[0].type__added` | added | `string` |
| `paths['/{scopeId}/providers/microsoft.Security/pricings'].get.parameters[1].type__added` | added | `string` |

### Changes for `x-ms-skip-url-encoding`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scopeId}/providers/microsoft.Security/pricings'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |

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

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.Pricing.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `paths['/{scopeId}/providers/microsoft.Security/pricings'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{scopeId}/providers/microsoft.Security/pricings/{pricingName}'].delete.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{scopeId}/providers/microsoft.Security/pricings/{pricingName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{scopeId}/providers/microsoft.Security/pricings/{pricingName}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |

