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
@doc("Lab services virtual machine image")
@parentResource(LabPlan)
model Image is ProxyResource<ImageProperties> {
  @doc("The image name.")
  @maxLength(100)
  @minLength(1)
  @pattern("^[-\\w\\\\._\\\\(\\\\)]+$")
  @path
  @key("imageName")
  @segment("images")
  name: string;
}

@armResourceOperations
interface Images {
  @doc("Gets an image resource.")
  get is ArmResourceRead<Image>;

  @doc("Updates an image resource via PUT. Creating new resources via PUT will not function.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Image>;

  @doc("Updates an image resource.")
  update is ArmCustomPatchSync<Image, ImageUpdate>;

  @doc("Gets all images from galleries attached to a lab plan.")
  listByLabPlan is ArmResourceListByParent<
    Image,
    {
      ...BaseParameters<Image>;

      @doc("The filter to apply to the operation.")
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
