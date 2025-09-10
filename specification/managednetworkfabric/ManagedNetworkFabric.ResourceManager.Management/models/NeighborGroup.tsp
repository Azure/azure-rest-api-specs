import "./common.tsp";
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;

@doc("Neighbor Group Properties defines the properties of the resource.")
model NeighborGroupProperties {
  ...AnnotationResource;

  @doc("An array of destination IPv4 Addresses or IPv6 Addresses.")
  destination: NeighborGroupDestination;

  @doc("List of NetworkTap IDs where neighbor group is associated.")
  @visibility(Lifecycle.Read)
  networkTapIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTaps";
    }
  ]>[];

  @doc("List of Network Tap Rule IDs where neighbor group is associated.")
  @visibility(Lifecycle.Read)
  networkTapRuleIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTapRules";
    }
  ]>[];

  @doc("Associated Network Fabric Resource IDs")
  @added(Versions.v2025_07_15)
  @visibility(Lifecycle.Read)
  networkFabricIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>[];

  @doc("Details of the last operation performed on the resource")
  @visibility(Lifecycle.Read)
  @added(Versions.v2024_06_15_preview)
  lastOperation?: LastOperationProperties;

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @added(Versions.v2025_07_15)
  @doc("Configuration state of the resource.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;
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
  ...TagsUpdate;

  @doc("Neighbor Group Patch properties.")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "properties")
  propertiesDeprecated?: NeighborGroupPatchProperties;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @doc("Neighbor Group Patch properties.")
  @added(Versions.v2025_07_15)
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: NeighborGroupPatchProperties;

  @added(Versions.v2025_07_15)
  @doc("The managed service identities assigned to this resource.")
  identity?: ManagedServiceIdentityPatch;
}

@doc("Neighbor Group Patch properties.")
model NeighborGroupPatchProperties {
  ...AnnotationResource;

  @doc("An array of destination IPv4 Addresses or IPv6 Addresses.")
  destination?: NeighborGroupDestinationPatch;
}

@doc("Response for Neighbor Group Resync operation.")
@added(Versions.v2025_07_15)
model NeighborGroupResyncResponse {
  ...OperationStatusResult;
}
