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

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(ManagedPrivateEndpointModels.create::parameters.resource,
  "requestBodyParameters"
);
@@clientName(ManagedPrivateEndpointModels.update::parameters.properties,
  "requestBodyParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ManagedDashboard.properties);
@@clientName(ManagedGrafanaPropertiesUpdateParameters,
  "ManagedGrafanaPatchProperties",
  "csharp"
);
@@alternateType(ManagedPrivateEndpointModelProperties.privateLinkResourceId,
  armResourceIdentifier
);
@@alternateType(ManagedPrivateEndpointModelProperties.privateLinkServiceUrl,
  url
);

@@clientName(ProvisioningState, "GrafanaProvisioningState", "csharp");
@@clientName(PublicNetworkAccess, "GrafanaPublicNetworkAccess", "csharp");
@@clientName(ZoneRedundancy, "GrafanaZoneRedundancy", "csharp");
@@clientName(ApiKey, "GrafanaApiKey", "csharp");
@@clientName(GrafanaIntegrations.azureMonitorWorkspaceIntegrations,
  "MonitorWorkspaceIntegrations",
  "csharp"
);
@@clientName(AzureMonitorWorkspaceIntegration,
  "MonitorWorkspaceIntegration",
  "csharp"
);
@@clientName(AzureMonitorWorkspaceIntegration.azureMonitorWorkspaceResourceId,
  "MonitorWorkspaceResourceId",
  "csharp"
);
@@alternateType(AzureMonitorWorkspaceIntegration.azureMonitorWorkspaceResourceId,
  armResourceIdentifier
);
@@clientName(PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@clientName(ManagedGrafanas.refresh,
  "RefreshManagedPrivateEndpoint",
  "csharp"
);
@@clientName(PrivateLinkResource, "GrafanaPrivateLinkResource", "csharp");
@@clientName(ResourceSku, "ManagedGrafanaSku", "csharp");
