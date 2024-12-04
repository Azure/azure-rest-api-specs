import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./winfields.tsp";
import "../Microsoft.Edge.Shared/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Edge;
@doc("Winfield image resource.")
@parentResource(Winfield)
model Image is ProxyResource<ImageProperties> {
  ...ResourceNameParameter<Image>;
}

@armResourceOperations
interface Images {
  @doc("List by parent")
  listByParent is ArmResourceListByParent<
    Image,
    {
      ...ApiVersionParameter;
      ...FilterQueryParameter;
      ...TopQueryParameter;
      ...SkipQueryParameter;
    }
  >;

  @doc("Get the resource")
  get is ArmResourceRead<Image>;

  @doc("get deployment manifest.")
  listDownloadUri is ArmResourceActionSync<
    Image,
    void,
    ArmResponse<ImageDownloadResponse> | ErrorResponse
  >;
}
