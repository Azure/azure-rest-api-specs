import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

/**
 * Neighbor Group Properties defines the properties of the resource.
 */
model NeighborGroupProperties {
  ...AnnotationResource;

  /**
   * An array of destination IPv4 Addresses or IPv6 Addresses.
   */
  destination: NeighborGroupDestination;

  /**
   * List of NetworkTap IDs where neighbor group is associated.
   */
  @visibility("read")
  networkTapIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTaps";
    }
  ]>[];

  /**
   * List of Network Tap Rule IDs where neighbor group is associated.
   */
  @visibility("read")
  networkTapRuleIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTapRules";
    }
  ]>[];

  /**
   * The provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * An array of destination IPv4 Addresses or IPv6 Addresses.
 */
model NeighborGroupDestination {
  /**
   * Array of IPv4 Addresses.
   */
  @maxItems(16)
  ipv4Addresses?: string[];

  /**
   * Array of IPv6 Addresses.
   */
  @maxItems(16)
  ipv6Addresses?: string[];
}

@doc("An array of destination IPv4 Addresses or IPv6 Addresses.")
model NeighborGroupDestinationPatch is NeighborGroupDestination;

/**
 * The Neighbor Group Patch definition.
 */
model NeighborGroupPatch {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...TagsUpdate;

  /**
   * Neighbor Group Patch properties.
   */
  properties?: NeighborGroupPatchProperties;
}

/**
 * Neighbor Group Patch properties.
 */
model NeighborGroupPatchProperties {
  ...AnnotationResource;

  /**
   * An array of destination IPv4 Addresses or IPv6 Addresses.
   */
  destination?: NeighborGroupDestinationPatch;
}
