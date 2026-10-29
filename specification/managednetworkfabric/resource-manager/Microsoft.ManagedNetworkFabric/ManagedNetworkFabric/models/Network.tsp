import "./common.tsp";
import "./Vlan.tsp";

using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.ManagedNetworkFabric;

@doc("Network runtime health.")
@added(Versions.v2026_07_15_preview)
union NetworkOperationalState {
  string,

  @doc("The Network is operational on all participating devices.")
  up: "Up",

  @doc("The Network is not operational.")
  down: "Down",

  @doc("The Network is operational on a subset of participating devices.")
  degraded: "Degraded",
}

@doc("Properties of a Network - a routed L2 and L3 segment under a Vrf, bound to a sibling Vlan. The fabric-kind-specific config bags are optional because exact bag selection requires parent Fabric context.")
@added(Versions.v2026_07_15_preview)
model NetworkProperties {
  @doc("Free-text description. Max 1024 characters.")
  @maxLength(1024)
  description?: string;

  @doc("ARM resource ID of the Vlan resource this network is bound to. Must be a sibling under the same Fabric.")
  vlanResourceId?: armResourceIdentifier;

  @doc("Named connected-subnet groups for this network segment.")
  @Azure.ResourceManager.identifiers(#["name"])
  connectedSubnets?: ConnectedSubnetGroup[];

  @doc("Maximum transmission unit in bytes for this network segment. Defaults to 1500.")
  @minValue(1500)
  @maxValue(9000)
  mtu?: int32 = 1500;

  @doc("Operator management policy; defaults to Observe. Only applicable in controller-managed mode.")
  managementPolicy?: ManagementPolicy = ManagementPolicy.observe;

  @doc("Platform-managed configuration. Applicable when the parent Fabric's root-level kind is platformManaged.")
  platformManagedConfig?: NetworkPlatformManagedConfig;

  @doc("User-managed configuration. Applicable when the parent Fabric's root-level kind is userManaged.")
  userManagedConfig?: NetworkUserManagedConfig;

  @doc("Cisco ACI controller-managed configuration. Applicable when the parent Fabric's root-level kind is controllerManaged and controllerKind is CiscoACI.")
  ciscoAciConfig?: NetworkCiscoAciConfig;

  @doc("Arista CloudVision controller-managed configuration. Applicable when the parent Fabric's root-level kind is controllerManaged and controllerKind is AristaCloudVision.")
  aristaCloudVisionConfig?: NetworkAristaCloudVisionConfig;

  @doc("Service-populated ARM provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("True when this Network was auto-created by controller hydration.")
  @visibility(Lifecycle.Read)
  systemManaged?: BooleanEnumProperty;

  @doc("Controller provenance for a hydrated Network, used to trace read-only ARM state back to the source controller object.")
  @visibility(Lifecycle.Read)
  hydrationSource?: HydrationSource;

  @doc("Administrative state; defaults to Enabled.")
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;

  @doc("Aggregated operational state across all participating devices.")
  @visibility(Lifecycle.Read)
  operationalState?: NetworkOperationalState;

  @doc("Configuration state from the operator.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  @doc("Numeric VLAN ID resolved from the referenced Vlan resource.")
  @minValue(1)
  @maxValue(4094)
  @visibility(Lifecycle.Read)
  resolvedVlanId?: int32;
}

@doc("Network patchable properties.")
@added(Versions.v2026_07_15_preview)
model NetworkPatchableProperties {
  @doc("Free-text description. Max 1024 characters.")
  @maxLength(1024)
  description?: string;

  @doc("ARM resource ID of the Vlan resource this network is bound to.")
  vlanResourceId?: armResourceIdentifier;

  @doc("Named connected-subnet groups for this network segment.")
  @Azure.ResourceManager.identifiers(#["name"])
  connectedSubnets?: ConnectedSubnetGroup[];

  @doc("Maximum transmission unit in bytes for this network segment.")
  @minValue(1500)
  @maxValue(9000)
  mtu?: int32;

  @doc("Operator management policy.")
  managementPolicy?: ManagementPolicy;

  @doc("Platform-managed configuration.")
  platformManagedConfig?: NetworkPlatformManagedConfigPatch;

  @doc("User-managed configuration.")
  userManagedConfig?: NetworkUserManagedConfig;

  @doc("Cisco ACI controller-managed configuration.")
  ciscoAciConfig?: NetworkCiscoAciConfig;

  @doc("Arista CloudVision controller-managed configuration.")
  aristaCloudVisionConfig?: NetworkAristaCloudVisionConfigPatch;
}

@doc("The Network patch resource definition.")
@added(Versions.v2026_07_15_preview)
model NetworkPatch {
  ...TagsUpdate;

  @doc("Network patchable properties.")
  properties?: NetworkPatchableProperties;
}

@doc("A named connected-subnet group.")
@added(Versions.v2026_07_15_preview)
model ConnectedSubnetGroup {
  @doc("Stable group name, unique within the Network.")
  name?: string;

  @doc("Address prefixes in this group. Entries may be IPv4 or IPv6 prefixes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  addressPrefixes?: ConnectedAddressPrefix[];
}

@doc("A single connected address prefix and its optional gateway.")
@added(Versions.v2026_07_15_preview)
model ConnectedAddressPrefix {
  @doc("CIDR prefix.")
  prefix?: string;

  @doc("Optional default gateway for the prefix.")
  gateway?: string;
}

@doc("Platform-managed network configuration.")
@added(Versions.v2026_07_15_preview)
model NetworkPlatformManagedConfig {
  @doc("Per-SVI BGP peering configuration.")
  bgpConfiguration?: NetworkBgpConfiguration;

  @doc("Static route configuration.")
  staticRouteConfiguration?: NetworkStaticRouteConfiguration;

  @doc("Import route policy reference.")
  importRoutePolicy?: RoutePolicyReference;

  @doc("Export route policy reference.")
  exportRoutePolicy?: RoutePolicyReference;

  @doc("ARM resource ID of the ingress ACL applied to this network.")
  ingressAclResourceId?: armResourceIdentifier;

  @doc("ARM resource ID of the egress ACL applied to this network.")
  egressAclResourceId?: armResourceIdentifier;
}

@doc("Platform-managed network configuration for patch operations.")
@added(Versions.v2026_07_15_preview)
model NetworkPlatformManagedConfigPatch {
  @doc("Per-SVI BGP peering configuration.")
  bgpConfiguration?: NetworkBgpConfigurationPatch;

  @doc("Static route configuration.")
  staticRouteConfiguration?: NetworkStaticRouteConfiguration;

  @doc("Import route policy reference.")
  importRoutePolicy?: RoutePolicyReference;

  @doc("Export route policy reference.")
  exportRoutePolicy?: RoutePolicyReference;

  @doc("ARM resource ID of the ingress ACL applied to this network.")
  ingressAclResourceId?: armResourceIdentifier;

  @doc("ARM resource ID of the egress ACL applied to this network.")
  egressAclResourceId?: armResourceIdentifier;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "User-managed networks intentionally carry no provider-managed settings; the empty object is the explicit configuration marker."
@doc("User-managed network configuration.")
@added(Versions.v2026_07_15_preview)
model NetworkUserManagedConfig {}

@doc("Cisco ACI controller-managed network configuration.")
@added(Versions.v2026_07_15_preview)
model NetworkCiscoAciConfig {
  @doc("Name of the ACI VRF within the tenant.")
  vrfName?: string;

  @doc("Name of the ACI Bridge Domain for this segment.")
  bridgeDomainName?: string;

  @doc("Name of the ACI Endpoint Group for this segment.")
  epgName?: string;

  @doc("Names of ACI contracts this EPG provides.")
  providedContracts?: string[];

  @doc("Names of ACI contracts this EPG consumes.")
  consumedContracts?: string[];
}

@doc("Arista CloudVision controller-managed network configuration.")
@added(Versions.v2026_07_15_preview)
model NetworkAristaCloudVisionConfig {
  @doc("Per-SVI BGP peering configuration.")
  bgpConfiguration?: NetworkBgpConfiguration;

  @doc("Static route configuration.")
  staticRouteConfiguration?: NetworkStaticRouteConfiguration;

  @doc("Import route policy reference.")
  importRoutePolicy?: RoutePolicyReference;

  @doc("Export route policy reference.")
  exportRoutePolicy?: RoutePolicyReference;

  @doc("ARM resource ID of the ingress ACL.")
  ingressAclResourceId?: armResourceIdentifier;

  @doc("ARM resource ID of the egress ACL.")
  egressAclResourceId?: armResourceIdentifier;

  @doc("Override the CloudVision configlet name.")
  configletName?: string;

  @doc("Override the CloudVision device tag query.")
  deviceQuery?: string;
}

@doc("Arista CloudVision controller-managed network configuration for patch operations.")
@added(Versions.v2026_07_15_preview)
model NetworkAristaCloudVisionConfigPatch {
  @doc("Per-SVI BGP peering configuration.")
  bgpConfiguration?: NetworkBgpConfigurationPatch;

  @doc("Static route configuration.")
  staticRouteConfiguration?: NetworkStaticRouteConfiguration;

  @doc("Import route policy reference.")
  importRoutePolicy?: RoutePolicyReference;

  @doc("Export route policy reference.")
  exportRoutePolicy?: RoutePolicyReference;

  @doc("ARM resource ID of the ingress ACL.")
  ingressAclResourceId?: armResourceIdentifier;

  @doc("ARM resource ID of the egress ACL.")
  egressAclResourceId?: armResourceIdentifier;

  @doc("Override the CloudVision configlet name.")
  configletName?: string;

  @doc("Override the CloudVision device tag query.")
  deviceQuery?: string;
}

@doc("BGP peering configuration for a network.")
@added(Versions.v2026_07_15_preview)
model NetworkBgpConfiguration {
  @doc("Enable Bidirectional Forwarding Detection. Defaults to False.")
  bfdEnabled?: BooleanEnumProperty = BooleanEnumProperty.False;

  @doc("Peer AS number for BGP sessions on this network.")
  @minValue(1)
  @maxValue(4294967295)
  peerAsn?: int64;

  @doc("IPv4 prefix ranges for dynamic BGP neighbor discovery.")
  ipv4ListenRangePrefixes?: string[];

  @doc("Explicit IPv4 BGP neighbor addresses.")
  @Azure.ResourceManager.identifiers(#["address"])
  ipv4NeighborAddresses?: BgpNeighborAddress[];
}

@doc("BGP peering configuration for a network patch operation.")
@added(Versions.v2026_07_15_preview)
model NetworkBgpConfigurationPatch {
  @doc("Enable Bidirectional Forwarding Detection.")
  bfdEnabled?: BooleanEnumProperty;

  @doc("Peer AS number for BGP sessions on this network.")
  @minValue(1)
  @maxValue(4294967295)
  peerAsn?: int64;

  @doc("IPv4 prefix ranges for dynamic BGP neighbor discovery.")
  ipv4ListenRangePrefixes?: string[];

  @doc("Explicit IPv4 BGP neighbor addresses.")
  @Azure.ResourceManager.identifiers(#["address"])
  ipv4NeighborAddresses?: BgpNeighborAddress[];
}

@doc("A BGP neighbor entry.")
@added(Versions.v2026_07_15_preview)
model BgpNeighborAddress {
  @doc("Neighbor IPv4 or IPv6 address.")
  address?: string;
}

@doc("Static route configuration for a network.")
@added(Versions.v2026_07_15_preview)
model NetworkStaticRouteConfiguration {
  @doc("IPv4 static routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv4Routes?: StaticRoute[];

  @doc("IPv6 static routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv6Routes?: StaticRoute[];
}

@doc("A static route entry.")
@added(Versions.v2026_07_15_preview)
model StaticRoute {
  @doc("Destination CIDR prefix.")
  prefix?: string;

  @doc("Next-hop addresses.")
  nextHop?: string[];
}

@doc("A reference to a RoutePolicy ARM resource.")
@added(Versions.v2026_07_15_preview)
model RoutePolicyReference {
  @doc("ARM resource ID of the RoutePolicy.")
  routePolicyResourceId?: armResourceIdentifier;
}
