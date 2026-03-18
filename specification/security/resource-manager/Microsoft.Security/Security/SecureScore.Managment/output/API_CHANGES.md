## Swagger Changes

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Security/secureScoreControlDefinitions'].get.tags__deleted` | deleted | `["Secure Score Control Definitions"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/secureScoreControlDefinitions'].get.tags__deleted` | deleted | `["Secure Score Control Definitions"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/secureScoreControls'].get.tags__deleted` | deleted | `["Secure Score Controls"]` |

### Changes for `x-ms-pageable`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Security/secureScoreControlDefinitions'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/secureScoreControlDefinitions'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/secureScoreControls'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |

### Changes for `SecureScoreControlScore`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecureScoreControlScore__deleted` | deleted | `{"type":"object","description":"Calculation result data","properties":{"max":{"type":"integer","form...` |

### Changes for `secureScoreControlDefinitionList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.secureScoreControlDefinitionList__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `AzureResourceLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureResourceLink__added` | added | `{"type":"object","description":"Describes an Azure resource with kind","properties":{"id":{"type":"s...` |

### Changes for `Resource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Resource__added` | added | `{"type":"object","description":"Describes an Azure resource.","properties":{"id":{"type":"string","d...` |

### Changes for `SecureScoreControlDefinitionList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecureScoreControlDefinitionList__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScoreDetails.readOnly__deleted` | deleted | `true` |
| `definitions.SecureScoreControlDefinitionSource.readOnly__deleted` | deleted | `true` |
| `definitions.SecureScoreControlList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.SecureScoreControlScoreDetails.properties.score.readOnly__added` | added | `true` |
| `definitions.SecureScoreItem.properties.properties.readOnly__deleted` | deleted | `true` |
| `definitions.SecureScoreItem.readOnly__deleted` | deleted | `true` |
| `definitions.SecureScoreItemProperties.readOnly__deleted` | deleted | `true` |
| `definitions.SecureScoresList.properties.value.readOnly__deleted` | deleted | `true` |

### Changes for `minimum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScoreDetails.properties.current.minimum__deleted` | deleted | `0` |
| `definitions.ScoreDetails.properties.max.minimum__deleted` | deleted | `0` |
| `definitions.ScoreDetails.properties.percentage.minimum__deleted` | deleted | `0` |
| `definitions.SecureScoreControlDefinitionItemProperties.properties.maxScore.minimum__deleted` | deleted | `0` |
| `definitions.SecureScoreControlScoreDetails.properties.weight.minimum__deleted` | deleted | `0` |
| `definitions.SecureScoreItemProperties.properties.weight.minimum__deleted` | deleted | `0` |

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

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecureScoreControlList.required__added` | added | `["value"]` |
| `definitions.SecureScoresList.required__added` | added | `["value"]` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.SecureScoreControlDefinitionItem.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `#/definitions/Resource` |
| `definitions.SecureScoreControlDetails.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `#/definitions/Resource` |
| `definitions.SecureScoreItem.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `info.description` | `API spec for Microsoft.Security (Microsoft Defender for Cloud) resource provider` | `API spec for Microsoft.Security (Azure Security Center) resource provider` |
| `info.title` | `Microsoft Defender for Cloud` | `SecurityCenter` |
| `paths['/providers/microsoft.Security/secureScoreControlDefinitions'].get.responses.200.schema.$ref` | `#/definitions/secureScoreControlDefinitionList` | `#/definitions/SecureScoreControlDefinitionList` |
| `paths['/providers/microsoft.Security/secureScoreControlDefinitions'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/secureScoreControlDefinitions'].get.responses.200.schema.$ref` | `#/definitions/secureScoreControlDefinitionList` | `#/definitions/SecureScoreControlDefinitionList` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/secureScoreControlDefinitions'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/secureScoreControls'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/secureScores'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/secureScores/{secureScoreName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/secureScores/{secureScoreName}/secureScoreControls'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |

