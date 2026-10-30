import "./common.tsp";
import "./Vlan.tsp";

using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;

@doc("VRF peering kind: how the VRF interconnects with other routing domains.")
@added(Versions.v2026_07_15_preview)
union PeeringKind {
  string,

  @doc("Direct VRF-to-VRF peering.")
  vrfToVrf: "VrfToVrf",

  @doc("Single-hop labeled (MPLS) VPN peering.")
  labeledVpn: "LabeledVpn",

  @doc("Multi-hop labeled (MPLS) VPN peering.")
  multihopLabeledVpn: "MultihopLabeledVpn",
}

@doc("Vrf runtime health.")
@added(Versions.v2026_07_15_preview)
union VrfOperationalState {
  string,

  @doc("The VRF is operational on all participating devices.")
  up: "Up",

  @doc("The VRF is not operational.")
  down: "Down",

  @doc("The VRF is operational on a subset of participating devices.")
  degraded: "Degraded",
}

@doc("Portable lifecycle purpose for a VRF.")
@added(Versions.v2026_07_15_preview)
union VrfPurpose {
  string,

  @doc("A routing domain that hosts tenant workload segments.")
  workload: "Workload",

  @doc("A routing domain that backs managed public egress services.")
  managedNatServices: "ManagedNatServices",
}

@doc("Portable east-west segmentation posture for a workload VRF.")
@added(Versions.v2026_07_15_preview)
union SegmentationPosture {
  string,

  @doc("Allow communication among workload endpoint groups within the VRF.")
  allowWithinVrf: "AllowWithinVrf",
}

@doc("A single aggregate route entry (CIDR prefix).")
@added(Versions.v2026_07_15_preview)
model VrfAggregateRoute {
  @doc("CIDR prefix to aggregate.")
  prefix: string;
}

@doc("Aggregate route summarization configuration for a VRF.")
@added(Versions.v2026_07_15_preview)
model VrfAggregateRouteConfiguration {
  @doc("IPv4 aggregate routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv4Routes?: VrfAggregateRoute[];

  @doc("IPv6 aggregate routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv6Routes?: VrfAggregateRoute[];
}

@doc("Properties of a Vrf - an isolated L3 routing domain rooted in a Fabric. In controller-managed mode a Vrf may be hydrated read-only from the controller.")
@added(Versions.v2026_07_15_preview)
model VrfProperties {
  @doc("Free-text description. Max 1024 characters.")
  @added(Versions.v2026_07_15_preview)
  @maxLength(1024)
  description?: string;

  @doc("How this VRF interconnects with other routing domains. Defaults to VrfToVrf.")
  peeringKind?: PeeringKind = PeeringKind.vrfToVrf;

  @doc("Lifecycle purpose for this routing domain.")
  purpose?: VrfPurpose;

  @doc("East-west segmentation posture. Applies when purpose is Workload.")
  segmentationPosture?: SegmentationPosture;

  @doc("Whether to redistribute connected subnets into the VRF routing table. Defaults to True.")
  redistributeConnectedSubnets?: BooleanEnumProperty = BooleanEnumProperty.True;

  @doc("Whether to redistribute static routes into the VRF routing table. Defaults to False.")
  redistributeStaticRoutes?: BooleanEnumProperty = BooleanEnumProperty.False;

  @doc("Aggregate route summarization configuration.")
  aggregateRouteConfiguration?: VrfAggregateRouteConfiguration;

  @doc("Operator management policy; defaults to Observe. Only applicable in controller-managed mode.")
  managementPolicy?: ManagementPolicy = ManagementPolicy.observe;

  @doc("Service-populated ARM provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Controller provenance for a hydrated Vrf, used to trace read-only ARM state back to the source controller object.")
  @visibility(Lifecycle.Read)
  hydrationSource?: HydrationSource;

  @doc("Administrative state; defaults to Enabled.")
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;

  @doc("Aggregated operational state across all participating devices.")
  @visibility(Lifecycle.Read)
  operationalState?: VrfOperationalState;

  @doc("Configuration state from the operator.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  @doc("ARM resource IDs of child Network resources.")
  @visibility(Lifecycle.Read)
  networks?: Azure.Core.armResourceIdentifier[];

  @doc("ARM resource IDs of child Peering resources.")
  @visibility(Lifecycle.Read)
  peerings?: Azure.Core.armResourceIdentifier[];
}

@doc("Vrf patchable properties.")
@added(Versions.v2026_07_15_preview)
model VrfPatchableProperties {
  @doc("Free-text description. Max 1024 characters.")
  @maxLength(1024)
  description?: string;

  @doc("How this VRF interconnects with other routing domains.")
  peeringKind?: PeeringKind;

  @doc("Lifecycle purpose for this routing domain.")
  purpose?: VrfPurpose;

  @doc("East-west segmentation posture. Applies when purpose is Workload.")
  segmentationPosture?: SegmentationPosture;

  @doc("Whether to redistribute connected subnets into the VRF routing table.")
  redistributeConnectedSubnets?: BooleanEnumProperty;

  @doc("Whether to redistribute static routes into the VRF routing table.")
  redistributeStaticRoutes?: BooleanEnumProperty;

  @doc("Aggregate route summarization configuration.")
  aggregateRouteConfiguration?: VrfAggregateRouteConfiguration;

  @doc("Operator management policy.")
  managementPolicy?: ManagementPolicy;
}

@doc("The Vrf patch resource definition.")
@added(Versions.v2026_07_15_preview)
model VrfPatch {
  ...TagsUpdate;

  @doc("Vrf patchable properties.")
  properties?: VrfPatchableProperties;
}
