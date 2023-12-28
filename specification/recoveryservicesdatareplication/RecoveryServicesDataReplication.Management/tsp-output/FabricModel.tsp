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
model FabricModel is TrackedResource<FabricModelProperties> {
  @doc("The fabric name.")
  @pattern("^[a-zA-Z0-9]*$")
  @key("fabricName")
  @segment("replicationFabrics")
  name: string;
}

@armResourceOperations
interface Fabric {
  @doc("Gets the details of the fabric.")
  get is ArmResourceRead<FabricModel>;
  @doc("Creates the fabric.")
  create is ArmResourceCreateOrUpdateAsync<FabricModel>;
  @doc("Performs update on the fabric.")
  update is ArmCustomPatchAsync<FabricModel, FabricModelUpdate>;
  @doc("Removes the fabric.")
  delete is ArmResourceDeleteWithoutOkAsync<FabricModel>;
  @doc("Gets the list of fabrics in the given subscription and resource group.")
  list is ArmResourceListByParent<
    FabricModel,
    {
      ...BaseParameters<FabricModel>;

      @doc("Continuation token from the previous call.")
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
  @doc("Gets the list of fabrics in the given subscription.")
  listBySubscription is ArmListBySubscription<FabricModel>;
}
