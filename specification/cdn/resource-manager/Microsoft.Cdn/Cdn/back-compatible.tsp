import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.Cdn;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AFDDomainUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AFDEndpointUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AFDOriginGroupUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AFDOriginUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(RouteUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(RuleUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SecurityPolicyUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DeploymentVersionUpdate.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ProfileUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(CanMigrateResult.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(MigrateResult.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DeepCreatedOrigin.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DeepCreatedOriginGroup.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DeepCreatedCustomDomain.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(EndpointUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(OriginUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(OriginGroupUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(CustomDomainParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Operation.properties);
@@clientName(Operation.properties, "operationProperties");

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(EdgeNode.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ProfileAgentUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ManagedRuleSetDefinition.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WebAgentUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(KnowledgeSourceUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WebApplicationFirewallPolicy.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PolicySettingsAfd.logScrubbing);

@@clientName(Profiles.create::parameters.resource, "profile");
@@clientName(Profiles.update::parameters.properties, "profileUpdateParameters");
@@clientName(Profiles.checkEndpointNameAvailability::parameters.body,
  "checkEndpointNameAvailabilityInput"
);
@@clientName(Profiles.checkHostNameAvailability::parameters.body,
  "checkHostNameAvailabilityInput"
);
@@clientName(Profiles.validateSecret::parameters.body, "validateSecretInput");
@@clientName(Profiles.upgrade::parameters.body, "profileUpgradeParameters");
@@clientName(Profiles.cdnMigrateToAfd::parameters.body, "migrationParameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Profile.properties);

@@clientName(AFDDomains.create::parameters.resource, "customDomain");
@@clientName(AFDDomains.update::parameters.properties,
  "customDomainUpdateProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AFDDomain.properties);

@@clientName(AFDEndpoints.create::parameters.resource, "endpoint", "!csharp");
@@clientName(AFDEndpoints.update::parameters.properties,
  "endpointUpdateProperties"
);
@@clientName(AFDEndpoints.purgeContent::parameters.body, "contents");
@@clientName(AFDEndpoints.validateCustomDomain::parameters.body,
  "customDomainProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AFDEndpoint.properties);

@@clientName(AFDOriginGroups.create::parameters.resource, "originGroup");
@@clientName(AFDOriginGroups.update::parameters.properties,
  "originGroupUpdateProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AFDOriginGroup.properties);

@@clientName(AFDOrigins.create::parameters.resource, "origin");
@@clientName(AFDOrigins.update::parameters.properties,
  "originUpdateProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AFDOrigin.properties);

@@clientName(Routes.create::parameters.resource, "route");
@@clientName(Routes.update::parameters.properties, "routeUpdateProperties");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Route.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(RuleSet.properties);

@@clientName(Rules.create::parameters.resource, "rule");
@@clientName(Rules.update::parameters.properties, "ruleUpdateProperties");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Rule.properties);

@@clientName(SecurityPolicies.create::parameters.resource, "securityPolicy");
@@clientName(SecurityPolicies.patch::parameters.properties,
  "securityPolicyUpdateProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SecurityPolicy.properties);

@@clientName(Secrets.create::parameters.resource, "secret");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Secret.properties);

@@clientName(KeyGroups.createUpdate::parameters.resource, "keyGroup");
@@clientName(KeyGroups.update::parameters.properties,
  "keyGroupUpdateProperties"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(KeyGroup.properties);

@@clientName(DeploymentVersions.update::parameters.properties,
  "deploymentVersionUpdateProperties"
);
@@clientName(DeploymentVersions.compare::parameters.body,
  "compareDeploymentVersionsParameter"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DeploymentVersion.properties);

@@clientName(Endpoints.create::parameters.resource, "endpoint", "!csharp");
@@clientName(Endpoints.update::parameters.properties,
  "endpointUpdateProperties"
);
@@clientName(Endpoints.purgeContent::parameters.body, "contentFilePaths");
@@clientName(Endpoints.loadContent::parameters.body, "contentFilePaths");
@@clientName(Endpoints.validateCustomDomain::parameters.body,
  "customDomainProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Endpoint.properties);

@@clientName(Origins.create::parameters.resource, "origin");
@@clientName(Origins.update::parameters.properties, "originUpdateProperties");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Origin.properties);

@@clientName(OriginGroups.create::parameters.resource, "originGroup");
@@clientName(OriginGroups.update::parameters.properties,
  "originGroupUpdateProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(OriginGroup.properties);

@@clientName(CustomDomains.create::parameters.resource,
  "customDomainProperties"
);
@@clientName(CustomDomains.enableCustomHttps::parameters.body,
  "customDomainHttpsParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(CustomDomain.properties);

@@clientName(ProfileAgents.createOrUpdate::parameters.resource, "profileAgent");
@@clientName(ProfileAgents.update::parameters.properties,
  "profileAgentUpdateParameters"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ProfileAgent.properties);

@@clientName(CdnWebApplicationFirewallPolicies.createOrUpdate::parameters.resource,
  "cdnWebApplicationFirewallPolicy"
);
@@clientName(CdnWebApplicationFirewallPolicies.update::parameters.properties,
  "cdnWebApplicationFirewallPolicyPatchParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(CdnWebApplicationFirewallPolicy.properties);

@@clientName(WebAgents.createOrUpdate::parameters.resource, "webAgent");
@@clientName(WebAgents.update::parameters.properties,
  "webAgentUpdateParameters"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WebAgent.properties);

@@clientName(KnowledgeSources.createOrUpdate::parameters.resource,
  "knowledgeSource"
);
@@clientName(KnowledgeSources.update::parameters.properties,
  "knowledgeSourceUpdateParameters"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(KnowledgeSource.properties);

@@clientName(checkNameAvailability::parameters.body,
  "checkNameAvailabilityInput"
);
@@clientName(checkNameAvailabilityWithSubscription::parameters.body,
  "checkNameAvailabilityInput"
);
@@clientName(validateProbe::parameters.body, "validateProbeInput");
@@maxLength(Profile.name, 260);
@@minLength(Profile.name, 1);
@@clientName(CidrIpAddress, "cidrIpAddress");
@@clientName(PolicySettings, "policySettings");

@@clientLocation(Profiles.checkEndpointNameAvailability, "AFDProfiles");
@@clientLocation(Profiles.listResourceUsage, "AFDProfiles");
@@clientLocation(Profiles.checkHostNameAvailability, "AFDProfiles");
@@clientLocation(Profiles.validateSecret, "AFDProfiles");
@@clientLocation(Profiles.upgrade, "AFDProfiles");
@@clientLocation(Profiles.getLogAnalyticsMetrics, "LogAnalytics");
@@clientLocation(Profiles.getLogAnalyticsRankings, "LogAnalytics");
@@clientLocation(Profiles.getLogAnalyticsLocations, "LogAnalytics");
@@clientLocation(Profiles.getLogAnalyticsResources, "LogAnalytics");
@@clientLocation(Profiles.getWafLogAnalyticsMetrics, "LogAnalytics");
@@clientLocation(Profiles.getWafLogAnalyticsRankings, "LogAnalytics");
@@clientName(Profiles.profilesListResourceUsage, "ListResourceUsage");
@@clientLocation(AFDDomains.get, "AFDCustomDomains");
@@clientLocation(AFDDomains.create, "AFDCustomDomains");
@@clientLocation(AFDDomains.update, "AFDCustomDomains");
@@clientLocation(AFDDomains.delete, "AFDCustomDomains");
@@clientLocation(AFDDomains.listByProfile, "AFDCustomDomains");
@@clientLocation(AFDDomains.refreshValidationToken, "AFDCustomDomains");
@@clientLocation(CdnWebApplicationFirewallPolicies.get, "Policies");
@@clientLocation(CdnWebApplicationFirewallPolicies.createOrUpdate, "Policies");
@@clientLocation(CdnWebApplicationFirewallPolicies.update, "Policies");
@@clientLocation(CdnWebApplicationFirewallPolicies.delete, "Policies");
@@clientLocation(CdnWebApplicationFirewallPolicies.list, "Policies");
@@clientLocation(ProfilesOperationGroup.canMigrate, Profiles);
@@clientLocation(ProfilesOperationGroup.migrate, Profiles);
@@clientLocation(ResourceUsageOperationGroup.list, "ResourceUsage");
@@clientLocation(EdgeNodesOperationGroup.list, "EdgeNodes");
@@clientLocation(ManagedRuleSetsOperationGroup.list, "ManagedRuleSets");
