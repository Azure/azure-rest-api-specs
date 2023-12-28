import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NetAppAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetApp;
@doc("Capacity pool resource")
@parentResource(NetAppAccount)
model CapacityPool is TrackedResource<PoolProperties> {
  @doc("The name of the capacity pool")
  @maxLength(64)
  @minLength(1)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$")
  @key("poolName")
  @segment("capacityPools")
  name: string;

  @doc("A unique read-only string that changes whenever the resource is updated.")
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface Pools {
  @doc("Get details of the specified capacity pool")
  get is ArmResourceRead<CapacityPool>;
  @doc("Create or Update a capacity pool")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CapacityPool>;
  @doc("Patch the specified capacity pool")
  update is ArmCustomPatchAsync<CapacityPool, CapacityPoolPatch>;
  @doc("Delete the specified capacity pool")
  delete is ArmResourceDeleteWithoutOkAsync<CapacityPool>;
  @doc("List all capacity pools in the NetApp Account")
  list is ArmResourceListByParent<CapacityPool>;
}
