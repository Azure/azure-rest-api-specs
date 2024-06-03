import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./common.tsp";
import "./service.tsp";
import "./MongoCluster.tsp";

using TypeSpec.Rest;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DocumentDB;
@doc("Represents a mongo cluster replica.")
@parentResource(MongoCluster)
@added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
model Replica is ProxyResource<MongoClusterProperties> {
  @doc("The name of the mongo cluster firewall rule.")
  @maxLength(40)
  @minLength(3)
  @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
  @key("replicaName")
  @segment("replicas")
  @visibility("read")
  @path
  name: string;
}

@armResourceOperations
@added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
interface Replicas {
  @doc("List all the replicas for the mongo cluster.")
  listByParent is ArmResourceListByParent<Replica>;
}
