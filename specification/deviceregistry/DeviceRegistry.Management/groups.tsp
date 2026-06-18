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
using Azure.Core;

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
model RefreshGroupMembersResult is ArmOperationStatus {
  @doc("The total count of members in the group after the refresh.")
  @visibility(Lifecycle.Read)
  totalMemberCount?: int64;

  @doc("The count of members added during the refresh.")
  @visibility(Lifecycle.Read)
  membersAddedCount?: int64;

  @doc("The count of members removed during the refresh.")
  @visibility(Lifecycle.Read)
  membersRemovedCount?: int64;

  @doc("The count of members that failed to be processed during the refresh.")
  @visibility(Lifecycle.Read)
  membersFailedCount?: int64;

  @doc("The timestamp of the last successful refresh.")
  @visibility(Lifecycle.Read)
  lastRefreshTimestamp?: utcDateTime;
}
 
alias RefreshMembersLroHeaders =
  Azure.Core.Foundations.RetryAfterHeader &
  ArmCombinedLroHeaders<FinalResult = RefreshGroupMembersResult>;

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
  @useFinalStateVia("azure-async-operation")
  refreshMembers is ArmResourceActionNoResponseContentAsync<
    Resource = Group,
    Request = void, 
    LroHeaders = RefreshMembersLroHeaders
  >;

  @doc("Returns the current count of members of this group.")
  getCurrentMemberCount is ArmResourceActionSync<
    Group,
    void,
    GroupMemberCountResponse
  >;
}
