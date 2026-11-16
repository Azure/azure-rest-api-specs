import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.SaaS;

@armResourceOperations
interface SaasSubscriptionLevel {
  /** Gets a SaaS resource by its name. */
  get is ArmResourceRead<
    SaasResource,
    Parameters = ExpandCustomerDataQueryParameter
  >;

  /** Creates or updates a SaaS resource. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SaasResource>;

  /** Updates mutable properties or tags on an existing SaaS resource. */
  update is ArmCustomPatchAsync<SaasResource, SaasResourceUpdate>;

  /** Deletes a SaaS resource. */
  delete is ArmResourceDeleteWithoutOkAsync<SaasResource>;

  /** Lists all SaaS resources within a resource group. */
  listByResourceGroup is ArmResourceListByParent<SaasResource>;

  /** Generates a publisher access token for a SaaS resource. */
  listAccessToken is ArmResourceActionSync<
    SaasResource,
    void,
    AccessTokenResult
  >;

  /** Unsubscribes from a SaaS subscription, optionally providing a reason and feedback. The resource remains in Azure but the subscription is cancelled. */
  unsubscribe is ArmResourceActionAsync<
    SaasResource,
    UnsubscribeOptions,
    SaasResource
  >;

  /** Validates a proposed update to an existing SaaS resource without modifying the resource. */
  @action("validate")
  validateUpdate is ArmResourceActionSync<
    SaasResource,
    SaasResourceUpdate,
    ResourceValidationResult
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Subscription-level and pre-creation purchase validation operations not scoped to a single resource instance."
interface SaasSubscriptionLevelGlobal {
  /** Lists all SaaS resources within an Azure subscription. */
  listByAzureSubscription is ArmListBySubscription<SaasResource>;

  /** Checks whether a proposed SaaS resource name is available. */
  checkNameAvailability is checkGlobalNameAvailability;

  /** Validates a proposed SaaS purchase within a resource group without creating the resource. */
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SaaS/resources/validate")
  validatePurchase(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /** The proposed purchase request to validate. */
    @bodyRoot
    body: SaasPurchaseValidationRequest,
  ): ArmResponse<ResourceValidationResult> | ErrorResponse;

  /** Validates a proposed SaaS purchase at subscription scope before a resource group is selected. */
  @post
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.SaaS/resources/validate")
  validatePurchaseBySubscription(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /** The proposed purchase request to validate. */
    @bodyRoot
    body: SaasPurchaseValidationRequest,
  ): ArmResponse<ResourceValidationResult> | ErrorResponse;
}
