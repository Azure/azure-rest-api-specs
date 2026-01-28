## Changed Paths

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/networkSecurityPerimeterOperationStatuses/{operationId}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/nspServiceTags
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/perimeterAssociableResourceTypes
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences/{linkReferenceName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links/{linkName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations/{loggingConfigurationName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}/reconcile
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}/reconcile
Change Type: deleted

## Swagger Changes

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `tags__added` | added | `[{"name":"NetworkSecurityPerimeters"}]` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/networkSecurityPerimeterOperationStatuses/{operationId}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/networkSecurityPerimeterOperationStatuses/{operationId}__deleted']` | deleted | `{"parameters":[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/L...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/nspServiceTags`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/nspServiceTags__deleted']` | deleted | `{"get":{"operationId":"NetworkSecurityPerimeterServiceTags_List","tags":["NetworkSecurityPerimeterSe...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/perimeterAssociableResourceTypes`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/perimeterAssociableResourceTypes__deleted']` | deleted | `{"get":{"operationId":"NetworkSecurityPerimeterAssociableResourceTypes_List","tags":["NetworkSecurit...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences__deleted']` | deleted | `{"get":{"operationId":"NetworkSecurityPerimeterLinkReferences_List","tags":["NetworkSecurityPerimete...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences/{linkReferenceName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences/{linkReferenceName}__deleted']` | deleted | `{"parameters":[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/R...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links__deleted']` | deleted | `{"get":{"operationId":"NetworkSecurityPerimeterLinks_List","tags":["NetworkSecurityPerimeterLinks"],...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links/{linkName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links/{linkName}__deleted']` | deleted | `{"parameters":[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/R...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations__deleted']` | deleted | `{"parameters":[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/R...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations/{loggingConfigurationName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations/{loggingConfigurationName}__deleted']` | deleted | `{"parameters":[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/R...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles__deleted']` | deleted | `{"get":{"operationId":"NetworkSecurityPerimeterProfiles_List","tags":["NetworkSecurityPerimeterProfi...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}__deleted']` | deleted | `{"parameters":[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/R...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules__deleted']` | deleted | `{"get":{"operationId":"NetworkSecurityPerimeterAccessRules_List","tags":["NetworkSecurityPerimeterAc...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}__deleted']` | deleted | `{"parameters":[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/R...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}/reconcile`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}/reconcile__deleted']` | deleted | `{"parameters":[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/R...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations__deleted']` | deleted | `{"get":{"operationId":"NetworkSecurityPerimeterAssociations_List","tags":["NetworkSecurityPerimeterA...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}__deleted']` | deleted | `{"parameters":[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/R...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}/reconcile`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}/reconcile__deleted']` | deleted | `{"parameters":[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/R...` |

### Changes for `parameters`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |

### Changes for `NspAccessRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspAccessRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/NspAccessRuleProperties","x-ms-cl...` |

### Changes for `NspAccessRuleListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspAccessRuleListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `NspAccessRuleReconcile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspAccessRuleReconcile__deleted` | deleted | `{"type":"object","properties":{}}` |

### Changes for `NspAssociation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspAssociation__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/NspAssociationProperties","x-ms-c...` |

### Changes for `NspAssociationReconcile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspAssociationReconcile__deleted` | deleted | `{"type":"object","properties":{}}` |

### Changes for `NspAssociationsListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspAssociationsListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `NspLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspLink__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/NspLinkProperties","x-ms-client-f...` |

### Changes for `NspLinkListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspLinkListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `NspLinkReference`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspLinkReference__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/NspLinkReferenceProperties","x-ms...` |

### Changes for `NspLinkReferenceListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspLinkReferenceListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `NspLoggingConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspLoggingConfiguration__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/NspLoggingConfigurationProperties...` |

### Changes for `NspLoggingConfigurationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspLoggingConfigurationListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `NspProfile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspProfile__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/NspProfileProperties","x-ms-clien...` |

### Changes for `NspProfileListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspProfileListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `NspServiceTagsListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspServiceTagsListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `PerimeterAssociableResourcesListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PerimeterAssociableResourcesListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeterListResult.required__added` | added | `["value"]` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeterProperties.properties.provisioningState.type__deleted` | deleted | `string` |
| `definitions.NspAccessRuleProperties.properties.direction.type__deleted` | deleted | `string` |
| `definitions.NspAccessRuleProperties.properties.provisioningState.type__deleted` | deleted | `string` |
| `definitions.NspAssociationProperties.properties.accessMode.type__deleted` | deleted | `string` |
| `definitions.NspAssociationProperties.properties.provisioningState.type__deleted` | deleted | `string` |
| `definitions.NspLinkProperties.properties.provisioningState.type__deleted` | deleted | `string` |
| `definitions.NspLinkProperties.properties.status.type__deleted` | deleted | `string` |
| `definitions.NspLinkReferenceProperties.properties.provisioningState.type__deleted` | deleted | `string` |
| `definitions.NspLinkReferenceProperties.properties.status.type__deleted` | deleted | `string` |

### Changes for `enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeterProperties.properties.provisioningState.enum__deleted` | deleted | `["Succeeded","Creating","Updating","Deleting","Accepted","Failed"]` |
| `definitions.NspAccessRuleProperties.properties.direction.enum__deleted` | deleted | `["Inbound","Outbound"]` |
| `definitions.NspAccessRuleProperties.properties.provisioningState.enum__deleted` | deleted | `["Succeeded","Creating","Updating","Deleting","Accepted","Failed"]` |
| `definitions.NspAssociationProperties.properties.accessMode.enum__deleted` | deleted | `["Learning","Enforced","Audit"]` |
| `definitions.NspAssociationProperties.properties.provisioningState.enum__deleted` | deleted | `["Succeeded","Creating","Updating","Deleting","Accepted","Failed"]` |
| `definitions.NspLinkProperties.properties.provisioningState.enum__deleted` | deleted | `["Succeeded","Creating","Updating","Deleting","Accepted","Failed","WaitForRemoteCompletion"]` |
| `definitions.NspLinkProperties.properties.status.enum__deleted` | deleted | `["Approved","Pending","Rejected","Disconnected"]` |
| `definitions.NspLinkReferenceProperties.properties.provisioningState.enum__deleted` | deleted | `["Succeeded","Creating","Updating","Deleting","Accepted","Failed","WaitForRemoteCompletion"]` |
| `definitions.NspLinkReferenceProperties.properties.status.enum__deleted` | deleted | `["Approved","Pending","Rejected","Disconnected"]` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeterProperties.properties.provisioningState['x-ms-enum__deleted']` | deleted | `{"name":"NspProvisioningState","modelAsString":true}` |
| `definitions.NspAccessRuleProperties.properties.direction['x-ms-enum__deleted']` | deleted | `{"name":"AccessRuleDirection","modelAsString":true}` |
| `definitions.NspAccessRuleProperties.properties.provisioningState['x-ms-enum__deleted']` | deleted | `{"name":"NspProvisioningState","modelAsString":true}` |
| `definitions.NspAssociationProperties.properties.accessMode['x-ms-enum__deleted']` | deleted | `{"name":"AssociationAccessMode","modelAsString":true}` |
| `definitions.NspAssociationProperties.properties.provisioningState['x-ms-enum__deleted']` | deleted | `{"name":"NspProvisioningState","modelAsString":true}` |
| `definitions.NspLinkProperties.properties.provisioningState['x-ms-enum__deleted']` | deleted | `{"name":"NspLinkProvisioningState","modelAsString":true}` |
| `definitions.NspLinkProperties.properties.status['x-ms-enum__deleted']` | deleted | `{"name":"NspLinkStatus","modelAsString":true}` |
| `definitions.NspLinkReferenceProperties.properties.provisioningState['x-ms-enum__deleted']` | deleted | `{"name":"NspLinkProvisioningState","modelAsString":true}` |
| `definitions.NspLinkReferenceProperties.properties.status['x-ms-enum__deleted']` | deleted | `{"name":"NspLinkStatus","modelAsString":true}` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeterProperties.properties.provisioningState.$ref__added` | added | `./common.json/definitions/NspProvisioningState` |
| `definitions.NspAccessRuleProperties.properties.direction.$ref__added` | added | `./common.json/definitions/AccessRuleDirection` |
| `definitions.NspAccessRuleProperties.properties.provisioningState.$ref__added` | added | `./common.json/definitions/NspProvisioningState` |
| `definitions.NspAssociationProperties.properties.accessMode.$ref__added` | added | `./common.json/definitions/AssociationAccessMode` |
| `definitions.NspAssociationProperties.properties.provisioningState.$ref__added` | added | `./common.json/definitions/NspProvisioningState` |
| `definitions.NspLinkProperties.properties.provisioningState.$ref__added` | added | `./common.json/definitions/NspLinkProvisioningState` |
| `definitions.NspLinkProperties.properties.status.$ref__added` | added | `./common.json/definitions/NspLinkStatus` |
| `definitions.NspLinkReferenceProperties.properties.provisioningState.$ref__added` | added | `./common.json/definitions/NspLinkProvisioningState` |
| `definitions.NspLinkReferenceProperties.properties.status.$ref__added` | added | `./common.json/definitions/NspLinkStatus` |

### Changes for `x-ms-client-flatten`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspAccessRuleProperties.properties.networkSecurityPerimeters.items['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.NspAccessRuleProperties.properties.networkSecurityPerimeters['x-ms-client-flatten__added']` | added | `true` |
| `definitions.NspAccessRuleProperties.properties.subscriptions.items['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.NspAccessRuleProperties.properties.subscriptions['x-ms-client-flatten__added']` | added | `true` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.NetworkSecurityPerimeter.allOf[0].$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/TrackedResource` | `./common.json/definitions/CommonTrackedResource` |
| `definitions.NspAssociationProperties.properties.privateLinkResource.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.NspAssociationProperties.properties.profile.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `info.description` | `The Network Security Perimeter API provides a RESTful set of web services that interact with network security perimeter resource.` | `APIs to manage web application firewall rules.` |
| `info.title` | `NetworkSecurityPerimeter` | `WebApplicationFirewallManagement` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkSecurityPerimeters'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].delete.parameters[1].name` | `forceDeletion` | `force` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `Azure async operation header` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |

