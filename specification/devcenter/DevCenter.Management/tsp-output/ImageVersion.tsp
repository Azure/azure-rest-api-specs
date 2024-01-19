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
@doc("Represents an image version.")
@parentResource(Image)
model ImageVersion is ProxyResource<ImageVersionProperties> {
  @doc("The version of the image.")
  @path
  @key("versionName")
  @segment("versions")
  name: string;
}

@armResourceOperations
interface ImageVersions {
  @doc("Gets an image version.")
  get is ArmResourceRead<ImageVersion>;

  @doc("Lists versions for an image.")
  listByImage is ArmResourceListByParent<ImageVersion>;
}
