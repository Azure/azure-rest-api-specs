import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./MongoCluster.tsp";
import "./FirewallRule.tsp";
import "./PrivateEndpointConnection.tsp";
import "./Replica.tsp";
import "./User.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** The Microsoft Azure management API provides create, read, update, and delete functionality for Azure Cosmos DB for MongoDB vCore resources including clusters and firewall rules. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing resource provider namespace."
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Existing resource provider namespace."
@armProviderNamespace
@service(#{ title: "MongoClusterManagementClient" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.DocumentDB;

/** The available API versions. */
enum Versions {
  /** Azure Cosmos DB for Mongo vCore clusters api version 2024-03-01-preview. */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_03_01_preview: "2024-03-01-preview",

  /** Azure Cosmos DB for Mongo vCore clusters api version 2024-06-01-preview. */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_06_01_preview: "2024-06-01-preview",

  /** Azure Cosmos DB for Mongo vCore clusters api version 2024-07-01. */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_07_01: "2024-07-01",

  /** Azure Cosmos DB for Mongo vCore clusters api version 2024-10-01-preview. */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_10_01_preview: "2024-10-01-preview",

  /** Azure Cosmos DB for Mongo vCore clusters api version 2025-04-01-preview. */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2025_04_01_preview: "2025-04-01-preview",

  /** Azure Cosmos DB for Mongo vCore clusters api version 2025-07-01-preview. */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2025_07_01_preview: "2025-07-01-preview",
}
