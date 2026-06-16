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
@@clientName(IntegrationFabric, "GrafanaIntegrationFabric", "csharp");
@@clientName(IntegrationFabricProperties,
  "GrafanaIntegrationFabricProperties",
  "csharp"
);
@@clientName(Snapshots, "GrafanaSnapshotsSettings", "csharp");
@@clientName(Snapshots.externalEnabled, "IsExternalEnabled", "csharp");
@@clientName(Security, "GrafanaSecuritySettings", "csharp");
@@clientName(Security.csrfAlwaysCheck, "IsCsrfAlwaysCheckEnabled", "csharp");
@@clientName(UnifiedAlertingScreenshots.captureEnabled,
  "IsCaptureEnabled",
  "csharp"
);
@@clientName(Smtp, "GrafanaSmtpSettings", "csharp");
@@clientName(Smtp.enabled, "IsEnabled", "csharp");
@@clientName(Users, "GrafanaUserSettings", "csharp");
@@clientName(StartTLSPolicy, "GrafanaStartTlsPolicy", "csharp");
@@clientName(StartTLSPolicy.OpportunisticStartTLS,
  "OpportunisticStartTls",
  "csharp"
);
@@clientName(StartTLSPolicy.MandatoryStartTLS, "MandatoryStartTls", "csharp");
@@clientName(StartTLSPolicy.NoStartTLS, "NoStartTls", "csharp");
@@clientName(CreatorCanAdmin, "GrafanaCreatorCanAdmin", "csharp");
@@clientName(Size, "GrafanaSize", "csharp");
@@clientName(PrivateEndpointConnection,
  "GrafanaPrivateEndpointConnection",
  "csharp"
);

@@clientName(DeterministicOutboundIP, "DeterministicOutboundIp", "java");
@@clientName(StartTLSPolicy, "StartTlsPolicy", "java");
@@clientName(ManagedGrafanaProperties.deterministicOutboundIP,
  "deterministicOutboundIp",
  "java"
);
@@clientName(ManagedGrafanaPropertiesUpdateParameters.deterministicOutboundIP,
  "deterministicOutboundIp",
  "java"
);
@@clientName(ManagedPrivateEndpointModelProperties.privateLinkServicePrivateIP,
  "privateLinkServicePrivateIp",
  "java"
);
@@clientName(Smtp.startTLSPolicy, "startTlsPolicy", "java");
@@clientName(Microsoft.Dashboard, "DashboardManagementClient", "javascript");
@@clientName(Microsoft.Dashboard, "DashboardManagementClient", "python");
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Azure.ResourceManager.CommonTypes.PrivateEndpoint.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(GrafanaAvailablePluginListResponse,
  "GrafanaAvailablePluginListResult",
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the base type back to TrackedResource for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ManagedGrafana,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
