## Swagger Changes

### Changes for `x-ms-code-generation-settings`

| Path | Change Type | Value |
|------|------------|-------|
| `info['x-ms-code-generation-settings__deleted']` | deleted | `{"name":"MonitorManagementClient"}` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `info.description__added` | added | `Monitor Management Client` |

### Changes for `x-ms-odata`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Insights/eventtypes/management/values'].get['x-ms-odata__deleted']` | deleted | `#/definitions/EventData` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/eventtypes/management/values'].get['x-ms-odata__deleted']` | deleted | `#/definitions/EventData` |

### Changes for `ErrorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorResponse__deleted` | deleted | `{"type":"object","description":"Describes the format of Error response.","properties":{"code":{"type...` |

### Changes for `LocalizableString`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LocalizableString__deleted` | deleted | `{"type":"object","description":"The localizable string class.","properties":{"value":{"type":"string...` |

### Changes for `Microsoft.Common.ErrorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Microsoft.Common.ErrorResponse__added']` | added | `{"type":"object","description":"Describes the format of Error response.","properties":{"code":{"type...` |

### Changes for `Microsoft.Common.LocalizableString`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Microsoft.Common.LocalizableString__added']` | added | `{"type":"object","description":"The localizable string class.","properties":{"value":{"type":"string...` |

### Changes for `nextLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EventCategoryCollection.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.EventCategoryCollection.description` | `A collection of event categories. Currently possible values are: Administrative, Security, ServiceHealth, Alert, Recommendation, Policy.` | `[Placeholder] Discription for page model` |
| `definitions.EventCategoryCollection.properties.value.description` | `the list that includes the Azure event categories.` | `[Placeholder] Discription for value property` |
| `definitions.EventCategoryCollection.properties.value.items.$ref` | `#/definitions/LocalizableString` | `#/definitions/Microsoft.Common.LocalizableString` |
| `definitions.EventData.properties.category.$ref` | `#/definitions/LocalizableString` | `#/definitions/Microsoft.Common.LocalizableString` |
| `definitions.EventData.properties.eventName.$ref` | `#/definitions/LocalizableString` | `#/definitions/Microsoft.Common.LocalizableString` |
| `definitions.EventData.properties.operationName.$ref` | `#/definitions/LocalizableString` | `#/definitions/Microsoft.Common.LocalizableString` |
| `definitions.EventData.properties.resourceProviderName.$ref` | `#/definitions/LocalizableString` | `#/definitions/Microsoft.Common.LocalizableString` |
| `definitions.EventData.properties.resourceType.$ref` | `#/definitions/LocalizableString` | `#/definitions/Microsoft.Common.LocalizableString` |
| `definitions.EventData.properties.status.$ref` | `#/definitions/LocalizableString` | `#/definitions/Microsoft.Common.LocalizableString` |
| `definitions.EventData.properties.subStatus.$ref` | `#/definitions/LocalizableString` | `#/definitions/Microsoft.Common.LocalizableString` |
| `paths['/providers/microsoft.Insights/eventcategories'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/Microsoft.Common.ErrorResponse` |
| `paths['/providers/microsoft.Insights/eventtypes/management/values'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/Microsoft.Common.ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/eventtypes/management/values'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/Microsoft.Common.ErrorResponse` |

