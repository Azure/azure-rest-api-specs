import "../../DataModels/Recommendation/ContainerAppEnvironment.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("ARM model of ACA Container App Environment.")
@parentResource(ACAAssessment)
model ACAContainerAppEnvironment
  is ProxyResource<ACAContainerAppEnvironmentProperties> {
  @doc("ACA Container App Environment Name.")
  @segment("containerAppEnvironments")
  @key("containerAppEnvironmentName")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  @visibility(Lifecycle.Read)
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("ARM model of ACA Container App Environment Properties.")
model ACAContainerAppEnvironmentProperties is ContainerAppEnvironment;
