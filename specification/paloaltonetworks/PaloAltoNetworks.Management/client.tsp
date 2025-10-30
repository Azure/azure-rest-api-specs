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
@@clientName(EnabledDNSType, "EnabledDnsType", "java");

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
@@clientName(AdvSecurityObjectTypeEnum, "AdvancedSecurityObjectType", "csharp");
@@clientName(ApplicationInsights, "FirewallApplicationInsights", "csharp");
@@clientName(AppSeenData, "AppSeenInfoList", "csharp");
@@clientName(BillingCycle, "FirewallBillingCycle", "csharp");
@@clientName(BooleanEnum, "FirewallBooleanType", "csharp");
@@clientName(Category, "EdlMatchCategory", "csharp");
@@clientName(Changelog, "RulestackChangelog", "csharp");
@@clientName(Changelog.lastCommitted, "LastCommittedOn", "csharp");
@@clientName(Changelog.lastModified, "LastModifiedOn", "csharp");
@@clientName(CountriesResponse, "RulestackCountryListResult", "csharp");
@@clientName(Country, "RulestackCountry", "csharp");
@@clientName(DecryptionRuleTypeEnum, "DecryptionRuleType", "csharp");
@@clientName(DefaultMode, "RuleCreationDefaultMode", "csharp");
@@clientName(DestinationAddr, "DestinationAddressInfo", "csharp");
@@clientName(DNSProxy, "AllowDnsProxyType", "csharp");
@@clientName(DNSSettings, "FirewallDnsSettings", "csharp");
@@clientName(EgressNat, "AllowEgressNatType", "csharp");
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
@@clientName(LogSettings, "FirewallLogSettings", "csharp");
@@clientName(LogType, "FirewallLogType", "csharp");
@@clientName(LogType.DLP, "Dlp", "csharp");
@@clientName(MarketplaceDetails, "PanFirewallMarketplaceDetails", "csharp");
@@clientName(MonitorLog, "MonitorLogConfiguration", "csharp");
@@alternateType(MonitorLog.id, Azure.Core.armResourceIdentifier, "csharp");
@@clientName(NetworkProfile, "FirewallNetworkProfile", "csharp");
@@clientName(NetworkType, "FirewallNetworkType", "csharp");
@@clientName(PanoramaConfig, "FirewallPanoramaConfiguration", "csharp");
@@clientName(PanoramaStatus, "FirewallPanoramaStatus", "csharp");
@@clientName(PlanData, "FirewallBillingPlanInfo", "csharp");
@@clientName(PredefinedUrlCategoriesResponse,
  "PredefinedUrlCategoryListResult",
  "csharp"
);
@@clientName(ProtocolType, "FirewallProtocolType", "csharp");
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
@@clientName(SecurityServices, "RulestackSecurityServices", "csharp");
@@clientName(SecurityServicesResponse,
  "RulestackSecurityServiceListResult",
  "csharp"
);
@@clientName(SecurityServicesTypeList,
  "RulestackSecurityServiceTypeList",
  "csharp"
);
@@clientName(SecurityServicesTypeEnum,
  "RulestackSecurityServiceType",
  "csharp"
);
@@clientName(ServerStatus, "FirewallPanoramaServerStatus", "csharp");
@@clientName(ServerStatus.UP, "Up", "csharp");
@@clientName(SourceAddr, "SourceAddressInfo", "csharp");
@@clientName(StateEnum, "RulestackStateType", "csharp");
@@clientName(StorageAccount, "StorageAccountConfiguration", "csharp");
@@alternateType(StorageAccount.id, Azure.Core.armResourceIdentifier, "csharp");
@@clientName(SupportInfo, "FirewallSupportInfo", "csharp");
@@clientName(TagInfo, "RulestackTagInfo", "csharp");
@@clientName(UsageType, "FirewallBillingPlanUsageType", "csharp");
@@clientName(VnetConfiguration, "FirewallVnetConfiguration", "csharp");
@@clientName(VwanConfiguration, "FirewallVwanConfiguration", "csharp");
@@clientName(VwanConfiguration.vHub, "Vhub", "csharp");
@@clientName(EnableStatus, "FreeTrialEnableStatus", "csharp");
@@clientName(RegistrationStatus, "AccountRegistrationStatus", "csharp");
@@clientName(MetricsObjectFirewallResource, "MetricsObjectFirewall", "csharp");
