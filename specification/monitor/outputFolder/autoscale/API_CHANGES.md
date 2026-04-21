## Swagger Changes

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `info.description__added` | added | `Monitor Management Client` |

### Changes for `Resource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Resource__deleted` | deleted | `{"type":"object","description":"The autoscale setting resource.","properties":{"id":{"type":"string"...` |

### Changes for `AutoscaleErrorResponseError`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AutoscaleErrorResponseError__added` | added | `{"type":"object","description":"The error object.","properties":{"code":{"type":"string","descriptio...` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AutoscaleErrorResponse.properties.error.type__deleted` | deleted | `object` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AutoscaleErrorResponse.properties.error.properties__deleted` | deleted | `{"code":{"type":"string","description":"One of a server-defined set of error codes."},"message":{"ty...` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AutoscaleErrorResponse.properties.error.$ref__added` | added | `#/definitions/AutoscaleErrorResponseError` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AutoscaleErrorResponse.properties.systemData.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/systemData` |
| `definitions.AutoscaleSettingResource.allOf[0].$ref` | `#/definitions/Resource` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |

