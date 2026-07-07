import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureArcData;
/**
 * Data controller resource
 */
model DataControllerResource
  is Azure.ResourceManager.TrackedResource<DataControllerProperties, false> {
  ...ResourceNameParameter<
    Resource = DataControllerResource,
    KeyName = "dataControllerName",
    SegmentName = "dataControllers",
    NamePattern = ""
  >;

  /**
   * The extendedLocation of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface DataControllerResources {
  /**
   * Retrieves a dataController resource
   */
  getDataController is ArmResourceRead<DataControllerResource>;

  /**
   * Creates or replaces a dataController resource
   */
  putDataController is ArmResourceCreateOrReplaceAsync<DataControllerResource>;

  /**
   * Updates a dataController resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  patchDataController is ArmCustomPatchAsync<
    DataControllerResource,
    PatchModel = DataControllerUpdate,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = DataControllerResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a dataController resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteDataController is ArmResourceDeleteWithoutOkAsync<
    DataControllerResource,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * List dataController resources in the resource group
   */
  @summary("List dataController resources in the resource group")
  listInGroup is ArmResourceListByParent<
    DataControllerResource,
    Response = ArmResponse<PageOfDataControllerResource>
  >;

  /**
   * List dataController resources in the subscription
   */
  @summary("List dataController resources in the subscription")
  listInSubscription is ArmListBySubscription<
    DataControllerResource,
    Response = ArmResponse<PageOfDataControllerResource>
  >;
}

@@doc(DataControllerResource.name, "The name of the data controller");
@@doc(DataControllerResource.properties, "The data controller's properties");
@@doc(DataControllerResources.putDataController::parameters.resource, "desc");
@@doc(
  DataControllerResources.patchDataController::parameters.properties,
  "The update data controller resource"
);
