## Swagger Changes

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableRequestHeaders'].get.tags__deleted` | deleted | `["ApplicationGateways"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableResponseHeaders'].get.tags__deleted` | deleted | `["ApplicationGateways"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableServerVariables'].get.tags__deleted` | deleted | `["ApplicationGateways"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableWafRuleSets'].get.tags__deleted` | deleted | `["ApplicationGateways"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/applicationGatewayWafDynamicManifests'].get.tags__added` | added | `["ApplicationGatewayWafDynamicManifestResults"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/applicationGatewayWafDynamicManifests/dafault'].get.tags__added` | added | `["ApplicationGatewayWafDynamicManifestResults"]` |
| `tags__added` | added | `[{"name":"ApplicationGateways"},{"name":"ApplicationGatewayAvailableSslOptionsOperationGroup"},{"nam...` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAvailableSslOptionsPropertiesFormat.properties.availableCipherSuites.items.$ref__added` | added | `./common.json#/definitions/ApplicationGatewaySslCipherSuite` |
| `definitions.ApplicationGatewayAvailableSslOptionsPropertiesFormat.properties.availableProtocols.items.$ref__added` | added | `./common.json#/definitions/ApplicationGatewaySslProtocol` |
| `definitions.ApplicationGatewayAvailableSslOptionsPropertiesFormat.properties.defaultPolicy.$ref__added` | added | `./common.json#/definitions/ApplicationGatewaySslPolicyName` |
| `definitions.ApplicationGatewayBackendHealthServer.properties.health.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayBackendHealthServerHealth` |
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat.properties.cookieBasedAffinity.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayCookieBasedAffinity` |
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat.properties.protocol.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayProtocol` |
| `definitions.ApplicationGatewayBackendSettingsPropertiesFormat.properties.protocol.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayProtocol` |
| `definitions.ApplicationGatewayClientAuthConfiguration.properties.verifyClientAuthMode.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayClientAuthVerificationModes` |
| `definitions.ApplicationGatewayClientAuthConfiguration.properties.verifyClientRevocation.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayClientRevocationOptions` |
| `definitions.ApplicationGatewayCustomError.properties.statusCode.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayCustomErrorStatusCode` |
| `definitions.ApplicationGatewayEntraJWTValidationConfigPropertiesFormat.properties.unAuthorizedRequestAction.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayUnAuthorizedRequestAction` |
| `definitions.ApplicationGatewayFirewallManifestRuleSet.properties.status.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayRuleSetStatusOptions` |
| `definitions.ApplicationGatewayFirewallManifestRuleSet.properties.tiers.items.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayTierTypes` |
| `definitions.ApplicationGatewayFirewallRule.properties.action.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayWafRuleActionTypes` |
| `definitions.ApplicationGatewayFirewallRule.properties.sensitivity.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayWafRuleSensitivityTypes` |
| `definitions.ApplicationGatewayFirewallRule.properties.state.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayWafRuleStateTypes` |
| `definitions.ApplicationGatewayFirewallRuleSetPropertiesFormat.properties.tiers.items.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayTierTypes` |
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat.properties.protocol.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayProtocol` |
| `definitions.ApplicationGatewayListenerPropertiesFormat.properties.protocol.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayProtocol` |
| `definitions.ApplicationGatewayLoadDistributionPolicyPropertiesFormat.properties.loadDistributionAlgorithm.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayLoadDistributionAlgorithm` |
| `definitions.ApplicationGatewayOnDemandProbe.properties.protocol.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayProtocol` |
| `definitions.ApplicationGatewayProbePropertiesFormat.properties.protocol.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayProtocol` |
| `definitions.ApplicationGatewayPropertiesFormat.properties.defaultPredefinedSslPolicy.$ref__added` | added | `./common.json#/definitions/ApplicationGatewaySslPolicyName` |
| `definitions.ApplicationGatewayPropertiesFormat.properties.operationalState.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayOperationalState` |
| `definitions.ApplicationGatewayRedirectConfigurationPropertiesFormat.properties.redirectType.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayRedirectType` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.ruleType.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayRequestRoutingRuleType` |
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat.properties.ruleType.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayRequestRoutingRuleType` |
| `definitions.ApplicationGatewaySku.properties.family.$ref__added` | added | `./common.json#/definitions/ApplicationGatewaySkuFamily` |
| `definitions.ApplicationGatewaySku.properties.name.$ref__added` | added | `./common.json#/definitions/ApplicationGatewaySkuName` |
| `definitions.ApplicationGatewaySku.properties.tier.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayTier` |
| `definitions.ApplicationGatewaySslPolicy.properties.cipherSuites.items.$ref__added` | added | `./common.json#/definitions/ApplicationGatewaySslCipherSuite` |
| `definitions.ApplicationGatewaySslPolicy.properties.disabledSslProtocols.items.$ref__added` | added | `./common.json#/definitions/ApplicationGatewaySslProtocol` |
| `definitions.ApplicationGatewaySslPolicy.properties.minProtocolVersion.$ref__added` | added | `./common.json#/definitions/ApplicationGatewaySslProtocol` |
| `definitions.ApplicationGatewaySslPolicy.properties.policyName.$ref__added` | added | `./common.json#/definitions/ApplicationGatewaySslPolicyName` |
| `definitions.ApplicationGatewaySslPolicy.properties.policyType.$ref__added` | added | `./common.json#/definitions/ApplicationGatewaySslPolicyType` |
| `definitions.ApplicationGatewaySslPredefinedPolicyPropertiesFormat.properties.cipherSuites.items.$ref__added` | added | `./common.json#/definitions/ApplicationGatewaySslCipherSuite` |
| `definitions.ApplicationGatewaySslPredefinedPolicyPropertiesFormat.properties.minProtocolVersion.$ref__added` | added | `./common.json#/definitions/ApplicationGatewaySslProtocol` |
| `definitions.ApplicationGatewayWebApplicationFirewallConfiguration.properties.firewallMode.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayFirewallMode` |
| `definitions.ExceptionEntry.properties.matchVariable.$ref__added` | added | `./common.json#/definitions/ExceptionEntryMatchVariable` |
| `definitions.ExceptionEntry.properties.selectorMatchOperator.$ref__added` | added | `./common.json#/definitions/ExceptionEntrySelectorMatchOperator` |
| `definitions.ExceptionEntry.properties.valueMatchOperator.$ref__added` | added | `./common.json#/definitions/ExceptionEntryValueMatchOperator` |
| `definitions.GroupByVariable.properties.variableName.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayFirewallUserSessionVariable` |
| `definitions.ManagedRuleOverride.properties.action.$ref__added` | added | `./common.json#/definitions/ActionType` |
| `definitions.ManagedRuleOverride.properties.sensitivity.$ref__added` | added | `./common.json#/definitions/SensitivityType` |
| `definitions.ManagedRuleOverride.properties.state.$ref__added` | added | `./common.json#/definitions/ManagedRuleEnabledState` |
| `definitions.MatchCondition.properties.operator.$ref__added` | added | `./common.json#/definitions/WebApplicationFirewallOperator` |
| `definitions.MatchCondition.properties.transforms.items.$ref__added` | added | `./common.json#/definitions/WebApplicationFirewallTransform` |
| `definitions.MatchVariable.properties.variableName.$ref__added` | added | `./common.json#/definitions/WebApplicationFirewallMatchVariable` |
| `definitions.OwaspCrsExclusionEntry.properties.matchVariable.$ref__added` | added | `./common.json#/definitions/OwaspCrsExclusionEntryMatchVariable` |
| `definitions.OwaspCrsExclusionEntry.properties.selectorMatchOperator.$ref__added` | added | `./common.json#/definitions/OwaspCrsExclusionEntrySelectorMatchOperator` |
| `definitions.PolicySettings.properties.logScrubbing.$ref__added` | added | `#/definitions/PolicySettingsLogScrubbing` |
| `definitions.PolicySettings.properties.mode.$ref__added` | added | `./common.json#/definitions/WebApplicationFirewallMode` |
| `definitions.PolicySettings.properties.state.$ref__added` | added | `./common.json#/definitions/WebApplicationFirewallEnabledState` |
| `definitions.WebApplicationFirewallCustomRule.properties.action.$ref__added` | added | `./common.json#/definitions/WebApplicationFirewallAction` |
| `definitions.WebApplicationFirewallCustomRule.properties.rateLimitDuration.$ref__added` | added | `./common.json#/definitions/ApplicationGatewayFirewallRateLimitDuration` |
| `definitions.WebApplicationFirewallCustomRule.properties.ruleType.$ref__added` | added | `./common.json#/definitions/WebApplicationFirewallRuleType` |
| `definitions.WebApplicationFirewallCustomRule.properties.state.$ref__added` | added | `./common.json#/definitions/WebApplicationFirewallState` |
| `definitions.WebApplicationFirewallPolicyPropertiesFormat.properties.resourceState.$ref__added` | added | `./common.json#/definitions/WebApplicationFirewallPolicyResourceState` |
| `definitions.WebApplicationFirewallScrubbingRules.properties.matchVariable.$ref__added` | added | `./common.json#/definitions/ScrubbingRuleEntryMatchVariable` |
| `definitions.WebApplicationFirewallScrubbingRules.properties.selectorMatchOperator.$ref__added` | added | `./common.json#/definitions/scrubbingRuleEntryMatchOperator` |
| `definitions.WebApplicationFirewallScrubbingRules.properties.state.$ref__added` | added | `./common.json#/definitions/scrubbingRuleEntryState` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableRequestHeaders'].get.responses.200.schema.$ref__deleted` | deleted | `#/definitions/ApplicationGatewayAvailableRequestHeadersResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableResponseHeaders'].get.responses.200.schema.$ref__deleted` | deleted | `#/definitions/ApplicationGatewayAvailableResponseHeadersResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableServerVariables'].get.responses.200.schema.$ref__deleted` | deleted | `#/definitions/ApplicationGatewayAvailableServerVariablesResult` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAvailableSslOptionsPropertiesFormat.properties.availableCipherSuites.items.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayAvailableSslOptionsPropertiesFormat.properties.availableProtocols.items.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayAvailableSslOptionsPropertiesFormat.properties.defaultPolicy.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayBackendHealthServer.properties.health.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat.properties.cookieBasedAffinity.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayBackendSettingsPropertiesFormat.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayClientAuthConfiguration.properties.verifyClientAuthMode.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayClientAuthConfiguration.properties.verifyClientRevocation.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayCustomError.properties.statusCode.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayEntraJWTValidationConfigPropertiesFormat.properties.unAuthorizedRequestAction.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayFirewallManifestRuleSet.properties.status.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayFirewallManifestRuleSet.properties.tiers.items.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayFirewallRule.properties.action.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayFirewallRule.properties.sensitivity.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayFirewallRule.properties.state.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayFirewallRuleSetPropertiesFormat.properties.tiers.items.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayHeaderConfiguration.properties.headerValueMatcher.type__deleted` | deleted | `object` |
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayListenerPropertiesFormat.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayLoadDistributionPolicyPropertiesFormat.properties.loadDistributionAlgorithm.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayOnDemandProbe.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayPrivateEndpointConnection.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.ApplicationGatewayProbePropertiesFormat.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayPropertiesFormat.properties.defaultPredefinedSslPolicy.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayPropertiesFormat.properties.operationalState.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayRedirectConfigurationPropertiesFormat.properties.redirectType.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.ruleType.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayRewriteRule.properties.actionSet.type__deleted` | deleted | `object` |
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat.properties.ruleType.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewaySku.properties.family.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewaySku.properties.name.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewaySku.properties.tier.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewaySslPolicy.properties.cipherSuites.items.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewaySslPolicy.properties.disabledSslProtocols.items.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewaySslPolicy.properties.minProtocolVersion.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewaySslPolicy.properties.policyName.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewaySslPolicy.properties.policyType.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewaySslPredefinedPolicyPropertiesFormat.properties.cipherSuites.items.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewaySslPredefinedPolicyPropertiesFormat.properties.minProtocolVersion.type__deleted` | deleted | `string` |
| `definitions.ApplicationGatewayWafDynamicManifestResult.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.ApplicationGatewayWebApplicationFirewallConfiguration.properties.firewallMode.type__deleted` | deleted | `string` |
| `definitions.ExceptionEntry.properties.matchVariable.type__deleted` | deleted | `string` |
| `definitions.ExceptionEntry.properties.selectorMatchOperator.type__deleted` | deleted | `string` |
| `definitions.ExceptionEntry.properties.valueMatchOperator.type__deleted` | deleted | `string` |
| `definitions.GroupByVariable.properties.variableName.type__deleted` | deleted | `string` |
| `definitions.ManagedRuleOverride.properties.action.type__deleted` | deleted | `string` |
| `definitions.ManagedRuleOverride.properties.sensitivity.type__deleted` | deleted | `string` |
| `definitions.ManagedRuleOverride.properties.state.type__deleted` | deleted | `string` |
| `definitions.MatchCondition.properties.operator.type__deleted` | deleted | `string` |
| `definitions.MatchCondition.properties.transforms.items.type__deleted` | deleted | `string` |
| `definitions.MatchVariable.properties.variableName.type__deleted` | deleted | `string` |
| `definitions.OwaspCrsExclusionEntry.properties.matchVariable.type__deleted` | deleted | `string` |
| `definitions.OwaspCrsExclusionEntry.properties.selectorMatchOperator.type__deleted` | deleted | `string` |
| `definitions.PolicySettings.properties.logScrubbing.type__deleted` | deleted | `object` |
| `definitions.PolicySettings.properties.mode.type__deleted` | deleted | `string` |
| `definitions.PolicySettings.properties.state.type__deleted` | deleted | `string` |
| `definitions.WebApplicationFirewallCustomRule.properties.action.type__deleted` | deleted | `string` |
| `definitions.WebApplicationFirewallCustomRule.properties.rateLimitDuration.type__deleted` | deleted | `string` |
| `definitions.WebApplicationFirewallCustomRule.properties.ruleType.type__deleted` | deleted | `string` |
| `definitions.WebApplicationFirewallCustomRule.properties.state.type__deleted` | deleted | `string` |
| `definitions.WebApplicationFirewallPolicyPropertiesFormat.properties.resourceState.type__deleted` | deleted | `string` |
| `definitions.WebApplicationFirewallScrubbingRules.properties.matchVariable.type__deleted` | deleted | `string` |
| `definitions.WebApplicationFirewallScrubbingRules.properties.selectorMatchOperator.type__deleted` | deleted | `string` |
| `definitions.WebApplicationFirewallScrubbingRules.properties.state.type__deleted` | deleted | `string` |
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

### Changes for `PolicySettingsLogScrubbing`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PolicySettingsLogScrubbing__added` | added | `{"type":"object","properties":{"state":{"$ref":"./common.json#/definitions/WebApplicationFirewallScr...` |

### Changes for `exclusiveMinimum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAutoscaleConfiguration.properties.maxCapacity.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayAutoscaleConfiguration.properties.minCapacity.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayConnectionDraining.properties.drainTimeoutInSec.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayLoadDistributionTargetPropertiesFormat.properties.weightPerServer.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.priority.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat.properties.priority.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayWebApplicationFirewallConfiguration.properties.fileUploadLimitInMb.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayWebApplicationFirewallConfiguration.properties.maxRequestBodySize.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayWebApplicationFirewallConfiguration.properties.maxRequestBodySizeInKb.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.PolicySettings.properties.fileUploadLimitInMb.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.PolicySettings.properties.maxRequestBodySizeInKb.exclusiveMinimum__deleted` | deleted | `false` |

### Changes for `enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAvailableSslOptionsPropertiesFormat.properties.availableCipherSuites.items.enum__deleted` | deleted | `["TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384","TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256","TLS_ECDHE_RSA_WITH...` |
| `definitions.ApplicationGatewayAvailableSslOptionsPropertiesFormat.properties.availableProtocols.items.enum__deleted` | deleted | `["TLSv1_0","TLSv1_1","TLSv1_2","TLSv1_3"]` |
| `definitions.ApplicationGatewayAvailableSslOptionsPropertiesFormat.properties.defaultPolicy.enum__deleted` | deleted | `["AppGwSslPolicy20150501","AppGwSslPolicy20170401","AppGwSslPolicy20170401S","AppGwSslPolicy20220101...` |
| `definitions.ApplicationGatewayBackendHealthServer.properties.health.enum__deleted` | deleted | `["Unknown","Up","Down","Partial","Draining"]` |
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat.properties.cookieBasedAffinity.enum__deleted` | deleted | `["Enabled","Disabled"]` |
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat.properties.protocol.enum__deleted` | deleted | `["Http","Https","Tcp","Tls"]` |
| `definitions.ApplicationGatewayBackendSettingsPropertiesFormat.properties.protocol.enum__deleted` | deleted | `["Http","Https","Tcp","Tls"]` |
| `definitions.ApplicationGatewayClientAuthConfiguration.properties.verifyClientAuthMode.enum__deleted` | deleted | `["Strict","Passthrough"]` |
| `definitions.ApplicationGatewayClientAuthConfiguration.properties.verifyClientRevocation.enum__deleted` | deleted | `["None","OCSP"]` |
| `definitions.ApplicationGatewayCustomError.properties.statusCode.enum__deleted` | deleted | `["HttpStatus400","HttpStatus403","HttpStatus404","HttpStatus405","HttpStatus408","HttpStatus500","Ht...` |
| `definitions.ApplicationGatewayEntraJWTValidationConfigPropertiesFormat.properties.unAuthorizedRequestAction.enum__deleted` | deleted | `["Deny","Allow"]` |
| `definitions.ApplicationGatewayFirewallManifestRuleSet.properties.status.enum__deleted` | deleted | `["Preview","GA","Supported","Deprecated"]` |
| `definitions.ApplicationGatewayFirewallManifestRuleSet.properties.tiers.items.enum__deleted` | deleted | `["Standard","WAF","Standard_v2","WAF_v2"]` |
| `definitions.ApplicationGatewayFirewallRule.properties.action.enum__deleted` | deleted | `["None","AnomalyScoring","Allow","Block","Log"]` |
| `definitions.ApplicationGatewayFirewallRule.properties.sensitivity.enum__deleted` | deleted | `["Low","Medium","High"]` |
| `definitions.ApplicationGatewayFirewallRule.properties.state.enum__deleted` | deleted | `["Enabled","Disabled"]` |
| `definitions.ApplicationGatewayFirewallRuleSetPropertiesFormat.properties.tiers.items.enum__deleted` | deleted | `["Standard","WAF","Standard_v2","WAF_v2"]` |
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat.properties.protocol.enum__deleted` | deleted | `["Http","Https","Tcp","Tls"]` |
| `definitions.ApplicationGatewayListenerPropertiesFormat.properties.protocol.enum__deleted` | deleted | `["Http","Https","Tcp","Tls"]` |
| `definitions.ApplicationGatewayLoadDistributionPolicyPropertiesFormat.properties.loadDistributionAlgorithm.enum__deleted` | deleted | `["RoundRobin","LeastConnections","IpHash"]` |
| `definitions.ApplicationGatewayOnDemandProbe.properties.protocol.enum__deleted` | deleted | `["Http","Https","Tcp","Tls"]` |
| `definitions.ApplicationGatewayProbePropertiesFormat.properties.protocol.enum__deleted` | deleted | `["Http","Https","Tcp","Tls"]` |
| `definitions.ApplicationGatewayPropertiesFormat.properties.defaultPredefinedSslPolicy.enum__deleted` | deleted | `["AppGwSslPolicy20150501","AppGwSslPolicy20170401","AppGwSslPolicy20170401S","AppGwSslPolicy20220101...` |
| `definitions.ApplicationGatewayPropertiesFormat.properties.operationalState.enum__deleted` | deleted | `["Stopped","Starting","Running","Stopping"]` |
| `definitions.ApplicationGatewayRedirectConfigurationPropertiesFormat.properties.redirectType.enum__deleted` | deleted | `["Permanent","Found","SeeOther","Temporary"]` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.ruleType.enum__deleted` | deleted | `["Basic","PathBasedRouting"]` |
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat.properties.ruleType.enum__deleted` | deleted | `["Basic","PathBasedRouting"]` |
| `definitions.ApplicationGatewaySku.properties.family.enum__deleted` | deleted | `["Generation_1","Generation_2"]` |
| `definitions.ApplicationGatewaySku.properties.name.enum__deleted` | deleted | `["Standard_Small","Standard_Medium","Standard_Large","WAF_Medium","WAF_Large","Standard_v2","WAF_v2"...` |
| `definitions.ApplicationGatewaySku.properties.tier.enum__deleted` | deleted | `["Standard","WAF","Standard_v2","WAF_v2","Basic"]` |
| `definitions.ApplicationGatewaySslPolicy.properties.cipherSuites.items.enum__deleted` | deleted | `["TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384","TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256","TLS_ECDHE_RSA_WITH...` |
| `definitions.ApplicationGatewaySslPolicy.properties.disabledSslProtocols.items.enum__deleted` | deleted | `["TLSv1_0","TLSv1_1","TLSv1_2","TLSv1_3"]` |
| `definitions.ApplicationGatewaySslPolicy.properties.minProtocolVersion.enum__deleted` | deleted | `["TLSv1_0","TLSv1_1","TLSv1_2","TLSv1_3"]` |
| `definitions.ApplicationGatewaySslPolicy.properties.policyName.enum__deleted` | deleted | `["AppGwSslPolicy20150501","AppGwSslPolicy20170401","AppGwSslPolicy20170401S","AppGwSslPolicy20220101...` |
| `definitions.ApplicationGatewaySslPolicy.properties.policyType.enum__deleted` | deleted | `["Predefined","Custom","CustomV2"]` |
| `definitions.ApplicationGatewaySslPredefinedPolicyPropertiesFormat.properties.cipherSuites.items.enum__deleted` | deleted | `["TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384","TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256","TLS_ECDHE_RSA_WITH...` |
| `definitions.ApplicationGatewaySslPredefinedPolicyPropertiesFormat.properties.minProtocolVersion.enum__deleted` | deleted | `["TLSv1_0","TLSv1_1","TLSv1_2","TLSv1_3"]` |
| `definitions.ApplicationGatewayWebApplicationFirewallConfiguration.properties.firewallMode.enum__deleted` | deleted | `["Detection","Prevention"]` |
| `definitions.ExceptionEntry.properties.matchVariable.enum__deleted` | deleted | `["RequestURI","RemoteAddr","RequestHeader"]` |
| `definitions.ExceptionEntry.properties.selectorMatchOperator.enum__deleted` | deleted | `["Equals","Contains","StartsWith","EndsWith"]` |
| `definitions.ExceptionEntry.properties.valueMatchOperator.enum__deleted` | deleted | `["Equals","Contains","StartsWith","EndsWith","IPMatch"]` |
| `definitions.GroupByVariable.properties.variableName.enum__deleted` | deleted | `["ClientAddr","GeoLocation","None","ClientAddrXFFHeader","GeoLocationXFFHeader"]` |
| `definitions.ManagedRuleOverride.properties.action.enum__deleted` | deleted | `["AnomalyScoring","Allow","Block","Log","JSChallenge"]` |
| `definitions.ManagedRuleOverride.properties.sensitivity.enum__deleted` | deleted | `["Low","Medium","High"]` |
| `definitions.ManagedRuleOverride.properties.state.enum__deleted` | deleted | `["Disabled","Enabled"]` |
| `definitions.MatchCondition.properties.operator.enum__deleted` | deleted | `["IPMatch","Equal","Contains","LessThan","GreaterThan","LessThanOrEqual","GreaterThanOrEqual","Begin...` |
| `definitions.MatchCondition.properties.transforms.items.enum__deleted` | deleted | `["Uppercase","Lowercase","Trim","UrlDecode","UrlEncode","RemoveNulls","HtmlEntityDecode"]` |
| `definitions.MatchVariable.properties.variableName.enum__deleted` | deleted | `["RemoteAddr","RequestMethod","QueryString","PostArgs","RequestUri","RequestHeaders","RequestBody","...` |
| `definitions.OwaspCrsExclusionEntry.properties.matchVariable.enum__deleted` | deleted | `["RequestHeaderNames","RequestCookieNames","RequestArgNames","RequestHeaderKeys","RequestHeaderValue...` |
| `definitions.OwaspCrsExclusionEntry.properties.selectorMatchOperator.enum__deleted` | deleted | `["Equals","Contains","StartsWith","EndsWith","EqualsAny"]` |
| `definitions.PolicySettings.properties.mode.enum__deleted` | deleted | `["Prevention","Detection"]` |
| `definitions.PolicySettings.properties.state.enum__deleted` | deleted | `["Disabled","Enabled"]` |
| `definitions.WebApplicationFirewallCustomRule.properties.action.enum__deleted` | deleted | `["Allow","Block","Log","JSChallenge"]` |
| `definitions.WebApplicationFirewallCustomRule.properties.rateLimitDuration.enum__deleted` | deleted | `["OneMin","FiveMins"]` |
| `definitions.WebApplicationFirewallCustomRule.properties.ruleType.enum__deleted` | deleted | `["MatchRule","RateLimitRule","Invalid"]` |
| `definitions.WebApplicationFirewallCustomRule.properties.state.enum__deleted` | deleted | `["Disabled","Enabled"]` |
| `definitions.WebApplicationFirewallPolicyPropertiesFormat.properties.resourceState.enum__deleted` | deleted | `["Creating","Enabling","Enabled","Disabling","Disabled","Deleting"]` |
| `definitions.WebApplicationFirewallScrubbingRules.properties.matchVariable.enum__deleted` | deleted | `["RequestHeaderNames","RequestCookieNames","RequestArgNames","RequestPostArgNames","RequestJSONArgNa...` |
| `definitions.WebApplicationFirewallScrubbingRules.properties.selectorMatchOperator.enum__deleted` | deleted | `["Equals","EqualsAny"]` |
| `definitions.WebApplicationFirewallScrubbingRules.properties.state.enum__deleted` | deleted | `["Enabled","Disabled"]` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAvailableSslOptionsPropertiesFormat.properties.availableCipherSuites.items['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewaySslCipherSuite","modelAsString":true}` |
| `definitions.ApplicationGatewayAvailableSslOptionsPropertiesFormat.properties.availableProtocols.items['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewaySslProtocol","modelAsString":true}` |
| `definitions.ApplicationGatewayAvailableSslOptionsPropertiesFormat.properties.defaultPolicy['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewaySslPolicyName","modelAsString":true}` |
| `definitions.ApplicationGatewayBackendHealthServer.properties.health['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayBackendHealthServerHealth","modelAsString":true}` |
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat.properties.cookieBasedAffinity['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayCookieBasedAffinity","modelAsString":true}` |
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayProtocol","modelAsString":true}` |
| `definitions.ApplicationGatewayBackendSettingsPropertiesFormat.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayProtocol","modelAsString":true}` |
| `definitions.ApplicationGatewayClientAuthConfiguration.properties.verifyClientAuthMode['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayClientAuthVerificationModes","modelAsString":true}` |
| `definitions.ApplicationGatewayClientAuthConfiguration.properties.verifyClientRevocation['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayClientRevocationOptions","modelAsString":true}` |
| `definitions.ApplicationGatewayCustomError.properties.statusCode['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayCustomErrorStatusCode","modelAsString":true}` |
| `definitions.ApplicationGatewayEntraJWTValidationConfigPropertiesFormat.properties.unAuthorizedRequestAction['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayUnAuthorizedRequestAction","modelAsString":true}` |
| `definitions.ApplicationGatewayFirewallManifestRuleSet.properties.status['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayRuleSetStatusOptions","modelAsString":true}` |
| `definitions.ApplicationGatewayFirewallManifestRuleSet.properties.tiers.items['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayTierTypes","modelAsString":true}` |
| `definitions.ApplicationGatewayFirewallRule.properties.action['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayWafRuleActionTypes","modelAsString":true}` |
| `definitions.ApplicationGatewayFirewallRule.properties.sensitivity['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayWafRuleSensitivityTypes","modelAsString":true}` |
| `definitions.ApplicationGatewayFirewallRule.properties.state['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayWafRuleStateTypes","modelAsString":true}` |
| `definitions.ApplicationGatewayFirewallRuleSetPropertiesFormat.properties.tiers.items['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayTierTypes","modelAsString":true}` |
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayProtocol","modelAsString":true}` |
| `definitions.ApplicationGatewayListenerPropertiesFormat.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayProtocol","modelAsString":true}` |
| `definitions.ApplicationGatewayLoadDistributionPolicyPropertiesFormat.properties.loadDistributionAlgorithm['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayLoadDistributionAlgorithm","modelAsString":true}` |
| `definitions.ApplicationGatewayOnDemandProbe.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayProtocol","modelAsString":true}` |
| `definitions.ApplicationGatewayProbePropertiesFormat.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayProtocol","modelAsString":true}` |
| `definitions.ApplicationGatewayPropertiesFormat.properties.defaultPredefinedSslPolicy['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewaySslPolicyName","modelAsString":true}` |
| `definitions.ApplicationGatewayPropertiesFormat.properties.operationalState['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayOperationalState","modelAsString":true}` |
| `definitions.ApplicationGatewayRedirectConfigurationPropertiesFormat.properties.redirectType['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayRedirectType","modelAsString":true}` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.ruleType['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayRequestRoutingRuleType","modelAsString":true}` |
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat.properties.ruleType['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayRequestRoutingRuleType","modelAsString":true}` |
| `definitions.ApplicationGatewaySku.properties.family['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewaySkuFamily","modelAsString":true}` |
| `definitions.ApplicationGatewaySku.properties.name['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewaySkuName","modelAsString":true}` |
| `definitions.ApplicationGatewaySku.properties.tier['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayTier","modelAsString":true}` |
| `definitions.ApplicationGatewaySslPolicy.properties.cipherSuites.items['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewaySslCipherSuite","modelAsString":true}` |
| `definitions.ApplicationGatewaySslPolicy.properties.disabledSslProtocols.items['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewaySslProtocol","modelAsString":true}` |
| `definitions.ApplicationGatewaySslPolicy.properties.minProtocolVersion['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewaySslProtocol","modelAsString":true}` |
| `definitions.ApplicationGatewaySslPolicy.properties.policyName['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewaySslPolicyName","modelAsString":true}` |
| `definitions.ApplicationGatewaySslPolicy.properties.policyType['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewaySslPolicyType","modelAsString":true}` |
| `definitions.ApplicationGatewaySslPredefinedPolicyPropertiesFormat.properties.cipherSuites.items['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewaySslCipherSuite","modelAsString":true}` |
| `definitions.ApplicationGatewaySslPredefinedPolicyPropertiesFormat.properties.minProtocolVersion['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewaySslProtocol","modelAsString":true}` |
| `definitions.ApplicationGatewayWebApplicationFirewallConfiguration.properties.firewallMode['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayFirewallMode","modelAsString":true}` |
| `definitions.ExceptionEntry.properties.matchVariable['x-ms-enum__deleted']` | deleted | `{"name":"ExceptionEntryMatchVariable","modelAsString":true}` |
| `definitions.ExceptionEntry.properties.selectorMatchOperator['x-ms-enum__deleted']` | deleted | `{"name":"ExceptionEntrySelectorMatchOperator","modelAsString":true}` |
| `definitions.ExceptionEntry.properties.valueMatchOperator['x-ms-enum__deleted']` | deleted | `{"name":"ExceptionEntryValueMatchOperator","modelAsString":true}` |
| `definitions.GroupByVariable.properties.variableName['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayFirewallUserSessionVariable","modelAsString":true}` |
| `definitions.ManagedRuleOverride.properties.action['x-ms-enum__deleted']` | deleted | `{"name":"ActionType","modelAsString":true}` |
| `definitions.ManagedRuleOverride.properties.sensitivity['x-ms-enum__deleted']` | deleted | `{"name":"SensitivityType","modelAsString":true}` |
| `definitions.ManagedRuleOverride.properties.state['x-ms-enum__deleted']` | deleted | `{"name":"ManagedRuleEnabledState","modelAsString":true}` |
| `definitions.MatchCondition.properties.operator['x-ms-enum__deleted']` | deleted | `{"name":"WebApplicationFirewallOperator","modelAsString":true}` |
| `definitions.MatchCondition.properties.transforms.items['x-ms-enum__deleted']` | deleted | `{"name":"WebApplicationFirewallTransform","modelAsString":true}` |
| `definitions.MatchVariable.properties.variableName['x-ms-enum__deleted']` | deleted | `{"name":"WebApplicationFirewallMatchVariable","modelAsString":true}` |
| `definitions.OwaspCrsExclusionEntry.properties.matchVariable['x-ms-enum__deleted']` | deleted | `{"name":"OwaspCrsExclusionEntryMatchVariable","modelAsString":true}` |
| `definitions.OwaspCrsExclusionEntry.properties.selectorMatchOperator['x-ms-enum__deleted']` | deleted | `{"name":"OwaspCrsExclusionEntrySelectorMatchOperator","modelAsString":true}` |
| `definitions.PolicySettings.properties.mode['x-ms-enum__deleted']` | deleted | `{"name":"WebApplicationFirewallMode","modelAsString":true}` |
| `definitions.PolicySettings.properties.state['x-ms-enum__deleted']` | deleted | `{"name":"WebApplicationFirewallEnabledState","modelAsString":true}` |
| `definitions.WebApplicationFirewallCustomRule.properties.action['x-ms-enum__deleted']` | deleted | `{"name":"WebApplicationFirewallAction","modelAsString":true}` |
| `definitions.WebApplicationFirewallCustomRule.properties.rateLimitDuration['x-ms-enum__deleted']` | deleted | `{"name":"ApplicationGatewayFirewallRateLimitDuration","modelAsString":true}` |
| `definitions.WebApplicationFirewallCustomRule.properties.ruleType['x-ms-enum__deleted']` | deleted | `{"name":"WebApplicationFirewallRuleType","modelAsString":true}` |
| `definitions.WebApplicationFirewallCustomRule.properties.state['x-ms-enum__deleted']` | deleted | `{"name":"WebApplicationFirewallState","modelAsString":true}` |
| `definitions.WebApplicationFirewallPolicyPropertiesFormat.properties.resourceState['x-ms-enum__deleted']` | deleted | `{"name":"WebApplicationFirewallPolicyResourceState","modelAsString":true}` |
| `definitions.WebApplicationFirewallScrubbingRules.properties.matchVariable['x-ms-enum__deleted']` | deleted | `{"name":"ScrubbingRuleEntryMatchVariable","modelAsString":true}` |
| `definitions.WebApplicationFirewallScrubbingRules.properties.selectorMatchOperator['x-ms-enum__deleted']` | deleted | `{"name":" scrubbingRuleEntryMatchOperator","modelAsString":true}` |
| `definitions.WebApplicationFirewallScrubbingRules.properties.state['x-ms-enum__deleted']` | deleted | `{"name":" scrubbingRuleEntryState","modelAsString":true}` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAvailableSslPredefinedPolicies.required__added` | added | `["value"]` |
| `definitions.ApplicationGatewayListResult.required__added` | added | `["value"]` |
| `definitions.ApplicationGatewayPrivateEndpointConnectionListResult.required__added` | added | `["value"]` |
| `definitions.ApplicationGatewayPrivateLinkResourceListResult.required__added` | added | `["value"]` |
| `definitions.ApplicationGatewayWafDynamicManifestResultList.required__added` | added | `["value"]` |
| `definitions.WebApplicationFirewallPolicyListResult.required__added` | added | `["value"]` |

### Changes for `exclusiveMaximum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayConnectionDraining.properties.drainTimeoutInSec.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayLoadDistributionTargetPropertiesFormat.properties.weightPerServer.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.priority.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat.properties.priority.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayWebApplicationFirewallConfiguration.properties.maxRequestBodySize.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayWebApplicationFirewallConfiguration.properties.maxRequestBodySizeInKb.exclusiveMaximum__deleted` | deleted | `false` |

### Changes for `x-nullable`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayFirewallDisabledRuleGroup.properties.rules.items['x-nullable__deleted']` | deleted | `false` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayPrivateEndpointConnection.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.ApplicationGatewayWafDynamicManifestResult.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayRewriteRule.properties.ruleSequence.format__added` | added | `int32` |
| `definitions.WebApplicationFirewallCustomRule.properties.priority.format__added` | added | `int32` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayWafDynamicManifestResult.allOf__added` | added | `[{"$ref":"./common.json#/definitions/ProxyResourcewithoutEtag"}]` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayWafDynamicManifestResult.properties.id__deleted` | deleted | `{"type":"string"}` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PolicySettings.properties.logScrubbing.properties__deleted` | deleted | `{"state":{"type":"string","description":"State of the log scrubbing config. Default value is Enabled...` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.ApplicationGateway.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.ApplicationGateway.properties.identity.$ref` | `./network.json#/definitions/ManagedServiceIdentity` | `./common.json#/definitions/ManagedServiceIdentity` |
| `definitions.ApplicationGatewayAuthenticationCertificate.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayAuthenticationCertificatePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayAvailableSslOptions.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.ApplicationGatewayAvailableSslOptionsPropertiesFormat.properties.predefinedPolicies.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayBackendAddressPool.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayBackendAddressPoolPropertiesFormat.properties.backendIPConfigurations.items.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceIPConfiguration` | `./virtualNetwork.json#/definitions/NetworkInterfaceIPConfiguration` |
| `definitions.ApplicationGatewayBackendAddressPoolPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayBackendHealthServer.properties.ipConfiguration.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceIPConfiguration` | `./virtualNetwork.json#/definitions/NetworkInterfaceIPConfiguration` |
| `definitions.ApplicationGatewayBackendHttpSettings.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat.properties.authenticationCertificates.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat.properties.probe.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat.properties.trustedRootCertificates.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayBackendSettings.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayBackendSettingsPropertiesFormat.properties.probe.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayBackendSettingsPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayBackendSettingsPropertiesFormat.properties.trustedRootCertificates.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayEntraJWTValidationConfig.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayEntraJWTValidationConfigPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayFirewallManifestRuleSet.properties.ruleGroups.items.$ref` | `applicationGateway.json#/definitions/ApplicationGatewayFirewallRuleGroup` | `#/definitions/ApplicationGatewayFirewallRuleGroup` |
| `definitions.ApplicationGatewayFirewallRuleSet.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.ApplicationGatewayFirewallRuleSetPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayFrontendIPConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.$ref` | `./network.json#/definitions/IPAllocationMethod` | `./common.json#/definitions/IPAllocationMethod` |
| `definitions.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.properties.privateLinkConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.properties.publicIPAddress.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayFrontendPort.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayFrontendPortPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayHttpListener.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat.properties.firewallPolicy.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat.properties.frontendIPConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat.properties.frontendPort.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat.properties.sslCertificate.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat.properties.sslProfile.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayIPConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayIPConfigurationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayIPConfigurationPropertiesFormat.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayListener.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayListenerPropertiesFormat.properties.frontendIPConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayListenerPropertiesFormat.properties.frontendPort.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayListenerPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayListenerPropertiesFormat.properties.sslCertificate.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayListenerPropertiesFormat.properties.sslProfile.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayLoadDistributionPolicy.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayLoadDistributionPolicyPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayLoadDistributionTarget.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayLoadDistributionTargetPropertiesFormat.properties.backendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayOnDemandProbe.properties.backendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayOnDemandProbe.properties.backendHttpSettings.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayPathRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayPathRulePropertiesFormat.properties.backendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayPathRulePropertiesFormat.properties.backendHttpSettings.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayPathRulePropertiesFormat.properties.firewallPolicy.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayPathRulePropertiesFormat.properties.loadDistributionPolicy.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayPathRulePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayPathRulePropertiesFormat.properties.redirectConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayPathRulePropertiesFormat.properties.rewriteRuleSet.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayPrivateEndpointConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.ApplicationGatewayPrivateEndpointConnectionProperties.properties.privateEndpoint.$ref` | `./privateEndpoint.json#/definitions/PrivateEndpoint` | `./virtualNetwork.json#/definitions/PrivateEndpoint` |
| `definitions.ApplicationGatewayPrivateEndpointConnectionProperties.properties.privateLinkServiceConnectionState.$ref` | `./privateLinkService.json#/definitions/PrivateLinkServiceConnectionState` | `./virtualNetwork.json#/definitions/PrivateLinkServiceConnectionState` |
| `definitions.ApplicationGatewayPrivateEndpointConnectionProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayPrivateLinkConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayPrivateLinkConfigurationProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayPrivateLinkIpConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayPrivateLinkIpConfigurationProperties.properties.privateIPAllocationMethod.$ref` | `./network.json#/definitions/IPAllocationMethod` | `./common.json#/definitions/IPAllocationMethod` |
| `definitions.ApplicationGatewayPrivateLinkIpConfigurationProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayPrivateLinkIpConfigurationProperties.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayPrivateLinkResource.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayProbe.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayProbePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayPropertiesFormat.properties.firewallPolicy.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayRedirectConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayRedirectConfigurationPropertiesFormat.properties.pathRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayRedirectConfigurationPropertiesFormat.properties.requestRoutingRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayRedirectConfigurationPropertiesFormat.properties.targetListener.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayRedirectConfigurationPropertiesFormat.properties.urlPathMaps.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayRequestRoutingRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.backendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.backendHttpSettings.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.entraJWTValidationConfig.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.httpListener.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.loadDistributionPolicy.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.redirectConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.rewriteRuleSet.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.urlPathMap.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayRewriteRuleSet.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayRewriteRuleSetPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayRoutingRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat.properties.backendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat.properties.backendSettings.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat.properties.listener.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewaySslCertificate.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewaySslCertificatePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewaySslPredefinedPolicy.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewaySslProfile.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewaySslProfilePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewaySslProfilePropertiesFormat.properties.trustedClientCertificates.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayTrustedClientCertificate.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayTrustedClientCertificatePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayTrustedRootCertificate.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayTrustedRootCertificatePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ApplicationGatewayUrlPathMap.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayUrlPathMapPropertiesFormat.properties.defaultBackendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayUrlPathMapPropertiesFormat.properties.defaultBackendHttpSettings.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayUrlPathMapPropertiesFormat.properties.defaultLoadDistributionPolicy.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayUrlPathMapPropertiesFormat.properties.defaultRedirectConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayUrlPathMapPropertiesFormat.properties.defaultRewriteRuleSet.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ApplicationGatewayUrlPathMapPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.WebApplicationFirewallPolicy.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.WebApplicationFirewallPolicyPropertiesFormat.properties.applicationGateways.items.$ref` | `./applicationGateway.json#/definitions/ApplicationGateway` | `#/definitions/ApplicationGateway` |
| `definitions.WebApplicationFirewallPolicyPropertiesFormat.properties.httpListeners.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.WebApplicationFirewallPolicyPropertiesFormat.properties.pathBasedRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.WebApplicationFirewallPolicyPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableRequestHeaders'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableResponseHeaders'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableServerVariables'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableSslOptions/default'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableSslOptions/default/predefinedPolicies'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableSslOptions/default/predefinedPolicies/{predefinedPolicyName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableWafRuleSets'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayWebApplicationFirewallPolicies'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/applicationGatewayWafDynamicManifests'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/applicationGatewayWafDynamicManifests/dafault'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/backendhealth'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/getBackendHealthOnDemand'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections/{connectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections/{connectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections/{connectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateLinkResources'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/start'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/stop'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGatewayWebApplicationFirewallPolicies'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/{policyName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/{policyName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/{policyName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |

