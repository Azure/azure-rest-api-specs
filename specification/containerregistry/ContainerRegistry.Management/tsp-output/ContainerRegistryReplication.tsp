import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerRegistry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ContainerRegistry;
@doc("An object that represents a replication for a container registry.")
@parentResource(ContainerRegistry)
model ContainerRegistryReplication is TrackedResource<ReplicationProperties> {
  @doc("The name of the replication.")
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("replicationName")
  @segment("replications")
  name: string;
}

@armResourceOperations
interface ContainerRegistryReplications {
  @doc("Gets the properties of the specified replication.")
  get is ArmResourceRead<ContainerRegistryReplication>;
  @doc("Creates a replication for a container registry with the specified parameters.")
  create is ArmResourceCreateOrUpdateAsync<ContainerRegistryReplication>;
  @doc("Updates a replication for a container registry with the specified parameters.")
  update is ArmResourcePatchAsync<
    ContainerRegistryReplication,
    ReplicationProperties
  >;
  @doc("Deletes a replication from a container registry.")
  delete is ArmResourceDeleteAsync<ContainerRegistryReplication>;
  @doc("Lists all the replications for the specified container registry.")
  list is ArmResourceListByParent<ContainerRegistryReplication>;
}
