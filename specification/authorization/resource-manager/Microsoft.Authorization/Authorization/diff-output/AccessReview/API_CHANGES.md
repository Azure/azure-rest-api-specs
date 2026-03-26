## Swagger Changes

### Changes for `x-ms-skip-url-encoding`

| Path                                                                                                                                                                                                              | Change Type | Value  |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- | ------ |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewHistoryDefinitions'].get.parameters[1]['x-ms-skip-url-encoding__deleted']`                                                                         | deleted     | `true` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions'].get.parameters[1]['x-ms-skip-url-encoding__deleted']`                                                                        | deleted     | `true` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances'].get.parameters[2]['x-ms-skip-url-encoding__deleted']`                                       | deleted     | `true` |
| `paths['/{scope}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/decisions'].get.parameters[3]['x-ms-skip-url-encoding__deleted']`                        | deleted     | `true` |
| `paths['/providers/microsoft.Authorization/accessReviewScheduleDefinitions'].get.parameters[0]['x-ms-skip-url-encoding__deleted']`                                                                                | deleted     | `true` |
| `paths['/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances'].get.parameters[1]['x-ms-skip-url-encoding__deleted']`                                               | deleted     | `true` |
| `paths['/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/decisions'].get.parameters[2]['x-ms-skip-url-encoding__deleted']`                                | deleted     | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewHistoryDefinitions'].get.parameters[0]['x-ms-skip-url-encoding__deleted']`                                                  | deleted     | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions'].get.parameters[0]['x-ms-skip-url-encoding__deleted']`                                                 | deleted     | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances'].get.parameters[1]['x-ms-skip-url-encoding__deleted']`                | deleted     | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/decisions'].get.parameters[2]['x-ms-skip-url-encoding__deleted']` | deleted     | `true` |

### Changes for `x-ms-examples`

| Path                                                                                                                                                                                                        | Change Type | Value |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- | ----- |
| `paths['/providers/microsoft.Authorization/operations'].get['x-ms-examples__deleted']`                                                                                                                      | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewHistoryDefinitions'].get['x-ms-examples__deleted']`                                                                   | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewHistoryDefinitions/{historyDefinitionId}'].delete['x-ms-examples__deleted']`                                          | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewHistoryDefinitions/{historyDefinitionId}'].get['x-ms-examples__deleted']`                                             | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewHistoryDefinitions/{historyDefinitionId}'].put['x-ms-examples__deleted']`                                             | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewHistoryDefinitions/{historyDefinitionId}/instances'].get['x-ms-examples__deleted']`                                   | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewHistoryDefinitions/{historyDefinitionId}/instances/{instanceId}/generateDownloadUri'].post['x-ms-examples__deleted']` | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions'].get['x-ms-examples__deleted']`                                                                  | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}'].delete['x-ms-examples__deleted']`                                        | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}'].get['x-ms-examples__deleted']`                                           | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}'].put['x-ms-examples__deleted']`                                           | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances'].get['x-ms-examples__deleted']`                                 | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}'].get['x-ms-examples__deleted']`                            | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}'].put['x-ms-examples__deleted']`                            | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/applyDecisions'].post['x-ms-examples__deleted']`            | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/contactedReviewers'].get['x-ms-examples__deleted']`         | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/decisions'].get['x-ms-examples__deleted']`                  | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/resetDecisions'].post['x-ms-examples__deleted']`            | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/sendReminders'].post['x-ms-examples__deleted']`             | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/instances/{id}/stop'].post['x-ms-examples__deleted']`                      | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleDefinitions/{scheduleDefinitionId}/stop'].post['x-ms-examples__deleted']`                                     | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleSettings/default'].get['x-ms-examples__deleted']`                                                             | deleted     | `{}`  |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/accessReviewScheduleSettings/default'].put['x-ms-examples__deleted']`                                                             | deleted     | `{}`  |

### Changes for `tags`

| Path                                                                     | Change Type | Value            |
| ------------------------------------------------------------------------ | ----------- | ---------------- |
| `paths['/providers/microsoft.Authorization/operations'].get.tags__added` | added       | `["Operations"]` |

### Changes for `required`

| Path                                                                          | Change Type | Value       |
| ----------------------------------------------------------------------------- | ----------- | ----------- |
| `definitions.AccessReviewContactedReviewerListResult.required__added`         | added       | `["value"]` |
| `definitions.AccessReviewDecisionListResult.required__added`                  | added       | `["value"]` |
| `definitions.AccessReviewHistoryDefinitionInstanceListResult.required__added` | added       | `["value"]` |
| `definitions.AccessReviewHistoryDefinitionListResult.required__added`         | added       | `["value"]` |
| `definitions.AccessReviewInstanceListResult.required__added`                  | added       | `["value"]` |
| `definitions.AccessReviewScheduleDefinitionListResult.required__added`        | added       | `["value"]` |
| `definitions.OperationListResult.required__added`                             | added       | `["value"]` |

### Changes for `allOf`

| Path                                                      | Change Type | Value                                                                                             |
| --------------------------------------------------------- | ----------- | ------------------------------------------------------------------------------------------------- |
| `definitions.AccessReviewDecision.allOf__added`           | added       | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}]` |
| `definitions.AccessReviewDefaultSettings.allOf__added`    | added       | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}]` |
| `definitions.AccessReviewHistoryDefinition.allOf__added`  | added       | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}]` |
| `definitions.AccessReviewInstance.allOf__added`           | added       | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}]` |
| `definitions.AccessReviewScheduleDefinition.allOf__added` | added       | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}]` |

### Changes for `id`

| Path                                                                | Change Type | Value                                                                                                     |
| ------------------------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.AccessReviewDecision.properties.id__deleted`           | deleted     | `{"type":"string","description":"The access review decision id.","readOnly":true}`                        |
| `definitions.AccessReviewDefaultSettings.properties.id__deleted`    | deleted     | `{"type":"string","description":"The access review default settings id. This is only going to be defa...` |
| `definitions.AccessReviewHistoryDefinition.properties.id__deleted`  | deleted     | `{"type":"string","description":"The access review history definition id.","readOnly":true}`              |
| `definitions.AccessReviewInstance.properties.id__deleted`           | deleted     | `{"type":"string","description":"The access review instance id.","readOnly":true}`                        |
| `definitions.AccessReviewScheduleDefinition.properties.id__deleted` | deleted     | `{"type":"string","description":"The access review schedule definition id.","readOnly":true}`             |

### Changes for `name`

| Path                                                                  | Change Type | Value                                                                                                     |
| --------------------------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.AccessReviewDecision.properties.name__deleted`           | deleted     | `{"type":"string","description":"The access review decision name.","readOnly":true}`                      |
| `definitions.AccessReviewDefaultSettings.properties.name__deleted`    | deleted     | `{"type":"string","description":"The access review default settings name. This is always going to be ...` |
| `definitions.AccessReviewHistoryDefinition.properties.name__deleted`  | deleted     | `{"type":"string","description":"The access review history definition unique id.","readOnly":true}`       |
| `definitions.AccessReviewInstance.properties.name__deleted`           | deleted     | `{"type":"string","description":"The access review instance name.","readOnly":true}`                      |
| `definitions.AccessReviewScheduleDefinition.properties.name__deleted` | deleted     | `{"type":"string","description":"The access review schedule definition unique id.","readOnly":true}`      |

### Changes for `type`

| Path                                                                                                    | Change Type | Value                                                                  |
| ------------------------------------------------------------------------------------------------------- | ----------- | ---------------------------------------------------------------------- |
| `definitions.AccessReviewDecision.properties.type__deleted`                                             | deleted     | `{"type":"string","description":"The resource type.","readOnly":true}` |
| `definitions.AccessReviewDecisionInsightProperties.properties.insightCreatedDateTime.type__added`       | added       | `string`                                                               |
| `definitions.AccessReviewDecisionUserSignInInsightProperties.properties.lastSignInDateTime.type__added` | added       | `string`                                                               |
| `definitions.AccessReviewDefaultSettings.properties.type__deleted`                                      | deleted     | `{"type":"string","description":"The resource type.","readOnly":true}` |
| `definitions.AccessReviewHistoryDefinition.properties.type__deleted`                                    | deleted     | `{"type":"string","description":"The resource type.","readOnly":true}` |
| `definitions.AccessReviewInstance.properties.type__deleted`                                             | deleted     | `{"type":"string","description":"The resource type.","readOnly":true}` |
| `definitions.AccessReviewScheduleDefinition.properties.type__deleted`                                   | deleted     | `{"type":"string","description":"The resource type.","readOnly":true}` |

### Changes for `x-ms-client-flatten`

| Path                                                                                              | Change Type | Value  |
| ------------------------------------------------------------------------------------------------- | ----------- | ------ |
| `definitions.AccessReviewDecisionInsight.properties.properties['x-ms-client-flatten__deleted']`   | deleted     | `true` |
| `definitions.AccessReviewDecisionProperties.properties.principal['x-ms-client-flatten__deleted']` | deleted     | `true` |

### Changes for `x-nullable`

| Path                                                                                           | Change Type | Value   |
| ---------------------------------------------------------------------------------------------- | ----------- | ------- |
| `definitions.AccessReviewHistoryDefinitionProperties.properties.scopes['x-nullable__deleted']` | deleted     | `false` |
| `definitions.AccessReviewInstanceProperties.properties.endDateTime['x-nullable__deleted']`     | deleted     | `false` |
| `definitions.AccessReviewInstanceProperties.properties.startDateTime['x-nullable__deleted']`   | deleted     | `false` |

### Changes for `readOnly`

| Path                                                                                                              | Change Type | Value   |
| ----------------------------------------------------------------------------------------------------------------- | ----------- | ------- |
| `definitions.AccessReviewHistoryInstanceProperties.properties.reviewHistoryPeriodEndDateTime.readOnly__deleted`   | deleted     | `false` |
| `definitions.AccessReviewHistoryInstanceProperties.properties.reviewHistoryPeriodStartDateTime.readOnly__deleted` | deleted     | `false` |

## Modified Values

| Path                                                                              | Old Value                                                                                                                                                                                       | New Value                                                                                                                        |
| --------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| `definitions.AccessReviewDecisionProperties.properties.decision.description`      | `The decision on the approval step. This value is initially set to NotReviewed. Approvers can take action of Approve/Deny`                                                                      | `Represents a reviewer's decision for a given review`                                                                            |
| `definitions.AccessReviewHistoryInstanceProperties.properties.status.description` | `Status of the requested review history instance data. This is either requested, in-progress, done or error. The state transitions are as follows - Requested -> InProgress -> Done -> Expired` | `This read-only field specifies the of the requested review history data. This is either requested, in-progress, done or error.` |
