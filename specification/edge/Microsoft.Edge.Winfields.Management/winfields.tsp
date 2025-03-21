import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Edge;
@doc("Winfield resource.")
model Winfield is TrackedResource<WinfieldProperties> {
  @doc("Name of the resource")
  @path
  @key("name")
  @segment("winfields")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$")
  name: string;
}

@armResourceOperations
interface Winfields
  extends Azure.ResourceManager.TrackedResourceOperations<
      Winfield,
      WinfieldProperties
    > {
  get is ArmResourceRead<Winfield>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Winfield>;
  delete is ArmResourceDeleteWithoutOkAsync<Winfield>;
  @doc("get deployment manifest.")
  listDeploymentManifest is ArmResourceActionSync<
    Winfield,
    void,
    ArmResponse<WinfieldDeploymentManifest> | ErrorResponse
  >;
}
