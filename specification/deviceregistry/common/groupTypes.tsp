namespace Microsoft.DeviceRegistry;

/** The type of group. */
union GroupType {
  string,

  /** A group of devices. */
  Device: "Device",
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
}

/** Common group properties shared across data-plane and control-plane. */
model GroupPropertiesBase {
  /** Globally unique, immutable, non-reusable ID. */
  @visibility(Lifecycle.Read)
  uuid?: string;

  /** Human-readable description of the group. */
  description?: string;

  /** Human-readable display name for the group. */
  displayName?: string;

  /** The type of group that determines what kind of resources can be members. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  groupType: GroupType;

  /** A timestamp indicating the last time the group membership was refreshed. */
  @visibility(Lifecycle.Read)
  lastMembershipRefreshTime?: utcDateTime;

  /** The membership state of the group. */
  @visibility(Lifecycle.Read)
  membershipState?: GroupMembershipState;

  /** The query string used to determine group membership. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  query: string;
}
