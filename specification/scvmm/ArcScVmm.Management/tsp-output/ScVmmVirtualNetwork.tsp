import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ArcScVmm;
@doc("The VirtualNetworks resource definition.")
model ScVmmVirtualNetwork is TrackedResource<VirtualNetworkProperties> {
  @doc("Name of the VirtualNetwork.")
  @path
  @key("virtualNetworkName")
  @segment("virtualNetworks")
  name: string;

  @doc("The extended location.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface ScVmmVirtualNetworks {
  @doc("Implements VirtualNetwork GET method.")
  get is ArmResourceRead<ScVmmVirtualNetwork>;
  @doc("Onboards the ScVmm virtual network as an Azure virtual network resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ScVmmVirtualNetwork>;
  @doc("Updates the VirtualNetworks resource.")
  update is ArmTagsPatchAsync<ScVmmVirtualNetwork>;
  @doc("Deregisters the ScVmm virtual network from Azure.")
  delete is ArmResourceDeleteAsync<
    ScVmmVirtualNetwork,
    {
      ...BaseParameters<ScVmmVirtualNetwork>;

      @doc("Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.")
      @query("force")
      force?: boolean;
    }
  >;
  @doc("List of VirtualNetworks in a resource group.")
  listByResourceGroup is ArmResourceListByParent<ScVmmVirtualNetwork>;
  @doc("List of VirtualNetworks in a subscription.")
  listBySubscription is ArmListBySubscription<ScVmmVirtualNetwork>;
}
