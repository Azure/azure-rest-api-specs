## Swagger Changes

### Changes for `x-ms-odata`

| Path                                                                                                                                                                                                                                                | Change Type | Value                                |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- | ------------------------------------ |
| `paths['/{scope}/providers/microsoft.Authorization/denyAssignments'].get['x-ms-odata__deleted']`                                                                                                                                                    | deleted     | `#/definitions/DenyAssignmentFilter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/denyAssignments'].get['x-ms-odata__deleted']`                                                                                                                             | deleted     | `#/definitions/DenyAssignmentFilter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{parentResourcePath}/{resourceType}/{resourceName}/providers/microsoft.Authorization/denyAssignments'].get['x-ms-odata__deleted']` | deleted     | `#/definitions/DenyAssignmentFilter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Authorization/denyAssignments'].get['x-ms-odata__deleted']`                                                                                          | deleted     | `#/definitions/DenyAssignmentFilter` |

### Changes for `DenyAssignmentFilter`

| Path                                        | Change Type | Value                                                                                                     |
| ------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.DenyAssignmentFilter__deleted` | deleted     | `{"type":"object","description":"Deny Assignments filter","properties":{"denyAssignmentName":{"type":...` |

### Changes for `Principal`

| Path                           | Change Type | Value                                                                                                     |
| ------------------------------ | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.Principal__added` | added       | `{"type":"object","description":"The name of the entity last modified it","properties":{"id":{"type":...` |

### Changes for `allOf`

| Path                                      | Change Type | Value                                                                                             |
| ----------------------------------------- | ----------- | ------------------------------------------------------------------------------------------------- |
| `definitions.DenyAssignment.allOf__added` | added       | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}]` |

### Changes for `id`

| Path                                                | Change Type | Value                                                                       |
| --------------------------------------------------- | ----------- | --------------------------------------------------------------------------- |
| `definitions.DenyAssignment.properties.id__deleted` | deleted     | `{"type":"string","description":"The deny assignment ID.","readOnly":true}` |

### Changes for `name`

| Path                                                  | Change Type | Value                                                                         |
| ----------------------------------------------------- | ----------- | ----------------------------------------------------------------------------- |
| `definitions.DenyAssignment.properties.name__deleted` | deleted     | `{"type":"string","description":"The deny assignment name.","readOnly":true}` |

### Changes for `type`

| Path                                                  | Change Type | Value                                                                         |
| ----------------------------------------------------- | ----------- | ----------------------------------------------------------------------------- |
| `definitions.DenyAssignment.properties.type__deleted` | deleted     | `{"type":"string","description":"The deny assignment type.","readOnly":true}` |

### Changes for `required`

| Path                                                   | Change Type | Value       |
| ------------------------------------------------------ | ----------- | ----------- |
| `definitions.DenyAssignmentListResult.required__added` | added       | `["value"]` |

## Modified Values

| Path                                                                                                                                                                                                                                                       | Old Value                                                                                     | New Value                                                                            |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| `definitions.DenyAssignmentProperties.properties.excludePrincipals.items.$ref`                                                                                                                                                                             | `./common-types.json#/definitions/Principal`                                                  | `#/definitions/Principal`                                                            |
| `definitions.DenyAssignmentProperties.properties.principals.items.$ref`                                                                                                                                                                                    | `./common-types.json#/definitions/Principal`                                                  | `#/definitions/Principal`                                                            |
| `paths./{denyAssignmentId}.get.responses.default.schema.$ref`                                                                                                                                                                                              | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/denyAssignments'].get.responses.default.schema.$ref`                                                                                                                                                    | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Authorization/denyAssignments/{denyAssignmentId}'].get.responses.default.schema.$ref`                                                                                                                                 | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/denyAssignments'].get.responses.default.schema.$ref`                                                                                                                             | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{parentResourcePath}/{resourceType}/{resourceName}/providers/microsoft.Authorization/denyAssignments'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Authorization/denyAssignments'].get.responses.default.schema.$ref`                                                                                          | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
