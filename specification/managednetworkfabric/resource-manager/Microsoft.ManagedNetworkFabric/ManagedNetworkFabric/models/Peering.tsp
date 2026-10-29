import "./common.tsp";
import "./Network.tsp";
import "./Vlan.tsp";
import "./Vrf.tsp";

using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.ManagedNetworkFabric;

@doc("Peering runtime health.")
@added(Versions.v2026_07_15_preview)
union PeeringOperationalState {
  string,

  @doc("The Peering is operational.")
  up: "Up",

  @doc("The Peering is not operational.")
  down: "Down",

  @doc("The Peering is operational on a subset of participating devices.")
  degraded: "Degraded",

  @doc("The Peering BGP session is established.")
  established: "Established",
}

@doc("BGP FSM state per RFC 4271 section 8.")
@added(Versions.v2026_07_15_preview)
union PeeringState {
  string,

  @doc("The BGP session is idle.")
  idle: "Idle",

  @doc("The BGP session is in connect state.")
  connect: "Connect",

  @doc("The BGP session is active.")
  active: "Active",

  @doc("The BGP session has sent an open message.")
  openSent: "OpenSent",

  @doc("The BGP session is confirming an open message.")
  openConfirm: "OpenConfirm",

  @doc("The BGP session is established.")
  established: "Established",
}

@doc("Provider type resolved from the parent Fabric kind and controller-managed configuration.")
@added(Versions.v2026_07_15_preview)
union ResolvedProviderType {
  string,

  @doc("Platform-managed provider.")
  platformManaged: "PlatformManaged",

  @doc("User-managed provider.")
  userManaged: "UserManaged",

  @doc("Cisco ACI controller-managed provider.")
  ciscoAci: "CiscoAci",

  @doc("Arista CloudVision controller-managed provider.")
  aristaCloudVision: "AristaCloudVision",
}

@doc("Properties of a Peering - an upstream BGP session bound to a VRF. The mode-specific config bags are optional because exact bag selection requires parent Fabric context.")
@added(Versions.v2026_07_15_preview)
model PeeringProperties {
  @doc("Free-text description. Max 1024 characters.")
  @maxLength(1024)
  description?: string;

  @doc("Remote peer BGP ASN.")
  @minValue(1)
  @maxValue(4294967295)
  peerAsn?: int64;

  @doc("Enable Bidirectional Forwarding Detection. Defaults to False.")
  bfdEnabled?: BooleanEnumProperty = BooleanEnumProperty.False;

  @doc("Primary IPv4 prefix for the peering link.")
  primaryIpv4Prefix?: string;

  @doc("Secondary IPv4 prefix for the peering link.")
  secondaryIpv4Prefix?: string;

  @doc("Primary IPv6 prefix for the peering link.")
  primaryIpv6Prefix?: string;

  @doc("Secondary IPv6 prefix for the peering link.")
  secondaryIpv6Prefix?: string;

  @doc("Operator management policy; defaults to Observe. Only applicable in controller-managed mode.")
  managementPolicy?: ManagementPolicy = ManagementPolicy.observe;

  @doc("Platform-managed peering configuration. Applicable when the parent Fabric's root-level kind is platformManaged.")
  platformManagedConfig?: PeeringPlatformManagedConfig;

  @doc("Cisco ACI controller-managed peering configuration. Applicable when the parent Fabric's root-level kind is controllerManaged and controllerKind is CiscoACI.")
  ciscoAciConfig?: PeeringCiscoAciConfig;

  @doc("Arista CloudVision controller-managed peering configuration. Applicable when the parent Fabric's root-level kind is controllerManaged and controllerKind is AristaCloudVision.")
  aristaCloudVisionConfig?: PeeringAristaCloudVisionConfig;

  @doc("Service-populated ARM provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Administrative state; defaults to Enabled.")
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;

  @doc("Aggregated operational state.")
  @visibility(Lifecycle.Read)
  operationalState?: PeeringOperationalState;

  @doc("BGP FSM state.")
  @visibility(Lifecycle.Read)
  peeringState?: PeeringState;

  @doc("Configuration state from the operator.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  @doc("Inferred provider type, surfaced in GET responses.")
  @visibility(Lifecycle.Read)
  resolvedProviderType?: ResolvedProviderType;
}

@doc("Peering patchable properties.")
@added(Versions.v2026_07_15_preview)
model PeeringPatchableProperties {
  @doc("Free-text description. Max 1024 characters.")
  @maxLength(1024)
  description?: string;

  @doc("Remote peer BGP ASN.")
  @minValue(1)
  @maxValue(4294967295)
  peerAsn?: int64;

  @doc("Enable Bidirectional Forwarding Detection.")
  bfdEnabled?: BooleanEnumProperty;

  @doc("Primary IPv4 prefix for the peering link.")
  primaryIpv4Prefix?: string;

  @doc("Secondary IPv4 prefix for the peering link.")
  secondaryIpv4Prefix?: string;

  @doc("Primary IPv6 prefix for the peering link.")
  primaryIpv6Prefix?: string;

  @doc("Secondary IPv6 prefix for the peering link.")
  secondaryIpv6Prefix?: string;

  @doc("Operator management policy.")
  managementPolicy?: ManagementPolicy;

  @doc("Platform-managed peering configuration.")
  platformManagedConfig?: PeeringPlatformManagedConfigPatch;

  @doc("Cisco ACI controller-managed peering configuration.")
  ciscoAciConfig?: PeeringCiscoAciConfig;

  @doc("Arista CloudVision controller-managed peering configuration.")
  aristaCloudVisionConfig?: PeeringAristaCloudVisionConfigPatch;
}

@doc("The Peering patch resource definition.")
@added(Versions.v2026_07_15_preview)
model PeeringPatch {
  ...TagsUpdate;

  @doc("Peering patchable properties.")
  properties?: PeeringPatchableProperties;
}

@doc("Platform-managed peering configuration.")
@added(Versions.v2026_07_15_preview)
model PeeringPlatformManagedConfig {
  @doc("ARM resource ID of the Uplink this peering uses.")
  uplinkResourceId?: armResourceIdentifier;

  @doc("BGP peering model. Selects which variant config bag applies.")
  peeringKind?: PeeringKind;

  @doc("Static routes for the peering.")
  staticRouteConfiguration?: PeeringStaticRouteConfiguration;

  @doc("Import route policy reference.")
  importRoutePolicy?: RoutePolicyReference;

  @doc("Export route policy reference.")
  exportRoutePolicy?: RoutePolicyReference;

  @doc("Per-VRF ingress ACL ARM resource ID.")
  ingressAclResourceId?: armResourceIdentifier;

  @doc("Per-VRF egress ACL ARM resource ID.")
  egressAclResourceId?: armResourceIdentifier;

  @doc("Per-VRF sub-interface configuration. Required when peeringKind is VrfToVrf.")
  vrfToVrfConfig?: VrfToVrfConfig;

  @doc("Per-VRF route targets. Required when peeringKind is LabeledVpn.")
  labeledVpnConfig?: LabeledVpnConfig;

  @doc("Per-VRF PE-to-PE multihop session config. Required when peeringKind is MultihopLabeledVpn.")
  multihopLabeledVpnConfig?: MultihopLabeledVpnConfig;
}

@doc("Platform-managed peering configuration for patch operations.")
@added(Versions.v2026_07_15_preview)
model PeeringPlatformManagedConfigPatch {
  @doc("ARM resource ID of the Uplink this peering uses.")
  uplinkResourceId?: armResourceIdentifier;

  @doc("BGP peering model. Selects which variant config bag applies.")
  peeringKind?: PeeringKind;

  @doc("Static routes for the peering.")
  staticRouteConfiguration?: PeeringStaticRouteConfiguration;

  @doc("Import route policy reference.")
  importRoutePolicy?: RoutePolicyReference;

  @doc("Export route policy reference.")
  exportRoutePolicy?: RoutePolicyReference;

  @doc("Per-VRF ingress ACL ARM resource ID.")
  ingressAclResourceId?: armResourceIdentifier;

  @doc("Per-VRF egress ACL ARM resource ID.")
  egressAclResourceId?: armResourceIdentifier;

  @doc("Per-VRF sub-interface configuration. Required when peeringKind is VrfToVrf.")
  vrfToVrfConfig?: VrfToVrfConfigPatch;

  @doc("Per-VRF route targets. Required when peeringKind is LabeledVpn.")
  labeledVpnConfig?: LabeledVpnConfig;

  @doc("Per-VRF PE-to-PE multihop session config. Required when peeringKind is MultihopLabeledVpn.")
  multihopLabeledVpnConfig?: MultihopLabeledVpnConfigPatch;
}

@doc("Cisco ACI controller-managed peering configuration.")
@added(Versions.v2026_07_15_preview)
model PeeringCiscoAciConfig {
  @doc("Name of the administrator-owned ACI L3Out object this peering references.")
  l3outName?: string;

  @doc("Name of the administrator-owned ACI external EPG under the L3Out.")
  externalEpgName?: string;

  @doc("Same-tenant ACI contracts the referenced external EPG provides.")
  providedContractNames?: string[];
}

@doc("Arista CloudVision controller-managed peering configuration.")
@added(Versions.v2026_07_15_preview)
model PeeringAristaCloudVisionConfig {
  @doc("ARM resource ID of the Uplink this peering uses.")
  uplinkResourceId?: armResourceIdentifier;

  @doc("BGP peering model. Selects which variant config bag applies.")
  peeringKind?: PeeringKind;

  @doc("Static routes for the peering.")
  staticRouteConfiguration?: PeeringStaticRouteConfiguration;

  @doc("Import route policy reference.")
  importRoutePolicy?: RoutePolicyReference;

  @doc("Export route policy reference.")
  exportRoutePolicy?: RoutePolicyReference;

  @doc("Per-VRF ingress ACL ARM resource ID.")
  ingressAclResourceId?: armResourceIdentifier;

  @doc("Per-VRF egress ACL ARM resource ID.")
  egressAclResourceId?: armResourceIdentifier;

  @doc("Override auto-generated configlet name.")
  configletName?: string;

  @doc("Override default device targeting.")
  deviceQuery?: string;

  @doc("Per-VRF sub-interface configuration. Required when peeringKind is VrfToVrf.")
  vrfToVrfConfig?: VrfToVrfConfig;

  @doc("Per-VRF route targets. Required when peeringKind is LabeledVpn.")
  labeledVpnConfig?: LabeledVpnConfig;

  @doc("Per-VRF PE-to-PE multihop session config. Required when peeringKind is MultihopLabeledVpn.")
  multihopLabeledVpnConfig?: MultihopLabeledVpnConfig;
}

@doc("Arista CloudVision controller-managed peering configuration for patch operations.")
@added(Versions.v2026_07_15_preview)
model PeeringAristaCloudVisionConfigPatch {
  @doc("ARM resource ID of the Uplink this peering uses.")
  uplinkResourceId?: armResourceIdentifier;

  @doc("BGP peering model. Selects which variant config bag applies.")
  peeringKind?: PeeringKind;

  @doc("Static routes for the peering.")
  staticRouteConfiguration?: PeeringStaticRouteConfiguration;

  @doc("Import route policy reference.")
  importRoutePolicy?: RoutePolicyReference;

  @doc("Export route policy reference.")
  exportRoutePolicy?: RoutePolicyReference;

  @doc("Per-VRF ingress ACL ARM resource ID.")
  ingressAclResourceId?: armResourceIdentifier;

  @doc("Per-VRF egress ACL ARM resource ID.")
  egressAclResourceId?: armResourceIdentifier;

  @doc("Override auto-generated configlet name.")
  configletName?: string;

  @doc("Override default device targeting.")
  deviceQuery?: string;

  @doc("Per-VRF sub-interface configuration. Required when peeringKind is VrfToVrf.")
  vrfToVrfConfig?: VrfToVrfConfigPatch;

  @doc("Per-VRF route targets. Required when peeringKind is LabeledVpn.")
  labeledVpnConfig?: LabeledVpnConfig;

  @doc("Per-VRF PE-to-PE multihop session config. Required when peeringKind is MultihopLabeledVpn.")
  multihopLabeledVpnConfig?: MultihopLabeledVpnConfigPatch;
}

@doc("Per-VRF sub-interface configuration.")
@added(Versions.v2026_07_15_preview)
model VrfToVrfConfig {
  @doc("Maximum transmission unit in bytes for the peering link. Defaults to 1500.")
  @minValue(1500)
  @maxValue(9000)
  mtu?: int32 = 1500;

  @doc("VLAN ID for the peering link.")
  @minValue(1)
  @maxValue(4094)
  vlanId?: int32;
}

@doc("Per-VRF sub-interface configuration for patch operations.")
@added(Versions.v2026_07_15_preview)
model VrfToVrfConfigPatch {
  @doc("Maximum transmission unit in bytes for the peering link.")
  @minValue(1500)
  @maxValue(9000)
  mtu?: int32;

  @doc("VLAN ID for the peering link.")
  @minValue(1)
  @maxValue(4094)
  vlanId?: int32;
}

@doc("Per-VRF route targets for labeled-VPN peering.")
@added(Versions.v2026_07_15_preview)
model LabeledVpnConfig {
  @doc("Route targets to import.")
  importRouteTargets?: string[];

  @doc("Route targets to export.")
  exportRouteTargets?: string[];
}

@doc("Per-VRF PE-to-PE session config for multihop labeled-VPN peering.")
@added(Versions.v2026_07_15_preview)
model MultihopLabeledVpnConfig {
  @doc("Loopback address of remote PE for multihop VPNv4.")
  remotePeAddress?: string;

  @doc("ASN of the remote PE.")
  @minValue(1)
  @maxValue(4294967295)
  remotePeAsn?: int64;

  @doc("Directly-connected ASBR address for labeled-unicast session.")
  asbrPeerAddress?: string;

  @doc("ASN of the directly-connected ASBR.")
  @minValue(1)
  @maxValue(4294967295)
  asbrPeerAsn?: int64;

  @doc("TTL for the multihop VPNv4 session. Defaults to 5.")
  ebgpMultihop?: int32 = 5;

  @doc("Route targets to import.")
  importRouteTargets?: string[];

  @doc("Route targets to export.")
  exportRouteTargets?: string[];
}

@doc("Per-VRF PE-to-PE session config for multihop labeled-VPN peering patch operations.")
@added(Versions.v2026_07_15_preview)
model MultihopLabeledVpnConfigPatch {
  @doc("Loopback address of remote PE for multihop VPNv4.")
  remotePeAddress?: string;

  @doc("ASN of the remote PE.")
  @minValue(1)
  @maxValue(4294967295)
  remotePeAsn?: int64;

  @doc("Directly-connected ASBR address for labeled-unicast session.")
  asbrPeerAddress?: string;

  @doc("ASN of the directly-connected ASBR.")
  @minValue(1)
  @maxValue(4294967295)
  asbrPeerAsn?: int64;

  @doc("TTL for the multihop VPNv4 session.")
  ebgpMultihop?: int32;

  @doc("Route targets to import.")
  importRouteTargets?: string[];

  @doc("Route targets to export.")
  exportRouteTargets?: string[];
}

@doc("Static route configuration for the peering.")
@added(Versions.v2026_07_15_preview)
model PeeringStaticRouteConfiguration {
  @doc("IPv4 static routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv4Routes?: PeeringStaticRoute[];

  @doc("IPv6 static routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv6Routes?: PeeringStaticRoute[];
}

@doc("A single static route entry.")
@added(Versions.v2026_07_15_preview)
model PeeringStaticRoute {
  @doc("Destination CIDR prefix.")
  prefix?: string;

  @doc("Next-hop addresses.")
  nextHop?: string[];
}
