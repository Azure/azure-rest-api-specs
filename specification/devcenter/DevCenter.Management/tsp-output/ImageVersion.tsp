import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Image.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
/**
 * Represents an image version.
 */
@parentResource(Image)
model ImageVersion is ProxyResource<ImageVersionProperties> {
  /**
   * The version of the image.
   */
  @path
  @key("versionName")
  @segment("versions")
  name: string;
}

@armResourceOperations
interface ImageVersions {
  /**
   * Gets an image version.
   */
  get is ArmResourceRead<ImageVersion>;

  /**
   * Lists versions for an image.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ImageVersions_ListByImage")
  listByImage is ArmResourceListByParent<ImageVersion>;
}
