import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.RecoveryServicesDataReplication;
@doc("Fabric model.")
model DataReplicationFabric is TrackedResource<FabricModelProperties> {
  @doc("The fabric name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("fabricName")
  @segment("replicationFabrics")
  name: string;
}

@armResourceOperations
interface DataReplicationFabrics {
  @doc("Gets the details of the fabric.")
  get is ArmResourceRead<DataReplicationFabric>;
  @doc("Creates the fabric.")
  create is ArmResourceCreateOrUpdateAsync<DataReplicationFabric>;
  @doc("Performs update on the fabric.")
  update is ArmResourcePatchAsync<DataReplicationFabric, FabricModelProperties>;
  @doc("Removes the fabric.")
  delete is ArmResourceDeleteWithoutOkAsync<DataReplicationFabric>;
  @doc("Gets the list of fabrics in the given subscription and resource group.")
  list is ArmResourceListByParent<
    DataReplicationFabric,
    {
      ...BaseParameters<DataReplicationFabric>;

      @doc("Continuation token from the previous call.")
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
  @doc("Gets the list of fabrics in the given subscription.")
  listBySubscription is ArmListBySubscription<DataReplicationFabric>;
}
