import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using PaloAltoNetworks.Cloudngfw;

@@clientLocation(GlobalRulestackResources.get, "GlobalRulestack");
@@clientLocation(GlobalRulestackResources.createOrUpdate, "GlobalRulestack");
@@clientLocation(GlobalRulestackResources.update, "GlobalRulestack");
@@clientLocation(GlobalRulestackResources.delete, "GlobalRulestack");
@@clientLocation(GlobalRulestackResources.list, "GlobalRulestack");
@@clientLocation(GlobalRulestackResources.commit, "GlobalRulestack");
@@clientName(GlobalRulestackResources.commit, "commit");
@@clientLocation(GlobalRulestackResources.getChangeLog, "GlobalRulestack");
@@clientName(GlobalRulestackResources.getChangeLog, "getChangeLog");
@@clientLocation(GlobalRulestackResources.listAdvancedSecurityObjects,
  "GlobalRulestack"
);
@@clientName(GlobalRulestackResources.listAdvancedSecurityObjects,
  "listAdvancedSecurityObjects"
);
@@clientLocation(GlobalRulestackResources.listAppIds, "GlobalRulestack");
@@clientName(GlobalRulestackResources.listAppIds, "listAppIds");
@@clientLocation(GlobalRulestackResources.listCountries, "GlobalRulestack");
@@clientName(GlobalRulestackResources.listCountries, "listCountries");
@@clientLocation(GlobalRulestackResources.listFirewalls, "GlobalRulestack");
@@clientName(GlobalRulestackResources.listFirewalls, "listFirewalls");
@@clientLocation(GlobalRulestackResources.listPredefinedUrlCategories,
  "GlobalRulestack"
);
@@clientName(GlobalRulestackResources.listPredefinedUrlCategories,
  "listPredefinedUrlCategories"
);
@@clientLocation(GlobalRulestackResources.listSecurityServices,
  "GlobalRulestack"
);
@@clientName(GlobalRulestackResources.listSecurityServices,
  "listSecurityServices"
);
@@clientLocation(GlobalRulestackResources.revert, "GlobalRulestack");
@@clientName(GlobalRulestackResources.revert, "revert");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GlobalRulestackResource.properties);

@@clientLocation(CertificateObjectGlobalRulestackResources.get,
  "CertificateObjectGlobalRulestack"
);
@@clientLocation(CertificateObjectGlobalRulestackResources.createOrUpdate,
  "CertificateObjectGlobalRulestack"
);
@@clientLocation(CertificateObjectGlobalRulestackResources.delete,
  "CertificateObjectGlobalRulestack"
);
@@clientLocation(CertificateObjectGlobalRulestackResources.list,
  "CertificateObjectGlobalRulestack"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CertificateObjectGlobalRulestackResource.properties);

@@clientLocation(FqdnListGlobalRulestackResources.get,
  "FqdnListGlobalRulestack"
);
@@clientLocation(FqdnListGlobalRulestackResources.createOrUpdate,
  "FqdnListGlobalRulestack"
);
@@clientLocation(FqdnListGlobalRulestackResources.delete,
  "FqdnListGlobalRulestack"
);
@@clientLocation(FqdnListGlobalRulestackResources.list,
  "FqdnListGlobalRulestack"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FqdnListGlobalRulestackResource.properties);

@@clientLocation(PostRulesResources.get, "PostRules");
@@clientLocation(PostRulesResources.createOrUpdate, "PostRules");
@@clientLocation(PostRulesResources.delete, "PostRules");
@@clientLocation(PostRulesResources.list, "PostRules");
@@clientLocation(PostRulesResources.getCounters, "PostRules");
@@clientName(PostRulesResources.getCounters, "getCounters");
@@clientLocation(PostRulesResources.refreshCounters, "PostRules");
@@clientName(PostRulesResources.refreshCounters, "refreshCounters");
@@clientLocation(PostRulesResources.resetCounters, "PostRules");
@@clientName(PostRulesResources.resetCounters, "resetCounters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PostRulesResource.properties);

@@clientLocation(PrefixListGlobalRulestackResources.get,
  "PrefixListGlobalRulestack"
);
@@clientLocation(PrefixListGlobalRulestackResources.createOrUpdate,
  "PrefixListGlobalRulestack"
);
@@clientLocation(PrefixListGlobalRulestackResources.delete,
  "PrefixListGlobalRulestack"
);
@@clientLocation(PrefixListGlobalRulestackResources.list,
  "PrefixListGlobalRulestack"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrefixListGlobalRulestackResource.properties);

@@clientLocation(PreRulesResources.get, "PreRules");
@@clientLocation(PreRulesResources.createOrUpdate, "PreRules");
@@clientLocation(PreRulesResources.delete, "PreRules");
@@clientLocation(PreRulesResources.list, "PreRules");
@@clientLocation(PreRulesResources.getCounters, "PreRules");
@@clientName(PreRulesResources.getCounters, "getCounters");
@@clientLocation(PreRulesResources.refreshCounters, "PreRules");
@@clientName(PreRulesResources.refreshCounters, "refreshCounters");
@@clientLocation(PreRulesResources.resetCounters, "PreRules");
@@clientName(PreRulesResources.resetCounters, "resetCounters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PreRulesResource.properties);

@@clientLocation(FirewallResources.get, "Firewalls");
@@clientLocation(FirewallResources.createOrUpdate, "Firewalls");
@@clientLocation(FirewallResources.update, "Firewalls");
@@clientLocation(FirewallResources.delete, "Firewalls");
@@clientLocation(FirewallResources.listByResourceGroup, "Firewalls");
@@clientLocation(FirewallResources.listBySubscription, "Firewalls");
@@clientLocation(FirewallResources.getGlobalRulestack, "Firewalls");
@@clientName(FirewallResources.getGlobalRulestack, "getGlobalRulestack");
@@clientLocation(FirewallResources.getLogProfile, "Firewalls");
@@clientName(FirewallResources.getLogProfile, "getLogProfile");
@@clientLocation(FirewallResources.getSupportInfo, "Firewalls");
@@clientName(FirewallResources.getSupportInfo, "getSupportInfo");
@@clientLocation(FirewallResources.saveLogProfile, "Firewalls");
@@clientName(FirewallResources.saveLogProfile, "saveLogProfile");
@@clientName(FirewallResources.saveLogProfile::parameters.body, "logSettings");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FirewallResource.properties);

@@clientLocation(LocalRulestackResources.get, "LocalRulestacks");
@@clientLocation(LocalRulestackResources.createOrUpdate, "LocalRulestacks");
@@clientLocation(LocalRulestackResources.update, "LocalRulestacks");
@@clientLocation(LocalRulestackResources.delete, "LocalRulestacks");
@@clientLocation(LocalRulestackResources.listByResourceGroup,
  "LocalRulestacks"
);
@@clientLocation(LocalRulestackResources.listBySubscription, "LocalRulestacks");
@@clientLocation(LocalRulestackResources.commit, "LocalRulestacks");
@@clientName(LocalRulestackResources.commit, "commit");
@@clientLocation(LocalRulestackResources.getChangeLog, "LocalRulestacks");
@@clientName(LocalRulestackResources.getChangeLog, "getChangeLog");
@@clientLocation(LocalRulestackResources.getSupportInfo, "LocalRulestacks");
@@clientName(LocalRulestackResources.getSupportInfo, "getSupportInfo");
@@clientLocation(LocalRulestackResources.listAdvancedSecurityObjects,
  "LocalRulestacks"
);
@@clientName(LocalRulestackResources.listAdvancedSecurityObjects,
  "listAdvancedSecurityObjects"
);
@@clientLocation(LocalRulestackResources.listAppIds, "LocalRulestacks");
@@clientName(LocalRulestackResources.listAppIds, "listAppIds");
@@clientLocation(LocalRulestackResources.listCountries, "LocalRulestacks");
@@clientName(LocalRulestackResources.listCountries, "listCountries");
@@clientLocation(LocalRulestackResources.listFirewalls, "LocalRulestacks");
@@clientName(LocalRulestackResources.listFirewalls, "listFirewalls");
@@clientLocation(LocalRulestackResources.listPredefinedUrlCategories,
  "LocalRulestacks"
);
@@clientName(LocalRulestackResources.listPredefinedUrlCategories,
  "listPredefinedUrlCategories"
);
@@clientLocation(LocalRulestackResources.listSecurityServices,
  "LocalRulestacks"
);
@@clientName(LocalRulestackResources.listSecurityServices,
  "listSecurityServices"
);
@@clientLocation(LocalRulestackResources.revert, "LocalRulestacks");
@@clientName(LocalRulestackResources.revert, "revert");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LocalRulestackResource.properties);

@@clientLocation(MetricsObjectFirewallResources.get, "MetricsObjectFirewall");
@@clientLocation(MetricsObjectFirewallResources.createOrUpdate,
  "MetricsObjectFirewall"
);
@@clientLocation(MetricsObjectFirewallResources.delete,
  "MetricsObjectFirewall"
);
@@clientLocation(MetricsObjectFirewallResources.listByFirewalls,
  "MetricsObjectFirewall"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MetricsObjectFirewallResource.properties);

@@clientLocation(FirewallStatusResources.get, "FirewallStatus");
@@clientLocation(FirewallStatusResources.listByFirewalls, "FirewallStatus");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FirewallStatusResource.properties);

@@clientLocation(CertificateObjectLocalRulestackResources.get,
  "CertificateObjectLocalRulestack"
);
@@clientLocation(CertificateObjectLocalRulestackResources.createOrUpdate,
  "CertificateObjectLocalRulestack"
);
@@clientLocation(CertificateObjectLocalRulestackResources.delete,
  "CertificateObjectLocalRulestack"
);
@@clientLocation(CertificateObjectLocalRulestackResources.listByLocalRulestacks,
  "CertificateObjectLocalRulestack"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CertificateObjectLocalRulestackResource.properties);

@@clientLocation(FqdnListLocalRulestackResources.get, "FqdnListLocalRulestack");
@@clientLocation(FqdnListLocalRulestackResources.createOrUpdate,
  "FqdnListLocalRulestack"
);
@@clientLocation(FqdnListLocalRulestackResources.delete,
  "FqdnListLocalRulestack"
);
@@clientLocation(FqdnListLocalRulestackResources.listByLocalRulestacks,
  "FqdnListLocalRulestack"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FqdnListLocalRulestackResource.properties);

@@clientLocation(LocalRulesResources.get, "LocalRules");
@@clientLocation(LocalRulesResources.createOrUpdate, "LocalRules");
@@clientLocation(LocalRulesResources.delete, "LocalRules");
@@clientLocation(LocalRulesResources.listByLocalRulestacks, "LocalRules");
@@clientLocation(LocalRulesResources.getCounters, "LocalRules");
@@clientName(LocalRulesResources.getCounters, "getCounters");
@@clientLocation(LocalRulesResources.refreshCounters, "LocalRules");
@@clientName(LocalRulesResources.refreshCounters, "refreshCounters");
@@clientLocation(LocalRulesResources.resetCounters, "LocalRules");
@@clientName(LocalRulesResources.resetCounters, "resetCounters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LocalRulesResource.properties);

@@clientLocation(PrefixListResources.get, "PrefixListLocalRulestack");
@@clientLocation(PrefixListResources.createOrUpdate,
  "PrefixListLocalRulestack"
);
@@clientLocation(PrefixListResources.delete, "PrefixListLocalRulestack");
@@clientLocation(PrefixListResources.listByLocalRulestacks,
  "PrefixListLocalRulestack"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrefixListResource.properties);

@@clientLocation(PaloAltoNetworksCloudngfwOperationsOperationGroup.createProductSerialNumber,
  "PaloAltoNetworksCloudngfwOperations"
);
@@clientName(PaloAltoNetworksCloudngfwOperationsOperationGroup.createProductSerialNumber,
  "createProductSerialNumber"
);
@@clientLocation(PaloAltoNetworksCloudngfwOperationsOperationGroup.listCloudManagerTenants,
  "PaloAltoNetworksCloudngfwOperations"
);
@@clientName(PaloAltoNetworksCloudngfwOperationsOperationGroup.listCloudManagerTenants,
  "listCloudManagerTenants"
);
@@clientLocation(PaloAltoNetworksCloudngfwOperationsOperationGroup.listProductSerialNumberStatus,
  "PaloAltoNetworksCloudngfwOperations"
);
@@clientName(PaloAltoNetworksCloudngfwOperationsOperationGroup.listProductSerialNumberStatus,
  "listProductSerialNumberStatus"
);
@@clientLocation(PaloAltoNetworksCloudngfwOperationsOperationGroup.listSupportInfo,
  "PaloAltoNetworksCloudngfwOperations"
);
@@clientName(PaloAltoNetworksCloudngfwOperationsOperationGroup.listSupportInfo,
  "listSupportInfo"
);
