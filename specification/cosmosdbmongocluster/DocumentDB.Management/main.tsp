import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./MongoCluster.tsp";
import "./FirewallRule.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "CosmosDB Mongo Cluster",
})
@versioned(Versions)
@doc("The Microsoft Azure management API provides create, read, update, and delete functionality for Azure Cosmos DB for MongoDB vCore resources including clusters and firewall rules.")
namespace Microsoft.DocumentDB;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_10_01: "2023-10-01",
}
