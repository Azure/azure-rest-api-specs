## Swagger Changes

### Changes for `x-ms-code-generation-settings`

| Path | Change Type | Value |
|------|------------|-------|
| `info['x-ms-code-generation-settings__deleted']` | deleted | `{"name":"MonitorManagementClient"}` |

### Changes for `ActionGroup`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActionGroup__deleted` | deleted | `{"type":"object","description":"A pointer to an Azure Action Group.","properties":{"actionGroupId":{...` |

### Changes for `AzureResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureResource__deleted` | deleted | `{"type":"object","description":"An Azure resource object.","properties":{"id":{"type":"string","desc...` |

### Changes for `ErrorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorResponse__deleted` | deleted | `{"type":"object","description":"The error response.","properties":{"code":{"type":"string","descript...` |

### Changes for `ActivityLogAlertActionGroup`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActivityLogAlertActionGroup__added` | added | `{"type":"object","description":"A pointer to an Azure Action Group.","properties":{"actionGroupId":{...` |

### Changes for `ActivityLogAlertErrorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActivityLogAlertErrorResponse__added` | added | `{"type":"object","description":"The error response.","properties":{"code":{"type":"string","descript...` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActivityLogAlertResource.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActivityLogAlertResource.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |

### Changes for `title`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AlertRuleAnyOfOrLeafCondition.properties.anyOf.title__deleted` | deleted | `An Activity Log Alert rule 'anyOf' condition.` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AlertRuleList.required__added` | added | `["value"]` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.ActionList.properties.actionGroups.items.$ref` | `#/definitions/ActionGroup` | `#/definitions/ActivityLogAlertActionGroup` |
| `definitions.ActivityLogAlertResource.allOf[0].$ref` | `#/definitions/AzureResource` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/Resource` |
| `definitions.AlertRuleAnyOfOrLeafCondition.description` | `An Activity Log Alert rule condition that is met when all its member conditions are met.
Each condition can be of one of the following types:
__Important__: Each type has its unique subset of properties. Properties from different types CANNOT exist in one condition.
   * __Leaf Condition -__ must contain 'field' and either 'equals' or 'containsAny'.
  _Please note, 'anyOf' should __not__ be set in a Leaf Condition._
  * __AnyOf Condition -__ must contain __only__ 'anyOf' (which is an array of Leaf Conditions).
  _Please note, 'field', 'equals' and 'containsAny' should __not__ be set in an AnyOf Condition._
` | `An Activity Log Alert rule condition that is met when all its member conditions are met.
Each condition can be of one of the following types:
__Important__: Each type has its unique subset of properties. Properties from different types CANNOT exist in one condition.
* __Leaf Condition -__ must contain 'field' and either 'equals' or 'containsAny'.
_Please note, 'anyOf' should __not__ be set in a Leaf Condition._
* __AnyOf Condition -__ must contain __only__ 'anyOf' (which is an array of Leaf Conditions).
_Please note, 'field', 'equals' and 'containsAny' should __not__ be set in an AnyOf Condition._` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/activityLogAlerts'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/ActivityLogAlertErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/activityLogAlerts'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/ActivityLogAlertErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/activityLogAlerts/{activityLogAlertName}'].delete.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/ActivityLogAlertErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/activityLogAlerts/{activityLogAlertName}'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/ActivityLogAlertErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/activityLogAlerts/{activityLogAlertName}'].patch.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/ActivityLogAlertErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/activityLogAlerts/{activityLogAlertName}'].put.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/ActivityLogAlertErrorResponse` |

