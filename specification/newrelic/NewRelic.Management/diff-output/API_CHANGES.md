## Swagger Changes

### Changes for `x-cadl-generated`

| Path | Change Type | Value |
|------|------------|-------|
| `info['x-cadl-generated__deleted']` | deleted | `[{"emitter":"@azure-tools/cadl-autorest"}]` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `info.description__added` | added | `// FIXME: (missing-service-description) Add service description` |

### Changes for `consumes`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/newRelic.Observability/monitors/{monitorName}/listConnectedPartnerResources'].post.consumes__added` | added | `["text/plain"]` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/newRelic.Observability/monitors/{monitorName}/listConnectedPartnerResources'].post.parameters[1].schema.$ref__deleted` | deleted | `#/definitions/email` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MonitoredSubscriptionProperties.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/newRelic.Observability/monitors/{monitorName}/listConnectedPartnerResources'].post.parameters[1].schema.type__added` | added | `string` |

### Changes for `pattern`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/newRelic.Observability/monitors/{monitorName}/monitoredSubscriptions/{configurationName}'].delete.parameters[1].pattern__deleted` | deleted | `^.*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/newRelic.Observability/monitors/{monitorName}/monitoredSubscriptions/{configurationName}'].get.parameters[1].pattern__deleted` | deleted | `^.*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/newRelic.Observability/monitors/{monitorName}/monitoredSubscriptions/{configurationName}'].patch.parameters[1].pattern__deleted` | deleted | `^.*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/newRelic.Observability/monitors/{monitorName}/monitoredSubscriptions/{configurationName}'].put.parameters[1].pattern__deleted` | deleted | `^.*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/newRelic.Observability/monitors/{monitorName}/refreshIngestionKey'].post.parameters[0].pattern__added` | added | `^.*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/newRelic.Observability/monitors/{monitorName}/switchBilling'].post.parameters[0].pattern__added` | added | `^.*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/newRelic.Observability/monitors/{monitorName}/tagRules'].get.parameters[0].pattern__added` | added | `^.*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/newRelic.Observability/monitors/{monitorName}/tagRules/{ruleSetName}'].delete.parameters[0].pattern__added` | added | `^.*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/newRelic.Observability/monitors/{monitorName}/tagRules/{ruleSetName}'].get.parameters[0].pattern__added` | added | `^.*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/newRelic.Observability/monitors/{monitorName}/tagRules/{ruleSetName}'].patch.parameters[0].pattern__added` | added | `^.*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/newRelic.Observability/monitors/{monitorName}/tagRules/{ruleSetName}'].put.parameters[0].pattern__added` | added | `^.*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/newRelic.Observability/monitors/{monitorName}/vmHostPayloads'].post.parameters[0].pattern__added` | added | `^.*$` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectedPartnerResourcesListResponse.required__added` | added | `["value"]` |
| `definitions.LinkedResourceListResponse.required__added` | added | `["value"]` |
| `definitions.MonitoredSubscription.properties.subscriptionId.required__deleted` | deleted | `["subscriptionId"]` |
| `definitions.MonitoredSubscriptionPropertiesList.required__added` | added | `["value"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/newRelic.Observability/monitors/{monitorName}/monitoredSubscriptions/{configurationName}'].put.parameters[2].required__added` | added | `true` |

### Changes for `AccountIdParameter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccountIdParameter__deleted` | deleted | `{"type":"object","properties":{}}` |

### Changes for `AppServicesGetParameter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AppServicesGetParameter__deleted` | deleted | `{"type":"object","properties":{"request":{"$ref":"#/definitions/AppServicesGetRequest"}},"required":...` |

### Changes for `HostsGetParameter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HostsGetParameter__deleted` | deleted | `{"type":"object","properties":{"request":{"$ref":"#/definitions/HostsGetRequest"}},"required":["requ...` |

### Changes for `LocationParameter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LocationParameter__deleted` | deleted | `{"type":"object","properties":{}}` |

### Changes for `MetricsRequestParameter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetricsRequestParameter__deleted` | deleted | `{"type":"object","properties":{"request":{"$ref":"#/definitions/MetricsRequest"}},"required":["reque...` |

### Changes for `MetricsStatusRequestParameter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetricsStatusRequestParameter__deleted` | deleted | `{"type":"object","properties":{"request":{"$ref":"#/definitions/MetricsStatusRequest"}},"required":[...` |

### Changes for `OrganizationIdParameter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OrganizationIdParameter__deleted` | deleted | `{"type":"object","properties":{}}` |

### Changes for `SecureString`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecureString__deleted` | deleted | `{"type":"string","format":"password","x-ms-secret":true}` |

### Changes for `SwitchBillingParameter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SwitchBillingParameter__deleted` | deleted | `{"type":"object","properties":{"request":{"$ref":"#/definitions/SwitchBillingRequest"}},"required":[...` |

### Changes for `UserEmailParameter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UserEmailParameter__deleted` | deleted | `{"type":"object","properties":{}}` |

### Changes for `email`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.email__deleted` | deleted | `{"type":"string","pattern":"^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\\\.)+[A-Za-z]{2,}$"}` |

### Changes for `x-cadl-name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccountsListResponse.properties.nextLink['x-cadl-name__deleted']` | deleted | `Rest.ResourceLocation` |
| `definitions.AccountsListResponse.properties.value['x-cadl-name__deleted']` | deleted | `AccountResource[]` |
| `definitions.AppServicesGetRequest.properties.azureResourceIds['x-cadl-name__deleted']` | deleted | `string[]` |
| `definitions.AppServicesListResponse.properties.nextLink['x-cadl-name__deleted']` | deleted | `Rest.ResourceLocation` |
| `definitions.AppServicesListResponse.properties.value['x-cadl-name__deleted']` | deleted | `AppServiceInfo[]` |
| `definitions.HostsGetRequest.properties.vmIds['x-cadl-name__deleted']` | deleted | `string[]` |
| `definitions.LogRules.properties.filteringTags['x-cadl-name__deleted']` | deleted | `FilteringTag[]` |
| `definitions.MetricRules.properties.filteringTags['x-cadl-name__deleted']` | deleted | `FilteringTag[]` |
| `definitions.MetricsStatusRequest.properties.azureResourceIds['x-cadl-name__deleted']` | deleted | `string[]` |
| `definitions.MetricsStatusResponse.properties.azureResourceIds['x-cadl-name__deleted']` | deleted | `string[]` |
| `definitions.MonitoredResourceListResponse.properties.nextLink['x-cadl-name__deleted']` | deleted | `Rest.ResourceLocation` |
| `definitions.MonitoredResourceListResponse.properties.value['x-cadl-name__deleted']` | deleted | `MonitoredResource[]` |
| `definitions.NewRelicMonitorResourceListResult.properties.nextLink['x-cadl-name__deleted']` | deleted | `Rest.ResourceLocation` |
| `definitions.NewRelicMonitorResourceListResult.properties.value['x-cadl-name__deleted']` | deleted | `NewRelicMonitorResource[]` |
| `definitions.NewRelicMonitorResourceUpdate.properties.tags['x-cadl-name__deleted']` | deleted | `Record<string>` |
| `definitions.OrganizationsListResponse.properties.nextLink['x-cadl-name__deleted']` | deleted | `Rest.ResourceLocation` |
| `definitions.OrganizationsListResponse.properties.value['x-cadl-name__deleted']` | deleted | `OrganizationResource[]` |
| `definitions.PlanDataListResponse.properties.nextLink['x-cadl-name__deleted']` | deleted | `Rest.ResourceLocation` |
| `definitions.PlanDataListResponse.properties.value['x-cadl-name__deleted']` | deleted | `PlanDataResource[]` |
| `definitions.TagRuleListResult.properties.nextLink['x-cadl-name__deleted']` | deleted | `Rest.ResourceLocation` |
| `definitions.TagRuleListResult.properties.value['x-cadl-name__deleted']` | deleted | `TagRule[]` |
| `definitions.VMHostsListResponse.properties.nextLink['x-cadl-name__deleted']` | deleted | `Rest.ResourceLocation` |
| `definitions.VMHostsListResponse.properties.value['x-cadl-name__deleted']` | deleted | `VMInfo[]` |

### Changes for `x-ms-identifiers`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AppServicesListResponse.properties.value['x-ms-identifiers__deleted']` | deleted | `["azureResourceId"]` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MonitoredSubscriptionProperties.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}...` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MonitoredSubscriptionProperties.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MonitoredSubscriptionProperties.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `x-ms-client-flatten`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MonitoredSubscriptionProperties.properties.properties['x-ms-client-flatten__added']` | added | `true` |

### Changes for `x-ms-mutability`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NewRelicMonitorResource.properties.properties['x-ms-mutability__deleted']` | deleted | `["create","read"]` |
| `definitions.TagRule.properties.properties['x-ms-mutability__deleted']` | deleted | `["create","read"]` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.NewRelicMonitorResource.properties.identity.$ref` | `../../../../../common-types/resource-management/v4/managedidentity.json#/definitions/ManagedServiceIdentity` | `../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/ManagedServiceIdentity` |
| `definitions.NewRelicMonitorResourceUpdate.properties.identity.$ref` | `../../../../../common-types/resource-management/v4/managedidentity.json#/definitions/ManagedServiceIdentity` | `../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/ManagedServiceIdentity` |

