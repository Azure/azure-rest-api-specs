## Changed Paths

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/azureWebCategories
Change Type: added

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/azureWebCategories/{name}
Change Type: added

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/firewallPolicies
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/deploy
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/listIdpsFilterOptions
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/listIdpsSignatures
Change Type: added

## Swagger Changes

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/azureWebCategories`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/azureWebCategories__added']` | added | `{"get":{"operationId":"WebCategories_ListBySubscription","parameters":[],"responses":{"200":{"descri...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/azureWebCategories/{name}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/azureWebCategories/{name}__added']` | added | `{"get":{"operationId":"WebCategories_Get","parameters":[{"name":"name","in":"path","required":true,"...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/firewallPolicies`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/firewallPolicies__added']` | added | `{"get":{"operationId":"FirewallPolicies_ListAll","parameters":[],"responses":{"200":{"description":"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies__added']` | added | `{"get":{"operationId":"FirewallPolicies_List","parameters":[],"responses":{"200":{"description":"ign...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}__added']` | added | `{"get":{"operationId":"FirewallPolicies_Get","parameters":[{"name":"firewallPolicyName","in":"path",...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/deploy`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/deploy__added']` | added | `{"post":{"operationId":"FirewallPolicyDeployments_Deploy","parameters":[{"name":"firewallPolicyName"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/listIdpsFilterOptions`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/listIdpsFilterOptions__added']` | added | `{"post":{"operationId":"FirewallPolicyIdpsSignaturesFilterValues_List","parameters":[{"name":"firewa...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/listIdpsSignatures`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/listIdpsSignatures__added']` | added | `{"post":{"operationId":"FirewallPolicyIdpsSignatures_List","parameters":[{"name":"firewallPolicyName...` |

### Changes for `minLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].put.parameters[0].minLength__deleted` | deleted | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCapture'].post.parameters[0].minLength__deleted` | deleted | `1` |

### Changes for `maxLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].put.parameters[0].maxLength__deleted` | deleted | `56` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCapture'].post.parameters[0].maxLength__deleted` | deleted | `56` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].patch.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/learnedIPPrefixes'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/AzureFirewall` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/AzureFirewall` |

### Changes for `pattern`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCapture'].post.parameters[0].pattern__deleted` | deleted | `^[a-zA-Z0-9]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCaptureOperation'].post.parameters[0].pattern__deleted` | deleted | `^[A-Za-z0-9][\\w\\-._]{0,54}[A-Za-z0-9_]$` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCapture'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCaptureOperation'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |

### Changes for `AzureFirewallAdditionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallAdditionalProperties__deleted` | deleted | `{"type":"object","additionalProperties":{"type":"string"}}` |

### Changes for `AzureFirewallApplicationRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallApplicationRule__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"description":{"type":"string"},"sourceAddre...` |

### Changes for `AzureFirewallApplicationRuleCollection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallApplicationRuleCollection__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/AzureFirewallApplicationRuleColle...` |

### Changes for `AzureFirewallApplicationRuleCollectionPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallApplicationRuleCollectionPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"priority":{"type":"integer","format":"int32","minimum":100,"exclusiv...` |

### Changes for `AzureFirewallApplicationRuleProtocol`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallApplicationRuleProtocol__deleted` | deleted | `{"type":"object","properties":{"protocolType":{"type":"string","enum":["Http","Https","Mssql"],"x-ms...` |

### Changes for `AzureFirewallAutoscaleConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallAutoscaleConfiguration__deleted` | deleted | `{"type":"object","properties":{"minCapacity":{"type":"integer","format":"int32","minimum":2,"x-nulla...` |

### Changes for `AzureFirewallFqdnTag`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallFqdnTag__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/AzureFirewallFqdnTagPropertiesFor...` |

### Changes for `AzureFirewallFqdnTagListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallFqdnTagListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `AzureFirewallFqdnTagPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallFqdnTagPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"provisioningState":{"$ref":"./network.json#/definitions/Provisioning...` |

### Changes for `AzureFirewallIPConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallIPConfiguration__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/AzureFirewallIPConfigurationPrope...` |

### Changes for `AzureFirewallIPConfigurationPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallIPConfigurationPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"privateIPAddress":{"type":"string","readOnly":true},"subnet":{"$ref"...` |

### Changes for `AzureFirewallIpGroups`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallIpGroups__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string","readOnly":true},"changeNumber":{"type":"string...` |

### Changes for `AzureFirewallNatRCAction`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallNatRCAction__deleted` | deleted | `{"type":"object","properties":{"type":{"type":"string","enum":["Snat","Dnat"],"x-ms-enum":{"name":"A...` |

### Changes for `AzureFirewallNatRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallNatRule__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"description":{"type":"string"},"sourceAddre...` |

### Changes for `AzureFirewallNatRuleCollection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallNatRuleCollection__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/AzureFirewallNatRuleCollectionPro...` |

### Changes for `AzureFirewallNatRuleCollectionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallNatRuleCollectionProperties__deleted` | deleted | `{"type":"object","properties":{"priority":{"type":"integer","format":"int32","minimum":100,"exclusiv...` |

### Changes for `AzureFirewallNetworkRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallNetworkRule__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"description":{"type":"string"},"protocols":...` |

### Changes for `AzureFirewallNetworkRuleCollection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallNetworkRuleCollection__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/AzureFirewallNetworkRuleCollectio...` |

### Changes for `AzureFirewallNetworkRuleCollectionPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallNetworkRuleCollectionPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"priority":{"type":"integer","format":"int32","minimum":100,"exclusiv...` |

### Changes for `AzureFirewallPacketCaptureFlags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallPacketCaptureFlags__deleted` | deleted | `{"type":"object","properties":{"type":{"type":"string","enum":["fin","syn","rst","push","ack","urg"]...` |

### Changes for `AzureFirewallPacketCaptureResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallPacketCaptureResponse__deleted` | deleted | `{"type":"object","properties":{"statusCode":{"type":"string","enum":["NotImplemented","AzureFirewall...` |

### Changes for `AzureFirewallPacketCaptureRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallPacketCaptureRule__deleted` | deleted | `{"type":"object","properties":{"sources":{"type":"array","items":{"type":"string"}},"destinations":{...` |

### Changes for `AzureFirewallPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"applicationRuleCollections":{"type":"array","items":{"$ref":"#/defin...` |

### Changes for `AzureFirewallPublicIPAddress`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallPublicIPAddress__deleted` | deleted | `{"type":"object","properties":{"address":{"type":"string"}}}` |

### Changes for `AzureFirewallRCAction`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallRCAction__deleted` | deleted | `{"type":"object","properties":{"type":{"type":"string","enum":["Allow","Deny"],"x-ms-enum":{"name":"...` |

### Changes for `AzureFirewallSku`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallSku__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string","enum":["AZFW_VNet","AZFW_Hub"],"x-ms-enum":{...` |

### Changes for `FirewallPacketCaptureParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FirewallPacketCaptureParameters__deleted` | deleted | `{"type":"object","properties":{"durationInSeconds":{"type":"integer","format":"int32","default":60,"...` |

### Changes for `HubIPAddresses`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HubIPAddresses__deleted` | deleted | `{"type":"object","properties":{"publicIPs":{"$ref":"#/definitions/HubPublicIPAddresses"},"privateIPA...` |

### Changes for `HubPublicIPAddresses`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HubPublicIPAddresses__deleted` | deleted | `{"type":"object","properties":{"addresses":{"type":"array","items":{"$ref":"#/definitions/AzureFirew...` |

### Changes for `IPPrefixesList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IPPrefixesList__deleted` | deleted | `{"type":"object","properties":{"ipPrefixes":{"type":"array","items":{"type":"string"}}}}` |

### Changes for `IpGroups`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IpGroups__deleted` | deleted | `{"type":"array","items":{"$ref":"#/definitions/AzureFirewallIpGroups"}}` |

### Changes for `AzureWebCategory`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWebCategory__added` | added | `{"type":"object","properties":{"properties":{"$ref":"./common.json/definitions/AzureWebCategoryPrope...` |

### Changes for `AzureWebCategoryListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWebCategoryListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `FirewallPolicy`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FirewallPolicy__added` | added | `{"type":"object","properties":{"properties":{"$ref":"./common.json/definitions/FirewallPolicyPropert...` |

### Changes for `FirewallPolicyListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FirewallPolicyListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallListResult.required__added` | added | `["value"]` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AzureFirewall.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.AzureFirewall.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `./common.json/definitions/ExtendedLocation` |
| `definitions.AzureFirewall.properties.properties.$ref` | `#/definitions/AzureFirewallPropertiesFormat` | `./common.json/definitions/AzureFirewallPropertiesFormat` |
| `info.description` | `The Microsoft Azure Network management API provides a RESTful set of web services that interact with Microsoft Azure Networks service to manage your network resources. The API has entities that capture the relationship between an end user and the Microsoft Azure Networks service.` | `APIs to manage web application firewall rules.` |
| `info.title` | `NetworkManagementClient` | `WebApplicationFirewallManagement` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/azureFirewallFqdnTags'].get.responses.200.schema.$ref` | `#/definitions/AzureFirewallFqdnTagListResult` | `./common.json/definitions/AzureFirewallFqdnTagListResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/azureFirewallFqdnTags'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/azureFirewalls'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/learnedIPPrefixes'].post.responses.200.schema.$ref` | `#/definitions/IPPrefixesList` | `./common.json/definitions/IPPrefixesList` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/learnedIPPrefixes'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCapture'].post.parameters[1].schema.$ref` | `#/definitions/FirewallPacketCaptureParameters` | `./common.json/definitions/FirewallPacketCaptureParameters` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCaptureOperation'].post.parameters[1].schema.$ref` | `#/definitions/FirewallPacketCaptureParameters` | `./common.json/definitions/FirewallPacketCaptureParameters` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCaptureOperation'].post.responses.200.schema.$ref` | `#/definitions/AzureFirewallPacketCaptureResponse` | `./common.json/definitions/AzureFirewallPacketCaptureResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCaptureOperation'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |

