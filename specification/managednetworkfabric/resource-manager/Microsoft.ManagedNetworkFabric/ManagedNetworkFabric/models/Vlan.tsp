import "./common.tsp";

using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;

@doc("Per-resource operator policy: whether the operator actively manages the object or only observes it.")
@added(Versions.v2026_07_15_preview)
union ManagementPolicy {
  string,

  @doc("The operator configures and reconciles the object on the devices.")
  manage: "Manage",

  @doc("The operator only reads and reports state; it makes no changes.")
  observe: "Observe",
}

@doc("Controller hydration provenance for resources discovered from an external SDN controller. Present only on read-only, controller-hydrated (system-managed) resources so ARM state can be traced back to its source controller object.")
@added(Versions.v2026_07_15_preview)
model HydrationSource {
  @doc("Controller endpoint that supplied the hydrated resource.")
  @visibility(Lifecycle.Read)
  controllerEndpoint?: url;

  @doc("Controller-native object identifier for the hydrated resource, used to correlate ARM state with the source controller object.")
  @visibility(Lifecycle.Read)
  controllerObjectId?: string;

  @doc("Time the controller source was last synchronized, used to judge freshness of the hydrated read-only ARM state.")
  @visibility(Lifecycle.Read)
  lastSyncTime?: utcDateTime;
}

@doc("Vlan runtime health.")
@added(Versions.v2026_07_15_preview)
union VlanOperationalState {
  string,

  @doc("The VLAN is operational on all participating devices.")
  up: "Up",

  @doc("The VLAN is not operational.")
  down: "Down",

  @doc("The VLAN is operational on a subset of participating devices.")
  degraded: "Degraded",
}

@doc("Properties of a Vlan resource. Vlans declare an L2 segment in the fabric. In controller-managed mode, system-managed Vlans are auto-hydrated as read-only. The vlanId is immutable after creation.")
@added(Versions.v2026_07_15_preview)
model VlanProperties {
  @doc("Free-text description. Max 1024 characters.")
  @added(Versions.v2026_07_15_preview)
  @maxLength(1024)
  description?: string;

  @doc("IEEE 802.1Q VLAN identifier (1-4094). Immutable after creation.")
  @minValue(1)
  @maxValue(4094)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vlanId: int32;

  @doc("Maximum transmission unit in bytes (1500-9000). Defaults to 1500.")
  @minValue(1500)
  @maxValue(9000)
  mtu?: int32 = 1500;

  @doc("Operator management policy; defaults to Observe. Manage lets the operator configure the VLAN on devices; Observe reports state only.")
  managementPolicy?: ManagementPolicy = ManagementPolicy.observe;

  @doc("True when this Vlan was auto-created by controller hydration (system-managed, read-only).")
  @visibility(Lifecycle.Read)
  systemManaged?: BooleanEnumProperty;

  @doc("Service-populated ARM provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Administrative state; defaults to Enabled.")
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;

  @doc("Aggregated operational state across all participating devices.")
  @visibility(Lifecycle.Read)
  operationalState?: VlanOperationalState;

  @doc("Configuration state from the operator.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;
}

@doc("Vlan patchable properties.")
@added(Versions.v2026_07_15_preview)
model VlanPatchableProperties {
  @doc("Free-text description. Max 1024 characters.")
  @maxLength(1024)
  description?: string;

  @doc("Maximum transmission unit in bytes (1500-9000).")
  @minValue(1500)
  @maxValue(9000)
  mtu?: int32;

  @doc("Operator management policy.")
  managementPolicy?: ManagementPolicy;
}

@doc("The Vlan patch resource definition.")
@added(Versions.v2026_07_15_preview)
model VlanPatch {
  ...TagsUpdate;

  @doc("Vlan patchable properties.")
  properties?: VlanPatchableProperties;
}
