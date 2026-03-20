## Changed Paths

Path: /{scope}/providers/microsoft.Security/assessments/{assessmentName}/governanceAssignments
Change Type: deleted

Path: /{scope}/providers/microsoft.Security/assessments/{assessmentName}/governanceAssignments/{assignmentKey}
Change Type: deleted

Path: /{scope}/providers/microsoft.Security/governanceAssignments
Change Type: added

Path: /{scope}/providers/microsoft.Security/governanceAssignments/{assignmentKey}
Change Type: added

Path: /{scope}/providers/microsoft.Security/governanceRules/{ruleId}/{operationId}/{operationId}
Change Type: added

Path: /{scope}/providers/microsoft.Security/governanceRules/{ruleId}/operationResults/{operationId}
Change Type: deleted

## Swagger Changes

### Changes for `/{scope}/providers/microsoft.Security/assessments/{assessmentName}/governanceAssignments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/assessments/{assessmentName}/governanceAssignments__deleted']` | deleted | `{"get":{"operationId":"GovernanceAssignments_List","tags":["GovernanceAssignments"],"description":"G...` |

### Changes for `/{scope}/providers/microsoft.Security/assessments/{assessmentName}/governanceAssignments/{assignmentKey}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/assessments/{assessmentName}/governanceAssignments/{assignmentKey}__deleted']` | deleted | `{"get":{"operationId":"GovernanceAssignments_Get","tags":["GovernanceAssignments"],"description":"Ge...` |

### Changes for `/{scope}/providers/microsoft.Security/governanceRules/{ruleId}/operationResults/{operationId}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}/operationResults/{operationId}__deleted']` | deleted | `{"get":{"operationId":"GovernanceRules_OperationResults","tags":["GovernanceRules"],"description":"G...` |

### Changes for `/{scope}/providers/microsoft.Security/governanceAssignments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/governanceAssignments__added']` | added | `{"get":{"operationId":"GovernanceAssignments_List","tags":["GovernanceAssignments"],"description":"G...` |

### Changes for `/{scope}/providers/microsoft.Security/governanceAssignments/{assignmentKey}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/governanceAssignments/{assignmentKey}__added']` | added | `{"get":{"operationId":"GovernanceAssignments_Get","tags":["GovernanceAssignments"],"description":"Ge...` |

### Changes for `/{scope}/providers/microsoft.Security/governanceRules/{ruleId}/{operationId}/{operationId}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}/{operationId}/{operationId}__added']` | added | `{"get":{"operationId":"GovernanceRules_OperationResults","tags":["GovernanceRules"],"description":"G...` |

### Changes for `x-ms-skip-url-encoding`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/governanceRules'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}'].delete.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}'].put.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}/execute'].post.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}'].delete.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"Location URL for the deletion status"}` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}/execute'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"Location URL for the execution status"}` |

### Changes for `Location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}'].delete.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}/execute'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |

### Changes for `schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}'].delete.responses.default.schema__added` | added | `{"$ref":"../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorRespo...` |

### Changes for `Condition`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Condition__deleted` | deleted | `{"type":"object","description":"Governance rule's condition","properties":{"property":{"type":"strin...` |

### Changes for `Conditions`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Conditions__deleted` | deleted | `{"type":"array","description":"Governance rule's conditions","items":{"$ref":"#/definitions/Conditio...` |

### Changes for `GovernanceRuleConditionSets`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GovernanceRuleConditionSets__deleted` | deleted | `{"type":"object","description":"List of governance rule's condition sets - OR between ConditionSets,...` |

### Changes for `OperationResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationResult__deleted` | deleted | `{"type":"object","description":"Long run operation status of governance rule over a given scope","pr...` |

### Changes for `OperationResultAutoGenerated`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationResultAutoGenerated__added` | added | `{"type":"object","description":"Long run operation status of governance rule over a given scope","pr...` |

### Changes for `minimum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GovernanceAssignmentAdditionalData.properties.ticketNumber.minimum__deleted` | deleted | `0` |
| `definitions.GovernanceRuleProperties.properties.rulePriority.minimum__deleted` | deleted | `0` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GovernanceAssignmentsList.required__added` | added | `["value"]` |
| `definitions.GovernanceRuleList.required__added` | added | `["value"]` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GovernanceAssignmentsList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.GovernanceRuleList.properties.value.readOnly__deleted` | deleted | `true` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GovernanceRuleProperties.properties.excludedScopes.items.description__deleted` | deleted | `The excluded scope` |
| `definitions.GovernanceRuleProperties.properties.metadata.description__added` | added | `The governance rule metadata` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GovernanceRuleProperties.properties.conditionSets.items.$ref__deleted` | deleted | `#/definitions/GovernanceRuleConditionSets` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.GovernanceAssignment.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.GovernanceRule.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `info.description` | `API spec for Microsoft.Security (Microsoft Defender for Cloud) resource provider` | `API spec for Microsoft.Security (Azure Security Center) resource provider` |
| `info.title` | `Microsoft Defender for Cloud` | `SecurityCenter` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}/execute'].post.parameters[2].name` | `ExecuteGovernanceRuleParams` | `executeGovernanceRuleParams` |
| `paths['/{scope}/providers/microsoft.Security/governanceRules/{ruleId}/execute'].post.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |

