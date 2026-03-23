## Swagger Changes

### Changes for `SecureScoreControlScore`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecureScoreControlScore__deleted` | deleted | `{"type":"object","description":"Calculation result data","properties":{"max":{"type":"integer","form...` |

### Changes for `AzureResourceLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureResourceLink__added` | added | `{"type":"object","description":"Describes an Azure resource with kind","properties":{"id":{"type":"s...` |

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

### Changes for `Resource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Resource__added` | added | `{"type":"object","description":"Describes an Azure resource.","properties":{"id":{"type":"string","d...` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScoreDetails.readOnly__deleted` | deleted | `true` |
| `definitions.SecureScoreControlDefinitionSource.readOnly__deleted` | deleted | `true` |
| `definitions.SecureScoreItem.readOnly__deleted` | deleted | `true` |
| `definitions.SecureScoreItemProperties.readOnly__deleted` | deleted | `true` |

### Changes for `exclusiveMinimum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScoreDetails.properties.current.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ScoreDetails.properties.max.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ScoreDetails.properties.percentage.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.SecureScoreControlDefinitionItemProperties.properties.maxScore.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.SecureScoreControlScoreDetails.properties.weight.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.SecureScoreItemProperties.properties.weight.exclusiveMinimum__deleted` | deleted | `false` |

### Changes for `exclusiveMaximum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScoreDetails.properties.percentage.exclusiveMaximum__deleted` | deleted | `false` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecureScoreControlDefinitionItem.properties.properties.description__added` | added | `Security Control Definition Properties.` |
| `definitions.SecureScoreControlDetails.properties.properties.description__added` | added | `Calculation result data in control level` |
| `definitions.SecureScoreControlScoreDetails.properties.definition.description__added` | added | `Information about the security control.` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecureScoreControlDefinitionItemProperties.properties.assessmentDefinitions.$ref__deleted` | deleted | `./common/v1/types.json#/definitions/AzureResourceLinks` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecureScoreControlDefinitionItemProperties.properties.assessmentDefinitions.type__added` | added | `array` |

### Changes for `items`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecureScoreControlDefinitionItemProperties.properties.assessmentDefinitions.items__added` | added | `{"$ref":"#/definitions/AzureResourceLink"}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.SecureScoreControlDefinitionItem.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `#/definitions/Resource` |
| `definitions.SecureScoreControlDetails.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `#/definitions/Resource` |
| `definitions.SecureScoreItem.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `paths['/providers/microsoft.Security/secureScoreControlDefinitions'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/secureScoreControlDefinitions'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/secureScoreControls'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/secureScores'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/secureScores/{secureScoreName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/secureScores/{secureScoreName}/secureScoreControls'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |

