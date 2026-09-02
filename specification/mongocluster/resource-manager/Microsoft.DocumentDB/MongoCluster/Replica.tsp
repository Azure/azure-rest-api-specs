using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DocumentDB;

/** Represents a mongo cluster replica. */
@parentResource(MongoCluster)
@added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
model Replica is ProxyResource<MongoClusterProperties> {
  /** The name of the mongo cluster firewall rule. */
  @maxLength(40)
  @minLength(3)
  @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
  @key("replicaName")
  @segment("replicas")
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

@armResourceOperations
@added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
interface Replicas {
  /** List all the replicas for the mongo cluster. */
  listByParent is ArmResourceListByParent<Replica>;
}
