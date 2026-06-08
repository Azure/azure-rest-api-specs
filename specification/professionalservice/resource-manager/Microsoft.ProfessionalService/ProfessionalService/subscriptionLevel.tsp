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
  get is ArmResourceRead<
    ProfessionalServiceResource,
    Parameters = ExpandCustomerDataQueryParameter
  >;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ProfessionalServiceResource>;
  // Async because changes are propagated to downstream partner systems via Service Bus;
  // the RP cannot confirm success until the async event completes.
  update is ArmCustomPatchAsync<
    ProfessionalServiceResource,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ProfessionalServiceResource,
      ProfessionalServiceResourceProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ProfessionalServiceResource>;
  listByResourceGroup is ArmResourceListByParent<
    ProfessionalServiceResource,
    Parameters = ExpandCustomerDataQueryParameter
  >;
  // NOTE: No listAccessToken (GenerateToken) — not supported for Professional Services.
  /** Unsubscribes from a Professional Service subscription, optionally providing a reason and feedback. The resource remains in Azure but the subscription is cancelled. */
  unsubscribe is ArmResourceActionAsync<
    ProfessionalServiceResource,
    UnsubscribeOptions,
    ProfessionalServiceResource
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Global operations not scoped to a single resource"
interface ProfessionalServiceSubscriptionLevelGlobal {
  listByAzureSubscription is ArmListBySubscription<
    ProfessionalServiceResource,
    Parameters = ExpandCustomerDataQueryParameter
  >;
  checkNameAvailability is checkGlobalNameAvailability;
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

    /** The operation ID. */
    @path operationId: string,
  ):
    | ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult>
    | ErrorResponse;
}
