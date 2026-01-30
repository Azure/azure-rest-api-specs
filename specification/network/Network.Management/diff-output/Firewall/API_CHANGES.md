## Swagger Changes

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

### Changes for `IpGroups`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IpGroups__deleted` | deleted | `{"type":"array","items":{"$ref":"#/definitions/AzureFirewallIpGroups"}}` |

### Changes for `exclusiveMinimum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallApplicationRuleCollectionPropertiesFormat.properties.priority.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.AzureFirewallApplicationRuleProtocol.properties.port.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.AzureFirewallNatRuleCollectionProperties.properties.priority.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.AzureFirewallNetworkRuleCollectionPropertiesFormat.properties.priority.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.FirewallPacketCaptureParameters.properties.durationInSeconds.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.FirewallPacketCaptureParameters.properties.numberOfPacketsToCapture.exclusiveMinimum__deleted` | deleted | `false` |

### Changes for `exclusiveMaximum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallApplicationRuleCollectionPropertiesFormat.properties.priority.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.AzureFirewallApplicationRuleProtocol.properties.port.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.AzureFirewallNatRuleCollectionProperties.properties.priority.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.AzureFirewallNetworkRuleCollectionPropertiesFormat.properties.priority.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.FirewallPacketCaptureParameters.properties.durationInSeconds.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.FirewallPacketCaptureParameters.properties.numberOfPacketsToCapture.exclusiveMaximum__deleted` | deleted | `false` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallApplicationRuleProtocol.properties.protocolType.type__deleted` | deleted | `string` |
| `definitions.AzureFirewallNatRCAction.properties.type.type__deleted` | deleted | `string` |
| `definitions.AzureFirewallNatRule.properties.protocols.items.type__deleted` | deleted | `string` |
| `definitions.AzureFirewallNetworkRule.properties.protocols.items.type__deleted` | deleted | `string` |
| `definitions.AzureFirewallPacketCaptureFlags.properties.type.type__deleted` | deleted | `string` |
| `definitions.AzureFirewallPacketCaptureResponse.properties.statusCode.type__deleted` | deleted | `string` |
| `definitions.AzureFirewallPropertiesFormat.properties.additionalProperties.type__added` | added | `object` |
| `definitions.AzureFirewallPropertiesFormat.properties.ipGroups.type__added` | added | `array` |
| `definitions.AzureFirewallPropertiesFormat.properties.threatIntelMode.type__deleted` | deleted | `string` |
| `definitions.AzureFirewallRCAction.properties.type.type__deleted` | deleted | `string` |
| `definitions.AzureFirewallSku.properties.name.type__deleted` | deleted | `string` |
| `definitions.AzureFirewallSku.properties.tier.type__deleted` | deleted | `string` |
| `definitions.FirewallPacketCaptureParameters.properties.protocol.type__deleted` | deleted | `string` |

### Changes for `enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallApplicationRuleProtocol.properties.protocolType.enum__deleted` | deleted | `["Http","Https","Mssql"]` |
| `definitions.AzureFirewallNatRCAction.properties.type.enum__deleted` | deleted | `["Snat","Dnat"]` |
| `definitions.AzureFirewallNatRule.properties.protocols.items.enum__deleted` | deleted | `["TCP","UDP","Any","ICMP"]` |
| `definitions.AzureFirewallNetworkRule.properties.protocols.items.enum__deleted` | deleted | `["TCP","UDP","Any","ICMP"]` |
| `definitions.AzureFirewallPacketCaptureFlags.properties.type.enum__deleted` | deleted | `["fin","syn","rst","push","ack","urg"]` |
| `definitions.AzureFirewallPacketCaptureResponse.properties.statusCode.enum__deleted` | deleted | `["NotImplemented","AzureFirewallPacketCaptureStartSucceeded","AzureFirewallPacketCaptureStartFailed"...` |
| `definitions.AzureFirewallPropertiesFormat.properties.threatIntelMode.enum__deleted` | deleted | `["Alert","Deny","Off"]` |
| `definitions.AzureFirewallRCAction.properties.type.enum__deleted` | deleted | `["Allow","Deny"]` |
| `definitions.AzureFirewallSku.properties.name.enum__deleted` | deleted | `["AZFW_VNet","AZFW_Hub"]` |
| `definitions.AzureFirewallSku.properties.tier.enum__deleted` | deleted | `["Standard","Premium","Basic"]` |
| `definitions.FirewallPacketCaptureParameters.properties.protocol.enum__deleted` | deleted | `["TCP","UDP","Any","ICMP"]` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallApplicationRuleProtocol.properties.protocolType['x-ms-enum__deleted']` | deleted | `{"name":"AzureFirewallApplicationRuleProtocolType","modelAsString":true}` |
| `definitions.AzureFirewallNatRCAction.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"AzureFirewallNatRCActionType","modelAsString":true}` |
| `definitions.AzureFirewallNatRule.properties.protocols.items['x-ms-enum__deleted']` | deleted | `{"name":"AzureFirewallNetworkRuleProtocol","modelAsString":true}` |
| `definitions.AzureFirewallNetworkRule.properties.protocols.items['x-ms-enum__deleted']` | deleted | `{"name":"AzureFirewallNetworkRuleProtocol","modelAsString":true}` |
| `definitions.AzureFirewallPacketCaptureFlags.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"AzureFirewallPacketCaptureFlagsType","modelAsString":true}` |
| `definitions.AzureFirewallPacketCaptureResponse.properties.statusCode['x-ms-enum__deleted']` | deleted | `{"name":"AzureFirewallPacketCaptureResponseCode","modelAsString":true}` |
| `definitions.AzureFirewallPropertiesFormat.properties.threatIntelMode['x-ms-enum__deleted']` | deleted | `{"name":"AzureFirewallThreatIntelMode","modelAsString":true}` |
| `definitions.AzureFirewallRCAction.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"AzureFirewallRCActionType","modelAsString":true}` |
| `definitions.AzureFirewallSku.properties.name['x-ms-enum__deleted']` | deleted | `{"name":"AzureFirewallSkuName","modelAsString":true}` |
| `definitions.AzureFirewallSku.properties.tier['x-ms-enum__deleted']` | deleted | `{"name":"AzureFirewallSkuTier","modelAsString":true}` |
| `definitions.FirewallPacketCaptureParameters.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"AzureFirewallNetworkRuleProtocol","modelAsString":true}` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallApplicationRuleProtocol.properties.protocolType.$ref__added` | added | `./common.json/definitions/AzureFirewallApplicationRuleProtocolType` |
| `definitions.AzureFirewallNatRCAction.properties.type.$ref__added` | added | `./common.json/definitions/AzureFirewallNatRCActionType` |
| `definitions.AzureFirewallNatRule.properties.protocols.items.$ref__added` | added | `./common.json/definitions/AzureFirewallNetworkRuleProtocol` |
| `definitions.AzureFirewallNetworkRule.properties.protocols.items.$ref__added` | added | `./common.json/definitions/AzureFirewallNetworkRuleProtocol` |
| `definitions.AzureFirewallPacketCaptureFlags.properties.type.$ref__added` | added | `./common.json/definitions/AzureFirewallPacketCaptureFlagsType` |
| `definitions.AzureFirewallPacketCaptureResponse.properties.statusCode.$ref__added` | added | `./common.json/definitions/AzureFirewallPacketCaptureResponseCode` |
| `definitions.AzureFirewallPropertiesFormat.properties.additionalProperties.$ref__deleted` | deleted | `#/definitions/AzureFirewallAdditionalProperties` |
| `definitions.AzureFirewallPropertiesFormat.properties.ipGroups.$ref__deleted` | deleted | `#/definitions/IpGroups` |
| `definitions.AzureFirewallPropertiesFormat.properties.threatIntelMode.$ref__added` | added | `./common.json/definitions/AzureFirewallThreatIntelMode` |
| `definitions.AzureFirewallRCAction.properties.type.$ref__added` | added | `./common.json/definitions/AzureFirewallRCActionType` |
| `definitions.AzureFirewallSku.properties.name.$ref__added` | added | `./common.json/definitions/AzureFirewallSkuName` |
| `definitions.AzureFirewallSku.properties.tier.$ref__added` | added | `./common.json/definitions/AzureFirewallSkuTier` |
| `definitions.FirewallPacketCaptureParameters.properties.protocol.$ref__added` | added | `./common.json/definitions/AzureFirewallNetworkRuleProtocol` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallFqdnTagListResult.required__added` | added | `["value"]` |
| `definitions.AzureFirewallListResult.required__added` | added | `["value"]` |

### Changes for `items`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallPropertiesFormat.properties.ipGroups.items__added` | added | `{"$ref":"#/definitions/AzureFirewallIpGroups"}` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallPropertiesFormat.properties.additionalProperties.additionalProperties__added` | added | `{"type":"string"}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AzureFirewall.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.AzureFirewall.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `./common.json/definitions/ExtendedLocation` |
| `definitions.AzureFirewallApplicationRuleCollection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.AzureFirewallApplicationRuleCollectionPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.AzureFirewallFqdnTag.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.AzureFirewallFqdnTagPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.AzureFirewallIPConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.AzureFirewallIPConfigurationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.AzureFirewallIPConfigurationPropertiesFormat.properties.publicIPAddress.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.AzureFirewallIPConfigurationPropertiesFormat.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.AzureFirewallNatRuleCollection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.AzureFirewallNatRuleCollectionProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.AzureFirewallNetworkRuleCollection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.AzureFirewallNetworkRuleCollectionPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.AzureFirewallPropertiesFormat.properties.firewallPolicy.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.AzureFirewallPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.AzureFirewallPropertiesFormat.properties.virtualHub.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `info.description` | `The Microsoft Azure Network management API provides a RESTful set of web services that interact with Microsoft Azure Networks service to manage your network resources. The API has entities that capture the relationship between an end user and the Microsoft Azure Networks service.` | `APIs to manage web application firewall rules.` |
| `info.title` | `NetworkManagementClient` | `WebApplicationFirewallManagement` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/azureFirewallFqdnTags'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/azureFirewalls'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/learnedIPPrefixes'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCaptureOperation'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |

