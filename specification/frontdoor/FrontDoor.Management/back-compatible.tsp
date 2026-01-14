import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PolicySettings.logScrubbing);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedRuleSetDefinition.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RoutingRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LoadBalancingSettingsModel.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(HealthProbeSettingsModel.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(BackendPool.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CustomHttpsConfiguration.keyVaultCertificateSourceParameters
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CustomHttpsConfiguration.frontDoorCertificateSourceParameters
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ProfileUpdateModel.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PreconfiguredEndpoint.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExperimentUpdateModel.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LatencyScorecard.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Timeseries.properties);

@@clientLocation(WebApplicationFirewallPolicies.get, "Policies");
@@clientLocation(WebApplicationFirewallPolicies.createOrUpdate, "Policies");
@@clientName(WebApplicationFirewallPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(WebApplicationFirewallPolicies.update, "Policies");
@@clientName(WebApplicationFirewallPolicies.update::parameters.properties,
  "parameters"
);
@@clientLocation(WebApplicationFirewallPolicies.delete, "Policies");
@@clientLocation(WebApplicationFirewallPolicies.list, "Policies");
@@clientLocation(WebApplicationFirewallPolicies.listBySubscription, "Policies");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(WebApplicationFirewallPolicy.properties);

@@clientName(FrontDoors.createOrUpdate::parameters.resource,
  "frontDoorParameters"
);
@@clientName(FrontDoors.validateCustomDomain::parameters.body,
  "customDomainProperties"
);
@@clientLocation(FrontDoors.purgeContent, "Endpoints");
@@clientName(FrontDoors.purgeContent::parameters.body, "contentFilePaths");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FrontDoor.properties);

@@clientName(RulesEngines.createOrUpdate::parameters.resource,
  "rulesEngineParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RulesEngine.properties);

@@clientName(FrontendEndpoints.enableHttps::parameters.body,
  "customHttpsConfiguration"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FrontendEndpoint.properties);

@@clientLocation(Profiles.get, "NetworkExperimentProfiles");
@@clientLocation(Profiles.createOrUpdate, "NetworkExperimentProfiles");
@@clientName(Profiles.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Profiles.update, "NetworkExperimentProfiles");
@@clientName(Profiles.update::parameters.properties, "parameters");
@@clientLocation(Profiles.delete, "NetworkExperimentProfiles");
@@clientLocation(Profiles.listByResourceGroup, "NetworkExperimentProfiles");
@@clientLocation(Profiles.list, "NetworkExperimentProfiles");
@@clientLocation(Profiles.preconfiguredEndpointsList, "PreconfiguredEndpoints");
@@clientName(Profiles.preconfiguredEndpointsList, "List");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Profile.properties);

@@clientName(Experiments.createOrUpdate::parameters.resource, "parameters");
@@clientName(Experiments.update::parameters.properties, "parameters");
@@clientLocation(Experiments.getLatencyScorecards, "Reports");
@@clientLocation(Experiments.getTimeseries, "Reports");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Experiment.properties);

@@clientLocation(ManagedRuleSetsOperationGroup.list, "ManagedRuleSets");

@@clientLocation(FrontDoorNameAvailabilityOperationGroup.check,
  "FrontDoorNameAvailability"
);

@@clientLocation(FrontDoorNameAvailabilityWithSubscriptionOperationGroup.check,
  "FrontDoorNameAvailabilityWithSubscription"
);
