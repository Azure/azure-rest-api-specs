## Swagger Changes

### Changes for `x-ms-code-generation-settings`

| Path | Change Type | Value |
|------|------------|-------|
| `info['x-ms-code-generation-settings__deleted']` | deleted | `{"name":"MonitorManagementClient"}` |

### Changes for `ErrorDetail`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorDetail__deleted` | deleted | `{"type":"object","description":"Describes details of an error response.","properties":{"code":{"type...` |

### Changes for `ErrorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorResponse__deleted` | deleted | `{"type":"object","description":"Describes the format of Error response.","properties":{"error":{"typ...` |

### Changes for `Identity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Identity__deleted` | deleted | `{"type":"object","description":"Identity for the resource.","properties":{"principalId":{"type":"str...` |

### Changes for `Resource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Resource__deleted` | deleted | `{"type":"object","description":"An azure resource object","properties":{"id":{"type":"string","descr...` |

### Changes for `UserIdentityProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UserIdentityProperties__deleted` | deleted | `{"type":"object","description":"Properties of the user assigned identity.","properties":{"principalI...` |

### Changes for `MetricAlertErrorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetricAlertErrorResponse__added` | added | `{"type":"object","description":"Describes the format of Error response.","properties":{"error":{"$re...` |

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

### Changes for `Microsoft.Common.Identity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Microsoft.Common.Identity__added']` | added | `{"type":"object","description":"Identity for the resource.","properties":{"principalId":{"type":"str...` |

### Changes for `Microsoft.Common.UserIdentityProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Microsoft.Common.UserIdentityProperties__added']` | added | `{"type":"object","description":"Properties of the user assigned identity.","properties":{"principalI...` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynamicMetricCriteria.properties.failingPeriods.type__deleted` | deleted | `object` |
| `definitions.MetricAlertCriteria.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.MultiMetricCriteria.additionalProperties.type__deleted` | deleted | `object` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynamicThresholdFailingPeriods.properties.minFailingPeriodsToAlert.format__added` | added | `float` |
| `definitions.DynamicThresholdFailingPeriods.properties.numberOfEvaluationPeriods.format__added` | added | `float` |
| `definitions.WebtestLocationAvailabilityCriteria.properties.failedLocationCount.format__added` | added | `float` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetricAlertAction.properties.webHookProperties.additionalProperties.description__deleted` | deleted | `The dictionary of custom properties to include with the post operation. These data are appended to the webhook payload.` |
| `definitions.MetricAlertProperties.properties.actionProperties.additionalProperties.description__deleted` | deleted | `The dictionary of action properties to include with the post operation. This data customizes the actions.` |
| `definitions.MetricAlertProperties.properties.customProperties.additionalProperties.description__deleted` | deleted | `The dictionary of custom properties to include with the post operation. These data are appended to the alert payload.` |
| `definitions.MetricAlertPropertiesPatch.properties.actionProperties.additionalProperties.description__deleted` | deleted | `The dictionary of action properties to include with the post operation. This data customizes the actions.` |
| `definitions.MetricAlertPropertiesPatch.properties.customProperties.additionalProperties.description__deleted` | deleted | `The dictionary of custom properties to include with the post operation. These data are appended to the alert payload.` |
| `definitions.PromQLCriteria.properties.failingPeriods.description__added` | added | `Configuration for failing periods in query-based alerts.` |

### Changes for `identity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetricAlertResource.properties.identity__added` | added | `{"$ref":"#/definitions/Microsoft.Common.Identity","description":"The identity of the resource."}` |

### Changes for `nextLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetricAlertResourceCollection.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |

### Changes for `x-ms-client-flatten`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetricAlertStatus.properties.properties['x-ms-client-flatten__deleted']` | deleted | `false` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StaticPromQLCriteria.properties__deleted` | deleted | `{}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.MetricAlertResource.allOf[0].$ref` | `#/definitions/Resource` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.MetricAlertResourceCollection.description` | `Represents a collection of alert rule resources.` | `[Placeholder] Discription for page model` |
| `definitions.MetricAlertResourceCollection.properties.value.description` | `The values for the alert rule resources.` | `[Placeholder] Discription for value property` |
| `definitions.MetricAlertResourcePatch.properties.identity.$ref` | `#/definitions/Identity` | `#/definitions/Microsoft.Common.Identity` |
| `definitions.MetricAlertSingleResourceMultipleMetricCriteria.properties.allOf.description` | `The list of metric criteria for this 'all of' operation. ` | `The list of metric criteria for this 'all of' operation.` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/metricAlerts'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/MetricAlertErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/metricAlerts'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/MetricAlertErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/metricAlerts'].get['x-ms-examples']['List metric alert rules'].$ref` | `./examples/listMetricAlert.json` | `./examples/listByResourceGroupMetricAlert.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/metricAlerts/{ruleName}'].delete.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/MetricAlertErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/metricAlerts/{ruleName}'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/MetricAlertErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/metricAlerts/{ruleName}'].patch.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/MetricAlertErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/metricAlerts/{ruleName}'].put.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/MetricAlertErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/metricAlerts/{ruleName}/status'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/MetricAlertErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/metricAlerts/{ruleName}/status/{statusName}'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/MetricAlertErrorResponse` |

