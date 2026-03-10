## Swagger Changes

### Changes for `CloudError`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudError__added` | added | `{"type":"object","description":"Common error response for all Azure Resource Manager APIs to return ...` |

### Changes for `CloudErrorBody`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudErrorBody__added` | added | `{"type":"object","description":"The error detail.","properties":{"code":{"type":"string","descriptio...` |

### Changes for `ErrorAdditionalInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorAdditionalInfo__added` | added | `{"type":"object","description":"The resource management error additional info.","properties":{"type"...` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AlertsSuppressionRule.properties.properties.description__added` | added | `describes AlertsSuppressionRule properties` |

### Changes for `modelAsString`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AlertsSuppressionRuleProperties.properties.state['x-ms-enum'].modelAsString__added` | added | `false` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AlertsSuppressionRuleProperties.properties.suppressionAlertsScope.type__deleted` | deleted | `object` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AlertsSuppressionRule.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ScopeElement.additionalProperties` | `true` | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/alertsSuppressionRules'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/alertsSuppressionRules/{alertsSuppressionRuleName}'].delete.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/alertsSuppressionRules/{alertsSuppressionRuleName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/alertsSuppressionRules/{alertsSuppressionRuleName}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |

