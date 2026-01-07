import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models/GroupProperties.tsp";
import "./UpdateAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

@versioned(Versions)
namespace Microsoft.DeviceUpdate;
/**
 * Device Update Group details.
 */
@parentResource(UpdateAccount)
@added(Versions.v2025_05_01_preview)
model Group is Azure.ResourceManager.TrackedResource<GroupProperties> {
  ...ResourceNameParameter<
    Resource = Group,
    KeyName = "groupName",
    SegmentName = "groups",
    NamePattern = "^[a-zA-Z0-9-._~]*$"
  >;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the Group.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2025_05_01_preview)
  extendedLocation?: ExtendedLocation;
}

@added(Versions.v2025_05_01_preview)
@armResourceOperations
interface Groups {
  /**
   * Returns Group's details.
   */
  get is ArmResourceRead<Group>;

  /**
   * Creates or updates a Group.
   */
  create is ArmResourceCreateOrReplaceSync<Group>;

  /**
   * Updates Group.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Group, TagUpdate>;

  /**
   * Delete Group.
   */
  delete is ArmResourceDeleteSync<Group>;

  /**
   * Returns Groups for the given account name.
   */
  listByUpdateAccount is ArmResourceListByParent<Group>;
}

@@maxLength(Group.name, 255);
@@minLength(Group.name, 1);
@@doc(Group.name, "Group Name");
@@doc(Groups.create::parameters.resource, "Group details.");
@@doc(Groups.update::parameters.properties, "Updated tags.");

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@clientName(Groups.create::parameters.resource, "group");

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(Groups.update::parameters.properties,
  "application/json",
  "tagUpdatePayload"
);
@@clientName(Groups.update::parameters.properties, "tagUpdatePayload");
