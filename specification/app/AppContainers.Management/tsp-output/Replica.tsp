import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Revision.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Container App Revision Replica.
 */
@parentResource(Revision)
model Replica is ProxyResource<ReplicaProperties> {
  /**
   * Name of the Container App Revision Replica.
   */
  @path
  @key("replicaName")
  @segment("replicas")
  name: string;
}

@armResourceOperations
interface Replicas {
  /**
   * Get a replica for a Container App Revision.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContainerAppsRevisionReplicas_GetReplica")
  getReplica is ArmResourceRead<Replica>;

  /**
   * List replicas for a Container App Revision.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContainerAppsRevisionReplicas_ListReplicas")
  listReplicas is ArmResourceListByParent<Replica>;
}
