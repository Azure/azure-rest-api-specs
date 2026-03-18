## Swagger Changes

### Changes for `schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/assignments/{assignmentId}'].delete.responses.default.schema__added` | added | `{"$ref":"../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorRespo...` |

### Changes for `AssignmentPropertiesAdditionalData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AssignmentPropertiesAdditionalData__added` | added | `{"type":"object","description":"Additional data about the assignment","properties":{"exemptionCatego...` |

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

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Assignment.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |
| `definitions.Standard.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Assignment.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.Standard.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Assignment.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.Standard.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |

### Changes for `kind`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Assignment.properties.kind__added` | added | `{"type":"string","description":"Kind of the resource"}` |
| `definitions.Standard.properties.kind__added` | added | `{"type":"string","description":"Kind of the resource"}` |

### Changes for `etag`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Assignment.properties.etag__added` | added | `{"type":"string","description":"Entity tag is used for comparing two or more entities from the same ...` |
| `definitions.Standard.properties.etag__added` | added | `{"type":"string","description":"Entity tag is used for comparing two or more entities from the same ...` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AssignmentProperties.properties.additionalData.type__deleted` | deleted | `object` |
| `definitions.AssignmentProperties.properties.metadata.type__deleted` | deleted | `object` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AssignmentProperties.properties.additionalData.properties__deleted` | deleted | `{"exemptionCategory":{"type":"string","description":"Exemption category of this assignment"}}` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AssignmentProperties.properties.additionalData.$ref__added` | added | `#/definitions/AssignmentPropertiesAdditionalData` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.Assignment.allOf[0].$ref` | `./common/v1/types.json#/definitions/TrackedResource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/Resource` |
| `definitions.Standard.allOf[0].$ref` | `./common/v1/types.json#/definitions/TrackedResource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/Resource` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/assignments'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/standards'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/assignments'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/assignments/{assignmentId}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/assignments/{assignmentId}'].put.description` | `Create a security assignment on the given scope. Will create/update the required standard assignment. ` | `Create a security assignment on the given scope. Will create/update the required standard assignment.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/assignments/{assignmentId}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/standards'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/standards/{standardId}'].delete.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/standards/{standardId}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/standards/{standardId}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |

