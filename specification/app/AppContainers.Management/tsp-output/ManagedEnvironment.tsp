import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

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
@projectedName("client", "ManagedEnvironmentsDiagnostics")
interface ManagedEnvironments_ManagedEnvironmentsDiagnostics {
  @doc("Get the properties of a Managed Environment used to host container apps.")
  getRoot is ArmResourceRead<ManagedEnvironment>;
}
