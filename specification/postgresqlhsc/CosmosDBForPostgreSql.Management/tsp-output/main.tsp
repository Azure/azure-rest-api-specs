import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Cluster.tsp";
import "./ClusterServer.tsp";
import "./Configuration.tsp";
import "./ServerConfiguration.tsp";
import "./ServerConfiguration.tsp";
import "./FirewallRule.tsp";
import "./Role.tsp";
import "./PrivateEndpointConnection.tsp";
import "./PrivateLinkResource.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "Cosmos DB for PostgreSQL",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v4)
@doc("Azure Cosmos DB for PostgreSQL database service resource provider REST APIs")
namespace Microsoft.DBforPostgreSQL;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2022-11-08 API version.")
  v2022_11_08: "2022-11-08",
}
