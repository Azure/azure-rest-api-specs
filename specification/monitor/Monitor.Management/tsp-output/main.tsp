import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./AutoscaleSetting.tsp";
import "./AlertRule.tsp";
import "./LogProfile.tsp";
import "./DiagnosticSetting.tsp";
import "./DiagnosticSettingsCategory.tsp";
import "./ActionGroup.tsp";
import "./MetricAlert.tsp";
import "./ScheduledQueryRule.tsp";
import "./VmInsightsOnboardingStatus.tsp";
import "./MonitorPrivateLinkScope.tsp";
import "./MonitorPrivateLinkResource.tsp";
import "./MonitorPrivateEndpointConnection.tsp";
import "./MonitorPrivateLinkScopedResource.tsp";
import "./ActivityLogAlert.tsp";
import "./DataCollectionEndpoint.tsp";
import "./DataCollectionRuleAssociation.tsp";
import "./DataCollectionRule.tsp";
import "./MonitorWorkspaceResource.tsp";
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
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
@doc("Monitor Management Client")
namespace Azure.ResourceManager.Monitor;
