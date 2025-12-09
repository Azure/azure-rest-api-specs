import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Dashboard;
using Azure.Core;

@@clientName(ManagedGrafanas.create::parameters.resource,
  "requestBodyParameters"
);
@@clientName(ManagedGrafanas.update::parameters.properties,
  "requestBodyParameters"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnection.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateLinkResource.properties
);

@@clientName(ManagedPrivateEndpointModels.create::parameters.resource,
  "requestBodyParameters"
);
@@clientName(ManagedPrivateEndpointModels.update::parameters.properties,
  "requestBodyParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ManagedPrivateEndpointModel.properties
);

@@clientName(IntegrationFabrics.create::parameters.resource,
  "requestBodyParameters"
);
@@clientName(IntegrationFabrics.update::parameters.properties,
  "requestBodyParameters"
);

@@clientName(ManagedDashboards.create::parameters.resource,
  "requestBodyParameters"
);
@@clientName(ManagedDashboards.update::parameters.properties,
  "requestBodyParameters"
);
@@clientName(PrivateEndpointConnections.approve::parameters.resource, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ManagedDashboard.properties
);
@@alternateType(ManagedPrivateEndpointModelProperties.privateLinkResourceId,
  armResourceIdentifier
);
@@alternateType(ManagedPrivateEndpointModelProperties.privateLinkServiceUrl,
  url
);
@@alternateType(AzureMonitorWorkspaceIntegration.azureMonitorWorkspaceResourceId,
  armResourceIdentifier
);

@@clientLocation(ManagedGrafanas.get, "Grafana", "!csharp");
@@clientLocation(ManagedGrafanas.create, "Grafana", "!csharp");
@@clientLocation(ManagedGrafanas.update, "Grafana", "!csharp");
@@clientLocation(ManagedGrafanas.delete, "Grafana", "!csharp");
@@clientLocation(ManagedGrafanas.listByResourceGroup, "Grafana", "!csharp");
@@clientLocation(ManagedGrafanas.list, "Grafana", "!csharp");
@@clientLocation(ManagedGrafanas.checkEnterpriseDetails, "Grafana", "!csharp");
@@clientLocation(ManagedGrafanas.fetchAvailablePlugins, "Grafana", "!csharp");
@@clientLocation(ManagedGrafanas.refresh, "ManagedPrivateEndpoints", "!csharp");
@@clientLocation(ManagedPrivateEndpointModels.get,
  "ManagedPrivateEndpoints",
  "!csharp"
);
@@clientLocation(ManagedPrivateEndpointModels.create,
  "ManagedPrivateEndpoints",
  "!csharp"
);
@@clientLocation(ManagedPrivateEndpointModels.update,
  "ManagedPrivateEndpoints",
  "!csharp"
);
@@clientLocation(ManagedPrivateEndpointModels.delete,
  "ManagedPrivateEndpoints",
  "!csharp"
);
@@clientLocation(ManagedPrivateEndpointModels.list,
  "ManagedPrivateEndpoints",
  "!csharp"
);
