import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;

@doc("Represents a devcenter encryption set resource.")
@parentResource(DevCenter)
model DevCenterEncryptionSet
  is Azure.ResourceManager.TrackedResource<DevCenterEncryptionSetProperties> {
  ...ResourceNameParameter<
    Resource = DevCenterEncryptionSet,
    KeyName = "encryptionSetName",
    SegmentName = "encryptionSets",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-]{2,25}$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This is a valid property."
  @doc("Managed identity properties.")
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

@armResourceOperations
interface DevCenterEncryptionSets {
  @doc("Gets a devcenter encryption set.")
  get is ArmResourceRead<DevCenterEncryptionSet>;

  @doc("Creates or updates a devcenter encryption set resource.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DevCenterEncryptionSet>;

  @doc("Partially updates a devcenter encryption set.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DevCenterEncryptionSet,
    PatchModel = EncryptionSetUpdate,
    LroHeaders = ArmLroLocationHeader,
    Response = DevCenterEncryptionSet | ArmAcceptedLroResponse<
      "Resource update request accepted.",
      ArmLroLocationHeader<FinalResult = DevCenterEncryptionSet>
    >
  >;

  @doc("Deletes a devcenter encryption set.")
  delete is ArmResourceDeleteWithoutOkAsync<
    DevCenterEncryptionSet,
    LroHeaders = ArmLroLocationHeader
  >;

  @doc("Lists all encryption sets in the devcenter.")
  list is ArmResourceListByParent<
    DevCenterEncryptionSet,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = EncryptionSetListResult
  >;
}

@@maxLength(DevCenterEncryptionSet.name, 63);
@@minLength(DevCenterEncryptionSet.name, 3);
@@doc(DevCenterEncryptionSet.name, "The name of the devcenter encryption set.");
@@doc(DevCenterEncryptionSet.properties,
  "Properties of a devcenter encryption set."
);
@@doc(DevCenterEncryptionSets.createOrUpdate::parameters.resource,
  "Represents a devcenter encryption set."
);
@@doc(DevCenterEncryptionSets.update::parameters.properties,
  "Updatable devcenter encryption set properties."
);
