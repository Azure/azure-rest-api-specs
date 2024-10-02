import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

/**
 * Network Fabric SKU Properties define properties of the resource.
 */
model NetworkFabricSkuProperties {
  /**
   * Type of Network Fabric SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "This is a valid property name."
  @visibility("read")
  type?: FabricSkuType;

  /**
   * Maximum number of compute racks available for this Network Fabric SKU. The value of max count racks is 4 for 4 rack SKU and 8 for 8 rack SKU.
   */
  maxComputeRacks?: int32;

  /**
   * Maximum number of servers available for this Network Fabric SKU.
   */
  maximumServerCount?: int32;

  /**
   * List of supported Network Fabric SKU versions.
   */
  @visibility("read")
  supportedVersions?: string[];

  /**
   * URL providing detailed configuration of the fabric SKU.
   */
  @visibility("read")
  details?: string;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Type of Network Fabric SKU.
 */
union FabricSkuType {
  @doc("FabricSkuType-SingleRack")
  SingleRack: "SingleRack",

  @doc("FabricSkuType-MultiRack")
  MultiRack: "MultiRack",

  string,
}
