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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/alertrules/{ruleName}/incidents'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../../common-types/resource-management/v3/type...` |

### Changes for `ErrorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorResponse__deleted` | deleted | `{"type":"object","description":"Describes the format of Error response.","properties":{"code":{"type...` |

### Changes for `Microsoft.Common.ErrorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Microsoft.Common.ErrorResponse__added']` | added | `{"type":"object","description":"Describes the format of Error response.","properties":{"code":{"type...` |

### Changes for `nextLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IncidentListResult.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.IncidentListResult.description` | `The List incidents operation response.` | `[Placeholder] Discription for page model` |
| `definitions.IncidentListResult.properties.value.description` | `the incident collection.` | `[Placeholder] Discription for value property` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/alertrules/{ruleName}/incidents/{incidentName}'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/Microsoft.Common.ErrorResponse` |

