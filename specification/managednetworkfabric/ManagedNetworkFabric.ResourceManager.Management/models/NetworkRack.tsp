import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

/**
 * Network Rack Properties defines the properties of the resource.
 */
model NetworkRackProperties {
  ...AnnotationResource;

  /**
   * Network Rack SKU name.
   */
  networkRackType?: NetworkRackType;

  /**
   * ARM resource ID of the Network Fabric.
   */
  networkFabricId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  /**
   * List of network device ARM resource IDs.
   */
  @visibility("read")
  networkDevices?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices";
    }
  ]>[];

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Network Rack patch resource definition.")
model NetworkRackPatch is TagsUpdate;

/**
 * Network Rack SKU name.
 */
union NetworkRackType {
  @doc("NetworkRackType-Aggregate")
  Aggregate: "Aggregate",

  @doc("NetworkRackType-Compute")
  Compute: "Compute",

  @doc("NetworkRackType-Combined")
  Combined: "Combined",

  string,
}
