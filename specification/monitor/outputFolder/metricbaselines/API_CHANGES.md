## Swagger Changes

### Changes for `x-ms-code-generation-settings`

| Path | Change Type | Value |
|------|------------|-------|
| `info['x-ms-code-generation-settings__deleted']` | deleted | `{"name":"MonitorManagementClient"}` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SingleBaseline.properties.highThresholds.items.description__deleted` | deleted | `A single high threshold value.` |
| `definitions.SingleBaseline.properties.lowThresholds.items.description__deleted` | deleted | `A single low threshold value.` |
| `definitions.TimeSeriesBaseline.properties.timestamps.items.description__deleted` | deleted | `The timestamp for the baseline value in ISO 8601 format.` |
| `info.description__added` | added | `Monitor Management Client` |

### Changes for `ErrorDetail`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorDetail__deleted` | deleted | `{"type":"object","description":"Describes details of an error response.","properties":{"code":{"type...` |

### Changes for `ErrorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorResponse__deleted` | deleted | `{"type":"object","description":"Describes the format of Error response.","properties":{"error":{"typ...` |

### Changes for `MetricBaselinesErrorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetricBaselinesErrorResponse__added` | added | `{"type":"object","description":"Describes the format of Error response.","properties":{"error":{"$re...` |

### Changes for `Microsoft.Common.ErrorDetail`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Microsoft.Common.ErrorDetail__added']` | added | `{"type":"object","description":"Describes details of an error response.","properties":{"code":{"type...` |

### Changes for `Microsoft.Common.ErrorDetailAdditionalInfoItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Microsoft.Common.ErrorDetailAdditionalInfoItem__added']` | added | `{"type":"object","properties":{"type":{"type":"string","description":"The type of additional informa...` |

### Changes for `Microsoft.Common.ErrorResponseError`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Microsoft.Common.ErrorResponseError__added']` | added | `{"type":"object","properties":{"code":{"type":"string","description":"Unlocalized string which can b...` |

### Changes for `Microsoft.Common.ErrorResponseErrorAdditionalInfoItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Microsoft.Common.ErrorResponseErrorAdditionalInfoItem__added']` | added | `{"type":"object","properties":{"type":{"type":"string","description":"The type of additional informa...` |

### Changes for `nextLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetricBaselinesResponse.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.MetricBaselinesResponse.description` | `A list of metric baselines.` | `[Placeholder] Discription for page model` |
| `definitions.MetricBaselinesResponse.properties.value.description` | `The list of metric baselines.` | `[Placeholder] Discription for value property` |
| `paths['/{resourceUri}/providers/microsoft.Insights/metricBaselines'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/MetricBaselinesErrorResponse` |

