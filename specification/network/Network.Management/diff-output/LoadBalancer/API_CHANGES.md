## Changed Paths

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendPoolName}/queryInboundNatRulePortMapping
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules/{loadBalancingRuleName}/health
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/frontendIPConfigurations
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/frontendIPConfigurations/{frontendIPConfigurationName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules/{loadBalancingRuleName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/outboundRules
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/outboundRules/{outboundRuleName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/probes
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/probes/{probeName}
Change Type: deleted

## Swagger Changes

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses__deleted']` | deleted | `{"post":{"operationId":"LoadBalancers_SwapPublicIpAddresses","parameters":[{"name":"location","in":"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools__deleted']` | deleted | `{"get":{"operationId":"LoadBalancerBackendAddressPools_List","parameters":[{"name":"loadBalancerName...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}__deleted']` | deleted | `{"get":{"operationId":"LoadBalancerBackendAddressPools_Get","parameters":[{"name":"loadBalancerName"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendPoolName}/queryInboundNatRulePortMapping`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendPoolName}/queryInboundNatRulePortMapping__deleted']` | deleted | `{"post":{"operationId":"LoadBalancers_ListInboundNatRulePortMappings","parameters":[{"name":"groupNa...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/frontendIPConfigurations`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/frontendIPConfigurations__deleted']` | deleted | `{"get":{"operationId":"LoadBalancerFrontendIPConfigurations_List","parameters":[{"name":"loadBalance...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/frontendIPConfigurations/{frontendIPConfigurationName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/frontendIPConfigurations/{frontendIPConfigurationName}__deleted']` | deleted | `{"get":{"operationId":"LoadBalancerFrontendIPConfigurations_Get","parameters":[{"name":"loadBalancer...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules__deleted']` | deleted | `{"get":{"operationId":"InboundNatRules_List","parameters":[{"name":"loadBalancerName","in":"path","r...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}__deleted']` | deleted | `{"get":{"operationId":"InboundNatRules_Get","parameters":[{"name":"loadBalancerName","in":"path","re...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules__deleted']` | deleted | `{"get":{"operationId":"LoadBalancerLoadBalancingRules_List","parameters":[{"name":"loadBalancerName"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules/{loadBalancingRuleName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules/{loadBalancingRuleName}__deleted']` | deleted | `{"get":{"operationId":"LoadBalancerLoadBalancingRules_Get","parameters":[{"name":"loadBalancerName",...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules/{loadBalancingRuleName}/health`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules/{loadBalancingRuleName}/health__deleted']` | deleted | `{"post":{"operationId":"LoadBalancerLoadBalancingRules_Health","parameters":[{"name":"groupName","in...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/outboundRules`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/outboundRules__deleted']` | deleted | `{"get":{"operationId":"LoadBalancerOutboundRules_List","parameters":[{"name":"loadBalancerName","in"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/outboundRules/{outboundRuleName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/outboundRules/{outboundRuleName}__deleted']` | deleted | `{"get":{"operationId":"LoadBalancerOutboundRules_Get","parameters":[{"name":"loadBalancerName","in":...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/probes`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/probes__deleted']` | deleted | `{"get":{"operationId":"LoadBalancerProbes_List","parameters":[{"name":"loadBalancerName","in":"path"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/probes/{probeName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/probes/{probeName}__deleted']` | deleted | `{"get":{"operationId":"LoadBalancerProbes_Get","parameters":[{"name":"loadBalancerName","in":"path",...` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/LoadBalancer` |

### Changes for `BackendAddressInboundNatRulePortMappings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BackendAddressInboundNatRulePortMappings__deleted` | deleted | `{"type":"object","properties":{"inboundNatRulePortMappings":{"type":"array","items":{"$ref":"#/defin...` |

### Changes for `BackendAddressPool`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BackendAddressPool__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/BackendAddressPoolPropertiesForma...` |

### Changes for `BackendAddressPoolPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BackendAddressPoolPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"location":{"type":"string"},"tunnelInterfaces":{"type":"array","item...` |

### Changes for `FrontendIPConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FrontendIPConfiguration__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/FrontendIPConfigurationProperties...` |

### Changes for `FrontendIPConfigurationPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FrontendIPConfigurationPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"inboundNatRules":{"type":"array","items":{"$ref":"./network.json#/de...` |

### Changes for `GatewayLoadBalancerTunnelInterface`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GatewayLoadBalancerTunnelInterface__deleted` | deleted | `{"type":"object","properties":{"port":{"type":"integer","format":"int32"},"identifier":{"type":"inte...` |

### Changes for `InboundNatPool`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InboundNatPool__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/InboundNatPoolPropertiesFormat","...` |

### Changes for `InboundNatPoolPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InboundNatPoolPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"frontendIPConfiguration":{"$ref":"./network.json#/definitions/SubRes...` |

### Changes for `InboundNatRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InboundNatRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/InboundNatRulePropertiesFormat","...` |

### Changes for `InboundNatRuleListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InboundNatRuleListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `InboundNatRulePortMapping`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InboundNatRulePortMapping__deleted` | deleted | `{"type":"object","properties":{"inboundNatRuleName":{"type":"string","readOnly":true},"protocol":{"t...` |

### Changes for `InboundNatRulePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InboundNatRulePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"frontendIPConfiguration":{"$ref":"./network.json#/definitions/SubRes...` |

### Changes for `LoadBalancerBackendAddress`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerBackendAddress__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/LoadBalancerBackendAddressPropert...` |

### Changes for `LoadBalancerBackendAddressPoolListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerBackendAddressPoolListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `LoadBalancerBackendAddressPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerBackendAddressPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"virtualNetwork":{"$ref":"./network.json#/definitions/SubResource"},"...` |

### Changes for `LoadBalancerFrontendIPConfigurationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerFrontendIPConfigurationListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `LoadBalancerHealthPerRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerHealthPerRule__deleted` | deleted | `{"type":"object","properties":{"up":{"type":"integer","format":"int32"},"down":{"type":"integer","fo...` |

### Changes for `LoadBalancerHealthPerRulePerBackendAddress`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerHealthPerRulePerBackendAddress__deleted` | deleted | `{"type":"object","properties":{"ipAddress":{"type":"string"},"networkInterfaceIPConfigurationId":{"t...` |

### Changes for `LoadBalancerLoadBalancingRuleListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerLoadBalancingRuleListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `LoadBalancerOutboundRuleListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerOutboundRuleListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `LoadBalancerProbeListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerProbeListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `LoadBalancerPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"frontendIPConfigurations":{"type":"array","items":{"$ref":"#/definit...` |

### Changes for `LoadBalancerSku`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerSku__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string","enum":["Basic","Standard","Gateway"],"x-ms-e...` |

### Changes for `LoadBalancerVipSwapRequest`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerVipSwapRequest__deleted` | deleted | `{"type":"object","properties":{"frontendIPConfigurations":{"type":"array","items":{"$ref":"#/definit...` |

### Changes for `LoadBalancerVipSwapRequestFrontendIPConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerVipSwapRequestFrontendIPConfiguration__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string"},"properties":{"$ref":"#/definitions/LoadBalanc...` |

### Changes for `LoadBalancerVipSwapRequestFrontendIPConfigurationProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerVipSwapRequestFrontendIPConfigurationProperties__deleted` | deleted | `{"type":"object","properties":{"publicIPAddress":{"$ref":"./network.json#/definitions/SubResource"}}...` |

### Changes for `LoadBalancingRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancingRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/LoadBalancingRulePropertiesFormat...` |

### Changes for `LoadBalancingRulePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancingRulePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"frontendIPConfiguration":{"$ref":"./network.json#/definitions/SubRes...` |

### Changes for `MigrateLoadBalancerToIpBasedRequest`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MigrateLoadBalancerToIpBasedRequest__deleted` | deleted | `{"type":"object","properties":{"pools":{"type":"array","items":{"type":"string"}}}}` |

### Changes for `MigratedPools`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MigratedPools__deleted` | deleted | `{"type":"object","properties":{"migratedPools":{"type":"array","items":{"type":"string"}}}}` |

### Changes for `NatRulePortMapping`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NatRulePortMapping__deleted` | deleted | `{"type":"object","properties":{"inboundNatRuleName":{"type":"string"},"frontendPort":{"type":"intege...` |

### Changes for `OutboundRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OutboundRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/OutboundRulePropertiesFormat","x-...` |

### Changes for `OutboundRulePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OutboundRulePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"allocatedOutboundPorts":{"type":"integer","format":"int32"},"fronten...` |

### Changes for `Probe`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Probe__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ProbePropertiesFormat","x-ms-clie...` |

### Changes for `ProbePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ProbePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"loadBalancingRules":{"type":"array","items":{"$ref":"./network.json#...` |

### Changes for `QueryInboundNatRulePortMappingRequest`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.QueryInboundNatRulePortMappingRequest__deleted` | deleted | `{"type":"object","properties":{"ipConfiguration":{"$ref":"./network.json#/definitions/SubResource"},...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerListResult.required__added` | added | `["value"]` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.LoadBalancer.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.LoadBalancer.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `./common.json/definitions/ExtendedLocation` |
| `definitions.LoadBalancer.properties.properties.$ref` | `#/definitions/LoadBalancerPropertiesFormat` | `./common.json/definitions/LoadBalancerPropertiesFormat` |
| `definitions.LoadBalancer.properties.sku.$ref` | `#/definitions/LoadBalancerSku` | `./common.json/definitions/LoadBalancerSku` |
| `info.description` | `The Microsoft Azure Network management API provides a RESTful set of web services that interact with Microsoft Azure Networks service to manage your network resources. The API has entities that capture the relationship between an end user and the Microsoft Azure Networks service.` | `APIs to manage web application firewall rules.` |
| `info.title` | `NetworkManagementClient` | `WebApplicationFirewallManagement` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/loadBalancers'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/migrateToIpBased'].post.parameters[2].schema.$ref` | `#/definitions/MigrateLoadBalancerToIpBasedRequest` | `./common.json/definitions/MigrateLoadBalancerToIpBasedRequest` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/migrateToIpBased'].post.responses.200.schema.$ref` | `#/definitions/MigratedPools` | `./common.json/definitions/MigratedPools` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/migrateToIpBased'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/networkInterfaces'].get.responses.200.schema.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceListResult` | `./virtualNetwork.json/definitions/NetworkInterfaceListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/networkInterfaces'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |

