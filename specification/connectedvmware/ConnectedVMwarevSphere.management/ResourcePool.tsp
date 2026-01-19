import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ConnectedVMwarevSphere;
@doc("Define the resourcePool.")
model ResourcePool is TrackedResource<ResourcePoolProperties> {
  @doc("Name of the resourcePool.")
  @path
  @key("resourcePoolName")
  @segment("resourcePools")
  name: string;

  @doc("Gets or sets the extended location.")
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ResourcePools {
  @doc("Implements resourcePool GET method.")
  get is ArmResourceRead<ResourcePool>;
  @doc("Create Or Update resourcePool.")
  create is ArmResourceCreateOrUpdateAsync<ResourcePool>;
  @doc("API to update certain properties of the resourcePool resource.")
  update is ArmTagsPatchSync<ResourcePool>;
  @doc("Implements resourcePool DELETE method.")
  delete is ArmResourceDeleteAsync<
    ResourcePool,
    {
      ...BaseParameters<ResourcePool>;

      @doc("Whether force delete was specified.")
      @query("force")
      force?: boolean;
    }
  >;
  @doc("List of resourcePools in a resource group.")
  listByResourceGroup is ArmResourceListByParent<ResourcePool>;
  @doc("List of resourcePools in a subscription.")
  list is ArmListBySubscription<ResourcePool>;
}
