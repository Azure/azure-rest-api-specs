import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Cdn;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AFDDomainUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AFDEndpointUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AFDOriginGroupUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AFDOriginUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RouteUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RuleUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SecurityPolicyUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProfileUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CanMigrateResult.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MigrateResult.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DeepCreatedOrigin.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DeepCreatedOriginGroup.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DeepCreatedCustomDomain.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EndpointUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OriginUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OriginGroupUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CustomDomainParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Operation.properties);
@@clientName(Operation.properties, "operationProperties");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EdgeNode.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ManagedRuleSetDefinition.properties);

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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Profile.properties);

@@clientName(AFDDomains.create::parameters.resource, "customDomain");
@@clientName(AFDDomains.update::parameters.properties,
  "customDomainUpdateProperties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AFDDomain.properties);

@@clientName(AFDEndpoints.create::parameters.resource, "endpoint");
@@clientName(AFDEndpoints.update::parameters.properties,
  "endpointUpdateProperties"
);
@@clientName(AFDEndpoints.purgeContent::parameters.body, "contents");
@@clientName(AFDEndpoints.validateCustomDomain::parameters.body,
  "customDomainProperties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AFDEndpoint.properties);

@@clientName(AFDOriginGroups.create::parameters.resource, "originGroup");
@@clientName(AFDOriginGroups.update::parameters.properties,
  "originGroupUpdateProperties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AFDOriginGroup.properties);

@@clientName(AFDOrigins.create::parameters.resource, "origin");
@@clientName(AFDOrigins.update::parameters.properties,
  "originUpdateProperties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AFDOrigin.properties);

@@clientName(Routes.create::parameters.resource, "route");
@@clientName(Routes.update::parameters.properties, "routeUpdateProperties");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Route.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RuleSet.properties);

@@clientName(Rules.create::parameters.resource, "rule");
@@clientName(Rules.update::parameters.properties, "ruleUpdateProperties");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Rule.properties);

@@clientName(SecurityPolicies.create::parameters.resource, "securityPolicy");
@@clientName(SecurityPolicies.patch::parameters.properties,
  "securityPolicyUpdateProperties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SecurityPolicy.properties);

@@clientName(Secrets.create::parameters.resource, "secret");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Secret.properties);

@@clientName(Endpoints.create::parameters.resource, "endpoint");
@@clientName(Endpoints.update::parameters.properties,
  "endpointUpdateProperties"
);
@@clientName(Endpoints.purgeContent::parameters.body, "contentFilePaths");
@@clientName(Endpoints.loadContent::parameters.body, "contentFilePaths");
@@clientName(Endpoints.validateCustomDomain::parameters.body,
  "customDomainProperties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Endpoint.properties);

@@clientName(Origins.create::parameters.resource, "origin");
@@clientName(Origins.update::parameters.properties, "originUpdateProperties");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Origin.properties);

@@clientName(OriginGroups.create::parameters.resource, "originGroup");
@@clientName(OriginGroups.update::parameters.properties,
  "originGroupUpdateProperties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OriginGroup.properties);

@@clientName(CustomDomains.create::parameters.resource,
  "customDomainProperties"
);
@@clientName(CustomDomains.enableCustomHttps::parameters.body,
  "customDomainHttpsParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CustomDomain.properties);

@@clientName(CdnWebApplicationFirewallPolicies.createOrUpdate::parameters.resource,
  "cdnWebApplicationFirewallPolicy"
);
@@clientName(CdnWebApplicationFirewallPolicies.update::parameters.properties,
  "cdnWebApplicationFirewallPolicyPatchParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CdnWebApplicationFirewallPolicy.properties);
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
