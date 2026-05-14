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
  get is ArmResourceRead<ProfessionalServiceResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ProfessionalServiceResource>;
  // Tags-only PATCH per ARM TrackedResource convention.
  // Business properties are not patchable for Professional Services in GA.
  updateTags is ArmTagsPatchAsync<ProfessionalServiceResource>;
  delete is ArmResourceDeleteWithoutOkAsync<ProfessionalServiceResource>;
  listByResourceGroup is ArmResourceListByParent<ProfessionalServiceResource>;
  // NOTE: No listAccessToken (GenerateToken) — not supported for Professional Services.
  /** Unsubscribes from a Professional Service subscription, optionally providing a reason and feedback. The resource remains in Azure but the subscription is cancelled. */
  unsubscribe is ArmResourceActionAsync<
    ProfessionalServiceResource,
    DeleteOptions,
    ProfessionalServiceResource
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom preflight route not tied to ProfessionalServiceResource"
interface ProfessionalServiceSubscriptionLevelPreflight {
  /** Pre-validates Professional Service subscription operations. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Preflight accepts dynamic payload"
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ProfessionalService/deployments/{resourceName}/preflight")
  preflight(
    ...ApiVersionParameter,
    ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,
    ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

    /** The resource name. */
    @pattern("^[a-zA-Z0-9-]{3,50}$")
    @path
    resourceName: string,

    /** The preflight request body. */
    @body body: unknown,
  ): ArmResponse<PreflightResult> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Global operations not scoped to a single resource"
interface ProfessionalServiceSubscriptionLevelGlobal {
  listByAzureSubscription is ArmListBySubscription<ProfessionalServiceResource>;
  checkNameAvailability is checkGlobalNameAvailability;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom operation status routes"
interface ProfessionalServiceOperationStatuses {
  /** Gets the status of a long-running Professional Service operation at the subscription scope. */
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
