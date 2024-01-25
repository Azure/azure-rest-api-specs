import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LabPlan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.LabServices;
/**
 * Lab services virtual machine image
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(LabPlan)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ImageProperties)
model Image extends ProxyResourceBase {
  /**
   * The image name.
   */
  @maxLength(100)
  @minLength(1)
  @pattern("^[-\\w\\\\._\\\\(\\\\)]+$")
  @path
  @key("imageName")
  @segment("images")
  @visibility("read")
  name: string;

  /**
   * Image resource properties
   */
  @extension("x-ms-client-flatten", true)
  properties: ImageProperties;
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
  createOrUpdate is ArmResourceCreateOrReplaceSync<Image>;

  /**
   * Updates an image resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Image, ImageUpdate>;

  /**
   * Gets all images from galleries attached to a lab plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Images_ListByLabPlan")
  listByLabPlan is ArmResourceListByParent<
    Image,
    {
      ...BaseParameters<Image>;

      /**
       * The filter to apply to the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@projectedName(Images.createOrUpdate::parameters.resource, "json", "body");
@@extension(Images.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(Images.createOrUpdate::parameters.resource, "The request body.");
@@projectedName(Images.update::parameters.properties, "json", "body");
@@extension(Images.update::parameters.properties, "x-ms-client-name", "body");
@@doc(Images.update::parameters.properties, "The request body.");
