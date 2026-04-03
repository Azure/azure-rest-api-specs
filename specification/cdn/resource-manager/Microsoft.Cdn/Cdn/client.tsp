import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Cdn;

@@clientName(CertificateSourceParameters,
  "CertificateSourceParametersBase",
  "go"
);
@@clientName(CdnEndpoint, "LinkedEndpoint", "go");
@@clientName(CdnWebApplicationFirewallPolicy, "CdnWafPolicy", "go");
@@clientName(WebApplicationFirewallPolicy,
  "WebApplicationFirewallPolicy",
  "go"
);
@@clientName(CdnWebApplicationFirewallPolicyProperties,
  "CdnWafPolicyProperties",
  "go"
);
@@clientName(WebApplicationFirewallPolicyProperties,
  "WebApplicationFirewallPolicyProperties",
  "go"
);

@@clientLocation(checkEndpointNameAvailability, "ManagementClient", "go");
@@clientLocation(checkNameAvailability, "ManagementClient", "go");
@@clientLocation(checkNameAvailabilityWithSubscription,
  "ManagementClient",
  "go"
);
@@clientLocation(validateProbe, "ManagementClient", "go");

@@clientName(CdnEndpoint, "EndpointResource", "java");

@@clientName(ValidateProbeInput.probeURL, "probeUrl", "java");

@@access(Certificate, Access.public, "java");
@@usage(Certificate,
  Azure.ClientGenerator.Core.Usage.input | Azure.ClientGenerator.Core.Usage.output,
  "java"
);
@@access(CustomerCertificate, Access.public, "java");
@@usage(CustomerCertificate,
  Azure.ClientGenerator.Core.Usage.input | Azure.ClientGenerator.Core.Usage.output,
  "java"
);
@@access(ManagedCertificate, Access.public, "java");
@@usage(ManagedCertificate,
  Azure.ClientGenerator.Core.Usage.input | Azure.ClientGenerator.Core.Usage.output,
  "java"
);
@@access(AzureFirstPartyManagedCertificate, Access.public, "java");
@@usage(AzureFirstPartyManagedCertificate,
  Azure.ClientGenerator.Core.Usage.input | Azure.ClientGenerator.Core.Usage.output,
  "java"
);

@@alternateType(RequestSchemeMatchConditionParameters.operator,
  "Equal",
  "java"
);

// AfdCustomDomains client for Java
@@clientLocation(AFDDomains.get, "AfdCustomDomains", "java");
@@clientLocation(AFDDomains.create, "AfdCustomDomains", "java");
@@clientLocation(AFDDomains.update, "AfdCustomDomains", "java");
@@clientLocation(AFDDomains.delete, "AfdCustomDomains", "java");
@@clientLocation(AFDDomains.listByProfile, "AfdCustomDomains", "java");
@@clientLocation(AFDDomains.refreshValidationToken, "AfdCustomDomains", "java");

// AfdProfiles client for Java
@@clientLocation(Profiles.checkEndpointNameAvailability, "AfdProfiles", "java");
@@clientLocation(Profiles.listResourceUsage, "AfdProfiles", "java");
@@clientLocation(Profiles.checkHostNameAvailability, "AfdProfiles", "java");
@@clientName(Profiles.checkHostNameAvailability,
  "checkHostnameAvailability",
  "java"
);
@@clientLocation(Profiles.validateSecret, "AfdProfiles", "java");
@@clientLocation(Profiles.upgrade, "AfdProfiles", "java");

@@clientName(AFDDomain, "AfdDomain", "java");
@@clientName(AFDDomainProperties, "AfdDomainProperties", "java");
@@clientName(AFDDomainHttpsCustomizedCipherSuiteSet,
  "AfdDomainHttpsCustomizedCipherSuiteSet",
  "java"
);
@@clientName(AFDDomainHttpsParameters, "AfdDomainHttpsParameters", "java");
@@clientName(AFDDomainMtlsParameters, "AfdDomainMtlsParameters", "java");
@@clientName(AFDDomains, "AfdDomains", "java");
@@clientName(AFDDomainUpdateParameters, "AfdDomainUpdateParameters", "java");
@@clientName(AFDDomainUpdatePropertiesParameters,
  "AfdDomainUpdatePropertiesParameters",
  "java"
);

@@clientName(AFDEndpoint, "AfdEndpoint", "java");
@@clientName(AFDEndpointProperties, "AfdEndpointProperties", "java");
@@clientName(AFDEndpoints, "AfdEndpoints", "java");
@@clientName(AFDEndpointUpdateParameters,
  "AfdEndpointUpdateParameters",
  "java"
);
@@clientName(AFDEndpointPropertiesUpdateParameters,
  "AfdEndpointPropertiesUpdateParameters",
  "java"
);

@@clientName(AFDOrigin, "AfdOrigin", "java");
@@clientName(AFDOriginProperties, "AfdOriginProperties", "java");
@@clientName(AFDOrigins, "AfdOrigins", "java");
@@clientName(AFDOriginUpdatePropertiesParameters,
  "AfdOriginUpdatePropertiesParameters",
  "java"
);
@@clientName(AFDOriginGroupUpdateParameters,
  "AfdOriginGroupUpdateParameters",
  "java"
);
@@clientName(AFDOriginGroupUpdatePropertiesParameters,
  "AfdOriginGroupUpdatePropertiesParameters",
  "java"
);

@@clientName(AFDOriginGroup, "AfdOriginGroup", "java");
@@clientName(AFDOriginGroupProperties, "AfdOriginGroupProperties", "java");
@@clientName(AFDOriginGroups, "AfdOriginGroups", "java");
@@clientName(AFDOriginGroupUpdateParameters,
  "AfdOriginGroupUpdateParameters",
  "java"
);
@@clientName(AFDOriginGroupUpdatePropertiesParameters,
  "AfdOriginGroupUpdatePropertiesParameters",
  "java"
);

@@clientName(CustomDomainProperties.hostName, "hostname", "java");
@@clientName(CustomDomainPropertiesParameters.hostName, "hostname", "java");
@@clientName(DeepCreatedOriginProperties.hostName, "hostname", "java");
@@clientName(DeepCreatedCustomDomainProperties.hostName, "hostname", "java");
@@clientName(OriginUpdatePropertiesParameters.hostName, "hostname", "java");
@@clientName(EndpointProperties.hostName, "hostname", "java");
@@clientName(ValidateCustomDomainInput.hostName, "hostname", "java");

@@clientName(DeliveryRuleHostNameCondition,
  "DeliveryRuleHostnameCondition",
  "java"
);
@@clientName(AFDOriginUpdateParameters, "AfdOriginUpdateParameters", "java");
@@clientName(HostNameMatchConditionParameters,
  "HostnameMatchConditionParameters",
  "java"
);
@@clientName(AFDEndpointProtocols, "AfdEndpointProtocols", "java");
@@clientName(AFDRouteGrpcState, "AfdRouteGrpcState", "java");
@@clientName(DeploymentVersionAFDOriginChange,
  "DeploymentVersionAfdOriginChange",
  "java"
);
@@clientName(DeploymentVersionAFDOriginGroupChange,
  "DeploymentVersionAfdOriginGroupChange",
  "java"
);
@@clientName(CheckHostNameAvailabilityInput,
  "CheckHostnameAvailabilityInput",
  "java"
);
@@clientName(RequestSchemeMatchValue,
  "RequestSchemeMatchConditionParametersMatchValuesItem",
  "java"
);
@@clientName(IsDeviceMatchValue,
  "IsDeviceMatchConditionParametersMatchValuesItem",
  "java"
);
@@clientName(DeliveryRuleActionName, "DeliveryRuleActionValue", "java");
@@clientName(AFDStateProperties, "AfdStateProperties", "java");
@@clientName(HostNameOperator, "HostnameOperator", "java");
@@clientName(RequestMethodMatchValue,
  "RequestMethodMatchConditionParametersMatchValuesItem",
  "java"
);
@@clientName(CheckHostNameAvailabilityInput.hostName, "hostname", "java");
@@clientName(AFDDomainProperties.hostName, "hostname", "java");
@@clientName(AFDEndpointProperties.hostName, "hostname", "java");
@@clientName(AFDOriginUpdatePropertiesParameters.hostName, "hostname", "java");
@@clientName(OriginProperties.hostName, "hostname", "java");
@@clientName(Components1Gs0LlpSchemasMetricsresponsePropertiesSeriesItemsPropertiesDataItems,
  "MetricsResponseSeriesItemData",
  "java"
);
@@clientName(Components18OrqelSchemasWafmetricsresponsePropertiesSeriesItemsPropertiesDataItems,
  "WafMetricsResponseSeriesItemData",
  "java"
);

@@clientName(Microsoft.Cdn, "CdnManagementClient", "javascript");
@@clientName(PolicySettingsDefaultCustomBlockResponseStatusCode.`405`,
  "FourHundredFive",
  "javascript,go"
);
@@clientName(PolicySettingsDefaultCustomBlockResponseStatusCode.`406`,
  "FourHundredSix",
  "javascript,go"
);
@@clientName(PolicySettingsDefaultCustomBlockResponseStatusCode.`403`,
  "FourHundredThree",
  "javascript,go"
);
@@clientName(PolicySettingsDefaultCustomBlockResponseStatusCode.`429`,
  "FourHundredTwentyNine",
  "javascript,go"
);
@@clientName(PolicySettingsDefaultCustomBlockResponseStatusCode.`200`,
  "TwoHundred",
  "javascript,go"
);

// C# SDK customizations: backward-compatible renames, access/usage configurations,
// client name overrides, and type alternates for the CDN management API C# SDK.
@@clientName(ActivatedResourceReference,
  "FrontDoorActivatedResourceInfo",
  "csharp"
);
@@clientName(MatchCondition, "CustomRuleMatchCondition", "csharp");
@@clientName(ResourceUsageUnit, "CdnUsageUnit", "csharp");
@@clientName(PolicySettings, "WafPolicySettings", "csharp");
@@clientName(ManagedRuleSet, "WafPolicyManagedRuleSet", "csharp");
@@clientName(UrlSigningKeyParameters, "UriSigningKeyProperties", "csharp");
@@clientName(EndpointProvisioningState,
  "CdnEndpointProvisioningState",
  "csharp"
);
@@clientName(SocketAddrOperator, "SocketAddressOperator", "csharp");
@@clientName(UrlFileExtensionOperator, "UriFileExtensionOperator", "csharp");
@@clientName(UrlFileNameOperator, "UriFileNameOperator", "csharp");
@@clientName(UrlPathOperator, "UriPathOperator", "csharp");
@@clientName(UpdateRule, "CertificateUpdateAction", "csharp");
@@clientName(DeleteRule, "CertificateDeleteAction", "csharp");
@@clientName(CacheBehavior, "CacheBehaviorSetting", "csharp");
@@clientName(CacheType, "CdnCacheLevel", "csharp");
@@clientName(CertificateType, "CdnManagedCertificateType", "csharp");
@@clientName(Microsoft.Cdn.CdnEndpoint, "CdnEndpointReference", "csharp");
@@clientName(CustomDomain, "CdnCustomDomain", "csharp");
@@clientName(Endpoint, "CdnEndpoint", "csharp");
@@clientName(Origin, "CdnOrigin", "csharp");
@@clientName(OriginGroup, "CdnOriginGroup", "csharp");
@@clientName(ValidateCustomDomainInput,
  "ValidateCustomDomainContent",
  "csharp"
);
@@clientName(ValidateCustomDomainOutput,
  "ValidateCustomDomainResult",
  "csharp"
);
@@clientName(HealthProbeParameters, "HealthProbeSettings", "csharp");
@@clientName(ResponseBasedOriginErrorDetectionParameters,
  "ResponseBasedOriginErrorDetectionSettings",
  "csharp"
);
@@clientName(HttpErrorRangeParameters, "HttpErrorRange", "csharp");
@@clientName(CheckNameAvailabilityInput,
  "CdnNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityOutput,
  "CdnNameAvailabilityResult",
  "csharp"
);
@@clientName(ValidateProbeOutput, "ValidateProbeResult", "csharp");
@@clientName(ResourceUsage, "CdnUsage", "csharp");
@@clientName(CdnManagedHttpsParameters, "CdnManagedHttpsContent", "csharp");
@@clientName(UserManagedHttpsParameters, "UserManagedHttpsContent", "csharp");
@@clientName(LoadBalancingSettingsParameters,
  "LoadBalancingSettings",
  "csharp"
);
@@clientName(CompressionSettings, "RouteCacheCompressionSettings", "csharp");
@@clientName(AfdPurgeParameters, "FrontDoorPurgeContent", "csharp");
@@clientName(AfdRouteCacheConfiguration,
  "FrontDoorRouteCacheConfiguration",
  "csharp"
);
@@clientName(Route, "FrontDoorRoute", "csharp");
@@clientName(RuleSet, "FrontDoorRuleSet", "csharp");
@@clientName(Rule, "FrontDoorRule", "csharp");
@@clientName(SecurityPolicy, "FrontDoorSecurityPolicy", "csharp");
@@clientName(Secret, "FrontDoorSecret", "csharp");
@@clientName(ValidateSecretOutput, "ValidateSecretResult", "csharp");
@@clientName(UsageName, "FrontDoorUsageResourceName", "csharp");
@@clientName(Microsoft.Cdn.Usage, "FrontDoorUsage", "csharp");
@@clientName(AzureFirstPartyManagedCertificateParameters,
  "AzureFirstPartyManagedCertificateProperties",
  "csharp"
);
@@clientName(CheckHostNameAvailabilityInput,
  "HostNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckEndpointNameAvailabilityInput,
  "EndpointNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckEndpointNameAvailabilityOutput,
  "EndpointNameAvailabilityResult",
  "csharp"
);
@@clientName(SecurityPolicyWebApplicationFirewallParameters,
  "SecurityPolicyWebApplicationFirewall",
  "csharp"
);
@@clientName(MatchCondition.operator, "matchOperator", "csharp");
@@clientName(MatchConditionAfd.operator, "matchOperator", "csharp");
@@clientName(CustomerCertificateParameters,
  "CustomerCertificateProperties",
  "csharp"
);
@@clientName(SecretParameters, "FrontDoorSecretProperties", "csharp");
@@clientName(AutoGeneratedDomainNameLabelScope,
  "DomainNameLabelScope",
  "csharp"
);
@@clientName(ManagedCertificateParameters,
  "ManagedCertificateProperties",
  "csharp"
);
@@clientName(SecretProperties, "SecretDetails", "csharp");
@@clientName(SecurityPolicyProperties, "SecurityPolicyDetails", "csharp");
@@clientName(SecurityPolicyPropertiesParameters,
  "SecurityPolicyProperties",
  "csharp"
);
@@clientName(AfdCertificateType, "FrontDoorCertificateType", "csharp");
@@clientName(AfdMinimumTlsVersion, "FrontDoorMinimumTlsVersion", "csharp");
@@clientName(AfdQueryStringCachingBehavior,
  "FrontDoorQueryStringCachingBehavior",
  "csharp"
);
@@clientName(DeploymentStatus, "FrontDoorDeploymentStatus", "csharp");
@@clientName(AfdProvisioningState, "FrontDoorProvisioningState", "csharp");
@@clientName(UsageUnit, "FrontDoorUsageUnit", "csharp");
@@clientName(ProtocolType, "SecureDeliveryProtocolType", "csharp");
@@clientName(ProbeProtocol, "HealthProbeProtocol", "csharp");
@@clientName(CustomHttpsProvisioningSubstate,
  "CustomHttpsAvailabilityState",
  "csharp"
);
@@clientName(MinimumTlsVersion, "CdnMinimumTlsVersion", "csharp");
@@clientName(ResourceType, "CdnResourceType", "csharp");
@@clientName(SslProtocol, "DeliveryRuleSslProtocol", "csharp");
@@clientName(ManagedRuleEnabledState, "ManagedRuleSetupState", "csharp");
@@clientName(ActionType, "OverrideActionType", "csharp");
@@clientName(Transform, "PreTransformCategory", "csharp");
@@clientName(Algorithm, "UriSigningAlgorithm", "csharp");
@@clientName(WafMetricsSeriesUnit,
  "WafMetricsResponseSeriesItemUnit",
  "csharp"
);
@@clientName(WafMetricsGranularity, "WafMetricsResponseGranularity", "csharp");
@@clientName(MetricsSeriesUnit, "MetricsResponseSeriesItemUnit", "csharp");
@@clientName(MetricsGranularity, "MetricsResponseGranularity", "csharp");
@@clientName(ManagedRuleGroupOverride,
  "ManagedRuleGroupOverrideSetting",
  "csharp"
);
@@clientName(ManagedRuleOverride, "ManagedRuleOverrideSetting", "csharp");
@@clientName(DeliveryRuleActionParameters,
  "DeliveryRuleActionProperties",
  "csharp"
);
@@clientName(DeliveryRuleConditionParameters,
  "DeliveryRuleConditionProperties",
  "csharp"
);
@@clientName(CertificateSourceParameters,
  "CertificateSourceProperties",
  "csharp"
);
@@clientName(KeyVaultSigningKeyParameters, "KeyVaultSigningKey", "csharp");
@@clientName(IsDeviceMatchValue, "IsDeviceMatchConditionMatchValue", "csharp");
@@clientName(RequestMethodMatchValue,
  "RequestMethodMatchConditionMatchValue",
  "csharp"
);
@@clientName(RequestSchemeMatchValue,
  "RequestSchemeMatchConditionMatchValue",
  "csharp"
);
@@clientName(UrlSigningKey, "UriSigningKey", "csharp");
@@clientName(EndpointPropertiesUpdateParametersDeliveryPolicy,
  "EndpointDeliveryPolicy",
  "csharp"
);
@@clientName(AFDEndpointProtocols, "FrontDoorEndpointProtocol", "csharp");
@@clientName(CustomDomainHttpsParameters, "CustomDomainHttpsContent", "csharp");
@@clientName(ProvisioningState,
  "WebApplicationFirewallPolicyProvisioningState",
  "csharp"
);
@@clientName(RequestSchemeMatchConditionParametersOperator,
  "RequestSchemeOperator",
  "csharp"
);
@@clientName(ScrubbingRuleEntryMatchOperator.Equals, "EqualsValue", "csharp");
@@clientName(ManagedRuleExclusionSelectorMatchOperator.Equals,
  "EqualsValue",
  "csharp"
);
@@clientName(AFDDomain, "FrontDoorCustomDomain", "csharp");
@@clientName(AFDDomainProperties, "FrontDoorCustomDomainProperties", "csharp");
@@clientName(AFDDomainHttpsParameters,
  "FrontDoorCustomDomainHttpsContent",
  "csharp"
);
@@clientName(AFDDomainUpdateParameters,
  "FrontDoorCustomDomainUpdateParameters",
  "csharp"
);
@@clientName(AFDDomainUpdatePropertiesParameters,
  "FrontDoorCustomDomainUpdatePropertiesParameters",
  "csharp"
);
@@clientName(AFDDomainHttpsCustomizedCipherSuiteSet,
  "FrontDoorCustomDomainHttpsCustomizedCipherSuiteSet",
  "csharp"
);
@@clientName(AFDDomainMtlsParameters,
  "FrontDoorCustomDomainMtlsParameters",
  "csharp"
);
@@clientName(AFDEndpoint, "FrontDoorEndpoint", "csharp");
@@clientName(AFDEndpoints.listResourceUsage, "GetResourceUsages", "csharp");
@@clientName(AFDOriginGroups.listResourceUsage, "GetResourceUsages", "csharp");
@@clientName(AFDEndpointProperties, "FrontDoorEndpointProperties", "csharp");
@@clientName(AFDEndpointUpdateParameters,
  "FrontDoorEndpointUpdateParameters",
  "csharp"
);
@@clientName(AFDEndpointPropertiesUpdateParameters,
  "FrontDoorEndpointPropertiesUpdateParameters",
  "csharp"
);
@@clientName(AFDOrigin, "FrontDoorOrigin", "csharp");
@@clientName(AFDOriginProperties, "FrontDoorOriginProperties", "csharp");
@@clientName(AFDOriginUpdateParameters,
  "FrontDoorOriginUpdateParameters",
  "csharp"
);
@@clientName(AFDOriginUpdatePropertiesParameters,
  "FrontDoorOriginUpdatePropertiesParameters",
  "csharp"
);
@@clientName(AFDOriginGroup, "FrontDoorOriginGroup", "csharp");
@@clientName(AFDOriginGroupProperties,
  "FrontDoorOriginGroupProperties",
  "csharp"
);
@@clientName(AFDOriginGroupUpdateParameters,
  "FrontDoorOriginGroupUpdateParameters",
  "csharp"
);
@@clientName(AFDOriginGroupUpdatePropertiesParameters,
  "FrontDoorOriginGroupUpdatePropertiesParameters",
  "csharp"
);
@@clientName(AFDOriginGroupUpdatePropertiesParameters.trafficRestorationTimeToHealedOrNewEndpointsInMinutes,
  "TrafficRestorationTimeInMinutes",
  "csharp"
);
@@clientName(AFDStateProperties, "FrontDoorStateProperties", "csharp");
@@clientName(AFDRouteGrpcState, "FrontDoorRouteGrpcState", "csharp");
@@clientName(IpAddressGroup, "IPAddressGroup", "csharp");
@@clientName(Status, "ValidationStatus", "csharp");
@@clientName(ValidateSecretInput, "ValidateSecretContent", "csharp");
@@clientName(MigrationParameters, "MigrationContent", "csharp");
@@clientName(CdnMigrationToAfdParameters, "CdnMigrationToAfdContent", "csharp");
@@clientName(EndpointProperties.customDomains,
  "DeepCreatedCustomDomains",
  "csharp"
);
@@clientName(EndpointPropertiesUpdateParameters.urlSigningKeys,
  "UriSigningKeys",
  "csharp"
);
@@access(DeepCreatedCustomDomain, Access.public, "csharp");
@@usage(DeepCreatedCustomDomain,
  Azure.ClientGenerator.Core.Usage.input | Azure.ClientGenerator.Core.Usage.output,
  "csharp"
);
@@access(DeepCreatedCustomDomainProperties, Access.public, "csharp");
@@usage(DeepCreatedCustomDomainProperties,
  Azure.ClientGenerator.Core.Usage.input | Azure.ClientGenerator.Core.Usage.output,
  "csharp"
);
@@clientName(CdnWebApplicationFirewallPolicyProperties.rateLimitRules,
  "RateLimitSettings",
  "csharp"
);
@@clientName(CdnWebApplicationFirewallPolicyProperties.customRules,
  "CustomSettings",
  "csharp"
);
@@clientName(WebApplicationFirewallPolicyProperties.customRules,
  "CustomSettings",
  "csharp"
);
@@clientName(Profiles.profilesListResourceUsage,
  "GetCdnProfileResourceUsages",
  "csharp"
);
@@clientName(CacheExpirationActionParameters,
  "CacheExpirationActionProperties",
  "csharp"
);
@@clientName(CacheKeyQueryStringActionParameters,
  "CacheKeyQueryStringActionProperties",
  "csharp"
);
@@clientName(HeaderActionParameters, "HeaderActionProperties", "csharp");
@@clientName(OriginGroupOverrideActionParameters,
  "OriginGroupOverrideActionProperties",
  "csharp"
);
@@clientName(RouteConfigurationOverrideActionParameters,
  "RouteConfigurationOverrideActionProperties",
  "csharp"
);
@@clientName(UrlRedirectAction, "UriRedirectAction", "csharp");
@@clientName(UrlRewriteAction, "UriRewriteAction", "csharp");
@@clientName(UrlSigningAction, "UriSigningAction", "csharp");
@@clientName(UrlRedirectActionParameters,
  "UriRedirectActionProperties",
  "csharp"
);
@@clientName(UrlRewriteActionParameters,
  "UriRewriteActionProperties",
  "csharp"
);
@@clientName(UrlSigningActionParameters,
  "UriSigningActionProperties",
  "csharp"
);
@@clientName(CanMigrateParameters, "CanMigrateContent", "csharp");
@@clientName(CustomDomainParameters,
  "CdnCustomDomainCreateOrUpdateContent",
  "csharp"
);
@@clientName(LoadParameters, "LoadContent", "csharp");
@@clientName(ProfileUpgradeParameters, "ProfileUpgradeContent", "csharp");
@@clientName(PurgeParameters, "PurgeContent", "csharp");
@@clientName(ValidateProbeInput, "ValidateProbeContent", "csharp");
@@clientName(ClientPortMatchConditionParameters,
  "ClientPortMatchCondition",
  "csharp"
);
@@clientName(CookiesMatchConditionParameters,
  "CookiesMatchCondition",
  "csharp"
);
@@clientName(HostNameMatchConditionParameters,
  "HostNameMatchCondition",
  "csharp"
);
@@clientName(HttpVersionMatchConditionParameters,
  "HttpVersionMatchCondition",
  "csharp"
);
@@clientName(IsDeviceMatchConditionParameters,
  "IsDeviceMatchCondition",
  "csharp"
);
@@clientName(PostArgsMatchConditionParameters,
  "PostArgsMatchCondition",
  "csharp"
);
@@clientName(QueryStringMatchConditionParameters,
  "QueryStringMatchCondition",
  "csharp"
);
@@clientName(RemoteAddressMatchConditionParameters,
  "RemoteAddressMatchCondition",
  "csharp"
);
@@clientName(RequestBodyMatchConditionParameters,
  "RequestBodyMatchCondition",
  "csharp"
);
@@clientName(RequestHeaderMatchConditionParameters,
  "RequestHeaderMatchCondition",
  "csharp"
);
@@clientName(RequestMethodMatchConditionParameters,
  "RequestMethodMatchCondition",
  "csharp"
);
@@clientName(RequestSchemeMatchConditionParameters,
  "RequestSchemeMatchCondition",
  "csharp"
);
@@clientName(RequestUriMatchConditionParameters,
  "RequestUriMatchCondition",
  "csharp"
);
@@clientName(ServerPortMatchConditionParameters,
  "ServerPortMatchCondition",
  "csharp"
);
@@clientName(SslProtocolMatchConditionParameters,
  "DeliveryRuleSslProtocolMatchCondition",
  "csharp"
);
@@clientName(SocketAddrMatchConditionParameters,
  "SocketAddressMatchCondition",
  "csharp"
);
@@clientName(UrlFileExtensionMatchConditionParameters,
  "UriFileExtensionMatchCondition",
  "csharp"
);
@@clientName(UrlFileNameMatchConditionParameters,
  "UriFileNameMatchCondition",
  "csharp"
);
@@clientName(UrlPathMatchConditionParameters,
  "UriPathMatchCondition",
  "csharp"
);
@@clientName(DeliveryRuleSocketAddrCondition,
  "DeliveryRuleSocketAddressCondition",
  "csharp"
);
@@clientName(DeliveryRuleUrlFileExtensionCondition,
  "DeliveryRuleUriFileExtensionCondition",
  "csharp"
);
@@clientName(DeliveryRuleUrlFileNameCondition,
  "DeliveryRuleUriFileNameCondition",
  "csharp"
);
@@clientName(DeliveryRuleUrlPathCondition,
  "DeliveryRuleUriPathCondition",
  "csharp"
);
@@clientName(CidrIpAddress, "CidrIPAddress", "csharp");
@@clientName(GeoFilterActions, "GeoFilterAction", "csharp");
@@clientName(Operator, "MatchOperator", "csharp");
@@clientName(ResponseBasedDetectedErrorTypes,
  "ResponseBasedDetectedErrorType",
  "csharp"
);
@@clientName(CdnCertificateSourceParameters, "CdnCertificateSource", "csharp");
@@clientName(KeyVaultCertificateSourceParameters,
  "KeyVaultCertificateSource",
  "csharp"
);
@@clientName(KeyVaultSigningKeyParametersType,
  "KeyVaultSigningKeyType",
  "csharp"
);
@@clientName(Sku, "CdnSku", "csharp");
@@clientName(UrlSigningParamIdentifier, "UriSigningParamIdentifier", "csharp");
@@clientName(ResourceUsageOperationGroup.list, "GetResourceUsages", "csharp");
@@clientName(ManagedRuleSetsOperationGroup.list,
  "GetManagedRuleSets",
  "csharp"
);
@@access(Sku, Access.public, "csharp");
@@usage(Sku,
  Azure.ClientGenerator.Core.Usage.input | Azure.ClientGenerator.Core.Usage.output,
  "csharp"
);
@@access(ManagedRuleSetDefinition, Access.public, "csharp");
@@usage(ManagedRuleSetDefinition,
  Azure.ClientGenerator.Core.Usage.input | Azure.ClientGenerator.Core.Usage.output,
  "csharp"
);
@@access(ManagedRuleSetDefinitionProperties, Access.public, "csharp");
@@usage(ManagedRuleSetDefinitionProperties,
  Azure.ClientGenerator.Core.Usage.input | Azure.ClientGenerator.Core.Usage.output,
  "csharp"
);
@@access(ManagedRuleGroupDefinition, Access.public, "csharp");
@@usage(ManagedRuleGroupDefinition,
  Azure.ClientGenerator.Core.Usage.input | Azure.ClientGenerator.Core.Usage.output,
  "csharp"
);
@@access(ManagedRuleDefinition, Access.public, "csharp");
@@usage(ManagedRuleDefinition,
  Azure.ClientGenerator.Core.Usage.input | Azure.ClientGenerator.Core.Usage.output,
  "csharp"
);
@@usage(CustomDomain, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@alternateType(ResourceReference.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ProfileProperties.frontDoorId, Azure.Core.uuid, "csharp");
@@alternateType(OriginProperties.privateLinkResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(OriginUpdatePropertiesParameters.privateLinkResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(DeepCreatedOriginProperties.privateLinkResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(EndpointPropertiesUpdateParametersWebApplicationFirewallPolicyLink.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ActivatedResourceReference.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(CdnEndpoint.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(CdnWebApplicationFirewallPolicy.etag,
  Azure.Core.eTag,
  "csharp"
);
@@alternateType(OriginGroupUpdatePropertiesParameters.origins,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(RouteUpdatePropertiesParameters.ruleSets,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(PolicySettings.defaultRedirectUrl, url, "csharp");
@@alternateType(PolicySettings.defaultCustomBlockResponseBody, bytes, "csharp");
@@alternateType(CdnWebApplicationFirewallPolicyProperties.endpointLinks,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);
@@clientName(PolicySettings.defaultRedirectUrl, "DefaultRedirectUri", "csharp");
@@clientName(CdnWebApplicationFirewallPolicyProperties.endpointLinks,
  "EndpointLinks",
  "csharp"
);
@@clientName(CdnEndpoint.id, "Id", "csharp");
@@clientName(ClientPortMatchConditionParameters.operator,
  "ClientPortOperator",
  "csharp"
);
@@clientName(CookiesMatchConditionParameters.operator,
  "CookiesOperator",
  "csharp"
);
@@clientName(HostNameMatchConditionParameters.operator,
  "HostNameOperator",
  "csharp"
);
@@clientName(HttpVersionMatchConditionParameters.operator,
  "HttpVersionOperator",
  "csharp"
);
@@clientName(IsDeviceMatchConditionParameters.operator,
  "IsDeviceOperator",
  "csharp"
);
@@clientName(PostArgsMatchConditionParameters.operator,
  "PostArgsOperator",
  "csharp"
);
@@clientName(QueryStringMatchConditionParameters.operator,
  "QueryStringOperator",
  "csharp"
);
@@clientName(RemoteAddressMatchConditionParameters.operator,
  "RemoteAddressOperator",
  "csharp"
);
@@clientName(RequestBodyMatchConditionParameters.operator,
  "RequestBodyOperator",
  "csharp"
);
@@clientName(RequestHeaderMatchConditionParameters.operator,
  "RequestHeaderOperator",
  "csharp"
);
@@clientName(RequestMethodMatchConditionParameters.operator,
  "RequestMethodOperator",
  "csharp"
);
@@clientName(RequestSchemeMatchConditionParameters.operator,
  "RequestSchemeOperator",
  "csharp"
);
@@clientName(RequestUriMatchConditionParameters.operator,
  "RequestUriOperator",
  "csharp"
);
@@clientName(ServerPortMatchConditionParameters.operator,
  "ServerPortOperator",
  "csharp"
);
@@clientName(SslProtocolMatchConditionParameters.operator,
  "SslProtocolOperator",
  "csharp"
);
@@clientName(SocketAddrMatchConditionParameters.operator,
  "SocketAddressOperator",
  "csharp"
);
@@clientName(UrlFileExtensionMatchConditionParameters.operator,
  "UriFileExtensionOperator",
  "csharp"
);
@@clientName(UrlFileNameMatchConditionParameters.operator,
  "UriFileNameOperator",
  "csharp"
);
@@clientName(UrlPathMatchConditionParameters.operator,
  "UriPathOperator",
  "csharp"
);
@@clientName(AFDDomainProperties.azureDnsZone, "DnsZone", "csharp");
@@clientName(AFDDomainUpdatePropertiesParameters.azureDnsZone,
  "DnsZone",
  "csharp"
);
@@clientName(AFDDomainProperties.preValidatedCustomDomainResourceId,
  "PreValidatedCustomDomainResource",
  "csharp"
);
@@clientName(AFDDomainUpdatePropertiesParameters.preValidatedCustomDomainResourceId,
  "PreValidatedCustomDomainResource",
  "csharp"
);
@@clientName(AFDOriginProperties.azureOrigin, "Origin", "csharp");
@@clientName(AFDOriginUpdatePropertiesParameters.azureOrigin,
  "Origin",
  "csharp"
);
@@clientName(CustomDomainProperties.customHttpsParameters,
  "CustomDomainHttpsContent",
  "csharp"
);
@@clientName(CustomDomainProperties.customHttpsProvisioningSubstate,
  "CustomHttpsAvailabilityState",
  "csharp"
);
@@clientName(SecurityPolicyProperties.parameters,
  "SecurityPolicyParameters",
  "csharp"
);
@@clientName(OriginGroupProperties.responseBasedOriginErrorDetectionSettings,
  "ResponseBasedOriginErrorDetectionSettings",
  "csharp"
);
@@clientName(ResponseBasedOriginErrorDetectionParameters.responseBasedDetectedErrorTypes,
  "ResponseBasedDetectedErrorType",
  "csharp"
);
@@clientName(CheckNameAvailabilityInput.type, "ResourceType", "csharp");
@@clientName(CheckEndpointNameAvailabilityInput.type, "ResourceType", "csharp");
@@clientName(ValidateCustomDomainOutput.customDomainValidated,
  "IsCustomDomainValid",
  "csharp"
);
@@clientName(OriginGroupProperties.trafficRestorationTimeToHealedOrNewEndpointsInMinutes,
  "TrafficRestorationTimeInMinutes",
  "csharp"
);
@@clientName(Endpoints.listResourceUsage, "GetResourceUsages", "csharp");
@@clientName(RuleSets.listResourceUsage, "GetResourceUsages", "csharp");
@@clientName(Profiles.profilesListResourceUsage,
  "GetCdnProfileResourceUsages",
  "csharp"
);

// we add this model in this namespace in order to replace some models with this model via alternateType decorator
namespace Azure.ResourceManager.Models {
  /** represents a reference to an existing resource by its id */
  model WritableSubResource {
    /** the id */
    id?: Azure.Core.armResourceIdentifier;
  }
  /** represents a reference to an existing resource by its id */
  model SubResource {
    /** the id */
    id?: Azure.Core.armResourceIdentifier;
  }
}
