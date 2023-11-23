import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./AlertRule.tsp";
import "./ActionResponse.tsp";
import "./AlertRuleTemplate.tsp";
import "./AutomationRule.tsp";
import "./Incident.tsp";
import "./Bookmark.tsp";
import "./BookmarkRelation.tsp";
import "./EntityRelation.tsp";
import "./IncidentRelation.tsp";
import "./Entity.tsp";
import "./EntityQuery.tsp";
import "./EntityQueryTemplate.tsp";
import "./FileImport.tsp";
import "./IncidentComment.tsp";
import "./IncidentTask.tsp";
import "./MetadataModel.tsp";
import "./OfficeConsent.tsp";
import "./SentinelOnboardingState.tsp";
import "./SecurityMLAnalyticsSetting.tsp";
import "./Setting.tsp";
import "./SourceControl.tsp";
import "./ThreatIntelligenceInformation.tsp";
import "./Watchlist.tsp";
import "./WatchlistItem.tsp";
import "./DataConnector.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "Security Insights",
})
@versioned(Versions)
@doc("API spec for Microsoft.SecurityInsights (Azure Security Insights) resource provider")
namespace Microsoft.SecurityInsights;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_12_01_preview: "2022-12-01-preview",
}
