## Swagger Changes

### Changes for `x-ms-odata`

| Path                                                                                                                                                                                                                           | Change Type | Value                                |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------- | ------------------------------------ |
| `paths['/{scope}/providers/microsoft.Authorization/roleAssignments'].get['x-ms-odata__deleted']`                                                                                                                               | deleted     | `#/definitions/RoleAssignmentFilter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/roleAssignments'].get['x-ms-odata__deleted']`                                                                                                        | deleted     | `#/definitions/RoleAssignmentFilter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}/providers/microsoft.Authorization/roleAssignments'].get['x-ms-odata__deleted']` | deleted     | `#/definitions/RoleAssignmentFilter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Authorization/roleAssignments'].get['x-ms-odata__deleted']`                                                                     | deleted     | `#/definitions/RoleAssignmentFilter` |

### Changes for `required`

| Path                                                                                                                                                                                                                                  | Change Type | Value       |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- | ----------- |
| `definitions.RoleAssignmentListResult.required__added`                                                                                                                                                                                | added       | `["value"]` |
| `paths['/{scope}/providers/microsoft.Authorization/roleAssignments'].get.parameters[1].required__added`                                                                                                                               | added       | `true`      |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}/providers/microsoft.Authorization/roleAssignments'].get.parameters[3].required__added` | added       | `true`      |

### Changes for `RoleAssignmentFilter`

| Path                                        | Change Type | Value                                                                                                     |
| ------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.RoleAssignmentFilter__deleted` | deleted     | `{"type":"object","description":"Role Assignments filter","properties":{"principalId":{"type":"string...` |

### Changes for `ValidationResponse`

| Path                                      | Change Type | Value                                                                                                     |
| ----------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.ValidationResponse__deleted` | deleted     | `{"type":"object","description":"Validation response","properties":{"isValid":{"type":"boolean","desc...` |

### Changes for `ValidationResponseErrorInfo`

| Path                                               | Change Type | Value                                                                                                     |
| -------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.ValidationResponseErrorInfo__deleted` | deleted     | `{"type":"object","description":"Failed validation result details","properties":{"code":{"type":"stri...` |

### Changes for `allOf`

| Path                                      | Change Type | Value                                                                                             |
| ----------------------------------------- | ----------- | ------------------------------------------------------------------------------------------------- |
| `definitions.RoleAssignment.allOf__added` | added       | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}]` |

### Changes for `id`

| Path                                                | Change Type | Value                                                                       |
| --------------------------------------------------- | ----------- | --------------------------------------------------------------------------- |
| `definitions.RoleAssignment.properties.id__deleted` | deleted     | `{"type":"string","description":"The role assignment ID.","readOnly":true}` |

### Changes for `name`

| Path                                                  | Change Type | Value                                                                         |
| ----------------------------------------------------- | ----------- | ----------------------------------------------------------------------------- |
| `definitions.RoleAssignment.properties.name__deleted` | deleted     | `{"type":"string","description":"The role assignment name.","readOnly":true}` |

### Changes for `type`

| Path                                                  | Change Type | Value                                                                         |
| ----------------------------------------------------- | ----------- | ----------------------------------------------------------------------------- |
| `definitions.RoleAssignment.properties.type__deleted` | deleted     | `{"type":"string","description":"The role assignment type.","readOnly":true}` |

### Changes for `x-ms-identifiers`

| Path                                                                               | Change Type | Value                         |
| ---------------------------------------------------------------------------------- | ----------- | ----------------------------- |
| `definitions.RoleAssignmentListResult.properties.value['x-ms-identifiers__added']` | added       | `["roleAssignmentName","id"]` |

## Modified Values

| Path                                                                                                                                                                                                                                  | Old Value                                                                                     | New Value                                                                            |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| `paths./{roleAssignmentId}.delete.responses.default.schema.$ref`                                                                                                                                                                      | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths./{roleAssignmentId}.get.responses.default.schema.$ref`                                                                                                                                                                         | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths./{roleAssignmentId}.put.responses.default.schema.$ref`                                                                                                                                                                         | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/roleAssignments'].get.parameters[1].in`                                                                                                                                            | `query`                                                                                       | `path`                                                                               |
| `paths['/{scope}/providers/microsoft.Authorization/roleAssignments'].get.parameters[1].name`                                                                                                                                          | `$filter`                                                                                     | `scope`                                                                              |
| `paths['/{scope}/providers/microsoft.Authorization/roleAssignments'].get.responses.default.schema.$ref`                                                                                                                               | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/roleAssignments/{roleAssignmentName}'].delete.responses.default.schema.$ref`                                                                                                       | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/roleAssignments/{roleAssignmentName}'].get.responses.default.schema.$ref`                                                                                                          | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/roleAssignments/{roleAssignmentName}'].put.responses.default.schema.$ref`                                                                                                          | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/roleAssignments'].get.responses.default.schema.$ref`                                                                                                        | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}/providers/microsoft.Authorization/roleAssignments'].get.parameters[3].in`              | `query`                                                                                       | `path`                                                                               |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}/providers/microsoft.Authorization/roleAssignments'].get.parameters[3].name`            | `$filter`                                                                                     | `resourceProviderNamespace`                                                          |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}/providers/microsoft.Authorization/roleAssignments'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Authorization/roleAssignments'].get.responses.default.schema.$ref`                                                                     | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
