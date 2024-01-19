import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProviderRegistration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ProviderHub;
@doc("Rollout details.")
@parentResource(ProviderRegistration)
model CustomRollout is ProxyResource<CustomRolloutProperties> {
  @doc("The rollout name.")
  @path
  @key("rolloutName")
  @segment("customRollouts")
  name: string;
}

@armResourceOperations
interface CustomRollouts {
  @doc("Gets the custom rollout details.")
  get is ArmResourceRead<CustomRollout>;

  @doc("Creates or updates the rollout details.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<CustomRollout>;

  @doc("Gets the list of the custom rollouts for the given provider.")
  listByProviderRegistration is ArmResourceListByParent<CustomRollout>;
}

@@projectedName(CustomRollouts.createOrUpdate::parameters.resource,
  "json",
  "properties"
);
@@extension(CustomRollouts.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "properties"
);
@@doc(CustomRollouts.createOrUpdate::parameters.resource,
  "The custom rollout properties supplied to the CreateOrUpdate operation."
);
