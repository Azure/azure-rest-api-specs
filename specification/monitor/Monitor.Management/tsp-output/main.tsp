import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./AutoscaleSettingResource.tsp";
import "./AlertRuleResource.tsp";
import "./LogProfileResource.tsp";
import "./DiagnosticSettingsResource.tsp";
import "./DiagnosticSettingsCategoryResource.tsp";
import "./ActionGroupResource.tsp";
import "./MetricAlertResource.tsp";
import "./ScheduledQueryRuleResource.tsp";
import "./VMInsightsOnboardingStatus.tsp";
import "./AzureMonitorPrivateLinkScope.tsp";
import "./PrivateLinkResource.tsp";
import "./PrivateEndpointConnection.tsp";
import "./ScopedResource.tsp";
import "./ActivityLogAlertResource.tsp";
import "./DataCollectionEndpointResource.tsp";
import "./DataCollectionRuleAssociationProxyOnlyResource.tsp";
import "./DataCollectionRuleResource.tsp";
import "./AzureMonitorWorkspaceResource.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "MonitorClient",
})
// FIXME: Common type version v2 is not supportted for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
@doc("Monitor Management Client")
namespace Azure.ResourceManager.Monitor;
