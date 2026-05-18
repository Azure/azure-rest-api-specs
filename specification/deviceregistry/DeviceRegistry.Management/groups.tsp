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
  listByNamespace is ArmResourceListByParent<Group>;

  @doc("Gets a stored sample of members that was determined during the last refresh.")
  getSampleOfMembers is ArmResourceActionSync<
    Group,
    void,
    GroupSampleOfMembersResponse
  >;

  @doc("Refreshes the members of this group.")
  refreshMembers is ArmResourceActionNoResponseContentAsync<Group, void>;

  @doc("Returns the current count of members of this group.")
  getCurrentMemberCount is ArmResourceActionSync<
    Group,
    void,
    GroupMemberCountResponse
  >;
}
