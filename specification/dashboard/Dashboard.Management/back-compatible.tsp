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

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateEndpointConnection.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(ManagedPrivateEndpointModels.create::parameters.resource,
  "requestBodyParameters"
);
@@clientName(ManagedPrivateEndpointModels.update::parameters.properties,
  "requestBodyParameters"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ManagedPrivateEndpointModel.properties);

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
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ManagedDashboard.properties);
@@alternateType(ManagedPrivateEndpointModelProperties.privateLinkResourceId,
  armResourceIdentifier
);
@@alternateType(ManagedPrivateEndpointModelProperties.privateLinkServiceUrl,
  url
);
@@alternateType(AzureMonitorWorkspaceIntegration.azureMonitorWorkspaceResourceId,
  armResourceIdentifier
);

@@clientLocation(ManagedGrafanas.get, "Grafana");
@@clientLocation(ManagedGrafanas.create, "Grafana");
@@clientLocation(ManagedGrafanas.update, "Grafana");
@@clientLocation(ManagedGrafanas.delete, "Grafana");
@@clientLocation(ManagedGrafanas.listByResourceGroup, "Grafana");
@@clientLocation(ManagedGrafanas.list, "Grafana");
@@clientLocation(ManagedGrafanas.checkEnterpriseDetails, "Grafana");
@@clientLocation(ManagedGrafanas.fetchAvailablePlugins, "Grafana");
@@clientLocation(ManagedGrafanas.refresh, "ManagedPrivateEndpoints");
@@clientLocation(ManagedPrivateEndpointModels.get, "ManagedPrivateEndpoints");
@@clientLocation(ManagedPrivateEndpointModels.create,
  "ManagedPrivateEndpoints"
);
@@clientLocation(ManagedPrivateEndpointModels.update,
  "ManagedPrivateEndpoints"
);
@@clientLocation(ManagedPrivateEndpointModels.delete,
  "ManagedPrivateEndpoints"
);
@@clientLocation(ManagedPrivateEndpointModels.list, "ManagedPrivateEndpoints");
