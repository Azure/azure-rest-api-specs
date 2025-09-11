import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ConnectedVMwarevSphere;
@doc("Define the virtualNetwork.")
model VirtualNetwork is TrackedResource<VirtualNetworkProperties> {
  @doc("Name of the virtual network resource.")
  @path
  @key("virtualNetworkName")
  @segment("virtualNetworks")
  name: string;

  @doc("Gets or sets the extended location.")
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface VirtualNetworks {
  @doc("Implements virtual network GET method.")
  get is ArmResourceRead<VirtualNetwork>;
  @doc("Create Or Update virtual network.")
  create is ArmResourceCreateOrUpdateAsync<VirtualNetwork>;
  @doc("API to update certain properties of the virtual network resource.")
  update is ArmTagsPatchSync<VirtualNetwork>;
  @doc("Implements virtual network DELETE method.")
  delete is ArmResourceDeleteAsync<
    VirtualNetwork,
    {
      ...BaseParameters<VirtualNetwork>;

      @doc("Whether force delete was specified.")
      @query("force")
      force?: boolean;
    }
  >;
  @doc("List of virtualNetworks in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VirtualNetwork>;
  @doc("List of virtualNetworks in a subscription.")
  list is ArmListBySubscription<VirtualNetwork>;
}
