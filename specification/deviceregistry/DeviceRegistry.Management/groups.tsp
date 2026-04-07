import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@added(Versions.v2026_11_02_preview)
@parentResource(Namespace)
@doc("A flexible grouping mechanism that allows devices or assets to be grouped by their property values.")
model Group is TrackedResource<GroupProperties> {
  @doc("The name of the group.")
  @key("groupName")
  @segment("groups")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(64)
  name: string;

  ...ManagedSystemAssignedIdentityProperty;
}

@added(Versions.v2026_11_02_preview)
@doc("The group properties.")
model GroupProperties {
  @doc("Globally unique, immutable, non-reusable ID.")
  @visibility(Lifecycle.Read)
  uuid?: string;

  @doc("Human-readable description of the group.")
  description?: string;

  @doc("Human-readable display name for the group.")
  displayName?: string;

  @doc("The refresh mode that determines how group membership is maintained.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  refreshMode: GroupRefreshMode;

  @doc("The type of group that determines what kind of resources can be members.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  groupType: GroupType;

  @doc("A timestamp (in UTC) indicating the last time the group membership was refreshed by resolving the query.")
  @visibility(Lifecycle.Read)
  lastMembershipRefreshTime?: utcDateTime;

  @doc("The membership state of the group.")
  @visibility(Lifecycle.Read)
  membershipState?: GroupMembershipState;

  @doc("The query string used to determine group membership. Defines the membership criteria and cannot be updated after creation.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  query: string;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_11_02_preview)
@doc("The refresh mode for a group.")
union GroupRefreshMode {
  string,

  @doc("Group membership is continuously refreshed.")
  Continuous: "Continuous",

  @doc("Group membership is manually refreshed.")
  Manual: "Manual",
}

@added(Versions.v2026_11_02_preview)
@doc("The type of resources that can be members of a group.")
union GroupType {
  string,

  @doc("The group contains device resources.")
  Device: "Device",

  @doc("The group contains asset resources.")
  Asset: "Asset",
}

@added(Versions.v2026_11_02_preview)
@doc("The membership state of a group.")
union GroupMembershipState {
  string,

  @doc("The group is being created.")
  Creating: "Creating",

  @doc("The group membership is being refreshed.")
  RefreshingMembers: "RefreshingMembers",

  @doc("The group membership is ready.")
  Ready: "Ready",
}

@added(Versions.v2026_11_02_preview)
@doc("Response for the get sample of members operation.")
model GroupSampleOfMembersResponse {
  @doc("A sample list of member resource IDs.")
  members?: string[];
}

@added(Versions.v2026_11_02_preview)
@doc("Response for the get current member count operation.")
model GroupMemberCountResponse {
  @doc("The current count of members in the group.")
  count?: int64;
}

@added(Versions.v2026_11_02_preview)
@armResourceOperations
interface Groups {
  get is ArmResourceRead<Group>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<Group>;
  update is ArmResourcePatchAsync<Group, GroupProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Group>;
  listByResourceGroup is ArmResourceListByParent<Group>;

  @doc("Gets a stored sample of members that was determined during the last refresh.")
  getSampleOfMembers is ArmResourceActionSync<
    Group,
    void,
    GroupSampleOfMembersResponse
  >;

  @doc("Refreshes the members of this group. Invalid for groups with Continuous refresh mode.")
  refreshMembers is ArmResourceActionNoResponseContentAsync<Group, void>;

  @doc("Returns the current count of members of this group. Invalid for groups with Continuous refresh mode.")
  getCurrentMemberCount is ArmResourceActionSync<
    Group,
    void,
    GroupMemberCountResponse
  >;
}
