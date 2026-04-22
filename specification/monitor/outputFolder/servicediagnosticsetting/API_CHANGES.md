## Swagger Changes

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `info.description__added` | added | `Monitor Management Client` |

### Changes for `examples`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceUri}/providers/microsoft.insights/diagnosticSettings/service'].get.responses.200.examples__deleted` | deleted | `{"application/json":{"id":"/subscriptions/1a66ce04-b633-4a0b-b2bc-a912ec8986a6/resourcegroups/viruel...` |
| `paths['/{resourceUri}/providers/microsoft.insights/diagnosticSettings/service'].put.responses.200.examples__deleted` | deleted | `{"application/json":{"id":"/subscriptions/1a66ce04-b633-4a0b-b2bc-a912ec8986a6/resourcegroups/viruel...` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceUri}/providers/microsoft.insights/diagnosticSettings/service'].put.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"#/definitions/Microsoft.Common.ErrorResponse"}}` |

### Changes for `ErrorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorResponse__deleted` | deleted | `{"type":"object","description":"Describes the format of Error response.","properties":{"code":{"type...` |

### Changes for `Resource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Resource__deleted` | deleted | `{"type":"object","description":"An azure resource object","properties":{"id":{"type":"string","descr...` |

### Changes for `RetentionPolicy`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RetentionPolicy__deleted` | deleted | `{"type":"object","description":"Specifies the retention policy for the log.","properties":{"enabled"...` |

### Changes for `Microsoft.Common.ErrorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Microsoft.Common.ErrorResponse__added']` | added | `{"type":"object","description":"Describes the format of Error response.","properties":{"code":{"type...` |

### Changes for `Microsoft.Common.RetentionPolicy`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Microsoft.Common.RetentionPolicy__added']` | added | `{"type":"object","description":"Specifies the retention policy for the log.","properties":{"enabled"...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceDiagnosticSettingsResource.required__added` | added | `["location"]` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceDiagnosticSettingsResource.properties.location__added` | added | `{"type":"string","description":"Resource location","x-ms-mutability":["create","read"]}` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceDiagnosticSettingsResource.properties.tags__added` | added | `{"type":"object","description":"Resource tags","additionalProperties":{"type":"string"}}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.LogSettings.properties.retentionPolicy.$ref` | `#/definitions/RetentionPolicy` | `#/definitions/Microsoft.Common.RetentionPolicy` |
| `definitions.MetricSettings.properties.retentionPolicy.$ref` | `#/definitions/RetentionPolicy` | `#/definitions/Microsoft.Common.RetentionPolicy` |
| `definitions.ServiceDiagnosticSettingsResource.allOf[0].$ref` | `#/definitions/Resource` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `paths['/{resourceUri}/providers/microsoft.insights/diagnosticSettings/service'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/Microsoft.Common.ErrorResponse` |
| `paths['/{resourceUri}/providers/microsoft.insights/diagnosticSettings/service'].patch.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/Microsoft.Common.ErrorResponse` |

