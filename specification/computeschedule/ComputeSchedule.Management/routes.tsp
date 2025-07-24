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
using Azure.ResourceManager;

namespace Microsoft.ComputeSchedule;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Each resource interface must have an @armResourceOperations decorator."
interface ScheduledActions {
  // -------------- Routes -------------
  /** VirtualMachinesSubmitDeallocate: Schedule deallocate operation for a batch of virtual machines at datetime in future. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesSubmitDeallocate")
  @post
  virtualMachinesSubmitDeallocate(
    ...Params,
    @body @doc("The request body") requestBody: SubmitDeallocateRequest,
  ): ArmResponse<DeallocateResourceOperationResponse> | ErrorResponse;

  /** VirtualMachinesSubmitHibernate: Schedule hibernate operation for a batch of virtual machines at datetime in future. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesSubmitHibernate")
  @post
  virtualMachinesSubmitHibernate(
    ...Params,
    @body @doc("The request body") requestBody: SubmitHibernateRequest,
  ): ArmResponse<HibernateResourceOperationResponse> | ErrorResponse;

  /** VirtualMachinesSubmitStart: Schedule start operation for a batch of virtual machines at datetime in future. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesSubmitStart")
  @post
  virtualMachinesSubmitStart(
    ...Params,
    @body @doc("The request body") requestBody: SubmitStartRequest,
  ): ArmResponse<StartResourceOperationResponse> | ErrorResponse;

  /** VirtualMachinesExecuteDeallocate: Execute deallocate operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesExecuteDeallocate")
  @post
  virtualMachinesExecuteDeallocate(
    ...Params,
    @body @doc("The request body") requestBody: ExecuteDeallocateRequest,
  ): ArmResponse<DeallocateResourceOperationResponse> | ErrorResponse;

  /** VirtualMachinesExecuteHibernate: Execute hibernate operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesExecuteHibernate")
  @post
  virtualMachinesExecuteHibernate(
    ...Params,
    @body @doc("The request body") requestBody: ExecuteHibernateRequest,
  ): ArmResponse<HibernateResourceOperationResponse> | ErrorResponse;

  /** VirtualMachinesExecuteStart: Execute start operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesExecuteStart")
  @post
  virtualMachinesExecuteStart(
    ...Params,
    @body @doc("The request body") requestBody: ExecuteStartRequest,
  ): ArmResponse<StartResourceOperationResponse> | ErrorResponse;

  /** VirtualMachinesExecuteCreate: Execute create operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @added(Microsoft.ComputeSchedule.Versions.`2025-05-01`)
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesExecuteCreate")
  @post
  virtualMachinesExecuteCreate(
    ...Params,
    @body @doc("The request body") requestBody: ExecuteCreateRequest,
  ): ArmResponse<CreateResourceOperationResponse> | ErrorResponse;

  /** VirtualMachinesExecuteDelete: Execute delete operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @added(Microsoft.ComputeSchedule.Versions.`2025-05-01`)
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesExecuteDelete")
  @post
  virtualMachinesExecuteDelete(
    ...Params,
    @body @doc("The request body") requestBody: ExecuteDeleteRequest,
  ): ArmResponse<DeleteResourceOperationResponse> | ErrorResponse;

  /** VirtualMachinesGetOperationStatus: Polling endpoint to read status of operations performed on virtual machines */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesGetOperationStatus")
  @post
  virtualMachinesGetOperationStatus(
    ...Params,
    @body @doc("The request body") requestBody: GetOperationStatusRequest,
  ): ArmResponse<GetOperationStatusResponse> | ErrorResponse;

  /** VirtualMachinesCancelOperations: Cancel a previously submitted (start/deallocate/hibernate) request */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesCancelOperations")
  @post
  virtualMachinesCancelOperations(
    ...Params,
    @body @doc("The request body") requestBody: CancelOperationsRequest,
  ): ArmResponse<CancelOperationsResponse> | ErrorResponse;

  /** VirtualMachinesGetOperationErrors: Get error details on operation errors (like transient errors encountered, additional logs) if they exist. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesGetOperationErrors")
  @post
  virtualMachinesGetOperationErrors(
    ...Params,
    @body @doc("The request body") requestBody: GetOperationErrorsRequest,
  ): ArmResponse<GetOperationErrorsResponse> | ErrorResponse;

  // Recurring scheduledaction routes
  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  get is ArmResourceRead<ScheduledAction>;

  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ScheduledAction>;

  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  update is ArmCustomPatchSync<
    ScheduledAction,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ScheduledAction,
      ScheduledActionProperties
    >
  >;

  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  delete is ArmResourceDeleteWithoutOkAsync<ScheduledAction>;

  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  listByResourceGroup is ArmResourceListByParent<ScheduledAction>;

  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  listBySubscription is ArmListBySubscription<ScheduledAction>;

  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  @autoRoute
  @listsResource(ScheduledActionResource)
  @armResourceList(ScheduledActionResource)
  @get
  @doc("List resources attached to Scheduled Actions")
  listResources(
    ...ResourceInstanceParameters<ScheduledActionResource>,
  ): ArmResponse<ResourceListResponse> | ErrorResponse;

  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  attachResources is ArmResourceActionSync<
    ScheduledAction,
    ResourceAttachRequest,
    ResourceOperationResponse
  >;

  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  detachResources is ArmResourceActionSync<
    ScheduledAction,
    ResourceDetachRequest,
    ResourceOperationResponse
  >;

  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  patchResources is ArmResourceActionSync<
    ScheduledAction,
    ResourcePatchRequest,
    ResourceOperationResponse
  >;

  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  disable is ArmResourceActionSync<ScheduledAction, void, OkResponse>;

  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  enable is ArmResourceActionSync<ScheduledAction, void, OkResponse>;

  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  cancelNextOccurrence is ArmResourceActionSync<
    ScheduledAction,
    CancelOccurrenceRequest,
    ResourceOperationResponse
  >;

  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  triggerManualOccurrence is ArmResourceActionSync<
    ScheduledAction,
    void,
    Occurrence
  >;
  // Recurring scheduledaction routes
}

// Recurring scheduledaction extension routes
@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@armResourceOperations
interface ScheduledActionExtension {
  listByVms is ArmResourceListByParent<ScheduledActionResources>;
}
// Recurring scheduledaction extension routes
