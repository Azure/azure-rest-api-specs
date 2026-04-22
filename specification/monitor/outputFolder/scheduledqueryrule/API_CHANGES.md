## Swagger Changes

### Changes for `Identity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Identity__deleted` | deleted | `{"type":"object","description":"Identity for the resource.","properties":{"principalId":{"type":"str...` |

### Changes for `UserIdentityProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UserIdentityProperties__deleted` | deleted | `{"type":"object","description":"User assigned identity properties.","properties":{"principalId":{"ty...` |

### Changes for `ConditionFailingPeriods`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConditionFailingPeriods__added` | added | `{"type":"object","description":"The minimum number of violations required within the selected lookba...` |

### Changes for `Microsoft.Common.CommonErrorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Microsoft.Common.CommonErrorResponse__added']` | added | `{"type":"object","description":"Common error response for all Azure Resource Manager APIs to return ...` |

### Changes for `Microsoft.Common.ErrorContract`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Microsoft.Common.ErrorContract__added']` | added | `{"type":"object","description":"Common error response for all Azure Resource Manager APIs to return ...` |

### Changes for `Microsoft.Common.Identity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Microsoft.Common.Identity__added']` | added | `{"type":"object","description":"Identity for the resource.","properties":{"principalId":{"type":"str...` |

### Changes for `Microsoft.Common.UserIdentityProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Microsoft.Common.UserIdentityProperties__added']` | added | `{"type":"object","description":"Properties of the user assigned identity.","properties":{"principalI...` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Actions.properties.actionProperties.additionalProperties.description__deleted` | deleted | `The dictionary of action properties to include with the post operation. This data customizes the actions.` |
| `definitions.Actions.properties.customProperties.additionalProperties.description__deleted` | deleted | `The dictionary of custom properties to include with the post operation. These data are appended to the alert payload.` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Condition.properties.failingPeriods.type__deleted` | deleted | `object` |
| `definitions.ScheduledQueryRuleProperties.properties.actions.type__deleted` | deleted | `object` |
| `definitions.ScheduledQueryRuleProperties.properties.resolveConfiguration.type__deleted` | deleted | `object` |
| `definitions.ScheduledQueryRuleResource.properties.type__deleted` | deleted | `{"type":"string","description":"The type of the resource. E.g. \\"Microsoft.Compute/virtualMachines\\"...` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Condition.properties.failingPeriods.properties__deleted` | deleted | `{"numberOfEvaluationPeriods":{"type":"integer","format":"int64","description":"The number of aggrega...` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Condition.properties.failingPeriods.$ref__added` | added | `#/definitions/ConditionFailingPeriods` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScheduledQueryRuleProperties.properties.severity.format__deleted` | deleted | `int64` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScheduledQueryRuleResource.allOf__added` | added | `[{"$ref":"../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResourc...` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScheduledQueryRuleResource.properties.id__deleted` | deleted | `{"type":"string","description":"Fully qualified resource ID for the resource. Ex - /subscriptions/{s...` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScheduledQueryRuleResource.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource","readOnly":true}` |

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScheduledQueryRuleResource.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScheduledQueryRuleResource.properties.properties.required__deleted` | deleted | `["enabled","criteria","scopes"]` |
| `definitions.ScheduledQueryRuleResourceCollection.required__added` | added | `["value"]` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.Condition.properties.criterionType.description` | `Specifies the type of threshold criteria` | `Specifies the type of threshold criteria. Previously undocumented values might be returned` |
| `definitions.ScheduledQueryRuleProperties.properties.severity.type` | `integer` | `number` |
| `definitions.ScheduledQueryRuleResource.properties.etag.description` | `The etag field is *not* required. If it is provided in the response body, it must also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields. ` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.ScheduledQueryRuleResource.properties.identity.$ref` | `#/definitions/Identity` | `#/definitions/Microsoft.Common.Identity` |
| `definitions.ScheduledQueryRuleResourcePatch.properties.identity.$ref` | `#/definitions/Identity` | `#/definitions/Microsoft.Common.Identity` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/scheduledQueryRules'].get.responses.default.schema.$ref` | `./common-types/v2/commonMonitoringTypes.json#/definitions/ErrorContract` | `#/definitions/Microsoft.Common.ErrorContract` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/scheduledQueryRules'].get.responses.default.schema.$ref` | `./common-types/v2/commonMonitoringTypes.json#/definitions/ErrorContract` | `#/definitions/Microsoft.Common.ErrorContract` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/scheduledQueryRules/{ruleName}'].delete.responses.default.schema.$ref` | `./common-types/v2/commonMonitoringTypes.json#/definitions/ErrorContract` | `#/definitions/Microsoft.Common.ErrorContract` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/scheduledQueryRules/{ruleName}'].get.responses.default.schema.$ref` | `./common-types/v2/commonMonitoringTypes.json#/definitions/ErrorContract` | `#/definitions/Microsoft.Common.ErrorContract` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/scheduledQueryRules/{ruleName}'].patch.responses.default.schema.$ref` | `./common-types/v2/commonMonitoringTypes.json#/definitions/ErrorContract` | `#/definitions/Microsoft.Common.ErrorContract` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/scheduledQueryRules/{ruleName}'].put.responses.default.schema.$ref` | `./common-types/v2/commonMonitoringTypes.json#/definitions/ErrorContract` | `#/definitions/Microsoft.Common.ErrorContract` |

