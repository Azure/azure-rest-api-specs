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
@doc("Holds the release information of a disconnected operations image.")
@parentResource(DisconnectedOperation)
model Image is ProxyResource<ImageProperties> {
  ...ResourceNameParameter<Image>;
}

@armResourceOperations
interface Images {
  @doc("List by disconnected operation.")
  listByDisconnectedOperation is ArmResourceListByParent<
    Image,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Image> & {
      ...FilterQueryParameter;
      ...TopQueryParameter;
      ...SkipQueryParameter;
    }
  >;

  @doc("Get the resource.")
  get is ArmResourceRead<Image>;

  @doc("Get the URI to download the image.")
  listDownloadUri is ArmResourceActionSync<
    Image,
    void,
    ArmResponse<ImageDownloadResult> | ErrorResponse
  >;
}
