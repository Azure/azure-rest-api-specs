import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./CosmosDBForPostgreSqlCluster.tsp";
import "./CosmosDBForPostgreSqlClusterServer.tsp";
import "./CosmosDBForPostgreSqlConfiguration.tsp";
import "./CosmosDBForPostgreSqlCoordinatorConfiguration.tsp";
import "./CosmosDBForPostgreSqlNodeConfiguration.tsp";
import "./CosmosDBForPostgreSqlFirewallRule.tsp";
import "./CosmosDBForPostgreSqlRole.tsp";
import "./CosmosDBForPostgreSqlPrivateEndpointConnection.tsp";
import "./CosmosDBForPostgreSqlPrivateLinkResource.tsp";
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
@doc("Azure Cosmos DB for PostgreSQL database service resource provider REST APIs")
namespace Azure.ResourceManager.CosmosDBForPostgreSql;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_11_08: "2022-11-08",
}
