import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Hub.tsp";
import "./ProfileResourceFormat.tsp";
import "./InteractionResourceFormat.tsp";
import "./RelationshipResourceFormat.tsp";
import "./RelationshipLinkResourceFormat.tsp";
import "./AuthorizationPolicyResourceFormat.tsp";
import "./ConnectorResourceFormat.tsp";
import "./ConnectorMappingResourceFormat.tsp";
import "./KpiResourceFormat.tsp";
import "./WidgetTypeResourceFormat.tsp";
import "./ViewResourceFormat.tsp";
import "./LinkResourceFormat.tsp";
import "./RoleAssignmentResourceFormat.tsp";
import "./PredictionResourceFormat.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "CustomerInsightsManagementClient",
})
@versioned(Versions)
@doc("The Azure Customer Insights management API provides a RESTful set of web services that interact with Azure Customer Insights service to manage your resources. The API has entities that capture the relationship between an end user and the Azure Customer Insights service.")
namespace Microsoft.CustomerInsights;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2017-04-26 API version.")
  v2017_04_26: "2017-04-26",
}
