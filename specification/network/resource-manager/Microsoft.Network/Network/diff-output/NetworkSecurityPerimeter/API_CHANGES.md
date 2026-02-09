## Changed Paths

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/networkSecurityPerimeterOperationStatuses/{operationId}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/networkSecurityPerimeterOperationStatuses/{operationId}/subscriptions/{subscriptionId}/locations/{location}/{operationId}
Change Type: added

## Swagger Changes

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `tags__added` | added | `[{"name":"NetworkSecurityPerimeters"},{"name":"NetworkSecurityPerimeterProfiles"},{"name":"NetworkSe...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/networkSecurityPerimeterOperationStatuses/{operationId}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/networkSecurityPerimeterOperationStatuses/{operationId}__deleted']` | deleted | `{"parameters":[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/L...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/networkSecurityPerimeterOperationStatuses/{operationId}/subscriptions/{subscriptionId}/locations/{location}/{operationId}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/networkSecurityPerimeterOperationStatuses/{operationId}/subscriptions/{subscriptionId}/locations/{location}/{operationId}__added']` | added | `{"get":{"operationId":"NetworkSecurityPerimeterOperationStatuses_Get","tags":["NetworkSecurityPerime...` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/nspServiceTags'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/perimeterAssociableResourceTypes'].get.parameters[0].name__deleted` | deleted | `location` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/nspServiceTags'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/perimeterAssociableResourceTypes'].get.parameters[0].in__deleted` | deleted | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeterListResult.required__added` | added | `["value"]` |
| `definitions.NspAccessRuleListResult.required__added` | added | `["value"]` |
| `definitions.NspAssociationsListResult.required__added` | added | `["value"]` |
| `definitions.NspLinkListResult.required__added` | added | `["value"]` |
| `definitions.NspLinkReferenceListResult.required__added` | added | `["value"]` |
| `definitions.NspLoggingConfigurationListResult.required__added` | added | `["value"]` |
| `definitions.NspProfileListResult.required__added` | added | `["value"]` |
| `definitions.NspServiceTagsListResult.required__added` | added | `["value"]` |
| `definitions.PerimeterAssociableResourcesListResult.required__added` | added | `["value"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/nspServiceTags'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/perimeterAssociableResourceTypes'].get.parameters[0].required__deleted` | deleted | `true` |

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
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/nspServiceTags'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/perimeterAssociableResourceTypes'].get.parameters[0].type__deleted` | deleted | `string` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeterProperties.properties.provisioningState.$ref__added` | added | `./common.json#/definitions/NspProvisioningState` |
| `definitions.NspAccessRuleProperties.properties.direction.$ref__added` | added | `./common.json#/definitions/AccessRuleDirection` |
| `definitions.NspAccessRuleProperties.properties.provisioningState.$ref__added` | added | `./common.json#/definitions/NspProvisioningState` |
| `definitions.NspAssociationProperties.properties.accessMode.$ref__added` | added | `./common.json#/definitions/AssociationAccessMode` |
| `definitions.NspAssociationProperties.properties.provisioningState.$ref__added` | added | `./common.json#/definitions/NspProvisioningState` |
| `definitions.NspLinkProperties.properties.provisioningState.$ref__added` | added | `./common.json#/definitions/NspLinkProvisioningState` |
| `definitions.NspLinkProperties.properties.status.$ref__added` | added | `./common.json#/definitions/NspLinkStatus` |
| `definitions.NspLinkReferenceProperties.properties.provisioningState.$ref__added` | added | `./common.json#/definitions/NspLinkProvisioningState` |
| `definitions.NspLinkReferenceProperties.properties.status.$ref__added` | added | `./common.json#/definitions/NspLinkStatus` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/nspServiceTags'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/perimeterAssociableResourceTypes'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}/reconcile'].post.parameters[3].schema.$ref__deleted` | deleted | `#/definitions/NspAccessRuleReconcile` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}/reconcile'].post.responses.200.schema.$ref__deleted` | deleted | `#/definitions/NspAccessRuleReconcile` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}/reconcile'].post.parameters[2].schema.$ref__deleted` | deleted | `#/definitions/NspAssociationReconcile` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}/reconcile'].post.responses.200.schema.$ref__deleted` | deleted | `#/definitions/NspAssociationReconcile` |

### Changes for `parameters`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].get.parameters__added` | added | `[{"name":"networkSecurityPerimeterName","in":"path","required":true,"type":"string","maxLength":80,"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences/{linkReferenceName}'].delete.parameters__added` | added | `[{"name":"networkSecurityPerimeterName","in":"path","required":true,"type":"string","maxLength":80,"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences/{linkReferenceName}'].get.parameters__added` | added | `[{"name":"networkSecurityPerimeterName","in":"path","required":true,"type":"string","maxLength":80,"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences/{linkReferenceName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links/{linkName}'].delete.parameters__added` | added | `[{"name":"networkSecurityPerimeterName","in":"path","required":true,"type":"string","maxLength":80,"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links/{linkName}'].get.parameters__added` | added | `[{"name":"networkSecurityPerimeterName","in":"path","required":true,"type":"string","maxLength":80,"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links/{linkName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations'].get.parameters__added` | added | `[{"name":"networkSecurityPerimeterName","in":"path","required":true,"type":"string","maxLength":80,"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations/{loggingConfigurationName}'].delete.parameters__added` | added | `[{"name":"networkSecurityPerimeterName","in":"path","required":true,"type":"string","maxLength":80,"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations/{loggingConfigurationName}'].get.parameters__added` | added | `[{"name":"networkSecurityPerimeterName","in":"path","required":true,"type":"string","maxLength":80,"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations/{loggingConfigurationName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}'].delete.parameters__added` | added | `[{"name":"networkSecurityPerimeterName","in":"path","required":true,"type":"string","maxLength":80,"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}'].get.parameters__added` | added | `[{"name":"networkSecurityPerimeterName","in":"path","required":true,"type":"string","maxLength":80,"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}'].delete.parameters__added` | added | `[{"name":"networkSecurityPerimeterName","in":"path","required":true,"type":"string","maxLength":80,"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}'].get.parameters__added` | added | `[{"name":"networkSecurityPerimeterName","in":"path","required":true,"type":"string","maxLength":80,"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}/reconcile'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}'].delete.parameters__added` | added | `[{"name":"networkSecurityPerimeterName","in":"path","required":true,"type":"string","maxLength":80,"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}'].get.parameters__added` | added | `[{"name":"networkSecurityPerimeterName","in":"path","required":true,"type":"string","maxLength":80,"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}/reconcile'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences/{linkReferenceName}'].delete.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"location header"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links/{linkName}'].delete.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"location header"}` |

### Changes for `Location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences/{linkReferenceName}'].delete.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links/{linkName}'].delete.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/NspAssociation` |

### Changes for `NspAccessRuleReconcile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspAccessRuleReconcile__deleted` | deleted | `{"type":"object","properties":{}}` |

### Changes for `NspAssociationReconcile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspAssociationReconcile__deleted` | deleted | `{"type":"object","properties":{}}` |

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
| `definitions.NetworkSecurityPerimeter.allOf[0].$ref` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/TrackedResource` | `./common.json#/definitions/CommonTrackedResource` |
| `definitions.NspAccessRule.allOf[0].$ref` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` | `./common.json#/definitions/CommonProxyResource` |
| `definitions.NspAssociation.allOf[0].$ref` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` | `./common.json#/definitions/CommonProxyResource` |
| `definitions.NspAssociationProperties.properties.privateLinkResource.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.NspAssociationProperties.properties.profile.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.NspLink.allOf[0].$ref` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` | `./common.json#/definitions/CommonProxyResource` |
| `definitions.NspLinkReference.allOf[0].$ref` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` | `./common.json#/definitions/CommonProxyResource` |
| `definitions.NspLoggingConfiguration.allOf[0].$ref` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` | `./common.json#/definitions/CommonProxyResource` |
| `definitions.NspProfile.allOf[0].$ref` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` | `./common.json#/definitions/CommonProxyResource` |
| `info.description` | `The Network Security Perimeter API provides a RESTful set of web services that interact with network security perimeter resource.` | `APIs to manage web application firewall rules.` |
| `info.title` | `NetworkSecurityPerimeter` | `WebApplicationFirewallManagement` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/nspServiceTags'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/perimeterAssociableResourceTypes'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkSecurityPerimeters'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `Azure async operation header` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences/{linkReferenceName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences/{linkReferenceName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links/{linkName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links/{linkName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links/{linkName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations/{loggingConfigurationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations/{loggingConfigurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations/{loggingConfigurationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}/reconcile'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `Azure async operation header` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}'].put.responses.202.headers['Azure-AsyncOperation'].description` | `Azure async operation header` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}/reconcile'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |

