import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerAppRevision.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppContainers;
@doc("Container App Revision Replica.")
@parentResource(ContainerAppRevision)
model ContainerAppReplica is ProxyResource<ReplicaProperties> {
  @doc("Name of the Container App Revision Replica.")
  @path
  @key("replicaName")
  @segment("replicas")
  name: string;
}

@armResourceOperations
interface ContainerAppReplicas {
  @doc("Get a replica for a Container App Revision.")
  getReplica is ArmResourceRead<ContainerAppReplica>;
  @doc("List replicas for a Container App Revision.")
  listReplicas is ArmResourceListByParent<ContainerAppReplica>;
}
