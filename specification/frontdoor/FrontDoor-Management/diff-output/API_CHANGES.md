## Swagger Changes

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FrontDoorProperties.properties.rulesEngines.items.description__deleted` | deleted | `A rules engine configuration.` |
| `definitions.FrontDoorUpdateParameters.properties.backendPools.items.description__deleted` | deleted | `A backend pool` |
| `definitions.FrontDoorUpdateParameters.properties.frontendEndpoints.items.description__deleted` | deleted | `A frontend endpoint` |
| `definitions.FrontDoorUpdateParameters.properties.healthProbeSettings.items.description__deleted` | deleted | `A health probe settings` |
| `definitions.FrontDoorUpdateParameters.properties.loadBalancingSettings.items.description__deleted` | deleted | `A load balancing settings` |
| `definitions.FrontDoorUpdateParameters.properties.routingRules.items.description__deleted` | deleted | `A routing rule` |
| `definitions.RoutingRuleUpdateParameters.properties.frontendEndpoints.items.description__deleted` | deleted | `A reference to a frontend endpoint` |
| `definitions.RoutingRuleUpdateParameters.properties.patternsToMatch.items.description__deleted` | deleted | `A route pattern of the rule. Must not have any * except possibly after the final / at the end of the path.` |
| `definitions.WebApplicationFirewallPolicyProperties.properties.resourceState.description__added` | added | `Resource status of the policy.` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkExperimentProfiles'].get.description__added` | added | `Gets a list of Network Experiment Profiles under a subscription` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles'].get.description__added` | added | `Gets a list of Network Experiment Profiles within a resource group under a subscription` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles/{profileName}'].delete.description__added` | added | `Deletes an NetworkExperiment Profile by ProfileName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles/{profileName}'].get.description__added` | added | `Gets an NetworkExperiment Profile by ProfileName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles/{profileName}'].put.description__added` | added | `Creates an NetworkExperiment Profile` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles/{profileName}/experiments'].get.description__added` | added | `Gets a list of Experiments` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles/{profileName}/experiments/{experimentName}'].delete.description__added` | added | `Deletes an Experiment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles/{profileName}/experiments/{experimentName}'].get.description__added` | added | `Gets an Experiment by ExperimentName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles/{profileName}/experiments/{experimentName}'].put.description__added` | added | `Creates or updates an Experiment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles/{profileName}/experiments/{experimentName}/latencyScorecard'].get.description__added` | added | `Gets a Latency Scorecard for a given Experiment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles/{profileName}/experiments/{experimentName}/timeseries'].get.description__added` | added | `Gets a Timeseries for a given Experiment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles/{profileName}/preconfiguredEndpoints'].get.description__added` | added | `Gets a list of Preconfigured Endpoints` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}'].delete.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}'].put.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/frontendEndpoints/{frontendEndpointName}/disableHttps'].post.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/frontendEndpoints/{frontendEndpointName}/enableHttps'].post.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/purge'].post.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/rulesEngines/{rulesEngineName}'].delete.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/rulesEngines/{rulesEngineName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/rulesEngines/{rulesEngineName}'].put.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoorWebApplicationFirewallPolicies/{policyName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoorWebApplicationFirewallPolicies/{policyName}'].patch.responses.200.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoorWebApplicationFirewallPolicies/{policyName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoorWebApplicationFirewallPolicies/{policyName}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles/{profileName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles/{profileName}'].patch.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles/{profileName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles/{profileName}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles/{profileName}/experiments/{experimentName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles/{profileName}/experiments/{experimentName}'].patch.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles/{profileName}/experiments/{experimentName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles/{profileName}/experiments/{experimentName}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoorWebApplicationFirewallPolicies/{policyName}'].delete.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"#/definitions/ErrorResponse"}}` |

### Changes for `x-new-pattern`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}'].delete.parameters[0]['x-new-pattern__deleted']` | deleted | `^[a-zA-Z0-9]+([-a-zA-Z0-9]?[a-zA-Z0-9])*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}'].get.parameters[0]['x-new-pattern__deleted']` | deleted | `^[a-zA-Z0-9]+([-a-zA-Z0-9]?[a-zA-Z0-9])*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}'].put.parameters[0]['x-new-pattern__deleted']` | deleted | `^[a-zA-Z0-9]+([-a-zA-Z0-9]?[a-zA-Z0-9])*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/frontendEndpoints'].get.parameters[0]['x-new-pattern__deleted']` | deleted | `^[a-zA-Z0-9]+([-a-zA-Z0-9]?[a-zA-Z0-9])*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/frontendEndpoints/{frontendEndpointName}'].get.parameters[0]['x-new-pattern__deleted']` | deleted | `^[a-zA-Z0-9]+([-a-zA-Z0-9]?[a-zA-Z0-9])*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/frontendEndpoints/{frontendEndpointName}/disableHttps'].post.parameters[0]['x-new-pattern__deleted']` | deleted | `^[a-zA-Z0-9]+([-a-zA-Z0-9]?[a-zA-Z0-9])*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/frontendEndpoints/{frontendEndpointName}/enableHttps'].post.parameters[0]['x-new-pattern__deleted']` | deleted | `^[a-zA-Z0-9]+([-a-zA-Z0-9]?[a-zA-Z0-9])*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/purge'].post.parameters[0]['x-new-pattern__deleted']` | deleted | `^[a-zA-Z0-9]+([-a-zA-Z0-9]?[a-zA-Z0-9])*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/rulesEngines'].get.parameters[0]['x-new-pattern__deleted']` | deleted | `^[a-zA-Z0-9]+([-a-zA-Z0-9]?[a-zA-Z0-9])*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/rulesEngines/{rulesEngineName}'].delete.parameters[0]['x-new-pattern__deleted']` | deleted | `^[a-zA-Z0-9]+([-a-zA-Z0-9]?[a-zA-Z0-9])*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/rulesEngines/{rulesEngineName}'].get.parameters[0]['x-new-pattern__deleted']` | deleted | `^[a-zA-Z0-9]+([-a-zA-Z0-9]?[a-zA-Z0-9])*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/rulesEngines/{rulesEngineName}'].put.parameters[0]['x-new-pattern__deleted']` | deleted | `^[a-zA-Z0-9]+([-a-zA-Z0-9]?[a-zA-Z0-9])*$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/validateCustomDomain'].post.parameters[0]['x-new-pattern__deleted']` | deleted | `^[a-zA-Z0-9]+([-a-zA-Z0-9]?[a-zA-Z0-9])*$` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/FrontDoor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/rulesEngines/{rulesEngineName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/RulesEngine` |

### Changes for `x-previous-pattern`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/frontendEndpoints/{frontendEndpointName}'].get.parameters[1]['x-previous-pattern__deleted']` | deleted | `^[-\\w\\d\\._]+$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/frontendEndpoints/{frontendEndpointName}/disableHttps'].post.parameters[1]['x-previous-pattern__deleted']` | deleted | `^[-\\w\\d\\._]+$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/frontendEndpoints/{frontendEndpointName}/enableHttps'].post.parameters[1]['x-previous-pattern__deleted']` | deleted | `^[-\\w\\d\\._]+$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/rulesEngines/{rulesEngineName}'].delete.parameters[1]['x-previous-pattern__deleted']` | deleted | `^[-\\w\\d\\._]+$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/rulesEngines/{rulesEngineName}'].get.parameters[1]['x-previous-pattern__deleted']` | deleted | `^[-\\w\\d\\._]+$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoors/{frontDoorName}/rulesEngines/{rulesEngineName}'].put.parameters[1]['x-previous-pattern__deleted']` | deleted | `^[-\\w\\d\\._]+$` |

### Changes for `summary`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles/{profileName}/experiments/{experimentName}'].get.summary__deleted` | deleted | `Gets an Experiment by ExperimentName` |

### Changes for `AzureAsyncOperationResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureAsyncOperationResult__deleted` | deleted | `{"type":"object","description":"The response body contains the status of the specified asynchronous ...` |

### Changes for `BackendPoolListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BackendPoolListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `Error`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Error__deleted` | deleted | `{"type":"object","properties":{"code":{"type":"string"},"message":{"type":"string"},"target":{"type"...` |

### Changes for `ErrorDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorDetails__deleted` | deleted | `{"type":"object","properties":{"code":{"type":"string"},"target":{"type":"string"},"message":{"type"...` |

### Changes for `HealthProbeSettingsListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HealthProbeSettingsListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `LoadBalancingSettingsListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancingSettingsListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `RoutingRuleListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoutingRuleListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `DefaultErrorResponseError`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DefaultErrorResponseError__added` | added | `{"type":"object","description":"Error model.","properties":{"code":{"type":"string","description":"E...` |

### Changes for `FrontendEndpointUpdateParametersWebApplicationFirewallPolicyLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FrontendEndpointUpdateParametersWebApplicationFirewallPolicyLink__added` | added | `{"type":"object","description":"Defines the Web Application Firewall policy for each host (if applic...` |

### Changes for `KeyVaultCertificateSourceParametersVault`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.KeyVaultCertificateSourceParametersVault__added` | added | `{"type":"object","description":"The Key Vault containing the SSL certificate","properties":{"id":{"t...` |

### Changes for `PolicySettingsLogScrubbing`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PolicySettingsLogScrubbing__added` | added | `{"type":"object","description":"Defines rules that scrub sensitive fields in the Web Application Fir...` |

### Changes for `RoutingRuleUpdateParametersWebApplicationFirewallPolicyLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoutingRuleUpdateParametersWebApplicationFirewallPolicyLink__added` | added | `{"type":"object","description":"Defines the Web Application Firewall policy for each routing rule (i...` |

### Changes for `exclusiveMinimum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Backend.properties.httpPort.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.Backend.properties.httpsPort.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.BackendPoolsSettings.properties.sendRecvTimeoutSeconds.exclusiveMinimum__deleted` | deleted | `false` |

### Changes for `exclusiveMaximum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Backend.properties.httpPort.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.Backend.properties.httpsPort.exclusiveMaximum__deleted` | deleted | `false` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Backend.properties.httpPort.format__added` | added | `int32` |
| `definitions.Backend.properties.httpsPort.format__added` | added | `int32` |
| `definitions.Backend.properties.priority.format__added` | added | `int32` |
| `definitions.Backend.properties.weight.format__added` | added | `int32` |
| `definitions.BackendPoolsSettings.properties.sendRecvTimeoutSeconds.format__added` | added | `int32` |
| `definitions.CustomRule.properties.priority.format__added` | added | `int32` |
| `definitions.CustomRule.properties.rateLimitDurationInMinutes.format__added` | added | `int32` |
| `definitions.CustomRule.properties.rateLimitThreshold.format__added` | added | `int32` |
| `definitions.FrontendEndpointUpdateParameters.properties.sessionAffinityTtlSeconds.format__added` | added | `int32` |
| `definitions.HealthProbeSettingsUpdateParameters.properties.intervalInSeconds.format__added` | added | `int32` |
| `definitions.LatencyMetric.properties.aCLower95CI.format__added` | added | `float` |
| `definitions.LatencyMetric.properties.aHUpper95CI.format__added` | added | `float` |
| `definitions.LatencyMetric.properties.aValue.format__added` | added | `float` |
| `definitions.LatencyMetric.properties.bCLower95CI.format__added` | added | `float` |
| `definitions.LatencyMetric.properties.bUpper95CI.format__added` | added | `float` |
| `definitions.LatencyMetric.properties.bValue.format__added` | added | `float` |
| `definitions.LatencyMetric.properties.delta.format__added` | added | `float` |
| `definitions.LatencyMetric.properties.deltaPercent.format__added` | added | `float` |
| `definitions.LoadBalancingSettingsUpdateParameters.properties.additionalLatencyMilliseconds.format__added` | added | `int32` |
| `definitions.LoadBalancingSettingsUpdateParameters.properties.sampleSize.format__added` | added | `int32` |
| `definitions.LoadBalancingSettingsUpdateParameters.properties.successfulSamplesRequired.format__added` | added | `int32` |
| `definitions.PolicySettings.properties.customBlockResponseStatusCode.format__added` | added | `int32` |
| `definitions.RulesEngineRule.properties.priority.format__added` | added | `int32` |
| `definitions.TimeseriesDataPoint.properties.value.format__added` | added | `float` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DefaultErrorResponse.properties.error.type__deleted` | deleted | `object` |
| `definitions.FrontendEndpoint.properties.type__deleted` | deleted | `{"type":"string","description":"Resource type.","readOnly":true}` |
| `definitions.FrontendEndpointUpdateParameters.properties.webApplicationFirewallPolicyLink.type__deleted` | deleted | `object` |
| `definitions.KeyVaultCertificateSourceParameters.properties.vault.type__deleted` | deleted | `object` |
| `definitions.PolicySettings.properties.logScrubbing.type__deleted` | deleted | `object` |
| `definitions.RoutingRuleUpdateParameters.properties.webApplicationFirewallPolicyLink.type__deleted` | deleted | `object` |
| `definitions.RulesEngine.properties.type__deleted` | deleted | `{"type":"string","description":"Resource type.","readOnly":true}` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DefaultErrorResponse.properties.error.properties__deleted` | deleted | `{"code":{"type":"string","description":"Error code.","readOnly":true},"message":{"type":"string","de...` |
| `definitions.FrontendEndpointUpdateParameters.properties.webApplicationFirewallPolicyLink.properties__deleted` | deleted | `{"id":{"type":"string","description":"Resource ID."}}` |
| `definitions.KeyVaultCertificateSourceParameters.properties.vault.properties__deleted` | deleted | `{"id":{"type":"string","description":"Resource ID."}}` |
| `definitions.PolicySettings.properties.logScrubbing.properties__deleted` | deleted | `{"state":{"type":"string","description":"State of the log scrubbing config. Default value is Enabled...` |
| `definitions.RoutingRuleUpdateParameters.properties.webApplicationFirewallPolicyLink.properties__deleted` | deleted | `{"id":{"type":"string","description":"Resource ID."}}` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DefaultErrorResponse.properties.error.$ref__added` | added | `#/definitions/DefaultErrorResponseError` |
| `definitions.FrontendEndpointUpdateParameters.properties.webApplicationFirewallPolicyLink.$ref__added` | added | `#/definitions/FrontendEndpointUpdateParametersWebApplicationFirewallPolicyLink` |
| `definitions.KeyVaultCertificateSourceParameters.properties.vault.$ref__added` | added | `#/definitions/KeyVaultCertificateSourceParametersVault` |
| `definitions.PolicySettings.properties.logScrubbing.$ref__added` | added | `#/definitions/PolicySettingsLogScrubbing` |
| `definitions.RoutingRuleUpdateParameters.properties.webApplicationFirewallPolicyLink.$ref__added` | added | `#/definitions/RoutingRuleUpdateParametersWebApplicationFirewallPolicyLink` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Experiment.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the Experiment","readOnly":true}` |
| `definitions.FrontendEndpoint.properties.name__deleted` | deleted | `{"type":"string","description":"Resource name."}` |
| `definitions.PreconfiguredEndpoint.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the endpoint"}` |
| `definitions.Profile.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the Profile"}` |
| `definitions.RulesEngine.properties.name__deleted` | deleted | `{"type":"string","description":"Resource name.","readOnly":true}` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Experiment.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.FrontDoor.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.Profile.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.WebApplicationFirewallPolicy.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Experiment.properties.location__added` | added | `{"type":"string","description":"Resource location."}` |
| `definitions.FrontDoor.properties.location__added` | added | `{"type":"string","description":"Resource location."}` |
| `definitions.Profile.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.WebApplicationFirewallPolicy.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExperimentList.required__added` | added | `["value"]` |
| `definitions.FrontDoorListResult.required__added` | added | `["value"]` |
| `definitions.FrontendEndpointsListResult.required__added` | added | `["value"]` |
| `definitions.ManagedRuleSetDefinitionList.required__added` | added | `["value"]` |
| `definitions.PreconfiguredEndpointList.required__added` | added | `["value"]` |
| `definitions.ProfileList.required__added` | added | `["value"]` |
| `definitions.RulesEngineListResult.required__added` | added | `["value"]` |
| `definitions.WebApplicationFirewallPolicyList.required__added` | added | `["value"]` |

### Changes for `title`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FrontDoorProperties.properties.rulesEngines.title__added` | added | `A rules engine configuration.` |
| `definitions.ManagedRuleSet.properties.ruleSetAction.title__deleted` | deleted | `ruleSetAction` |
| `definitions.ManagedRuleSet.properties.ruleSetVersion.title__added` | added | `ruleSetAction` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FrontendEndpointLink.readOnly__deleted` | deleted | `true` |
| `definitions.RoutingRuleLink.readOnly__deleted` | deleted | `true` |
| `definitions.SecurityPolicyLink.readOnly__deleted` | deleted | `true` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RulesEngine.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}...` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RulesEngine.properties.id__deleted` | deleted | `{"type":"string","description":"Resource ID.","readOnly":true}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.BackendPool.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.BackendPoolProperties.properties.resourceState.description` | `Resource status.` | `Resource status of the Front Door or Front Door SubResource.` |
| `definitions.BackendPoolUpdateParameters.properties.healthProbeSettings.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.BackendPoolUpdateParameters.properties.loadBalancingSettings.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.Experiment.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ForwardingConfiguration.properties.backendPool.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.FrontDoor.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.FrontDoorProperties.properties.resourceState.description` | `Resource status of the Front Door.` | `Resource status of the Front Door or Front Door SubResource.` |
| `definitions.FrontendEndpoint.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.FrontendEndpointProperties.properties.resourceState.description` | `Resource status.` | `Resource status of the Front Door or Front Door SubResource.` |
| `definitions.HealthProbeSettingsModel.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.HealthProbeSettingsProperties.properties.resourceState.description` | `Resource status.` | `Resource status of the Front Door or Front Door SubResource.` |
| `definitions.HealthProbeSettingsUpdateParameters.properties.protocol.description` | `Protocol scheme to use for this probe` | `Accepted protocol schemes.` |
| `definitions.LatencyScorecard.allOf[0].$ref` | `./network.json#/definitions/Resource` | `#/definitions/Resource` |
| `definitions.LoadBalancingSettingsModel.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.LoadBalancingSettingsProperties.properties.resourceState.description` | `Resource status.` | `Resource status of the Front Door or Front Door SubResource.` |
| `definitions.ManagedRuleSetDefinition.allOf[0].$ref` | `./network.json#/definitions/Resource` | `#/definitions/Resource` |
| `definitions.PreconfiguredEndpoint.allOf[0].$ref` | `./network.json#/definitions/Resource` | `#/definitions/Resource` |
| `definitions.Profile.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ProfileUpdateProperties.properties.enabledState.description` | `The enabled state of the Profile` | `The state of the Experiment` |
| `definitions.RoutingRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.RoutingRuleProperties.properties.resourceState.description` | `Resource status.` | `Resource status of the Front Door or Front Door SubResource.` |
| `definitions.RoutingRuleUpdateParameters.properties.frontendEndpoints.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.RoutingRuleUpdateParameters.properties.rulesEngine.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.RulesEngineProperties.properties.resourceState.description` | `Resource status.` | `Resource status of the Front Door or Front Door SubResource.` |
| `definitions.RulesEngineRule.properties.priority.description` | `A priority assigned to this rule. ` | `A priority assigned to this rule.` |
| `definitions.Timeseries.allOf[0].$ref` | `./network.json#/definitions/Resource` | `#/definitions/Resource` |
| `definitions.WebApplicationFirewallPolicy.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.WebApplicationFirewallScrubbingRules.properties.selectorMatchOperator['x-ms-enum'].name` | ` scrubbingRuleEntryMatchOperator` | `ScrubbingRuleEntryMatchOperator` |
| `definitions.WebApplicationFirewallScrubbingRules.properties.state['x-ms-enum'].name` | ` scrubbingRuleEntryState` | `ScrubbingRuleEntryState` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/frontDoorWebApplicationFirewallPolicies/{policyName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkExperimentProfiles'].get['x-ms-examples']['List NetworkExperiment Profiles in a Resource Group'].$ref` | `./examples/NetworkExperimentListProfiles.json` | `./examples/NetworkExperimentListByResourceGroupProfiles.json` |

