import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
@doc("Represents a devcenter resource.")
model DevCenter is Azure.ResourceManager.TrackedResource<DevCenterProperties> {
  ...ResourceNameParameter<
    Resource = DevCenter,
    KeyName = "devCenterName",
    SegmentName = "devcenters",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-]{2,25}$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This is a valid property."
  @doc("Managed identity properties.")
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

@armResourceOperations
interface DevCenters {
  @doc("Gets a devcenter.")
  get is ArmResourceRead<DevCenter>;

  @doc("Creates or updates a devcenter resource.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DevCenter>;

  @doc("Partially updates a devcenter.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DevCenter,
    PatchModel = DevCenterUpdate,
    LroHeaders = ArmLroLocationHeader,
    Response = DevCenter | ArmAcceptedLroResponse<
      "Resource update request accepted.",
      ArmLroLocationHeader<FinalResult = DevCenter>
    >
  >;

  @doc("Deletes a devcenter.")
  delete is ArmResourceDeleteWithoutOkAsync<
    DevCenter,
    LroHeaders = ArmLroLocationHeader
  >;

  @doc("Lists all devcenters in a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    DevCenter,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = DevCenterListResult
  >;

  @doc("Lists all devcenters in a subscription.")
  listBySubscription is ArmListBySubscription<
    DevCenter,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = DevCenterListResult
  >;

  @doc("Lists images for a devcenter.")
  @list
  @get
  @action("images")
  listByDevCenter is ArmResourceActionSync<
    DevCenter,
    void,
    Response = ImageListResult,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
}

@@maxLength(DevCenter.name, 26);
@@minLength(DevCenter.name, 3);
@@doc(DevCenter.name, "The name of the devcenter.");
@@doc(DevCenter.properties, "DevCenter properties");
@@doc(DevCenters.createOrUpdate::parameters.resource,
  "Represents a devcenter."
);
@@doc(DevCenters.update::parameters.properties,
  "Updatable devcenter properties."
);
