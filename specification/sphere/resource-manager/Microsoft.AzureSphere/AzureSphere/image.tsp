using TypeSpec.Rest;
using Azure.ResourceManager;
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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Image,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

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
      ...Azure.ResourceManager.Foundations.BaseParameters<Image>;
      ...CustomFilterQueryParameter;
      ...CustomTopQueryParameter;
      ...CustomSkipQueryParameter;
      ...CustomMaxPageSizeQueryParameter;
    }
  >;
}
