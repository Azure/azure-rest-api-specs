using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;

namespace Microsoft.AszLabHardware;

@doc("A pool of assigned hardware")
model Pool is TrackedResource<PoolProperties> {
  @doc("The name of the pool")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("poolName")
  @segment("pools")
  @path
  name: string;
}

@doc("Details of the AszLabHw Pool.")
model PoolProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Pools {
  get is ArmResourceRead<Pool>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Pool>;
  update is ArmTagsPatchAsync<Pool, PoolProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Pool>;
  listByResourceGroup is ArmResourceListByParent<Pool>;
  listBySubscription is ArmListBySubscription<Pool>;
}

scalar PoolResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AszLabHardware/pools",
    }
  ]>;
