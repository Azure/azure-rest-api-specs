import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using PaloAltoNetworks.Cloudngfw;

@@clientName(PaloAltoNetworks.Cloudngfw,
  "PaloAltoNetworksNgfwMgmtClient",
  "python"
);

// Java
@@clientName(SupportInfo.helpURL, "helpUrl", "java");
@@clientName(SupportInfo.supportURL, "supportUrl", "java");
@@clientName(SupportInfo.registerURL, "registerUrl", "java");
@@clientName(SupportInfoModel.helpURL, "helpUrl", "java");
@@clientName(SupportInfoModel.supportURL, "supportUrl", "java");
@@clientName(SupportInfoModel.registerURL, "registerUrl", "java");

// Model name compatibility fixes for TypeSpec migration
@@clientName(IPAddress, "IpAddress", "java");
@@clientName(IPAddressSpace, "IpAddressSpace", "java");
@@clientName(DNSSettings, "DnsSettings", "java");
@@clientName(DNSProxy, "DnsProxy", "java");
@@clientName(EnabledDNSType, "EnabledDnsType", "java, csharp");

// CSharp
@@clientName(EnabledDNSType.CUSTOM, "Custom", "csharp");
@@clientName(EnabledDNSType.AZURE, "Azure", "csharp");
@@clientName(CertificateObjectGlobalRulestackResource,
  "GlobalRulestackCertificateObject",
  "csharp"
);
@@clientName(CertificateObjectLocalRulestackResource,
  "LocalRulestackCertificateObject",
  "csharp"
);
@@clientName(FirewallResource, "PaloAltoNetworksFirewall", "csharp");
@@clientName(FirewallStatusResource,
  "PaloAltoNetworksFirewallStatus",
  "csharp"
);
@@clientName(FqdnListGlobalRulestackResource, "GlobalRulestackFqdn", "csharp");
@@clientName(FqdnListLocalRulestackResource, "LocalRulestackFqdn", "csharp");
@@clientName(GlobalRulestackResource, "GlobalRulestack", "csharp");
@@clientName(LocalRulesResource, "LocalRulestackRule", "csharp");
@@clientName(LocalRulestackResource, "LocalRulestack", "csharp");
@@clientName(PostRulesResource, "PostRulestackRule", "csharp");
@@clientName(PrefixListGlobalRulestackResource,
  "GlobalRulestackPrefix",
  "csharp"
);
@@clientName(PrefixListResource, "LocalRulestackPrefix", "csharp");
@@clientName(PreRulesResource, "PreRulestackRule", "csharp");
@@clientName(ActionEnum, "RulestackActionType", "csharp");
@@clientName(AdvSecurityObjectListResponse,
  "AdvancedSecurityObjectListResult",
  "csharp"
);
@@clientName(AdvSecurityObjectModel, "AdvancedSecurityObject", "csharp");
@@clientName(AdvSecurityObjectModel.type,
  "AdvSecurityObjectModelType",
  "csharp"
);
@@clientName(AdvSecurityObjectTypeEnum, "AdvancedSecurityObjectType", "csharp");
@@clientName(ApplicationInsights, "FirewallApplicationInsights", "csharp");
@@clientName(AppSeenData, "AppSeenInfoList", "csharp");
@@clientName(BillingCycle, "FirewallBillingCycle", "csharp");
@@clientName(BillingCycle.WEEKLY, "Weekly", "csharp");
@@clientName(BillingCycle.MONTHLY, "Monthly", "csharp");
@@clientName(BooleanEnum, "FirewallBooleanType", "csharp");
@@clientName(BooleanEnum.TRUE, "True", "csharp");
@@clientName(BooleanEnum.FALSE, "False", "csharp");
@@clientName(Category, "EdlMatchCategory", "csharp");
@@clientName(Changelog, "RulestackChangelog", "csharp");
@@clientName(Changelog.lastCommitted, "LastCommittedOn", "csharp");
@@clientName(Changelog.lastModified, "LastModifiedOn", "csharp");
@@clientName(CountriesResponse, "RulestackCountryListResult", "csharp");
@@clientName(Country, "RulestackCountry", "csharp");
@@clientName(DecryptionRuleTypeEnum, "DecryptionRuleType", "csharp");
@@clientName(DecryptionRuleTypeEnum.SSLOutboundInspection,
  "SslOutboundInspection",
  "csharp"
);
@@clientName(DecryptionRuleTypeEnum.SSLInboundInspection,
  "SslInboundInspection",
  "csharp"
);
@@clientName(DefaultMode, "RuleCreationDefaultMode", "csharp");
@@clientName(DefaultMode.NONE, "None", "csharp");
@@clientName(DefaultMode.FIREWALL, "Firewall", "csharp");
@@clientName(DestinationAddr, "DestinationAddressInfo", "csharp");
@@clientName(DNSProxy, "AllowDnsProxyType", "csharp");
@@clientName(DNSProxy.DISABLED, "Disabled", "csharp");
@@clientName(DNSProxy.ENABLED, "Enabled", "csharp");
@@clientName(DNSSettings, "FirewallDnsSettings", "csharp");
@@clientName(EgressNat, "AllowEgressNatType", "csharp");
@@clientName(EgressNat.DISABLED, "Disabled", "csharp");
@@clientName(EgressNat.ENABLED, "Enabled", "csharp");
@@clientName(EndpointConfiguration, "FirewallEndpointConfiguration", "csharp");
@@clientName(EventHub, "EventHubConfiguration", "csharp");
@@alternateType(EventHub.id, Azure.Core.armResourceIdentifier, "csharp");
@@clientName(FirewallResourceUpdateProperties,
  "FirewallUpdateProperties",
  "csharp"
);
@@clientName(FrontendSetting, "FirewallFrontendSetting", "csharp");
@@clientName(GlobalRulestackResourceUpdateProperties,
  "GlobalRulestackUpdateProperties",
  "csharp"
);
@@clientName(HealthStatus, "FirewallHealthStatus", "csharp");
@@clientName(HealthStatus.GREEN, "Green", "csharp");
@@clientName(HealthStatus.YELLOW, "Yellow", "csharp");
@@clientName(HealthStatus.INITIALIZING, "Initializing", "csharp");
@@clientName(HealthStatus.RED, "Red", "csharp");
@@clientName(IPAddress, "IPAddressInfo", "csharp");
@@alternateType(IPAddress.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(IPAddressSpace, "IPAddressSpaceInfo", "csharp");
@@alternateType(IPAddressSpace.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(ListAppIdResponse, "RulestackAppIdListResult", "csharp");
@@clientName(ListFirewallsResponse, "RulestackFirewallListResult", "csharp");
@@clientName(LocalRulestackResourceUpdateProperties,
  "LocalRulestackUpdateProperties",
  "csharp"
);
@@clientName(LogDestination, "FirewallLogDestination", "csharp");
@@clientName(LogDestination.storageConfigurations,
  "StorageConfiguration",
  "csharp"
);
@@clientName(LogDestination.eventHubConfigurations,
  "EventHubConfiguration",
  "csharp"
);
@@clientName(LogDestination.monitorConfigurations,
  "MonitorConfiguration",
  "csharp"
);
@@clientName(LogOption, "FirewallLogOption", "csharp");
@@clientName(LogOption.SAME_DESTINATION, "SameDestination", "csharp");
@@clientName(LogOption.INDIVIDUAL_DESTINATION,
  "IndividualDestination",
  "csharp"
);
@@clientName(LogSettings, "FirewallLogSettings", "csharp");
@@clientName(LogType, "FirewallLogType", "csharp");
@@clientName(LogType.TRAFFIC, "Traffic", "csharp");
@@clientName(LogType.THREAT, "Threat", "csharp");
@@clientName(LogType.DECRYPTION, "Decryption", "csharp");
@@clientName(LogType.WILDFIRE, "Wildfire", "csharp");
@@clientName(LogType.AUDIT, "Audit", "csharp");
@@clientName(LogType.DLP, "Dlp", "csharp");
@@clientName(MarketplaceDetails, "PanFirewallMarketplaceDetails", "csharp");
@@clientName(MonitorLog, "MonitorLogConfiguration", "csharp");
@@alternateType(MonitorLog.id, Azure.Core.armResourceIdentifier, "csharp");
@@clientName(NetworkProfile, "FirewallNetworkProfile", "csharp");
@@clientName(NetworkProfile.publicIps, "PublicIPs", "csharp");
@@clientName(NetworkProfile.egressNatIp, "EgressNatIP", "csharp");
@@clientName(NetworkType, "FirewallNetworkType", "csharp");
@@clientName(NetworkType.VNET, "Vnet", "csharp");
@@clientName(NetworkType.VWAN, "Vwan", "csharp");
@@clientName(PanoramaConfig, "FirewallPanoramaConfiguration", "csharp");
@@clientName(PanoramaStatus, "FirewallPanoramaStatus", "csharp");
@@clientName(PlanData, "FirewallBillingPlanInfo", "csharp");
@@clientName(PredefinedUrlCategoriesResponse,
  "PredefinedUrlCategoryListResult",
  "csharp"
);
@@clientName(ProtocolType, "FirewallProtocolType", "csharp");
@@clientName(ProtocolType.TCP, "Tcp", "csharp");
@@clientName(ProtocolType.UDP, "Udp", "csharp");
@@clientName(ProvisioningState, "FirewallProvisioningState", "csharp");
@@clientName(ReadOnlyProvisioningState,
  "FirewallProvisioningStateType",
  "csharp"
);
@@clientName(RuleCounter, "FirewallRuleCounter", "csharp");
@@clientName(RuleCounter.requestTimestamp, "RequestOn", "csharp");
@@clientName(RuleCounter.timestamp, "ResponseOn", "csharp");
@@clientName(RuleCounter.lastUpdatedTimestamp, "LastUpdatedOn", "csharp");
@@clientName(RuleCounterReset, "FirewallRuleResetConter", "csharp");
@@alternateType(RulestackDetails.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(ScopeType, "RulestackScopeType", "csharp");
@@clientName(ScopeType.LOCAL, "Local", "csharp");
@@clientName(ScopeType.GLOBAL, "Global", "csharp");
@@clientName(SecurityServices, "RulestackSecurityServices", "csharp");
@@clientName(SecurityServicesResponse,
  "RulestackSecurityServiceListResult",
  "csharp"
);
@@clientName(SecurityServicesTypeList,
  "RulestackSecurityServiceTypeList",
  "csharp"
);
@@clientName(SecurityServicesTypeList.type,
  "SecurityServicesTypeListType",
  "csharp"
);
@@clientName(SecurityServicesTypeEnum,
  "RulestackSecurityServiceType",
  "csharp"
);
@@clientName(SecurityServicesTypeEnum.ipsVulnerability,
  "IPsVulnerability",
  "csharp"
);
@@clientName(ServerStatus, "FirewallPanoramaServerStatus", "csharp");
@@clientName(ServerStatus.DOWN, "Down", "csharp");
@@clientName(ServerStatus.UP, "Up", "csharp");
@@clientName(SourceAddr, "SourceAddressInfo", "csharp");
@@clientName(StateEnum, "RulestackStateType", "csharp");
@@clientName(StateEnum.DISABLED, "Disabled", "csharp");
@@clientName(StateEnum.ENABLED, "Enabled", "csharp");
@@clientName(StorageAccount, "StorageAccountConfiguration", "csharp");
@@alternateType(StorageAccount.id, Azure.Core.armResourceIdentifier, "csharp");
@@clientName(SupportInfo, "FirewallSupportInfo", "csharp");
@@clientName(TagInfo, "RulestackTagInfo", "csharp");
@@clientName(UsageType, "FirewallBillingPlanUsageType", "csharp");
@@clientName(UsageType.PAYG, "Payg", "csharp");
@@clientName(UsageType.COMMITTED, "Committed", "csharp");
@@clientName(VnetConfiguration, "FirewallVnetConfiguration", "csharp");
@@clientName(VwanConfiguration, "FirewallVwanConfiguration", "csharp");
@@clientName(VwanConfiguration.vHub, "Vhub", "csharp");
@@clientName(EnableStatus, "FreeTrialEnableStatus", "csharp");
@@clientName(RegistrationStatus, "AccountRegistrationStatus", "csharp");
@@clientName(MetricsObjectFirewallResource, "MetricsObjectFirewall", "csharp");
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(RulestackProperties.panEtag, Azure.Core.eTag, "csharp");
@@alternateType(LocalRulestackResource.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@clientName(RulestackProperties.panEtag, "PanETag", "csharp");
@@alternateType(RulestackProperties.panLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(GlobalRulestackResourceUpdateProperties.panEtag,
  Azure.Core.eTag,
  "csharp"
);
@@clientName(GlobalRulestackResourceUpdateProperties.panEtag,
  "PanETag",
  "csharp"
);
@@alternateType(GlobalRulestackResourceUpdateProperties.panLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(CertificateObject.etag, Azure.Core.eTag, "csharp");
@@alternateType(FqdnObject.etag, Azure.Core.eTag, "csharp");
@@alternateType(RuleEntry.etag, Azure.Core.eTag, "csharp");
@@alternateType(PrefixObject.etag, Azure.Core.eTag, "csharp");
@@alternateType(FirewallResource.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(FirewallDeploymentProperties.panEtag,
  Azure.Core.eTag,
  "csharp"
);
@@clientName(FirewallDeploymentProperties.panEtag, "PanETag", "csharp");
@@alternateType(FirewallResourceUpdateProperties.panEtag,
  Azure.Core.eTag,
  "csharp"
);
@@clientName(FirewallResourceUpdateProperties.panEtag, "PanETag", "csharp");
@@alternateType(MetricsObject.panEtag, Azure.Core.eTag, "csharp");
@@clientName(MetricsObject.panEtag, "PanETag", "csharp");
@@alternateType(LocalRulestackResourceUpdate.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(LocalRulestackResourceUpdateProperties.panEtag,
  Azure.Core.eTag,
  "csharp"
);
@@clientName(LocalRulestackResourceUpdateProperties.panEtag,
  "PanETag",
  "csharp"
);
@@alternateType(LocalRulestackResourceUpdateProperties.panLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(GlobalRulestackResource.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(GlobalRulestackResource.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(GlobalRulestackResourceUpdate.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(GlobalRulestackResourceUpdate.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(RulestackDetails.location, Azure.Core.azureLocation, "csharp");
@@alternateType(FirewallResourceUpdate.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@clientName(VnetConfiguration.ipOfTrustSubnetForUdr,
  "IPOfTrustSubnetForUdr",
  "csharp"
);
@@clientName(VwanConfiguration.ipOfTrustSubnetForUdr,
  "IPOfTrustSubnetForUdr",
  "csharp"
);
// @@usage(FirewallStatusResource, Usage.input, "csharp");
@@clientName(EnabledDNSType, "EnabledDnsType", "java");

// POST nextlink
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "POST nextlink"
@@Legacy.nextLinkVerb(LocalRulestackResources.listAppIds, "POST");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "POST nextlink"
@@Legacy.nextLinkVerb(LocalRulestackResources.listCountries, "POST");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "POST nextlink"
@@Legacy.nextLinkVerb(LocalRulestackResources.listPredefinedUrlCategories,
  "POST"
);
