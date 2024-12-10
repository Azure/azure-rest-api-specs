import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

@doc("Neighbor Group Properties defines the properties of the resource.")
model NeighborGroupProperties {
  ...AnnotationResource;

  @doc("An array of destination IPv4 Addresses or IPv6 Addresses.")
  destination: NeighborGroupDestination;

  @doc("List of NetworkTap IDs where neighbor group is associated.")
  @visibility("read")
  networkTapIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTaps";
    }
  ]>[];

  @doc("List of Network Tap Rule IDs where neighbor group is associated.")
  @visibility("read")
  networkTapRuleIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTapRules";
    }
  ]>[];

  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("An array of destination IPv4 Addresses or IPv6 Addresses.")
model NeighborGroupDestination {
  @doc("Array of IPv4 Addresses.")
  @maxItems(16)
  ipv4Addresses?: string[];

  @doc("Array of IPv6 Addresses.")
  @maxItems(16)
  ipv6Addresses?: string[];
}

@doc("An array of destination IPv4 Addresses or IPv6 Addresses.")
model NeighborGroupDestinationPatch is NeighborGroupDestination;

@doc("The Neighbor Group Patch definition.")
model NeighborGroupPatch {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...TagsUpdate;

  @doc("Neighbor Group Patch properties.")
  properties?: NeighborGroupPatchProperties;
}

@doc("Neighbor Group Patch properties.")
model NeighborGroupPatchProperties {
  ...AnnotationResource;

  @doc("An array of destination IPv4 Addresses or IPv6 Addresses.")
  destination?: NeighborGroupDestinationPatch;
}
