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
/**
 * Default rollout definition.
 */
@parentResource(ProviderRegistration)
model DefaultRollout is ProxyResource<DefaultRolloutProperties> {
  /**
   * The rollout name.
   */
  @path
  @key("rolloutName")
  @segment("defaultRollouts")
  name: string;
}

@armResourceOperations
interface DefaultRollouts {
  /**
   * Gets the default rollout details.
   */
  get is ArmResourceRead<DefaultRollout>;

  /**
   * Creates or updates the rollout details.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DefaultRollout,
    BaseParameters<DefaultRollout>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes the rollout resource. Rollout must be in terminal state.
   */
  delete is ArmResourceDeleteSync<DefaultRollout>;

  /**
   * Gets the list of the rollouts for the given provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DefaultRollouts_ListByProviderRegistration")
  listByProviderRegistration is ArmResourceListByParent<DefaultRollout>;

  /**
   * Stops or cancels the rollout, if in progress.
   */
  stop is ArmResourceActionSync<DefaultRollout, void, void>;
}

@@projectedName(DefaultRollouts.createOrUpdate::parameters.resource,
  "json",
  "properties"
);
@@extension(DefaultRollouts.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "properties"
);
@@doc(DefaultRollouts.createOrUpdate::parameters.resource,
  "The Default rollout properties supplied to the CreateOrUpdate operation."
);
