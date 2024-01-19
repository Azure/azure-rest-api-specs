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
@doc("Container App Revision Replica.")
@parentResource(Revision)
model Replica is ProxyResource<ReplicaProperties> {
  @doc("Name of the Container App Revision Replica.")
  @path
  @key("replicaName")
  @segment("replicas")
  name: string;
}

@armResourceOperations
interface Replicas {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a replica for a Container App Revision.")
  @operationId("ContainerAppsRevisionReplicas_GetReplica")
  getReplica is ArmResourceRead<Replica>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List replicas for a Container App Revision.")
  @operationId("ContainerAppsRevisionReplicas_ListReplicas")
  listReplicas is ArmResourceListByParent<Replica>;
}
