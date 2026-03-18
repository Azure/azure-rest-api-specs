## Swagger Changes

### Changes for `summary`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/apiCollections'].get.summary__deleted` | deleted | `Gets a list of API collections within a subscription` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections'].get.summary__deleted` | deleted | `Gets a list of onboarded Azure API Management APIs` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections/{apiId}'].delete.summary__deleted` | deleted | `Offboard an Azure API Management API from Microsoft Defender for APIs` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections/{apiId}'].get.summary__deleted` | deleted | `Gets an onboarded Azure API Management API` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections/{apiId}'].put.summary__deleted` | deleted | `Onboard an Azure API Management API to Microsoft Defender for APIs` |

### Changes for `minLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections'].get.parameters[0].minLength__deleted` | deleted | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections/{apiId}'].delete.parameters[0].minLength__deleted` | deleted | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections/{apiId}'].get.parameters[0].minLength__deleted` | deleted | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections/{apiId}'].put.parameters[0].minLength__deleted` | deleted | `1` |

### Changes for `maxLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections'].get.parameters[0].maxLength__deleted` | deleted | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections/{apiId}'].delete.parameters[0].maxLength__deleted` | deleted | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections/{apiId}'].get.parameters[0].maxLength__deleted` | deleted | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections/{apiId}'].put.parameters[0].maxLength__deleted` | deleted | `50` |

### Changes for `pattern`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections'].get.parameters[0].pattern__deleted` | deleted | `^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections/{apiId}'].delete.parameters[0].pattern__deleted` | deleted | `^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections/{apiId}'].get.parameters[0].pattern__deleted` | deleted | `^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections/{apiId}'].put.parameters[0].pattern__deleted` | deleted | `^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApiCollection.properties.properties.description__added` | added | `Describes the properties of an API collection.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections/{apiId}'].put.responses.201.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/apiCollections'].get.tags__deleted` | deleted | `["D4APICollectionList"]` |

### Changes for `x-ms-pageable`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/apiCollections'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApiCollectionList.required__added` | added | `["value"]` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApiCollectionList.properties.value.readOnly__deleted` | deleted | `true` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.ApiCollection.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `info.description` | `API spec for Microsoft.Security (Microsoft Defender for Cloud) resource provider` | `API spec for Microsoft.Security (Azure Security Center) resource provider` |
| `info.title` | `Microsoft Defender for Cloud` | `SecurityCenter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/apiCollections'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections/{apiId}'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections/{apiId}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/providers/microsoft.Security/apiCollections/{apiId}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/apiCollections'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |

