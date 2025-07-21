## Swagger Changes

### Changes for `CreationSupported_Get`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/Dynatrace.Observability/subscriptionStatuses/{dynatraceEnvironmentId}'].get['x-ms-examples'].CreationSupported_Get__deleted` | deleted | `{"$ref":"./examples/CreationSupported_Get.json"}` |

### Changes for `CreationSupported_List`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/Dynatrace.Observability/subscriptionStatuses/{dynatraceEnvironmentId}'].get['x-ms-examples'].CreationSupported_List__added` | added | `{"$ref":"./examples/CreationSupported_List.json"}` |

### Changes for `email`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.email__deleted` | deleted | `{"type":"string","pattern":"^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\\\.)+[A-Za-z]{2,}$"}` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AppServiceListResponse.required__added` | added | `["value"]` |
| `definitions.LinkableEnvironmentListResponse.required__added` | added | `["value"]` |
| `definitions.MonitoredResourceListResponse.required__added` | added | `["value"]` |
| `definitions.MonitoredSubscriptionPropertiesList.required__added` | added | `["value"]` |
| `definitions.VMHostsListResponse.required__added` | added | `["value"]` |

### Changes for `x-cadl-name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynatraceSingleSignOnProperties.properties.aadDomains['x-cadl-name__deleted']` | deleted | `string[]` |
| `definitions.DynatraceSingleSignOnResourceListResult.properties.value['x-cadl-name__deleted']` | deleted | `Dynatrace.Observability.DynatraceSingleSignOnResource[]` |
| `definitions.LogRules.properties.filteringTags['x-cadl-name__deleted']` | deleted | `FilteringTag[]` |
| `definitions.MetricsStatusResponse.properties.azureResourceIds['x-cadl-name__deleted']` | deleted | `string[]` |
| `definitions.MonitoredResourceListResponse.properties.value['x-cadl-name__deleted']` | deleted | `MonitoredResource[]` |
| `definitions.MonitorResourceListResult.properties.value['x-cadl-name__deleted']` | deleted | `Dynatrace.Observability.MonitorResource[]` |
| `definitions.TagRuleListResult.properties.value['x-cadl-name__deleted']` | deleted | `Dynatrace.Observability.TagRule[]` |

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynatraceSingleSignOnResource.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/systemData","rea...` |
| `definitions.MonitorResource.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/systemData","rea...` |
| `definitions.TagRule.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/systemData","rea...` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MonitoredSubscriptionProperties.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"}...` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MonitoredSubscriptionProperties.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MonitoredSubscriptionProperties.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MonitoredSubscriptionProperties.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |

