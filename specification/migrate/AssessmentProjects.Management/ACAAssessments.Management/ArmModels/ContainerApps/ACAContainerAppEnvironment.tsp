import "../../DataModels/Recommendation/ContainerAppEnvironment.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("ARM model of ACA Managed Environment.")
@parentResource(ACAAssessment)
model ACAManagedEnvironment is ProxyResource<ACAManagedEnvironmentProperties> {
  @doc("ACA Managed Environment Name.")
  @segment("managedEnvironments")
  @key("managedEnvironmentName")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  @visibility(Lifecycle.Read)
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("ARM model of ACA Managed Environment Properties.")
model ACAManagedEnvironmentProperties is ContainerAppEnvironment;
