import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";
import "../common/groupTypes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@added(Versions.v2026_11_02_preview)
@parentResource(Namespace)
@doc("A flexible grouping mechanism that allows devices to be grouped by their property values.")
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

@@added(GroupType, Versions.v2026_11_02_preview);
@@added(GroupMembershipState, Versions.v2026_11_02_preview);
@@added(GroupPropertiesBase, Versions.v2026_11_02_preview);

@added(Versions.v2026_11_02_preview)
@doc("The group properties.")
model GroupProperties {
  ...GroupPropertiesBase;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_11_02_preview)
@doc("Response for the preview members operation.")
model GroupPreviewMembersResponse {
  @doc("A preview of member resource IDs.")
  members?: string[];
}

@added(Versions.v2026_11_02_preview)
@doc("Response for the get current member count operation.")
model GroupMemberCountResponse {
  @doc("The current count of members in the group.")
  count?: int64;
}

@added(Versions.v2026_11_02_preview)
@doc("The status of a refresh members operation.")
model GroupRefreshMembersOperationStatus {
  @doc("The unique ID of the operation.")
  id: string;

  @doc("The name of the operation.")
  name: string;

  @doc("The status of the operation.")
  status: string;

  @doc("The start time of the operation.")
  startTime?: utcDateTime;

  @doc("The end time of the operation.")
  endTime?: utcDateTime;

  @doc("Error object that describes the error when status is Failed.")
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;

  @doc("The total count of members in the group after the refresh.")
  totalMemberCount?: int64;

  @doc("The count of members added during the refresh.")
  membersAddedCount?: int64;

  @doc("The count of members removed during the refresh.")
  membersRemovedCount?: int64;

  @doc("The count of members that failed to be processed during the refresh.")
  membersFailedCount?: int64;

  @doc("The timestamp of the last successful refresh.")
  lastRefreshTimestamp?: utcDateTime;
}

@added(Versions.v2026_11_02_preview)
@doc("The request parameters for getting the status of a refresh members operation.")
model GetRefreshMembersOperationsRequest {
  @doc("The operation ID.")
  operationId: string;
}

@added(Versions.v2026_11_02_preview)
@armResourceOperations
interface Groups {
  get is ArmResourceRead<Group>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<Group>;
  update is ArmResourcePatchAsync<Group, GroupProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Group>;
  listByNamespace is ArmResourceListByParent<Group>;

  @doc("Gets a stored preview of members that was determined during the last refresh.")
  previewMembers is ArmResourceActionSync<
    Group,
    void,
    GroupPreviewMembersResponse
  >;

  @doc("Refreshes the members of this group.")
  refreshMembers is ArmResourceActionNoResponseContentAsync<Group, void>;

  @doc("Returns the current count of members of this group.")
  getCurrentMemberCount is ArmResourceActionSync<
    Group,
    void,
    GroupMemberCountResponse
  >;

  @doc("Gets the status of a refresh members operation.")
  getRefreshMembersOperations is ArmResourceActionSync<
    Group,
    GetRefreshMembersOperationsRequest,
    GroupRefreshMembersOperationStatus
  >;
}
