import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Group resource
// NOTE: GroupProperties is aligned with the control plane GroupProperties model
// in specification/deviceregistry/DeviceRegistry.Management/groups.tsp.
// Keep in sync when making changes.
// ──────────────────────────────────────────────

/** A group resource. */
@resource("groups")
@parentResource(Namespace)
model Group {
  ...DataPlaneResourceBase;

  /** The unique identifier of the group. */
  @key("groupUuid")
  @visibility(Lifecycle.Read)
  groupUuid: string;

  /** The resource-specific properties for this group. */
  properties?: GroupProperties;
}

/** Properties of a group resource. */
model GroupProperties {
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

  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

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

// ──────────────────────────────────────────────
// Group operation models
// ──────────────────────────────────────────────

/** Request body for looking up a group by its UUID. */
model GetGroupByUuidRequest {
  /** The unique identifier of the group. */
  groupUuid: string;
}

// ──────────────────────────────────────────────
// Groups interface
// ──────────────────────────────────────────────

/** Operations on groups within a namespace. */
@tag("Groups")
interface Groups {
  /** Look up a group by its unique identifier. */
  getGroupByUuid is ResourceOperations.ResourceCollectionAction<
    Group,
    GetGroupByUuidRequest,
    Group
  >;
}
