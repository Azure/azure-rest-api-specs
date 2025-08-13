import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./disconnectedOperations.tsp";
import "../Microsoft.Edge.Shared/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Edge;
@doc("Disconnected operations image resource.")
@parentResource(DisconnectedOperation)
model Image is ProxyResource<ImageProperties> {
  ...ResourceNameParameter<Image>;
}

@armResourceOperations
interface Images {
  @doc("List by parent")
  @removed(Microsoft.Edge.Versions.v2025_06_01)
  listByParent is ArmResourceListByParent<
    Image,
    {
      ...ApiVersionParameter;
      ...FilterQueryParameter;
      ...TopQueryParameter;
      ...SkipQueryParameter;
    }
  >;

  @doc("List by parent")
  listAll is ArmResourceListByParent<
    Image,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Image> & {
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
    ArmResponse<ImageDownloadResult> | ErrorResponse
  >;
}
