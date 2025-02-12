import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models/GroupProperties.tsp";
import "./UpdateAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DeviceUpdate;
/**
 * Device Update Group details.
 */
@parentResource(UpdateAccount)
model Group is Azure.ResourceManager.TrackedResource<GroupProperties> {
  ...ResourceNameParameter<
    Resource = Group,
    KeyName = "groupName",
    SegmentName = "groups",
    NamePattern = "^[a-zA-Z0-9-._~]*$"
  >;
}

@armResourceOperations
interface Groups {
  /**
   * Returns Groups details.
   */
  get is ArmResourceRead<Group>;

  /**
   * Creates or updates a Group.
   */
  create is ArmResourceCreateOrReplaceSync<Group>;

  /**
   * Updates Group.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<Group, TagUpdate>;

  /**
   * Delete Group.
   */
  delete is ArmResourceDeleteSync<Group>;

  /**
   * Returns subgroups for the given group.
   */
  listByUpdateAccount is ArmResourceListByParent<Group>;
}

@@maxLength(Group.name, 255);
@@minLength(Group.name, 1);
@@doc(Group.name, "Group Name");
@@doc(Groups.create::parameters.resource, "Group details.");
@@doc(Groups.update::parameters.properties, "Updated tags.");

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(Groups.create::parameters.resource, "application/json", "group");
@@clientName(Groups.create::parameters.resource, "group");

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(Groups.update::parameters.properties,
  "application/json",
  "tagUpdatePayload"
);
@@clientName(Groups.update::parameters.properties, "tagUpdatePayload");
