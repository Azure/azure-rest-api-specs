## Swagger Changes

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MapsAccountProperties.properties.linkedResources.$ref__deleted` | deleted | `#/definitions/LinkedResources` |
| `definitions.MapsAccountProperties.properties.locations.$ref__deleted` | deleted | `#/definitions/Locations` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Maps/locations/{location}/operationResults/{operationId}'].get.parameters[1].$ref__deleted` | deleted | `../../../../../../common-types/resource-management/v6/types.json#/parameters/OperationIdParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Maps/locations/{location}/operationStatuses/{operationId}'].get.parameters[1].$ref__deleted` | deleted | `../../../../../../common-types/resource-management/v6/types.json#/parameters/OperationIdParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].$ref__added` | added | `../../../../../../common-types/resource-management/v6/privatelinks.json#/parameters/PrivateEndpointConnectionName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].$ref__added` | added | `../../../../../../common-types/resource-management/v6/privatelinks.json#/parameters/PrivateEndpointConnectionName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[1].$ref__added` | added | `../../../../../../common-types/resource-management/v6/privatelinks.json#/parameters/PrivateEndpointConnectionName` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Maps/locations/{location}/operationResults/{operationId}'].get.parameters[1].name__added` | added | `operationId` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Maps/locations/{location}/operationStatuses/{operationId}'].get.parameters[1].name__added` | added | `operationId` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].name__deleted` | deleted | `privateEndpointConnectionName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].name__deleted` | deleted | `privateEndpointConnectionName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[1].name__deleted` | deleted | `privateEndpointConnectionName` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Maps/locations/{location}/operationResults/{operationId}'].get.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Maps/locations/{location}/operationStatuses/{operationId}'].get.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[1].in__deleted` | deleted | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CreatorList.required__added` | added | `["value"]` |
| `definitions.MapsAccounts.required__added` | added | `["value"]` |
| `definitions.PrivateEndpointConnectionList.required__added` | added | `["value"]` |
| `definitions.PrivateLinkResourceList.required__added` | added | `["value"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Maps/locations/{location}/operationResults/{operationId}'].get.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Maps/locations/{location}/operationStatuses/{operationId}'].get.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[1].required__deleted` | deleted | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MapsAccountProperties.properties.linkedResources.type__added` | added | `array` |
| `definitions.MapsAccountProperties.properties.locations.type__added` | added | `array` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Maps/locations/{location}/operationResults/{operationId}'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Maps/locations/{location}/operationStatuses/{operationId}'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[1].type__deleted` | deleted | `string` |

### Changes for `minLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Maps/locations/{location}/operationResults/{operationId}'].get.parameters[1].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Maps/locations/{location}/operationStatuses/{operationId}'].get.parameters[1].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[1].minLength__deleted` | deleted | `3` |

### Changes for `maxLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].maxLength__deleted` | deleted | `98` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].maxLength__deleted` | deleted | `98` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[1].maxLength__deleted` | deleted | `98` |

### Changes for `pattern`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].pattern__deleted` | deleted | `^[^%&:\\\\/#?]+$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].pattern__deleted` | deleted | `^[^%&:\\\\/#?]+$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[1].pattern__deleted` | deleted | `^[^%&:\\\\/#?]+$` |

### Changes for `Azure-AsyncOperation`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"Operation Status Location URI"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.responses.201.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"Operation Status Location URI"}` |

### Changes for `Location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.responses.201.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |

### Changes for `LinkedResources`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LinkedResources__deleted` | deleted | `{"type":"array","description":"The array of associated resources to the Maps account. Linked resourc...` |

### Changes for `Locations`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Locations__deleted` | deleted | `{"type":"array","description":"The list of data processing locations for the Maps Account.","items":...` |

### Changes for `Azure.ResourceManager.EncryptionProperty`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.EncryptionProperty__added']` | added | `{"type":"object","description":"Model used only to spread in the `encryption` envelope property for ...` |

### Changes for `LocationsItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LocationsItem__added` | added | `{"type":"object","description":"Data processing location.","properties":{"locationName":{"type":"str...` |

### Changes for `PrivateLinkResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateLinkResource__added` | added | `{"type":"object","description":"A private link resource.","properties":{"properties":{"$ref":"../../...` |

### Changes for `minimum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccountSasParameters.properties.maxRatePerSecond.minimum__deleted` | deleted | `0` |

### Changes for `exclusiveMinimum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccountSasParameters.properties.maxRatePerSecond.exclusiveMinimum__deleted` | deleted | `true` |

### Changes for `maxItems`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CorsRules.properties.corsRules.maxItems__deleted` | deleted | `5` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CorsRules.properties.corsRules.items.description__deleted` | deleted | `Specifies a CORS rule for the Maps Account.` |
| `definitions.MapsAccount.properties.identity.description__added` | added | `The managed service identities assigned to this resource.` |
| `definitions.MapsAccountProperties.properties.encryption.description__added` | added | `All encryption configuration for a resource.` |
| `definitions.MapsAccountProperties.properties.linkedResources.description__added` | added | `The array of associated resources to the Maps account. Linked resource in the array cannot individually update, you must update all linked resources in the array together. These resources may be used on operations on the Azure Maps REST API. Access is controlled by the Maps Account Managed Identity(s) permissions to those resource(s).` |
| `definitions.MapsAccountUpdateParameters.properties.identity.description__added` | added | `Managed service identity (system assigned and/or user assigned identities)` |

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Creator.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v6/types.json#/definitions/systemData","...` |
| `definitions.MapsAccount.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v6/types.json#/definitions/systemData"}` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CreatorList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.MapsAccounts.properties.value.readOnly__deleted` | deleted | `true` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MapsAccountProperties.properties.disableLocalAuth.default__deleted` | deleted | `false` |

### Changes for `items`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MapsAccountProperties.properties.linkedResources.items__added` | added | `{"$ref":"#/definitions/LinkedResource"}` |
| `definitions.MapsAccountProperties.properties.locations.items__added` | added | `{"$ref":"#/definitions/LocationsItem"}` |

### Changes for `x-nullable`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateEndpointConnectionList.properties.nextLink['x-nullable__deleted']` | deleted | `true` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.CorsRules.description` | `Sets the CORS rules. You can include up to five CorsRule elements in the request. ` | `Sets the CORS rules. You can include up to five CorsRule elements in the request.` |
| `definitions.CorsRules.properties.corsRules.description` | `The list of CORS rules. You can include up to five CorsRule elements in the request. ` | `The list of CORS rules. You can include up to five CorsRule elements in the request.` |
| `definitions.MapsAccountProperties.properties.encryption.$ref` | `../../../../../../common-types/resource-management/v5/customermanagedkeys.json#/definitions/encryption` | `#/definitions/Azure.ResourceManager.EncryptionProperty` |
| `definitions.PrivateLinkResourceList.properties.value.items.$ref` | `../../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateLinkResource` | `#/definitions/PrivateLinkResource` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Maps/locations/{location}/operationResults/{operationId}'].get.responses.202.headers.Location.description` | `` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/listSas'].post.description` | `Create and list an account shared access signature token. Use this SAS token for authentication to Azure Maps REST APIs through various Azure Maps SDKs. As prerequisite to create a SAS Token. 

Prerequisites:
1. Create or have an existing User Assigned Managed Identity in the same Azure region as the account. 
2. Create or update an Azure Maps account with the same Azure region as the User Assigned Managed Identity is placed.` | `Create and list an account shared access signature token. Use this SAS token for authentication to Azure Maps REST APIs through various Azure Maps SDKs. As prerequisite to create a SAS Token.

Prerequisites:
1. Create or have an existing User Assigned Managed Identity in the same Azure region as the account.
2. Create or update an Azure Maps account with the same Azure region as the User Assigned Managed Identity is placed.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.202.headers.Location.description` | `Operation Results Location URI` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Maps/accounts/{accountName}/privateLinkResources/{privateLinkResourceName}'].get.responses.200.schema.$ref` | `../../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateLinkResource` | `#/definitions/PrivateLinkResource` |

