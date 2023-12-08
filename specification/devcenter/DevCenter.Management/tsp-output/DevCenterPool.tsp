import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenterProject.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevCenter;
@doc("A pool of Virtual Machines.")
@parentResource(DevCenterProject)
model DevCenterPool is TrackedResource<PoolProperties> {
  @doc("Name of the pool.")
  @path
  @key("poolName")
  @segment("pools")
  name: string;
}

@armResourceOperations
interface DevCenterPools {
  @doc("Gets a machine pool")
  get is ArmResourceRead<DevCenterPool>;
  @doc("Creates or updates a machine pool")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DevCenterPool>;
  @doc("Partially updates a machine pool")
  update is ArmResourcePatchAsync<DevCenterPool, PoolProperties>;
  @doc("Deletes a machine pool")
  delete is ArmResourceDeleteAsync<DevCenterPool>;
  @doc("Lists pools for a project")
  listByProject is ArmResourceListByParent<
    DevCenterPool,
    {
      ...BaseParameters<DevCenterPool>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Triggers a refresh of the pool status.")
  runHealthChecks is ArmResourceActionAsync<DevCenterPool, {}, {}>;
}
