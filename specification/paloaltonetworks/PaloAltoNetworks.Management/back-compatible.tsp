import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
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
<<<<<<< HEAD
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
>>>>>>> upstream/main
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
<<<<<<< HEAD
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
>>>>>>> upstream/main
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
<<<<<<< HEAD
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
>>>>>>> upstream/main
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
<<<<<<< HEAD
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
>>>>>>> upstream/main
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
<<<<<<< HEAD
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
>>>>>>> upstream/main
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
<<<<<<< HEAD
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
>>>>>>> upstream/main
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
<<<<<<< HEAD
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
>>>>>>> upstream/main
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
<<<<<<< HEAD
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
>>>>>>> upstream/main
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
<<<<<<< HEAD
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
>>>>>>> upstream/main
@@flattenProperty(MetricsObjectFirewallResource.properties);

@@clientLocation(FirewallStatusResources.get, "FirewallStatus");
@@clientLocation(FirewallStatusResources.listByFirewalls, "FirewallStatus");
<<<<<<< HEAD
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
>>>>>>> upstream/main
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
<<<<<<< HEAD
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
>>>>>>> upstream/main
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
<<<<<<< HEAD
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
>>>>>>> upstream/main
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
<<<<<<< HEAD
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
>>>>>>> upstream/main
@@flattenProperty(LocalRulesResource.properties);

@@clientLocation(PrefixListResources.get, "PrefixListLocalRulestack");
@@clientLocation(PrefixListResources.createOrUpdate,
  "PrefixListLocalRulestack"
);
@@clientLocation(PrefixListResources.delete, "PrefixListLocalRulestack");
@@clientLocation(PrefixListResources.listByLocalRulestacks,
  "PrefixListLocalRulestack"
);
<<<<<<< HEAD
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
>>>>>>> upstream/main
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

@@clientName(AdvSecurityObjectListResponse, "advSecurityObjectListResponse");
@@clientName(SecurityServicesResponse, "securityServicesResponse");
@@clientName(SecurityServices, "securityServices");
@@clientName(SecurityServicesTypeList, "securityServicesTypeList");
@@clientName(AdvSecurityObjectModel, "advSecurityObjectModel");

@@clientName(AzureResourceManagerManagedIdentityProperties,
  "Azure.ResourceManager.ManagedIdentityProperties",
  "!python"
);
@@clientName(AzureResourceManagerUserAssignedIdentity,
  "Azure.ResourceManager.UserAssignedIdentity",
  "!python"
);

@@visibility(CertificateObjectGlobalRulestackResource.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(CertificateObjectLocalRulestackResource.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(FirewallResource.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(FirewallStatusResource.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(FqdnListGlobalRulestackResource.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(FqdnListLocalRulestackResource.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(GlobalRulestackResource.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(LocalRulesResource.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(LocalRulestackResource.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(MetricsObjectFirewallResource.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(PostRulesResource.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(PreRulesResource.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(PrefixListGlobalRulestackResource.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(PrefixListResource.properties, Lifecycle.Read, Lifecycle.Create);
