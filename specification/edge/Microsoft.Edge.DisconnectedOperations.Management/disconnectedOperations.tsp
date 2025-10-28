import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Edge;
@doc("Disconnected operation resource.")
model DisconnectedOperation
  is TrackedResource<DisconnectedOperationProperties> {
  @doc("Name of the resource")
  @path
  @key("name")
  @segment("disconnectedOperations")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$")
  name: string;
}

@armResourceOperations
interface DisconnectedOperations
  extends Azure.ResourceManager.TrackedResourceOperations<
      DisconnectedOperation,
      DisconnectedOperationProperties
    > {
  get is ArmResourceRead<DisconnectedOperation>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DisconnectedOperation>;
  delete is ArmResourceDeleteWithoutOkAsync<DisconnectedOperation>;
  @doc("get deployment manifest.")
  listDeploymentManifest is ArmResourceActionSync<
    DisconnectedOperation,
    void,
    ArmResponse<DisconnectedOperationDeploymentManifest> | ErrorResponse
  >;
}
