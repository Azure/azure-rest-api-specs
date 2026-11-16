import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ProfessionalService;

@armResourceOperations
interface ProfessionalServiceSubscriptionLevel {
  /** Gets a Professional Service resource by its name. */
  get is ArmResourceRead<
    ProfessionalServiceResource,
    Parameters = ExpandCustomerDataQueryParameter
  >;

  /** Creates or updates a Professional Service resource. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ProfessionalServiceResource>;

  // Async because changes are propagated to downstream partner systems via Service Bus;
  // the RP cannot confirm success until the async event completes.
  /** Updates mutable properties or tags on an existing Professional Service resource. */
  update is ArmCustomPatchAsync<
    ProfessionalServiceResource,
    ProfessionalServiceResourceUpdate
  >;

  /** Deletes a Professional Service resource. */
  delete is ArmResourceDeleteWithoutOkAsync<ProfessionalServiceResource>;

  /** Lists all Professional Service resources within a resource group. */
  listByResourceGroup is ArmResourceListByParent<ProfessionalServiceResource>;

  // NOTE: No listAccessToken (GenerateToken) — not supported for Professional Services.
  /** Unsubscribes from a Professional Service subscription, optionally providing a reason and feedback. The resource remains in Azure but the subscription is cancelled. */
  unsubscribe is ArmResourceActionAsync<
    ProfessionalServiceResource,
    UnsubscribeOptions,
    ProfessionalServiceResource
  >;

  /** Validates a proposed update to an existing Professional Service resource without modifying the resource. */
  @action("validate")
  validateUpdate is ArmResourceActionSync<
    ProfessionalServiceResource,
    ProfessionalServiceResourceUpdate,
    ResourceValidationResult
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Subscription-level and pre-creation purchase validation operations not scoped to a single resource instance."
interface ProfessionalServiceSubscriptionLevelGlobal {
  /** Lists all Professional Service resources within an Azure subscription. */
  listByAzureSubscription is ArmListBySubscription<ProfessionalServiceResource>;

  /** Checks whether a proposed Professional Service resource name is available. */
  checkNameAvailability is checkGlobalNameAvailability;

  /** Validates a proposed Professional Service purchase within a resource group without creating the resource. */
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ProfessionalService/resources/validate")
  validatePurchase(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /** The proposed purchase request to validate. */
    @bodyRoot
    body: ProfessionalServicePurchaseValidationRequest,
  ): ArmResponse<ResourceValidationResult> | ErrorResponse;

  /** Validates a proposed Professional Service purchase at subscription scope before a resource group is selected. */
  @post
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProfessionalService/resources/validate")
  validatePurchaseBySubscription(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /** The proposed purchase request to validate. */
    @bodyRoot
    body: ProfessionalServicePurchaseValidationRequest,
  ): ArmResponse<ResourceValidationResult> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom operation status routes"
// Operation status is subscription-scoped by design. All LRO operations (including RG-scoped ones)
// return Azure-AsyncOperation headers pointing to this subscription-scope endpoint because operation
// state is tracked internally by subscription ID + operation ID, not by resource group.
interface ProfessionalServiceOperationStatuses {
  /** Gets the status of a long-running Professional Service operation at the subscription scope. All async operations, including resource-group-scoped ones, poll through this endpoint. */
  @get
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProfessionalService/operationStatuses/{operationId}")
  getSubscriptionOperationStatus(
    ...ApiVersionParameter,
    ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,
    ...Azure.ResourceManager.CommonTypes.OperationIdParameter,
  ):
    | ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult>
    | ErrorResponse;
}
