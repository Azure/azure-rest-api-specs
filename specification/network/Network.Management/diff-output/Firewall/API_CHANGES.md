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

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/azureFirewallFqdnTags'].get.tags__deleted` | deleted | `["AzureFirewallFqdnTags"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/learnedIPPrefixes'].post.tags__added` | added | `["AzureFirewalls"]` |
| `tags__added` | added | `[{"name":"AzureFirewalls"},{"name":"AzureWebCategories"},{"name":"FirewallPolicies"}]` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/azureWebCategories`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/azureWebCategories__added']` | added | `{"get":{"operationId":"WebCategories_ListBySubscription","tags":["AzureWebCategories"],"parameters":...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/azureWebCategories/{name}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/azureWebCategories/{name}__added']` | added | `{"get":{"operationId":"WebCategories_Get","tags":["AzureWebCategories"],"parameters":[{"name":"name"...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/firewallPolicies`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/firewallPolicies__added']` | added | `{"get":{"operationId":"FirewallPolicies_ListAll","tags":["FirewallPolicies"],"parameters":[],"respon...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies__added']` | added | `{"get":{"operationId":"FirewallPolicies_List","tags":["FirewallPolicies"],"parameters":[],"responses...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}__added']` | added | `{"get":{"operationId":"FirewallPolicies_Get","tags":["FirewallPolicies"],"parameters":[{"name":"fire...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/deploy`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/deploy__added']` | added | `{"post":{"operationId":"FirewallPolicyDeployments_Deploy","tags":["FirewallPolicies"],"parameters":[...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/listIdpsFilterOptions`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/listIdpsFilterOptions__added']` | added | `{"post":{"operationId":"FirewallPolicyIdpsSignaturesFilterValues_List","tags":["FirewallPolicies"],"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/listIdpsSignatures`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/listIdpsSignatures__added']` | added | `{"post":{"operationId":"FirewallPolicyIdpsSignatures_List","tags":["FirewallPolicies"],"parameters":...` |

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

### Changes for `AzureFirewallApplicationRuleCollection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallApplicationRuleCollection__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/AzureFirewallApplicationRuleColle...` |

### Changes for `AzureFirewallApplicationRuleCollectionPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallApplicationRuleCollectionPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"priority":{"type":"integer","format":"int32","minimum":100,"exclusiv...` |

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

### Changes for `AzureFirewallIPConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallIPConfiguration__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/AzureFirewallIPConfigurationPrope...` |

### Changes for `AzureFirewallIpGroups`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallIpGroups__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string","readOnly":true},"changeNumber":{"type":"string...` |

### Changes for `AzureFirewallNatRuleCollection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallNatRuleCollection__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/AzureFirewallNatRuleCollectionPro...` |

### Changes for `AzureFirewallNatRuleCollectionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallNatRuleCollectionProperties__deleted` | deleted | `{"type":"object","properties":{"priority":{"type":"integer","format":"int32","minimum":100,"exclusiv...` |

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

### Changes for `FirewallPacketCaptureParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FirewallPacketCaptureParameters__deleted` | deleted | `{"type":"object","properties":{"durationInSeconds":{"type":"integer","format":"int32","default":60,"...` |

### Changes for `IPPrefixesList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IPPrefixesList__deleted` | deleted | `{"type":"object","properties":{"ipPrefixes":{"type":"array","items":{"type":"string"}}}}` |

### Changes for `IpGroups`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IpGroups__deleted` | deleted | `{"type":"array","items":{"$ref":"#/definitions/AzureFirewallIpGroups"}}` |

### Changes for `AzureFirewallIPGroups`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallIPGroups__added` | added | `{"type":"object","properties":{"id":{"type":"string","readOnly":true},"changeNumber":{"type":"string...` |

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

### Changes for `FirewallPolicyIntrusionDetection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FirewallPolicyIntrusionDetection__added` | added | `{"type":"object","properties":{"mode":{"$ref":"./common.json/definitions/FirewallPolicyIntrusionDete...` |

### Changes for `FirewallPolicyIntrusionDetectionBypassTrafficSpecifications`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FirewallPolicyIntrusionDetectionBypassTrafficSpecifications__added` | added | `{"type":"object","properties":{"name":{"type":"string"},"description":{"type":"string"},"protocol":{...` |

### Changes for `FirewallPolicyIntrusionDetectionConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FirewallPolicyIntrusionDetectionConfiguration__added` | added | `{"type":"object","properties":{"signatureOverrides":{"type":"array","items":{"$ref":"#/definitions/F...` |

### Changes for `FirewallPolicyIntrusionDetectionSignatureSpecification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FirewallPolicyIntrusionDetectionSignatureSpecification__added` | added | `{"type":"object","properties":{"id":{"type":"string"},"mode":{"$ref":"./common.json/definitions/Fire...` |

### Changes for `FirewallPolicyListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FirewallPolicyListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `FirewallPolicyRuleCollectionGroupProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FirewallPolicyRuleCollectionGroupProperties__added` | added | `{"type":"object","properties":{"size":{"type":"string","readOnly":true},"priority":{"type":"integer"...` |

### Changes for `FirewallPolicySNAT`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FirewallPolicySNAT__added` | added | `{"type":"object","properties":{"privateRanges":{"type":"array","items":{"type":"string"}},"autoLearn...` |

### Changes for `FirewallPolicyThreatIntelWhitelist`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FirewallPolicyThreatIntelWhitelist__added` | added | `{"type":"object","properties":{"ipAddresses":{"type":"array","items":{"type":"string"}},"fqdns":{"ty...` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallApplicationRuleProtocol.properties.protocolType.type__deleted` | deleted | `string` |
| `definitions.AzureFirewallNatRCAction.properties.type.type__deleted` | deleted | `string` |
| `definitions.AzureFirewallNatRule.properties.protocols.items.type__deleted` | deleted | `string` |
| `definitions.AzureFirewallNetworkRule.properties.protocols.items.type__deleted` | deleted | `string` |
| `definitions.AzureFirewallPropertiesFormat.properties.additionalProperties.type__added` | added | `object` |
| `definitions.AzureFirewallPropertiesFormat.properties.ipGroups.type__added` | added | `array` |
| `definitions.AzureFirewallPropertiesFormat.properties.threatIntelMode.type__deleted` | deleted | `string` |
| `definitions.AzureFirewallRCAction.properties.type.type__deleted` | deleted | `string` |
| `definitions.AzureFirewallSku.properties.name.type__deleted` | deleted | `string` |
| `definitions.AzureFirewallSku.properties.tier.type__deleted` | deleted | `string` |

### Changes for `enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallApplicationRuleProtocol.properties.protocolType.enum__deleted` | deleted | `["Http","Https","Mssql"]` |
| `definitions.AzureFirewallNatRCAction.properties.type.enum__deleted` | deleted | `["Snat","Dnat"]` |
| `definitions.AzureFirewallNatRule.properties.protocols.items.enum__deleted` | deleted | `["TCP","UDP","Any","ICMP"]` |
| `definitions.AzureFirewallNetworkRule.properties.protocols.items.enum__deleted` | deleted | `["TCP","UDP","Any","ICMP"]` |
| `definitions.AzureFirewallPropertiesFormat.properties.threatIntelMode.enum__deleted` | deleted | `["Alert","Deny","Off"]` |
| `definitions.AzureFirewallRCAction.properties.type.enum__deleted` | deleted | `["Allow","Deny"]` |
| `definitions.AzureFirewallSku.properties.name.enum__deleted` | deleted | `["AZFW_VNet","AZFW_Hub"]` |
| `definitions.AzureFirewallSku.properties.tier.enum__deleted` | deleted | `["Standard","Premium","Basic"]` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallApplicationRuleProtocol.properties.protocolType['x-ms-enum__deleted']` | deleted | `{"name":"AzureFirewallApplicationRuleProtocolType","modelAsString":true}` |
| `definitions.AzureFirewallNatRCAction.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"AzureFirewallNatRCActionType","modelAsString":true}` |
| `definitions.AzureFirewallNatRule.properties.protocols.items['x-ms-enum__deleted']` | deleted | `{"name":"AzureFirewallNetworkRuleProtocol","modelAsString":true}` |
| `definitions.AzureFirewallNetworkRule.properties.protocols.items['x-ms-enum__deleted']` | deleted | `{"name":"AzureFirewallNetworkRuleProtocol","modelAsString":true}` |
| `definitions.AzureFirewallPropertiesFormat.properties.threatIntelMode['x-ms-enum__deleted']` | deleted | `{"name":"AzureFirewallThreatIntelMode","modelAsString":true}` |
| `definitions.AzureFirewallRCAction.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"AzureFirewallRCActionType","modelAsString":true}` |
| `definitions.AzureFirewallSku.properties.name['x-ms-enum__deleted']` | deleted | `{"name":"AzureFirewallSkuName","modelAsString":true}` |
| `definitions.AzureFirewallSku.properties.tier['x-ms-enum__deleted']` | deleted | `{"name":"AzureFirewallSkuTier","modelAsString":true}` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallApplicationRuleProtocol.properties.protocolType.$ref__added` | added | `./common.json/definitions/AzureFirewallApplicationRuleProtocolType` |
| `definitions.AzureFirewallNatRCAction.properties.type.$ref__added` | added | `./common.json/definitions/AzureFirewallNatRCActionType` |
| `definitions.AzureFirewallNatRule.properties.protocols.items.$ref__added` | added | `./common.json/definitions/AzureFirewallNetworkRuleProtocol` |
| `definitions.AzureFirewallNetworkRule.properties.protocols.items.$ref__added` | added | `./common.json/definitions/AzureFirewallNetworkRuleProtocol` |
| `definitions.AzureFirewallPropertiesFormat.properties.additionalProperties.$ref__deleted` | deleted | `#/definitions/AzureFirewallAdditionalProperties` |
| `definitions.AzureFirewallPropertiesFormat.properties.ipGroups.$ref__deleted` | deleted | `#/definitions/IpGroups` |
| `definitions.AzureFirewallPropertiesFormat.properties.threatIntelMode.$ref__added` | added | `./common.json/definitions/AzureFirewallThreatIntelMode` |
| `definitions.AzureFirewallRCAction.properties.type.$ref__added` | added | `./common.json/definitions/AzureFirewallRCActionType` |
| `definitions.AzureFirewallSku.properties.name.$ref__added` | added | `./common.json/definitions/AzureFirewallSkuName` |
| `definitions.AzureFirewallSku.properties.tier.$ref__added` | added | `./common.json/definitions/AzureFirewallSkuTier` |

### Changes for `exclusiveMinimum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallApplicationRuleProtocol.properties.port.exclusiveMinimum__deleted` | deleted | `false` |

### Changes for `exclusiveMaximum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallApplicationRuleProtocol.properties.port.exclusiveMaximum__deleted` | deleted | `false` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallListResult.required__added` | added | `["value"]` |

### Changes for `items`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallPropertiesFormat.properties.ipGroups.items__added` | added | `{"$ref":"#/definitions/AzureFirewallIPGroups"}` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallPropertiesFormat.properties.additionalProperties.additionalProperties__added` | added | `{"type":"string"}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AzureFirewall.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.AzureFirewall.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `./common.json/definitions/ExtendedLocation` |
| `definitions.AzureFirewallFqdnTagPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.AzureFirewallIPConfigurationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.AzureFirewallIPConfigurationPropertiesFormat.properties.publicIPAddress.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.AzureFirewallIPConfigurationPropertiesFormat.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.AzureFirewallPropertiesFormat.properties.applicationRuleCollections.items.$ref` | `#/definitions/AzureFirewallApplicationRuleCollection` | `./common.json/definitions/AzureFirewallApplicationRuleCollection` |
| `definitions.AzureFirewallPropertiesFormat.properties.autoscaleConfiguration.$ref` | `#/definitions/AzureFirewallAutoscaleConfiguration` | `./common.json/definitions/AzureFirewallAutoscaleConfiguration` |
| `definitions.AzureFirewallPropertiesFormat.properties.firewallPolicy.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.AzureFirewallPropertiesFormat.properties.ipConfigurations.items.$ref` | `#/definitions/AzureFirewallIPConfiguration` | `./common.json/definitions/AzureFirewallIPConfiguration` |
| `definitions.AzureFirewallPropertiesFormat.properties.managementIpConfiguration.$ref` | `#/definitions/AzureFirewallIPConfiguration` | `./common.json/definitions/AzureFirewallIPConfiguration` |
| `definitions.AzureFirewallPropertiesFormat.properties.natRuleCollections.items.$ref` | `#/definitions/AzureFirewallNatRuleCollection` | `./common.json/definitions/AzureFirewallNatRuleCollection` |
| `definitions.AzureFirewallPropertiesFormat.properties.networkRuleCollections.items.$ref` | `#/definitions/AzureFirewallNetworkRuleCollection` | `./common.json/definitions/AzureFirewallNetworkRuleCollection` |
| `definitions.AzureFirewallPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.AzureFirewallPropertiesFormat.properties.virtualHub.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
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

