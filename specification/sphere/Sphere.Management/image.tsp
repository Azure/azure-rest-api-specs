import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./catalog.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureSphere;
/**
 * An image resource belonging to a catalog resource.
 */
@parentResource(Catalog)
model Image is ProxyResource<ImageProperties> {
  /**
   * Image name. Use an image GUID for GA versions of the API.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "existing api"
  @path
  @key("imageName")
  @segment("images")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface Images {
  /**
   * Get a Image
   */
  get is ArmResourceRead<Image>;

  /**
   * Create a Image
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Image>;

  /**
   * Delete a Image
   */
  #suppress "deprecated" "For backward compatible"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatible"
  delete is ArmResourceDeleteAsync<Image>;

  /**
   * List Image resources by Catalog
   */
  listByCatalog is ArmResourceListByParent<
    Image,
    {
      ...BaseParameters<Image>;
      ...CustomFilterQueryParameter;
      ...CustomTopQueryParameter;
      ...CustomSkipQueryParameter;
      ...CustomMaxPageSizeQueryParameter;
    }
  >;
}
