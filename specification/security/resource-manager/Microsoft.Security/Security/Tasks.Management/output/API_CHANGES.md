## Swagger Changes

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/tasks'].get.parameters[0].$ref__deleted` | deleted | `./common/v1/types.json#/parameters/AscLocation` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/tasks'].get.parameters[1].$ref__deleted` | deleted | `./common/v1/types.json#/parameters/ODataFilter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/tasks'].get.parameters[0].$ref__deleted` | deleted | `./common/v1/types.json#/parameters/ODataFilter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/tasks'].get.parameters[0].$ref__deleted` | deleted | `./common/v1/types.json#/parameters/AscLocation` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/tasks'].get.parameters[1].$ref__deleted` | deleted | `./common/v1/types.json#/parameters/ODataFilter` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/tasks'].get.parameters[0].name__added` | added | `ascLocation` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/tasks'].get.parameters[1].name__added` | added | `$filter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/tasks'].get.parameters[0].name__added` | added | `$filter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/tasks'].get.parameters[0].name__added` | added | `ascLocation` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/tasks'].get.parameters[1].name__added` | added | `$filter` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/tasks'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/tasks'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/tasks'].get.parameters[0].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/tasks'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/tasks'].get.parameters[1].in__added` | added | `query` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityTaskList.required__added` | added | `["value"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/tasks'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/tasks'].get.parameters[0].required__added` | added | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/tasks'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/tasks'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/tasks'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/tasks'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/tasks'].get.parameters[1].type__added` | added | `string` |

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
| `definitions.SecurityTask.properties.properties.description__added` | added | `Describes properties of a task.` |
| `definitions.SecurityTaskProperties.properties.securityTaskParameters.description__added` | added | `Changing set of properties, depending on the task type that is derived from the name field` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityTaskList.properties.value.readOnly__deleted` | deleted | `true` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.SecurityTask.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.SecurityTaskParameters.additionalProperties` | `true` | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/tasks'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/tasks/{taskName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/tasks/{taskName}/{taskUpdateActionType}'].post.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/tasks'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/tasks'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/tasks/{taskName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/tasks/{taskName}/{taskUpdateActionType}'].post.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |

