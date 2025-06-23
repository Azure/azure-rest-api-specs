import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Dashboard;

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
@@clientName(ManagedGrafanaPropertiesUpdateParameters,
  "ManagedGrafanaPatchProperties",
  "csharp"
);
