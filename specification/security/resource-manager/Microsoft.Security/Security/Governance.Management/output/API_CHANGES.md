## Swagger Changes

### Changes for `x-ms-skip-url-encoding`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/assessments/{assessmentName}/governanceAssignments'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/assessments/{assessmentName}/governanceAssignments/{assignmentKey}'].delete.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/assessments/{assessmentName}/governanceAssignments/{assignmentKey}'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/assessments/{assessmentName}/governanceAssignments/{assignmentKey}'].put.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}'].delete.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}'].put.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}/execute'].post.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |

### Changes for `schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/assessments/{assessmentName}/governanceAssignments/{assignmentKey}'].delete.responses.default.schema__added` | added | `{"$ref":"#/definitions/CloudError"}` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}'].delete.responses.default.schema__added` | added | `{"$ref":"#/definitions/CloudError"}` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}'].delete.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"Location URL for the deletion status"}` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}/execute'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"Location URL for the execution status"}` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}/operationResults/{operationId}'].get.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"Location URL for the execution status"}` |

### Changes for `Location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}'].delete.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}/execute'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}/operationResults/{operationId}'].get.responses.202.headers.Location__added` | added | `{"type":"string","description":"Location URL for the execution status"}` |

### Changes for `Conditions`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Conditions__deleted` | deleted | `{"type":"array","description":"Governance rule's conditions","items":{"$ref":"#/definitions/Conditio...` |

### Changes for `GovernanceRuleConditionSets`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GovernanceRuleConditionSets__deleted` | deleted | `{"type":"object","description":"List of governance rule's condition sets - OR between ConditionSets,...` |

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
| `definitions.GovernanceRuleProperties.properties.excludedScopes.items.description__deleted` | deleted | `The excluded scope` |
| `definitions.GovernanceRuleProperties.properties.metadata.description__added` | added | `The governance rule metadata` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GovernanceRuleProperties.properties.conditionSets.items.$ref__deleted` | deleted | `#/definitions/GovernanceRuleConditionSets` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GovernanceRuleProperties.properties.conditionSets.items.type__added` | added | `array` |

### Changes for `items`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GovernanceRuleProperties.properties.conditionSets.items.items__added` | added | `{"type":"array","items":{"$ref":"#/definitions/Condition"}}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.GovernanceAssignment.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.GovernanceRule.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.OperationResult.properties.status['x-ms-enum'].name` | `OperationResult` | `OperationResultStatus` |
| `paths['/{scope}/providers/microsoft.Security/assessments/{assessmentName}/governanceAssignments'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{scope}/providers/microsoft.Security/assessments/{assessmentName}/governanceAssignments/{assignmentKey}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{scope}/providers/microsoft.Security/assessments/{assessmentName}/governanceAssignments/{assignmentKey}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}/execute'].post.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}/operationResults/{operationId}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |

