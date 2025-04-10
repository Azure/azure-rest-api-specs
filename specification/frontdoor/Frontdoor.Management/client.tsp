import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Network;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PolicySettings.logScrubbing);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ManagedRuleSetDefinition.properties);

@@clientName(RouteConfiguration.`@odata.type`, "odataType");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RoutingRule.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LoadBalancingSettingsModel.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HealthProbeSettingsModel.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BackendPool.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CustomHttpsConfiguration.keyVaultCertificateSourceParameters);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CustomHttpsConfiguration.frontDoorCertificateSourceParameters
);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProfileUpdateModel.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PreconfiguredEndpoint.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ExperimentUpdateModel.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LatencyScorecard.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Timeseries.properties);

@@clientName(WebApplicationFirewallPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WebApplicationFirewallPolicies.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WebApplicationFirewallPolicy.properties);

@@clientName(FrontDoors.createOrUpdate::parameters.resource,
  "frontDoorParameters"
);
@@clientName(FrontDoors.validateCustomDomain::parameters.body,
  "customDomainProperties"
);
@@clientName(FrontDoors.purgeContent::parameters.body, "contentFilePaths");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FrontDoor.properties);

@@clientName(RulesEngines.createOrUpdate::parameters.resource,
  "rulesEngineParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RulesEngine.properties);

@@clientName(FrontendEndpoints.enableHttps::parameters.body,
  "customHttpsConfiguration"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FrontendEndpoint.properties);

@@clientName(Profiles.createOrUpdate::parameters.resource, "parameters");
@@clientName(Profiles.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Profile.properties);

@@clientName(Experiments.createOrUpdate::parameters.resource, "parameters");
@@clientName(Experiments.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Experiment.properties);
