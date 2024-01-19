import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
@doc("An environment for hosting container apps")
@singleton("rootApi")
model ManagedEnvironment is TrackedResource<ManagedEnvironmentProperties> {
  @key("detectorProperty")
  @segment("detectorProperties")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ManagedEnvironments {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the properties of a Managed Environment used to host container apps.")
  @operationId("ManagedEnvironmentsDiagnostics_GetRoot")
  getRoot is ArmResourceRead<ManagedEnvironment>;
}
