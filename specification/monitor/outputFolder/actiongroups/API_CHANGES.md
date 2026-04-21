## Swagger Changes

### Changes for `x-ms-code-generation-settings`

| Path | Change Type | Value |
|------|------------|-------|
| `info['x-ms-code-generation-settings__deleted']` | deleted | `{"name":"MonitorManagementClient"}` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActionGroupPatchBody.properties.identity.description__added` | added | `Managed service identity (system assigned and/or user assigned identities)` |
| `definitions.TestNotificationDetailsResponse.properties.context.description__added` | added | `The context info` |
| `info.description__added` | added | `Monitor Management Client` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/actionGroups/{actionGroupName}/createNotifications'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"The location header that has the polling uri."}` |

### Changes for `Location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/actionGroups/{actionGroupName}/createNotifications'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |

### Changes for `AzureResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureResource__deleted` | deleted | `{"type":"object","description":"An azure resource object","properties":{"id":{"type":"string","descr...` |

### Changes for `ErrorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorResponse__deleted` | deleted | `{"type":"object","description":"Describes the format of Error response.","properties":{"code":{"type...` |

### Changes for `Microsoft.Common.ErrorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Microsoft.Common.ErrorResponse__added']` | added | `{"type":"object","description":"Describes the format of Error response.","properties":{"code":{"type...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActionGroupList.required__added` | added | `["value"]` |

### Changes for `identity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActionGroupResource.properties.identity__added` | added | `{"$ref":"../../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Man...` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IncidentReceiver.properties.connection.type__deleted` | deleted | `object` |
| `definitions.TestNotificationDetailsResponse.properties.context.type__deleted` | deleted | `object` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.ActionGroupPatchBody.properties.identity.$ref` | `../../../../../../common-types/resource-management/v5/managedidentity.json#/definitions/ManagedServiceIdentity` | `../../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/ManagedServiceIdentity` |
| `definitions.ActionGroupResource.allOf[0].$ref` | `#/definitions/AzureResource` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.AutomationRunbookReceiver.properties.managedIdentity.description` | `The principal id of the managed identity. The value can be "None", "SystemAssigned" ` | `The principal id of the managed identity. The value can be "None", "SystemAssigned"` |
| `definitions.AzureFunctionReceiver.properties.managedIdentity.description` | `The principal id of the managed identity. The value can be "None", "SystemAssigned" ` | `The principal id of the managed identity. The value can be "None", "SystemAssigned"` |
| `definitions.EventHubReceiver.properties.managedIdentity.description` | `The principal id of the managed identity. The value can be "None", "SystemAssigned" ` | `The principal id of the managed identity. The value can be "None", "SystemAssigned"` |
| `definitions.LogicAppReceiver.properties.managedIdentity.description` | `The principal id of the managed identity. The value can be "None", "SystemAssigned" ` | `The principal id of the managed identity. The value can be "None", "SystemAssigned"` |
| `definitions.WebhookReceiver.properties.managedIdentity.description` | `The principal id of the managed identity. The value can be "None", "SystemAssigned" ` | `The principal id of the managed identity. The value can be "None", "SystemAssigned"` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/actionGroups'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/Microsoft.Common.ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/actionGroups'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/Microsoft.Common.ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/actionGroups'].get['x-ms-examples']['List action groups at resource group level'].$ref` | `./examples/listActionGroups.json` | `./examples/listActionGroupsByResourceGroup.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/actionGroups/{actionGroupName}'].delete.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/Microsoft.Common.ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/actionGroups/{actionGroupName}'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/Microsoft.Common.ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/actionGroups/{actionGroupName}'].patch.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/Microsoft.Common.ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/actionGroups/{actionGroupName}'].put.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/Microsoft.Common.ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/actionGroups/{actionGroupName}/createNotifications'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/Microsoft.Common.ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/actionGroups/{actionGroupName}/notificationStatus/{notificationId}'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/Microsoft.Common.ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/actionGroups/{actionGroupName}/subscribe'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/Microsoft.Common.ErrorResponse` |

