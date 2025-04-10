import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LabPlan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.LabServices;
/**
 * Lab services virtual machine image
 */
@parentResource(LabPlan)
model Image is Azure.ResourceManager.ProxyResource<ImageProperties, false> {
  ...ResourceNameParameter<
    Resource = Image,
    KeyName = "imageName",
    SegmentName = "images",
    NamePattern = "^[-\\w\\\\._\\\\(\\\\)]+$"
  >;
}

@armResourceOperations
interface Images {
  /**
   * Gets an image resource.
   */
  get is ArmResourceRead<Image>;

  /**
   * Updates an image resource via PUT. Creating new resources via PUT will not function.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Image,
    Response = ArmResourceUpdatedResponse<Image>
  >;

  /**
   * Updates an image resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Image, PatchModel = ImageUpdate>;

  /**
   * Gets all images from galleries attached to a lab plan.
   */
  listByLabPlan is ArmResourceListByParent<
    Image,
    Parameters = {
      /**
       * The filter to apply to the operation.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<PagedImages>
  >;
}

@@maxLength(Image.name, 100);
@@minLength(Image.name, 1);
@@doc(Image.name, "The image name.");
@@doc(Image.properties, "Image resource properties");
@@doc(Images.createOrUpdate::parameters.resource, "The request body.");
@@doc(Images.update::parameters.properties, "The request body.");
