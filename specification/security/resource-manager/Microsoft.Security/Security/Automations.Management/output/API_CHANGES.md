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

### Changes for `SecurityContactPropertiesNotificationsByRole`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityContactPropertiesNotificationsByRole__added` | added | `{"type":"object","description":"Defines whether to send email notifications from Microsoft Defender ...` |

### Changes for `Tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Tags__added` | added | `{"type":"object","description":"A list of key value pairs that describe the resource.","properties":...` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Automation.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Automation.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |

### Changes for `kind`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Automation.properties.kind__added` | added | `{"type":"string","description":"Kind of the resource"}` |

### Changes for `etag`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Automation.properties.etag__added` | added | `{"type":"string","description":"Entity tag is used for comparing two or more entities from the same ...` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AutomationActionLogicApp.allOf[0].readOnly__deleted` | deleted | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityContactProperties.properties.notificationsByRole.type__deleted` | deleted | `object` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityContactProperties.properties.notificationsByRole.properties__deleted` | deleted | `{"state":{"type":"string","description":"Defines whether to send email notifications from AMicrosoft...` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityContactProperties.properties.notificationsByRole.$ref__added` | added | `#/definitions/SecurityContactPropertiesNotificationsByRole` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.Automation.allOf[0].$ref` | `./common/v1/types.json#/definitions/TrackedResource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/Resource` |
| `definitions.AutomationRuleSet.description` | `A rule set which evaluates all its rules upon an event interception. Only when all the included rules in the rule set will be evaluated as 'true', will the event trigger the defined actions. ` | `A rule set which evaluates all its rules upon an event interception. Only when all the included rules in the rule set will be evaluated as 'true', will the event trigger the defined actions.` |
| `definitions.AutomationUpdateModel.allOf[0].$ref` | `./common/v1/types.json#/definitions/Tags` | `#/definitions/Tags` |
| `definitions.SecurityContact.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/automations'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/securityContacts'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/securityContacts/{securityContactName}'].delete.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/securityContacts/{securityContactName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/securityContacts/{securityContactName}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/automations'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/automations/{automationName}'].delete.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/automations/{automationName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/automations/{automationName}'].patch.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/automations/{automationName}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/automations/{automationName}/validate'].post.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |

