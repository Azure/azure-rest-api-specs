import "./common.tsp";

namespace Microsoft.DeviceRegistry;

/** The type of group. */
union GroupType {
  string,

  /** A group of devices. */
  RegistryDevice: "RegistryDevice",
}

/** The membership state of a group. */
union GroupMembershipState {
  string,

  /** The group is being created. */
  Creating: "Creating",

  /** The group is refreshing its members. */
  RefreshingMembers: "RefreshingMembers",

  /** The group is ready. */
  Ready: "Ready",

  /** The group failed to resolve its members. */
  FailedToResolveMembers: "FailedToResolveMembers",
}

/** Common group properties shared across data-plane and control-plane. */
model GroupPropertiesBase {
  ...DisplayProperties;

  /** Globally unique, immutable, non-reusable ID. */
  @visibility(Lifecycle.Read)
  uuid?: string;

  /** The type of group that determines what kind of resources can be members. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  groupType: GroupType;

  /** A timestamp indicating the last time the group membership was refreshed. */
  @visibility(Lifecycle.Read)
  lastMembershipRefreshTime?: utcDateTime;

  /** The membership state of the group. */
  @visibility(Lifecycle.Read)
  membershipState?: GroupMembershipState;

  /** The filter string used to determine group membership. To define a group that contains all devices in the namespace, use \"*\". */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  queryFilter: string;
}
