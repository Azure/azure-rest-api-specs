## Swagger Changes

### Changes for `x-ms-code-generation-settings`

| Path | Change Type | Value |
|------|------------|-------|
| `info['x-ms-code-generation-settings__deleted']` | deleted | `{"name":"MonitorManagementClient"}` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `info.description__added` | added | `Monitor Management Client` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/logprofiles'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"#/definitions/Microsoft.Common.ErrorResponse"}}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/logprofiles/{logProfileName}'].delete.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"#/definitions/Microsoft.Common.ErrorResponse"}}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/logprofiles/{logProfileName}'].put.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"#/definitions/Microsoft.Common.ErrorResponse"}}` |

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

### Changes for `nextLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogProfileCollection.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.LogProfileCollection.description` | `Represents a collection of log profiles.` | `[Placeholder] Discription for page model` |
| `definitions.LogProfileCollection.properties.value.description` | `the values of the log profiles.` | `[Placeholder] Discription for value property` |
| `definitions.LogProfileProperties.properties.retentionPolicy.$ref` | `#/definitions/RetentionPolicy` | `#/definitions/Microsoft.Common.RetentionPolicy` |
| `definitions.LogProfileResource.allOf[0].$ref` | `#/definitions/Resource` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/logprofiles/{logProfileName}'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/Microsoft.Common.ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/logprofiles/{logProfileName}'].patch.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/Microsoft.Common.ErrorResponse` |

