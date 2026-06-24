import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./scheduledactionmodels.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Compute;

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface ScheduledActions {
  get is ArmResourceRead<ScheduledAction>;

  createOrUpdate is ArmResourceCreateOrReplaceAsync<ScheduledAction>;

  update is ArmCustomPatchAsync<
    ScheduledAction,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ScheduledAction,
      ScheduledActionProperties
    >,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  delete is ArmResourceDeleteWithoutOkAsync<
    ScheduledAction,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  listByResourceGroup is ArmResourceListByParent<ScheduledAction>;

  listBySubscription is ArmListBySubscription<ScheduledAction>;

  @autoRoute
  @listsResource(ScheduledActionResource)
  @armResourceList(ScheduledActionResource)
  @list
  @get
  @doc("List resources attached to Scheduled Actions")
  listResources(...ResourceInstanceParameters<ScheduledActionResource>):
    | ArmResponse<ResourceListResponse>
    | ErrorResponse;

  attachResources is ArmResourceActionAsync<
    ScheduledAction,
    ResourceAttachRequest,
    ResourceOperationResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  detachResources is ArmResourceActionAsync<
    ScheduledAction,
    ResourceDetachRequest,
    ResourceOperationResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  patchResources is ArmResourceActionSync<
    ScheduledAction,
    ResourcePatchRequest,
    ResourceOperationResponse
  >;

  disable is ArmResourceActionNoResponseContentAsync<
    ScheduledAction,
    void,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  enable is ArmResourceActionNoResponseContentAsync<
    ScheduledAction,
    void,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  cancelNextOccurrence is ArmResourceActionAsync<
    ScheduledAction,
    CancelOccurrenceRequest,
    ResourceOperationResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  triggerManualOccurrence is ArmResourceActionAsync<
    ScheduledAction,
    void,
    Occurrence,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = Occurrence> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@armResourceOperations
interface ScheduledActionExtension {
  listByVms is ArmResourceListByParent<ScheduledActionResources>;
}

@armResourceOperations(#{ allowStaticRoutes: true })
interface ScheduledActionOperationStatus {
  @doc("Get the status of a ScheduledActions asynchronous operation. Both the `Azure-AsyncOperation` and `Location` headers returned by long-running operations point at this endpoint.")
  @get
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/operationStatuses/{operationId}")
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @doc("The location name.")
    @path
    @minLength(1)
    location: azureLocation,

    @doc("The operation id.")
    @path
    @minLength(1)
    @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
    operationId: string,
  ):
    | ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult>
    | ErrorResponse;
}
