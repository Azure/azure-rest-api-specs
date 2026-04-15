namespace Microsoft.DeviceRegistry;

/** The refresh mode for group membership. */
union GroupRefreshMode {
  string,

  /** Group membership is refreshed continuously. */
  Continuous: "Continuous",

  /** Group membership is refreshed manually. */
  Manual: "Manual",
}

/** The type of group. */
union GroupType {
  string,

  /** A group of devices. */
  Device: "Device",

  /** A group of assets. */
  Asset: "Asset",
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

  /** The refresh mode that determines how group membership is maintained. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  refreshMode: GroupRefreshMode;

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
