import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "../common/groupTypes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Group resource
// Shared types (GroupType, GroupMembershipState) are defined
// in specification/deviceregistry/common/groupTypes.tsp.
// ──────────────────────────────────────────────

/** A group resource. */
@resource("groups")
@parentResource(Namespace)
model Group {
  ...DataPlaneResourceBase;

  /** The resource-specific properties for this group. */
  properties?: GroupProperties;
}

@@key(Group.name, "groupName");

/** Properties of a group resource. */
model GroupProperties {
  ...OmitProperties<GroupPropertiesBase, "uuid">;

  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

// ──────────────────────────────────────────────
// Group operation models
// ──────────────────────────────────────────────

/** Request for looking up a group by its UUID. */
model GetGroupByUuidRequest {
  /** The unique identifier of the group. */
  @query
  groupUuid: string;
}

/** Request for looking up a device's groups. */
model GetGroupsForDeviceRequest {
  /** The unique identifier of the device. */
  @query
  deviceUuid: string;
}

/** A reference to a group that a device belongs to. */
model GroupReference {
  /** The unique identifier of the group. */
  groupUuid: string;
}

/** Result of querying group memberships for a device. */
model GetGroupsForDeviceResult {
  ...DataPlaneResourceBase;

  /** The groups that this device belongs to. */
  groups: GroupReference[];
}

// ──────────────────────────────────────────────
// Groups interface
// ──────────────────────────────────────────────

/** Operations on groups within a namespace. */
@tag("Groups")
interface Groups {
  /** Look up a group by its unique identifier. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  getGroupByUuid is ResourceOperations.ResourceCollectionAction<
    Group,
    GetGroupByUuidRequest,
    Group
  >;

  /** Returns the groups that a device belongs to. */
  @added(Versions.v2026_11_01_preview)
  getGroupsForDevice is ResourceOperations.ResourceCollectionAction<
    Group,
    GetGroupsForDeviceRequest,
    GetGroupsForDeviceResult
  >;
}
