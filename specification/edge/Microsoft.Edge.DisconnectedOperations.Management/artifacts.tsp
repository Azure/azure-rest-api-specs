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
@doc("Disconnected operations artifact resource.")
@parentResource(Image)
model Artifact is ProxyResource<ArtifactProperties> {
  ...ResourceNameParameter<Artifact>;
}

@armResourceOperations
interface Artifacts {
  @doc("List by parent")
  listByParent is ArmResourceListByParent<Artifact>;

  @doc("Get the resource")
  get is ArmResourceRead<Artifact>;

  @doc("Get artifact download link.")
  listDownloadUri is ArmResourceActionSync<
    Artifact,
    void,
    ArmResponse<ArtifactDownloadResult> | ErrorResponse
  >;
}
