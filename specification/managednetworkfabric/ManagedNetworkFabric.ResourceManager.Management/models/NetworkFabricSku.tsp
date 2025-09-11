import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

@doc("Network Fabric SKU Properties define properties of the resource.")
model NetworkFabricSkuProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "This is a valid property name."
  @doc("Type of Network Fabric SKU.")
  @visibility(Lifecycle.Read)
  type?: FabricSkuType;

  @doc("Maximum number of compute racks available for this Network Fabric SKU. The value of max count racks is 4 for 4 rack SKU and 8 for 8 rack SKU.")
  maxComputeRacks?: int32;

  @doc("Maximum number of servers available for this Network Fabric SKU.")
  maximumServerCount?: int32;

  @doc("List of supported Network Fabric SKU versions.")
  @visibility(Lifecycle.Read)
  supportedVersions?: string[];

  @doc("URL providing detailed configuration of the fabric SKU.")
  @visibility(Lifecycle.Read)
  details?: string;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Type of Network Fabric SKU.")
union FabricSkuType {
  @doc("FabricSkuType-SingleRack")
  SingleRack: "SingleRack",

  @doc("FabricSkuType-MultiRack")
  MultiRack: "MultiRack",

  string,
}
