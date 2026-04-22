## Swagger Changes

### Changes for `x-ms-odata`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceUri}/providers/microsoft.Insights/metrics'].get['x-ms-odata__deleted']` | deleted | `../../../../common-types/v2/commonMonitoringTypes.json#/definitions/MetadataValue` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/metrics'].get['x-ms-odata__deleted']` | deleted | `../../../../common-types/v2/commonMonitoringTypes.json#/definitions/MetadataValue` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/metrics'].post['x-ms-odata__deleted']` | deleted | `../../../../common-types/v2/commonMonitoringTypes.json#/definitions/MetadataValue` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetricDefinition.properties.unit.$ref__deleted` | deleted | `./common-types/v2/commonMonitoringTypes.json#/definitions/Unit` |
| `definitions.SubscriptionScopeMetricDefinition.properties.unit.$ref__deleted` | deleted | `./common-types/v2/commonMonitoringTypes.json#/definitions/Unit` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/metricDefinitions'].get.parameters[0].$ref__deleted` | deleted | `./common-types/v2/commonMonitoringTypes.json#/parameters/RegionParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/metricDefinitions'].get.parameters[1].$ref__deleted` | deleted | `./common-types/v2/commonMonitoringTypes.json#/parameters/MetricNamespaceParameter` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/metricDefinitions'].get.parameters[0].name__added` | added | `region` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/metricDefinitions'].get.parameters[1].name__added` | added | `metricnamespace` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/metricDefinitions'].get.parameters[0].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/metricDefinitions'].get.parameters[1].in__added` | added | `query` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/metricDefinitions'].get.parameters[0].required__added` | added | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetricDefinition.properties.unit.type__added` | added | `string` |
| `definitions.SubscriptionScopeMetricDefinition.properties.unit.type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/metricDefinitions'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/metricDefinitions'].get.parameters[1].type__added` | added | `string` |

### Changes for `ErrorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorResponse__deleted` | deleted | `{"type":"object","description":"Describes the format of Error response.","properties":{"code":{"type...` |

### Changes for `MetadataValue`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetadataValue__added` | added | `{"type":"object","description":"Represents a metric metadata value.","properties":{"name":{"$ref":"#...` |

### Changes for `Metric`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Metric__added` | added | `{"type":"object","description":"The result data of a query.","properties":{"id":{"type":"string","de...` |

### Changes for `MetricValue`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetricValue__added` | added | `{"type":"object","description":"Represents a metric value.","properties":{"timeStamp":{"type":"strin...` |

### Changes for `Microsoft.Common.CommonErrorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Microsoft.Common.CommonErrorResponse__added']` | added | `{"type":"object","description":"Common error response for all Azure Resource Manager APIs to return ...` |

### Changes for `Microsoft.Common.ErrorContract`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Microsoft.Common.ErrorContract__added']` | added | `{"type":"object","description":"Common error response for all Azure Resource Manager APIs to return ...` |

### Changes for `Microsoft.Common.ErrorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Microsoft.Common.ErrorResponse__added']` | added | `{"type":"object","description":"Describes the format of Error response.","properties":{"code":{"type...` |

### Changes for `Microsoft.Common.LocalizableString`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Microsoft.Common.LocalizableString__added']` | added | `{"type":"object","description":"The localizable string class.","properties":{"value":{"type":"string...` |

### Changes for `TimeSeriesElement`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TimeSeriesElement__added` | added | `{"type":"object","description":"A time series result type. The discriminator value is always TimeSer...` |

### Changes for `enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetricDefinition.properties.unit.enum__added` | added | `["Count","Bytes","Seconds","CountPerSecond","BytesPerSecond","Percent","MilliSeconds","ByteSeconds",...` |
| `definitions.SubscriptionScopeMetricDefinition.properties.unit.enum__added` | added | `["Count","Bytes","Seconds","CountPerSecond","BytesPerSecond","Percent","MilliSeconds","ByteSeconds",...` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetricDefinition.properties.unit['x-ms-enum__added']` | added | `{"name":"MetricUnit","modelAsString":true}` |
| `definitions.SubscriptionScopeMetricDefinition.properties.unit['x-ms-enum__added']` | added | `{"name":"MetricUnit","modelAsString":true}` |

### Changes for `nextLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetricDefinitionCollection.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |
| `definitions.MetricNamespaceCollection.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |
| `definitions.SubscriptionScopeMetricDefinitionCollection.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.MetricDefinition.properties.dimensions.items.$ref` | `./common-types/v2/commonMonitoringTypes.json#/definitions/LocalizableString` | `#/definitions/Microsoft.Common.LocalizableString` |
| `definitions.MetricDefinition.properties.name.$ref` | `./common-types/v2/commonMonitoringTypes.json#/definitions/LocalizableString` | `#/definitions/Microsoft.Common.LocalizableString` |
| `definitions.MetricDefinitionCollection.description` | `Represents collection of metric definitions.` | `[Placeholder] Discription for page model` |
| `definitions.MetricDefinitionCollection.properties.value.description` | `The values for the metric definitions.` | `[Placeholder] Discription for value property` |
| `definitions.MetricNamespaceCollection.description` | `Represents collection of metric namespaces.` | `[Placeholder] Discription for page model` |
| `definitions.MetricNamespaceCollection.properties.value.description` | `The values for the metric namespaces.` | `[Placeholder] Discription for value property` |
| `definitions.Response.properties.cost.type` | `number` | `integer` |
| `definitions.Response.properties.interval.description` | `The interval (window size) for which the metric data was returned in ISO 8601 duration format with a special case for 'FULL' value that returns single datapoint for entire time span requested (*Examples: PT15M, PT1H, P1D, FULL*). 
This may be adjusted and different from what was originally requested if AutoAdjustTimegrain=true is specified. This is not present if a metadata request was made.` | `The interval (window size) for which the metric data was returned in ISO 8601 duration format with a special case for 'FULL' value that returns single datapoint for entire time span requested (*Examples: PT15M, PT1H, P1D, FULL*).
This may be adjusted and different from what was originally requested if AutoAdjustTimegrain=true is specified. This is not present if a metadata request was made.` |
| `definitions.Response.properties.value.items.$ref` | `./common-types/v2/commonMonitoringTypes.json#/definitions/Metric` | `#/definitions/Metric` |
| `definitions.SubscriptionScopeMetricDefinition.properties.dimensions.items.$ref` | `./common-types/v2/commonMonitoringTypes.json#/definitions/LocalizableString` | `#/definitions/Microsoft.Common.LocalizableString` |
| `definitions.SubscriptionScopeMetricDefinition.properties.name.$ref` | `./common-types/v2/commonMonitoringTypes.json#/definitions/LocalizableString` | `#/definitions/Microsoft.Common.LocalizableString` |
| `definitions.SubscriptionScopeMetricDefinitionCollection.description` | `Represents collection of metric definitions.` | `[Placeholder] Discription for page model` |
| `definitions.SubscriptionScopeMetricDefinitionCollection.properties.value.description` | `The values for the metric definitions.` | `[Placeholder] Discription for value property` |
| `paths['/{resourceUri}/providers/microsoft.Insights/metricDefinitions'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v1/types.json#/definitions/ErrorResponse` | `#/definitions/Microsoft.Common.CommonErrorResponse` |
| `paths['/{resourceUri}/providers/microsoft.insights/metricNamespaces'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/Microsoft.Common.ErrorResponse` |
| `paths['/{resourceUri}/providers/microsoft.Insights/metrics'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v1/types.json#/definitions/ErrorResponse` | `#/definitions/Microsoft.Common.CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/metricDefinitions'].get.responses.default.schema.$ref` | `./common-types/v2/commonMonitoringTypes.json#/definitions/ErrorContract` | `#/definitions/Microsoft.Common.ErrorContract` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/metrics'].get.responses.default.schema.$ref` | `./common-types/v2/commonMonitoringTypes.json#/definitions/ErrorContract` | `#/definitions/Microsoft.Common.ErrorContract` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/metrics'].post.responses.default.schema.$ref` | `./common-types/v2/commonMonitoringTypes.json#/definitions/ErrorContract` | `#/definitions/Microsoft.Common.ErrorContract` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/metrics'].post['x-ms-examples']['Post request for subscription level metric data'].$ref` | `./examples/GetMultiResourceMetric.json` | `./examples/PostMultiResourceMetric.json` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/metrics'].post['x-ms-examples']['Post request for subscription level metric metadata'].$ref` | `./examples/GetMultiResourceMetricMetadata.json` | `./examples/PostMultiResourceMetricMetadata.json` |

