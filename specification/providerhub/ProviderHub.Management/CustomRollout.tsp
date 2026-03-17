import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProviderRegistration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ProviderHub;

@parentResource(ProviderRegistration)
model CustomRollout
  is Azure.ResourceManager.ProxyResource<CustomRolloutProperties, false> {
  ...ResourceNameParameter<
    Resource = CustomRollout,
    KeyName = "rolloutName",
    SegmentName = "customRollouts",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

@armResourceOperations
interface CustomRollouts {
  /**
   * Gets the custom rollout details.
   */
  get is ArmResourceRead<CustomRollout>;

  /**
   * Creates or updates the rollout details.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CustomRollout>;

  /**
   * Deletes the custom rollout resource. Custom rollout must be in terminal state.
   */
  delete is ArmResourceDeleteSync<CustomRollout>;

  /**
   * Gets the list of the custom rollouts for the given provider.
   */
  listByProviderRegistration is ArmResourceListByParent<
    CustomRollout,
    Response = ArmResponse<CustomRolloutArrayResponseWithContinuation>
  >;

  /**
   * Stops or cancels the custom rollout, if in progress.
   */
  stop is ArmResourceActionSync<CustomRollout, void, OkResponse>;
}

@@maxLength(CustomRollout.name, 260);
@@doc(CustomRollout.name, "The rollout name.");
@@doc(CustomRollout.properties, "Properties of the rollout.");
@@doc(CustomRollouts.createOrUpdate::parameters.resource,
  "The custom rollout properties supplied to the CreateOrUpdate operation."
);
