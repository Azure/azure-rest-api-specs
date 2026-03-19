## Swagger Changes

### Changes for `x-ms-skip-url-encoding`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewHistoryDefinitions'].get.parameters[1]['x-ms-skip-url-encoding__deleted']` | deleted | `true` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions'].get.parameters[1]['x-ms-skip-url-encoding__deleted']` | deleted | `true` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances'].get.parameters[2]['x-ms-skip-url-encoding__deleted']` | deleted | `true` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/decisions'].get.parameters[3]['x-ms-skip-url-encoding__deleted']` | deleted | `true` |
| `paths['/providers/microsoft.Authorization/accessReviewScheduleDefinitions'].get.parameters[0]['x-ms-skip-url-encoding__deleted']` | deleted | `true` |
| `paths['/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/decisions'].get.parameters[2]['x-ms-skip-url-encoding__deleted']` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewHistoryDefinitions'].get.parameters[0]['x-ms-skip-url-encoding__deleted']` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions'].get.parameters[0]['x-ms-skip-url-encoding__deleted']` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances'].get.parameters[1]['x-ms-skip-url-encoding__deleted']` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/decisions'].get.parameters[2]['x-ms-skip-url-encoding__deleted']` | deleted | `true` |

### Changes for `x-ms-examples`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Authorization/accessReviewScheduleDefinitions'].get['x-ms-examples__deleted']` | deleted | `{"GetAccessReviews":{"$ref":"./examples/GetAccessReviewScheduleDefinitionsAssignedForMyApproval.json...` |
| `paths['/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances'].get['x-ms-examples__deleted']` | deleted | `{"GetAccessReviews":{"$ref":"./examples/GetAccessReviewInstancesAssignedForMyApproval.json"}}` |
| `paths['/providers/microsoft.Authorization/operations'].get['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewHistoryDefinitions'].get['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewHistoryDefinitions/{historyDefinitionId}'].delete['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewHistoryDefinitions/{historyDefinitionId}'].get['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewHistoryDefinitions/{historyDefinitionId}'].put['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewHistoryDefinitions/{historyDefinitionId}/instances'].get['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewHistoryDefinitions/{historyDefinitionId}/instances/{instanceId}/generateDownloadUri'].post['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions'].get['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}'].delete['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}'].get['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}'].put['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances'].get['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}'].get['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}'].put['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/applyDecisions'].post['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/contactedReviewers'].get['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/decisions'].get['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/resetDecisions'].post['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/sendReminders'].post['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/stop'].post['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/stop'].post['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleSettings/default'].get['x-ms-examples__deleted']` | deleted | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleSettings/default'].put['x-ms-examples__deleted']` | deleted | `{}` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Authorization/operations'].get.tags__added` | added | `["Operations"]` |

### Changes for `AccessReviewHistoryDefinitionInstanceListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccessReviewHistoryDefinitionInstanceListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `Operation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation__deleted` | deleted | `{"type":"object","description":"The definition of a Microsoft.Authorization operation.","properties"...` |

### Changes for `OperationDisplay`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationDisplay__deleted` | deleted | `{"type":"object","description":"The display information for a Microsoft.Authorization operation.","p...` |

### Changes for `OperationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `AccessReviewHistoryInstanceListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccessReviewHistoryInstanceListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccessReviewContactedReviewerListResult.required__added` | added | `["value"]` |
| `definitions.AccessReviewDecisionListResult.required__added` | added | `["value"]` |
| `definitions.AccessReviewHistoryDefinitionListResult.required__added` | added | `["value"]` |
| `definitions.AccessReviewInstanceListResult.required__added` | added | `["value"]` |
| `definitions.AccessReviewScheduleDefinitionListResult.required__added` | added | `["value"]` |

### Changes for `x-nullable`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccessReviewContactedReviewerProperties.properties.createdDateTime['x-nullable__deleted']` | deleted | `true` |
| `definitions.AccessReviewDecisionInsightProperties.properties.insightCreatedDateTime['x-nullable__deleted']` | deleted | `true` |
| `definitions.AccessReviewDecisionProperties.properties.appliedBy['x-nullable__deleted']` | deleted | `true` |
| `definitions.AccessReviewDecisionProperties.properties.appliedDateTime['x-nullable__deleted']` | deleted | `true` |
| `definitions.AccessReviewDecisionProperties.properties.principal['x-nullable__deleted']` | deleted | `true` |
| `definitions.AccessReviewDecisionProperties.properties.principalResourceMembership['x-nullable__deleted']` | deleted | `true` |
| `definitions.AccessReviewDecisionProperties.properties.resource['x-nullable__deleted']` | deleted | `true` |
| `definitions.AccessReviewDecisionProperties.properties.reviewedBy['x-nullable__deleted']` | deleted | `true` |
| `definitions.AccessReviewDecisionProperties.properties.reviewedDateTime['x-nullable__deleted']` | deleted | `true` |
| `definitions.AccessReviewDecisionUserSignInInsightProperties.properties.lastSignInDateTime['x-nullable__deleted']` | deleted | `true` |
| `definitions.AccessReviewHistoryDefinitionProperties.properties.createdBy['x-nullable__deleted']` | deleted | `true` |
| `definitions.AccessReviewHistoryDefinitionProperties.properties.createdDateTime['x-nullable__deleted']` | deleted | `true` |
| `definitions.AccessReviewHistoryDefinitionProperties.properties.decisions['x-nullable__deleted']` | deleted | `true` |
| `definitions.AccessReviewHistoryDefinitionProperties.properties.reviewHistoryPeriodEndDateTime['x-nullable__deleted']` | deleted | `true` |
| `definitions.AccessReviewHistoryDefinitionProperties.properties.reviewHistoryPeriodStartDateTime['x-nullable__deleted']` | deleted | `true` |
| `definitions.AccessReviewHistoryDefinitionProperties.properties.scopes['x-nullable__deleted']` | deleted | `false` |
| `definitions.AccessReviewHistoryDefinitionProperties.properties.settings['x-nullable__deleted']` | deleted | `true` |
| `definitions.AccessReviewHistoryInstanceProperties.properties.expiration['x-nullable__deleted']` | deleted | `true` |
| `definitions.AccessReviewHistoryInstanceProperties.properties.fulfilledDateTime['x-nullable__deleted']` | deleted | `true` |
| `definitions.AccessReviewHistoryInstanceProperties.properties.runDateTime['x-nullable__deleted']` | deleted | `true` |
| `definitions.AccessReviewInstanceProperties.properties.endDateTime['x-nullable__deleted']` | deleted | `false` |
| `definitions.AccessReviewInstanceProperties.properties.startDateTime['x-nullable__deleted']` | deleted | `false` |
| `definitions.AccessReviewRecurrenceRange.properties.endDate['x-nullable__deleted']` | deleted | `true` |
| `definitions.AccessReviewRecurrenceRange.properties.startDate['x-nullable__deleted']` | deleted | `true` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccessReviewDecision.allOf__added` | added | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}]` |
| `definitions.AccessReviewDefaultSettings.allOf__added` | added | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}]` |
| `definitions.AccessReviewHistoryDefinition.allOf__added` | added | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}]` |
| `definitions.AccessReviewInstance.allOf__added` | added | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}]` |
| `definitions.AccessReviewScheduleDefinition.allOf__added` | added | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}]` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccessReviewDecision.properties.id__deleted` | deleted | `{"type":"string","description":"The access review decision id.","readOnly":true}` |
| `definitions.AccessReviewDefaultSettings.properties.id__deleted` | deleted | `{"type":"string","description":"The access review default settings id. This is only going to be defa...` |
| `definitions.AccessReviewHistoryDefinition.properties.id__deleted` | deleted | `{"type":"string","description":"The access review history definition id.","readOnly":true}` |
| `definitions.AccessReviewInstance.properties.id__deleted` | deleted | `{"type":"string","description":"The access review instance id.","readOnly":true}` |
| `definitions.AccessReviewScheduleDefinition.properties.id__deleted` | deleted | `{"type":"string","description":"The access review schedule definition id.","readOnly":true}` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccessReviewDecision.properties.name__deleted` | deleted | `{"type":"string","description":"The access review decision name.","readOnly":true}` |
| `definitions.AccessReviewDefaultSettings.properties.name__deleted` | deleted | `{"type":"string","description":"The access review default settings name. This is always going to be ...` |
| `definitions.AccessReviewHistoryDefinition.properties.name__deleted` | deleted | `{"type":"string","description":"The access review history definition unique id.","readOnly":true}` |
| `definitions.AccessReviewInstance.properties.name__deleted` | deleted | `{"type":"string","description":"The access review instance name.","readOnly":true}` |
| `definitions.AccessReviewScheduleDefinition.properties.name__deleted` | deleted | `{"type":"string","description":"The access review schedule definition unique id.","readOnly":true}` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccessReviewDecision.properties.type__deleted` | deleted | `{"type":"string","description":"The resource type.","readOnly":true}` |
| `definitions.AccessReviewDefaultSettings.properties.type__deleted` | deleted | `{"type":"string","description":"The resource type.","readOnly":true}` |
| `definitions.AccessReviewHistoryDefinition.properties.type__deleted` | deleted | `{"type":"string","description":"The resource type.","readOnly":true}` |
| `definitions.AccessReviewInstance.properties.type__deleted` | deleted | `{"type":"string","description":"The resource type.","readOnly":true}` |
| `definitions.AccessReviewScheduleDefinition.properties.type__deleted` | deleted | `{"type":"string","description":"The resource type.","readOnly":true}` |

### Changes for `x-ms-client-flatten`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccessReviewDecisionInsight.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.AccessReviewDecisionProperties.properties.principal['x-ms-client-flatten__deleted']` | deleted | `true` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccessReviewDecisionInsightProperties.properties.insightCreatedDateTime.format__deleted` | deleted | `date-time` |
| `definitions.AccessReviewDecisionUserSignInInsightProperties.properties.lastSignInDateTime.format__deleted` | deleted | `date-time` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccessReviewHistoryInstanceProperties.properties.reviewHistoryPeriodEndDateTime.readOnly__deleted` | deleted | `false` |
| `definitions.AccessReviewHistoryInstanceProperties.properties.reviewHistoryPeriodStartDateTime.readOnly__deleted` | deleted | `false` |

### Changes for `title`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorDefinition.title__deleted` | deleted | `Error` |
| `definitions.ErrorDefinitionProperties.title__deleted` | deleted | `Error` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AccessReviewDecisionProperties.properties.decision.description` | `The decision on the approval step. This value is initially set to NotReviewed. Approvers can take action of Approve/Deny` | `Represents a reviewer's decision for a given review` |
| `definitions.AccessReviewHistoryInstanceProperties.properties.status.description` | `Status of the requested review history instance data. This is either requested, in-progress, done or error. The state transitions are as follows - Requested -> InProgress -> Done -> Expired` | `This read-only field specifies the of the requested review history data. This is either requested, in-progress, done or error.` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewHistoryDefinitions/{historyDefinitionId}/instances'].get.responses.200.schema.$ref` | `#/definitions/AccessReviewHistoryDefinitionInstanceListResult` | `#/definitions/AccessReviewHistoryInstanceListResult` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewHistoryDefinitions/{historyDefinitionId}/instances'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewHistoryDefinitions/{historyDefinitionId}/instances/{instanceId}/generateDownloadUri'].post.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}'].delete.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}'].put.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}'].put.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/applyDecisions'].post.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/contactedReviewers'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/decisions'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/recordAllDecisions'].post.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/resetDecisions'].post.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/sendReminders'].post.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/stop'].post.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/stop'].post.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleSettings/default'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleSettings/default'].put.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.Authorization/accessReviewScheduleDefinitions'].get.description` | `Get access review instances assigned for my approval.` | `List a AccessReviewScheduleDefinition` |
| `paths['/providers/microsoft.Authorization/accessReviewScheduleDefinitions'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/acceptRecommendations'].post.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/contactedReviewers'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/decisions'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/decisions/{decisionId}'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/decisions/{decisionId}'].patch.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.Authorization/operations'].get.description` | `Lists the operations available from this provider.` | `List the operations for the provider` |
| `paths['/providers/microsoft.Authorization/operations'].get.responses.200.schema.$ref` | `#/definitions/OperationListResult` | `../../../common-types/resource-management/v3/types.json#/definitions/OperationListResult` |
| `paths['/providers/microsoft.Authorization/operations'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewHistoryDefinitions'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewHistoryDefinitions/{historyDefinitionId}'].delete.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewHistoryDefinitions/{historyDefinitionId}'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewHistoryDefinitions/{historyDefinitionId}'].put.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewHistoryDefinitions/{historyDefinitionId}/instances'].get.responses.200.schema.$ref` | `#/definitions/AccessReviewHistoryDefinitionInstanceListResult` | `#/definitions/AccessReviewHistoryInstanceListResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewHistoryDefinitions/{historyDefinitionId}/instances'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}'].delete.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}'].put.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}'].put.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/applyDecisions'].post.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/contactedReviewers'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/decisions'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/resetDecisions'].post.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/sendReminders'].post.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/stop'].post.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/stop'].post.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleSettings/default'].get.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleSettings/default'].put.responses.default.schema.$ref` | `#/definitions/ErrorDefinition` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |

