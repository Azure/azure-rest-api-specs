## Swagger Changes

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableRequestHeaders'].get.responses.200.schema.$ref__deleted` | deleted | `#/definitions/ApplicationGatewayAvailableRequestHeadersResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableResponseHeaders'].get.responses.200.schema.$ref__deleted` | deleted | `#/definitions/ApplicationGatewayAvailableResponseHeadersResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableServerVariables'].get.responses.200.schema.$ref__deleted` | deleted | `#/definitions/ApplicationGatewayAvailableServerVariablesResult` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayPrivateEndpointConnection.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.ApplicationGatewayWafDynamicManifestResult.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableRequestHeaders'].get.responses.200.schema.type__added` | added | `array` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableResponseHeaders'].get.responses.200.schema.type__added` | added | `array` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableServerVariables'].get.responses.200.schema.type__added` | added | `array` |

### Changes for `items`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableRequestHeaders'].get.responses.200.schema.items__added` | added | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableResponseHeaders'].get.responses.200.schema.items__added` | added | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableServerVariables'].get.responses.200.schema.items__added` | added | `{"type":"string"}` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/backendhealth'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/getBackendHealthOnDemand'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections/{connectionName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections/{connectionName}'].put.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/start'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/stop'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/{policyName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ApplicationGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections/{connectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ApplicationGatewayPrivateEndpointConnection` |

### Changes for `ApplicationGatewayAuthenticationCertificate`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAuthenticationCertificate__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayAuthenticationC...` |

### Changes for `ApplicationGatewayAuthenticationCertificatePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAuthenticationCertificatePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"data":{"type":"string"},"provisioningState":{"$ref":"./network.json#...` |

### Changes for `ApplicationGatewayAutoscaleConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAutoscaleConfiguration__deleted` | deleted | `{"type":"object","properties":{"minCapacity":{"type":"integer","format":"int32","minimum":0,"exclusi...` |

### Changes for `ApplicationGatewayAvailableRequestHeadersResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAvailableRequestHeadersResult__deleted` | deleted | `{"type":"array","items":{"type":"string"}}` |

### Changes for `ApplicationGatewayAvailableResponseHeadersResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAvailableResponseHeadersResult__deleted` | deleted | `{"type":"array","items":{"type":"string"}}` |

### Changes for `ApplicationGatewayAvailableServerVariablesResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAvailableServerVariablesResult__deleted` | deleted | `{"type":"array","items":{"type":"string"}}` |

### Changes for `ApplicationGatewayAvailableSslOptionsPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAvailableSslOptionsPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"predefinedPolicies":{"type":"array","items":{"$ref":"./network.json#...` |

### Changes for `ApplicationGatewayAvailableSslPredefinedPolicies`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAvailableSslPredefinedPolicies__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ApplicationGatewayAvailableWafRuleSetsResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAvailableWafRuleSetsResult__deleted` | deleted | `{"type":"object","properties":{"value":{"type":"array","items":{"$ref":"#/definitions/ApplicationGat...` |

### Changes for `ApplicationGatewayBackendAddress`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayBackendAddress__deleted` | deleted | `{"type":"object","properties":{"fqdn":{"type":"string"},"ipAddress":{"type":"string"}}}` |

### Changes for `ApplicationGatewayBackendAddressPool`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayBackendAddressPool__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayBackendAddressP...` |

### Changes for `ApplicationGatewayBackendAddressPoolPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayBackendAddressPoolPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"backendIPConfigurations":{"type":"array","items":{"$ref":"./networkI...` |

### Changes for `ApplicationGatewayBackendHealth`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayBackendHealth__deleted` | deleted | `{"type":"object","properties":{"backendAddressPools":{"type":"array","items":{"$ref":"#/definitions/...` |

### Changes for `ApplicationGatewayBackendHealthHttpSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayBackendHealthHttpSettings__deleted` | deleted | `{"type":"object","properties":{"backendHttpSettings":{"$ref":"#/definitions/ApplicationGatewayBacken...` |

### Changes for `ApplicationGatewayBackendHealthOnDemand`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayBackendHealthOnDemand__deleted` | deleted | `{"type":"object","properties":{"backendAddressPool":{"$ref":"#/definitions/ApplicationGatewayBackend...` |

### Changes for `ApplicationGatewayBackendHealthPool`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayBackendHealthPool__deleted` | deleted | `{"type":"object","properties":{"backendAddressPool":{"$ref":"#/definitions/ApplicationGatewayBackend...` |

### Changes for `ApplicationGatewayBackendHealthServer`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayBackendHealthServer__deleted` | deleted | `{"type":"object","properties":{"address":{"type":"string"},"ipConfiguration":{"$ref":"./networkInter...` |

### Changes for `ApplicationGatewayBackendHttpSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayBackendHttpSettings__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayBackendHttpSett...` |

### Changes for `ApplicationGatewayBackendHttpSettingsPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"port":{"type":"integer","format":"int32"},"protocol":{"type":"string...` |

### Changes for `ApplicationGatewayBackendSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayBackendSettings__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayBackendSettings...` |

### Changes for `ApplicationGatewayBackendSettingsPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayBackendSettingsPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"port":{"type":"integer","format":"int32"},"protocol":{"type":"string...` |

### Changes for `ApplicationGatewayClientAuthConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayClientAuthConfiguration__deleted` | deleted | `{"type":"object","properties":{"verifyClientCertIssuerDN":{"type":"boolean"},"verifyClientRevocation...` |

### Changes for `ApplicationGatewayConnectionDraining`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayConnectionDraining__deleted` | deleted | `{"type":"object","properties":{"enabled":{"type":"boolean"},"drainTimeoutInSec":{"type":"integer","f...` |

### Changes for `ApplicationGatewayCustomError`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayCustomError__deleted` | deleted | `{"type":"object","properties":{"statusCode":{"type":"string","enum":["HttpStatus400","HttpStatus403"...` |

### Changes for `ApplicationGatewayEntraJWTValidationConfig`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayEntraJWTValidationConfig__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayEntraJWTValidat...` |

### Changes for `ApplicationGatewayEntraJWTValidationConfigPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayEntraJWTValidationConfigPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"unAuthorizedRequestAction":{"type":"string","enum":["Deny","Allow"],...` |

### Changes for `ApplicationGatewayFirewallDisabledRuleGroup`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayFirewallDisabledRuleGroup__deleted` | deleted | `{"type":"object","properties":{"ruleGroupName":{"type":"string"},"rules":{"type":"array","items":{"t...` |

### Changes for `ApplicationGatewayFirewallExclusion`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayFirewallExclusion__deleted` | deleted | `{"type":"object","properties":{"matchVariable":{"type":"string"},"selectorMatchOperator":{"type":"st...` |

### Changes for `ApplicationGatewayFirewallManifestRuleSet`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayFirewallManifestRuleSet__deleted` | deleted | `{"type":"object","properties":{"ruleSetType":{"type":"string"},"ruleSetVersion":{"type":"string"},"s...` |

### Changes for `ApplicationGatewayFirewallRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayFirewallRule__deleted` | deleted | `{"type":"object","properties":{"ruleId":{"type":"integer","format":"int32"},"ruleIdString":{"type":"...` |

### Changes for `ApplicationGatewayFirewallRuleGroup`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayFirewallRuleGroup__deleted` | deleted | `{"type":"object","properties":{"ruleGroupName":{"type":"string"},"description":{"type":"string"},"ru...` |

### Changes for `ApplicationGatewayFirewallRuleSet`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayFirewallRuleSet__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayFirewallRuleSet...` |

### Changes for `ApplicationGatewayFirewallRuleSetPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayFirewallRuleSetPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"provisioningState":{"$ref":"./network.json#/definitions/Provisioning...` |

### Changes for `ApplicationGatewayForContainersReferenceDefinition`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayForContainersReferenceDefinition__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string","format":"arm-id","x-ms-arm-id-details":{"allow...` |

### Changes for `ApplicationGatewayFrontendIPConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayFrontendIPConfiguration__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayFrontendIPConfi...` |

### Changes for `ApplicationGatewayFrontendIPConfigurationPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayFrontendIPConfigurationPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"privateIPAddress":{"type":"string"},"privateIPAllocationMethod":{"$r...` |

### Changes for `ApplicationGatewayFrontendPort`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayFrontendPort__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayFrontendPortPro...` |

### Changes for `ApplicationGatewayFrontendPortPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayFrontendPortPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"port":{"type":"integer","format":"int32"},"provisioningState":{"$ref...` |

### Changes for `ApplicationGatewayGlobalConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayGlobalConfiguration__deleted` | deleted | `{"type":"object","properties":{"enableRequestBuffering":{"type":"boolean"},"enableResponseBuffering"...` |

### Changes for `ApplicationGatewayHeaderConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayHeaderConfiguration__deleted` | deleted | `{"type":"object","properties":{"headerName":{"type":"string"},"headerValueMatcher":{"$ref":"#/defini...` |

### Changes for `ApplicationGatewayHttpListener`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayHttpListener__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayHttpListenerPro...` |

### Changes for `ApplicationGatewayHttpListenerPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"frontendIPConfiguration":{"$ref":"./network.json#/definitions/SubRes...` |

### Changes for `ApplicationGatewayIPConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayIPConfiguration__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayIPConfiguration...` |

### Changes for `ApplicationGatewayIPConfigurationPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayIPConfigurationPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"subnet":{"$ref":"./network.json#/definitions/SubResource"},"provisio...` |

### Changes for `ApplicationGatewayListener`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayListener__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayListenerPropert...` |

### Changes for `ApplicationGatewayListenerPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayListenerPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"frontendIPConfiguration":{"$ref":"./network.json#/definitions/SubRes...` |

### Changes for `ApplicationGatewayLoadDistributionPolicy`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayLoadDistributionPolicy__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayLoadDistributio...` |

### Changes for `ApplicationGatewayLoadDistributionPolicyPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayLoadDistributionPolicyPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"loadDistributionTargets":{"type":"array","items":{"$ref":"#/definiti...` |

### Changes for `ApplicationGatewayLoadDistributionTarget`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayLoadDistributionTarget__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayLoadDistributio...` |

### Changes for `ApplicationGatewayLoadDistributionTargetPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayLoadDistributionTargetPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"weightPerServer":{"type":"integer","format":"int32","minimum":1,"exc...` |

### Changes for `ApplicationGatewayOnDemandProbe`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayOnDemandProbe__deleted` | deleted | `{"type":"object","properties":{"protocol":{"type":"string","enum":["Http","Https","Tcp","Tls"],"x-ms...` |

### Changes for `ApplicationGatewayPathRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayPathRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayPathRulePropert...` |

### Changes for `ApplicationGatewayPathRulePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayPathRulePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"paths":{"type":"array","items":{"type":"string"}},"backendAddressPoo...` |

### Changes for `ApplicationGatewayPrivateEndpointConnectionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayPrivateEndpointConnectionProperties__deleted` | deleted | `{"type":"object","properties":{"privateEndpoint":{"$ref":"./privateEndpoint.json#/definitions/Privat...` |

### Changes for `ApplicationGatewayPrivateLinkConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayPrivateLinkConfiguration__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayPrivateLinkConf...` |

### Changes for `ApplicationGatewayPrivateLinkConfigurationProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayPrivateLinkConfigurationProperties__deleted` | deleted | `{"type":"object","properties":{"ipConfigurations":{"type":"array","items":{"$ref":"#/definitions/App...` |

### Changes for `ApplicationGatewayPrivateLinkIpConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayPrivateLinkIpConfiguration__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayPrivateLinkIpCo...` |

### Changes for `ApplicationGatewayPrivateLinkIpConfigurationProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayPrivateLinkIpConfigurationProperties__deleted` | deleted | `{"type":"object","properties":{"privateIPAddress":{"type":"string"},"privateIPAllocationMethod":{"$r...` |

### Changes for `ApplicationGatewayPrivateLinkResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayPrivateLinkResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayPrivateLinkReso...` |

### Changes for `ApplicationGatewayPrivateLinkResourceListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayPrivateLinkResourceListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ApplicationGatewayPrivateLinkResourceProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayPrivateLinkResourceProperties__deleted` | deleted | `{"type":"object","properties":{"groupId":{"type":"string","readOnly":true},"requiredMembers":{"type"...` |

### Changes for `ApplicationGatewayProbe`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayProbe__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayProbeProperties...` |

### Changes for `ApplicationGatewayProbeHealthResponseMatch`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayProbeHealthResponseMatch__deleted` | deleted | `{"type":"object","properties":{"body":{"type":"string"},"statusCodes":{"type":"array","items":{"type...` |

### Changes for `ApplicationGatewayProbePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayProbePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"protocol":{"type":"string","enum":["Http","Https","Tcp","Tls"],"x-ms...` |

### Changes for `ApplicationGatewayPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"sku":{"$ref":"#/definitions/ApplicationGatewaySku"},"sslPolicy":{"$r...` |

### Changes for `ApplicationGatewayRedirectConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayRedirectConfiguration__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayRedirectConfigu...` |

### Changes for `ApplicationGatewayRedirectConfigurationPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayRedirectConfigurationPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"redirectType":{"type":"string","enum":["Permanent","Found","SeeOther...` |

### Changes for `ApplicationGatewayRequestRoutingRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayRequestRoutingRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayRequestRoutingR...` |

### Changes for `ApplicationGatewayRequestRoutingRulePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"ruleType":{"type":"string","enum":["Basic","PathBasedRouting"],"x-ms...` |

### Changes for `ApplicationGatewayRewriteRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayRewriteRule__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"ruleSequence":{"type":"integer"},"condition...` |

### Changes for `ApplicationGatewayRewriteRuleActionSet`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayRewriteRuleActionSet__deleted` | deleted | `{"type":"object","properties":{"requestHeaderConfigurations":{"type":"array","items":{"$ref":"#/defi...` |

### Changes for `ApplicationGatewayRewriteRuleCondition`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayRewriteRuleCondition__deleted` | deleted | `{"type":"object","properties":{"variable":{"type":"string"},"pattern":{"type":"string"},"ignoreCase"...` |

### Changes for `ApplicationGatewayRewriteRuleSet`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayRewriteRuleSet__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayRewriteRuleSetP...` |

### Changes for `ApplicationGatewayRewriteRuleSetPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayRewriteRuleSetPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"rewriteRules":{"type":"array","items":{"$ref":"#/definitions/Applica...` |

### Changes for `ApplicationGatewayRoutingRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayRoutingRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayRoutingRuleProp...` |

### Changes for `ApplicationGatewayRoutingRulePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"ruleType":{"type":"string","enum":["Basic","PathBasedRouting"],"x-ms...` |

### Changes for `ApplicationGatewaySku`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewaySku__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string","enum":["Standard_Small","Standard_Medium","S...` |

### Changes for `ApplicationGatewaySslCertificate`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewaySslCertificate__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewaySslCertificateP...` |

### Changes for `ApplicationGatewaySslCertificatePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewaySslCertificatePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"data":{"type":"string"},"password":{"type":"string"},"publicCertData...` |

### Changes for `ApplicationGatewaySslPolicy`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewaySslPolicy__deleted` | deleted | `{"type":"object","properties":{"disabledSslProtocols":{"type":"array","items":{"type":"string","enum...` |

### Changes for `ApplicationGatewaySslPredefinedPolicy`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewaySslPredefinedPolicy__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"properties":{"$ref":"#/definitions/Applicat...` |

### Changes for `ApplicationGatewaySslPredefinedPolicyPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewaySslPredefinedPolicyPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"cipherSuites":{"type":"array","items":{"type":"string","enum":["TLS_...` |

### Changes for `ApplicationGatewaySslProfile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewaySslProfile__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewaySslProfilePrope...` |

### Changes for `ApplicationGatewaySslProfilePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewaySslProfilePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"trustedClientCertificates":{"type":"array","items":{"$ref":"./networ...` |

### Changes for `ApplicationGatewayTrustedClientCertificate`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayTrustedClientCertificate__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayTrustedClientCe...` |

### Changes for `ApplicationGatewayTrustedClientCertificatePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayTrustedClientCertificatePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"data":{"type":"string"},"validatedCertData":{"type":"string","readOn...` |

### Changes for `ApplicationGatewayTrustedRootCertificate`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayTrustedRootCertificate__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayTrustedRootCert...` |

### Changes for `ApplicationGatewayTrustedRootCertificatePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayTrustedRootCertificatePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"data":{"type":"string"},"keyVaultSecretId":{"type":"string"},"provis...` |

### Changes for `ApplicationGatewayUrlConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayUrlConfiguration__deleted` | deleted | `{"type":"object","properties":{"modifiedPath":{"type":"string"},"modifiedQueryString":{"type":"strin...` |

### Changes for `ApplicationGatewayUrlPathMap`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayUrlPathMap__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplicationGatewayUrlPathMapPrope...` |

### Changes for `ApplicationGatewayUrlPathMapPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayUrlPathMapPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"defaultBackendAddressPool":{"$ref":"./network.json#/definitions/SubR...` |

### Changes for `ApplicationGatewayWafDynamicManifestPropertiesResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayWafDynamicManifestPropertiesResult__deleted` | deleted | `{"type":"object","properties":{"defaultRuleSet":{"$ref":"#/definitions/DefaultRuleSetPropertyFormat"...` |

### Changes for `ApplicationGatewayWafDynamicManifestResultList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayWafDynamicManifestResultList__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ApplicationGatewayWebApplicationFirewallConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayWebApplicationFirewallConfiguration__deleted` | deleted | `{"type":"object","properties":{"enabled":{"type":"boolean"},"firewallMode":{"type":"string","enum":[...` |

### Changes for `DefaultRuleSetPropertyFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DefaultRuleSetPropertyFormat__deleted` | deleted | `{"type":"object","properties":{"ruleSetType":{"type":"string"},"ruleSetVersion":{"type":"string"}}}` |

### Changes for `ExceptionEntry`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExceptionEntry__deleted` | deleted | `{"type":"object","properties":{"matchVariable":{"type":"string","enum":["RequestURI","RemoteAddr","R...` |

### Changes for `ExclusionManagedRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExclusionManagedRule__deleted` | deleted | `{"type":"object","properties":{"ruleId":{"type":"string"}},"required":["ruleId"]}` |

### Changes for `ExclusionManagedRuleGroup`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExclusionManagedRuleGroup__deleted` | deleted | `{"type":"object","properties":{"ruleGroupName":{"type":"string"},"rules":{"type":"array","items":{"$...` |

### Changes for `ExclusionManagedRuleSet`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExclusionManagedRuleSet__deleted` | deleted | `{"type":"object","properties":{"ruleSetType":{"type":"string"},"ruleSetVersion":{"type":"string"},"r...` |

### Changes for `GroupByUserSession`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GroupByUserSession__deleted` | deleted | `{"type":"object","properties":{"groupByVariables":{"type":"array","items":{"$ref":"#/definitions/Gro...` |

### Changes for `GroupByVariable`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GroupByVariable__deleted` | deleted | `{"type":"object","properties":{"variableName":{"type":"string","enum":["ClientAddr","GeoLocation","N...` |

### Changes for `HeaderValueMatcher`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HeaderValueMatcher__deleted` | deleted | `{"type":"object","properties":{"pattern":{"type":"string"},"ignoreCase":{"type":"boolean"},"negate":...` |

### Changes for `ManagedRuleGroupOverride`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ManagedRuleGroupOverride__deleted` | deleted | `{"type":"object","properties":{"ruleGroupName":{"type":"string"},"rules":{"type":"array","items":{"$...` |

### Changes for `ManagedRuleOverride`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ManagedRuleOverride__deleted` | deleted | `{"type":"object","properties":{"ruleId":{"type":"string"},"state":{"type":"string","enum":["Disabled...` |

### Changes for `ManagedRuleSet`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ManagedRuleSet__deleted` | deleted | `{"type":"object","properties":{"ruleSetType":{"type":"string"},"ruleSetVersion":{"type":"string"},"r...` |

### Changes for `ManagedRuleSetRuleGroup`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ManagedRuleSetRuleGroup__deleted` | deleted | `{"type":"object","properties":{"ruleGroupName":{"type":"string"},"rules":{"type":"array","items":{"t...` |

### Changes for `ManagedRulesDefinition`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ManagedRulesDefinition__deleted` | deleted | `{"type":"object","properties":{"exceptions":{"type":"array","items":{"$ref":"#/definitions/Exception...` |

### Changes for `MatchCondition`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MatchCondition__deleted` | deleted | `{"type":"object","properties":{"matchVariables":{"type":"array","items":{"$ref":"#/definitions/Match...` |

### Changes for `MatchVariable`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MatchVariable__deleted` | deleted | `{"type":"object","properties":{"variableName":{"type":"string","enum":["RemoteAddr","RequestMethod",...` |

### Changes for `OwaspCrsExclusionEntry`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OwaspCrsExclusionEntry__deleted` | deleted | `{"type":"object","properties":{"matchVariable":{"type":"string","enum":["RequestHeaderNames","Reques...` |

### Changes for `PolicySettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PolicySettings__deleted` | deleted | `{"type":"object","properties":{"state":{"type":"string","enum":["Disabled","Enabled"],"x-ms-enum":{"...` |

### Changes for `WebApplicationFirewallCustomRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebApplicationFirewallCustomRule__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string","maxLength":128},"etag":{"type":"string","rea...` |

### Changes for `WebApplicationFirewallPolicyListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebApplicationFirewallPolicyListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `WebApplicationFirewallPolicyPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebApplicationFirewallPolicyPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"policySettings":{"$ref":"#/definitions/PolicySettings"},"customRules...` |

### Changes for `WebApplicationFirewallScrubbingRules`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebApplicationFirewallScrubbingRules__deleted` | deleted | `{"type":"object","properties":{"matchVariable":{"type":"string","enum":["RequestHeaderNames","Reques...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayListResult.required__added` | added | `["value"]` |
| `definitions.ApplicationGatewayPrivateEndpointConnectionListResult.required__added` | added | `["value"]` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayPrivateEndpointConnection.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.ApplicationGatewayWafDynamicManifestResult.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayWafDynamicManifestResult.allOf__added` | added | `[{"$ref":"./common.json/definitions/ProxyResourcewithoutEtag"}]` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayWafDynamicManifestResult.properties.id__deleted` | deleted | `{"type":"string"}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.ApplicationGateway.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.ApplicationGateway.properties.identity.$ref` | `./network.json#/definitions/ManagedServiceIdentity` | `./common.json/definitions/ManagedServiceIdentity` |
| `definitions.ApplicationGateway.properties.properties.$ref` | `#/definitions/ApplicationGatewayPropertiesFormat` | `./common.json/definitions/ApplicationGatewayPropertiesFormat` |
| `definitions.ApplicationGatewayAvailableSslOptions.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.ApplicationGatewayAvailableSslOptions.properties.properties.$ref` | `#/definitions/ApplicationGatewayAvailableSslOptionsPropertiesFormat` | `./common.json/definitions/ApplicationGatewayAvailableSslOptionsPropertiesFormat` |
| `definitions.ApplicationGatewayPrivateEndpointConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResourceModel` |
| `definitions.ApplicationGatewayPrivateEndpointConnection.properties.properties.$ref` | `#/definitions/ApplicationGatewayPrivateEndpointConnectionProperties` | `./common.json/definitions/ApplicationGatewayPrivateEndpointConnectionProperties` |
| `definitions.ApplicationGatewayWafDynamicManifestResult.properties.properties.$ref` | `#/definitions/ApplicationGatewayWafDynamicManifestPropertiesResult` | `./common.json/definitions/ApplicationGatewayWafDynamicManifestPropertiesResult` |
| `definitions.WebApplicationFirewallPolicy.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.WebApplicationFirewallPolicy.properties.properties.$ref` | `#/definitions/WebApplicationFirewallPolicyPropertiesFormat` | `./common.json/definitions/WebApplicationFirewallPolicyPropertiesFormat` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableRequestHeaders'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableResponseHeaders'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableServerVariables'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableSslOptions/default'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableSslOptions/default/predefinedPolicies'].get.responses.200.schema.$ref` | `#/definitions/ApplicationGatewayAvailableSslPredefinedPolicies` | `./common.json/definitions/ApplicationGatewayAvailableSslPredefinedPolicies` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableSslOptions/default/predefinedPolicies'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableSslOptions/default/predefinedPolicies/{predefinedPolicyName}'].get.responses.200.schema.$ref` | `#/definitions/ApplicationGatewaySslPredefinedPolicy` | `./common.json/definitions/ApplicationGatewaySslPredefinedPolicy` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableSslOptions/default/predefinedPolicies/{predefinedPolicyName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableWafRuleSets'].get.responses.200.schema.$ref` | `#/definitions/ApplicationGatewayAvailableWafRuleSetsResult` | `./common.json/definitions/ApplicationGatewayAvailableWafRuleSetsResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableWafRuleSets'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayWebApplicationFirewallPolicies'].get.responses.200.schema.$ref` | `#/definitions/WebApplicationFirewallPolicyListResult` | `./common.json/definitions/WebApplicationFirewallPolicyListResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayWebApplicationFirewallPolicies'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/applicationGatewayWafDynamicManifests'].get.responses.200.schema.$ref` | `#/definitions/ApplicationGatewayWafDynamicManifestResultList` | `./common.json/definitions/ApplicationGatewayWafDynamicManifestResultList` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/applicationGatewayWafDynamicManifests'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/applicationGatewayWafDynamicManifests/dafault'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/backendhealth'].post.responses.200.schema.$ref` | `#/definitions/ApplicationGatewayBackendHealth` | `./common.json/definitions/ApplicationGatewayBackendHealth` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/backendhealth'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/getBackendHealthOnDemand'].post.parameters[2].schema.$ref` | `#/definitions/ApplicationGatewayOnDemandProbe` | `./common.json/definitions/ApplicationGatewayOnDemandProbe` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/getBackendHealthOnDemand'].post.responses.200.schema.$ref` | `#/definitions/ApplicationGatewayBackendHealthOnDemand` | `./common.json/definitions/ApplicationGatewayBackendHealthOnDemand` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/getBackendHealthOnDemand'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections/{connectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections/{connectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections/{connectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateLinkResources'].get.responses.200.schema.$ref` | `#/definitions/ApplicationGatewayPrivateLinkResourceListResult` | `./common.json/definitions/ApplicationGatewayPrivateLinkResourceListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateLinkResources'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/start'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/stop'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGatewayWebApplicationFirewallPolicies'].get.responses.200.schema.$ref` | `#/definitions/WebApplicationFirewallPolicyListResult` | `./common.json/definitions/WebApplicationFirewallPolicyListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGatewayWebApplicationFirewallPolicies'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/{policyName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/{policyName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/{policyName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |

