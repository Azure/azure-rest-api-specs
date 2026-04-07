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

namespace Microsoft.ComputeSchedule;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Each resource interface must have an @armResourceOperations decorator."
interface ScheduledActions {
  // -------------- Routes -------------
  /** virtualMachinesSubmitDeallocate: submitDeallocate for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesSubmitDeallocate")
  @post
  virtualMachinesSubmitDeallocate(
    ...Params,
    @body @doc("The request body") requestBody: SubmitDeallocateRequest,
  ): ArmResponse<DeallocateResourceOperationResponse> | ErrorResponse;

  /** virtualMachinesSubmitHibernate: submitHibernate for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesSubmitHibernate")
  @post
  virtualMachinesSubmitHibernate(
    ...Params,
    @body @doc("The request body") requestBody: SubmitHibernateRequest,
  ): ArmResponse<HibernateResourceOperationResponse> | ErrorResponse;

  /** virtualMachinesSubmitStart: submitStart for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesSubmitStart")
  @post
  virtualMachinesSubmitStart(
    ...Params,
    @body @doc("The request body") requestBody: SubmitStartRequest,
  ): ArmResponse<StartResourceOperationResponse> | ErrorResponse;

  /** virtualMachinesExecuteDeallocate: executeDeallocate for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesExecuteDeallocate")
  @post
  virtualMachinesExecuteDeallocate(
    ...Params,
    @body @doc("The request body") requestBody: ExecuteDeallocateRequest,
  ): ArmResponse<DeallocateResourceOperationResponse> | ErrorResponse;

  /** virtualMachinesExecuteHibernate: executeHibernate for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesExecuteHibernate")
  @post
  virtualMachinesExecuteHibernate(
    ...Params,
    @body @doc("The request body") requestBody: ExecuteHibernateRequest,
  ): ArmResponse<HibernateResourceOperationResponse> | ErrorResponse;

  /** virtualMachinesExecuteStart: executeStart for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesExecuteStart")
  @post
  virtualMachinesExecuteStart(
    ...Params,
    @body @doc("The request body") requestBody: ExecuteStartRequest,
  ): ArmResponse<StartResourceOperationResponse> | ErrorResponse;

  /** virtualMachinesExecuteCreateFlex: executeCreateFlex for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesExecuteCreateFlex")
  @post
  virtualMachinesExecuteCreateFlex(
    ...Params,
    @body @doc("The request body") requestBody: ExecuteCreateFlexRequest,
  ): ArmResponse<CreateFlexResourceOperationResponse> | ErrorResponse;

  /** virtualMachinesExecuteCreate: executeCreate for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesExecuteCreate")
  @post
  virtualMachinesExecuteCreate(
    ...Params,
    @body @doc("The request body") requestBody: ExecuteCreateRequest,
  ): ArmResponse<CreateResourceOperationResponse> | ErrorResponse;

  /** virtualMachinesExecuteDelete: executeDelete for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesExecuteDelete")
  @post
  virtualMachinesExecuteDelete(
    ...Params,
    @body @doc("The request body") requestBody: ExecuteDeleteRequest,
  ): ArmResponse<DeleteResourceOperationResponse> | ErrorResponse;

  /** virtualMachinesGetOperationStatus: getOperationStatus for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesGetOperationStatus")
  @post
  virtualMachinesGetOperationStatus(
    ...Params,
    @body @doc("The request body") requestBody: GetOperationStatusRequest,
  ): ArmResponse<GetOperationStatusResponse> | ErrorResponse;

  /** virtualMachinesCancelOperations: cancelOperations for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesCancelOperations")
  @post
  virtualMachinesCancelOperations(
    ...Params,
    @body @doc("The request body") requestBody: CancelOperationsRequest,
  ): ArmResponse<CancelOperationsResponse> | ErrorResponse;

  /** virtualMachinesGetOperationErrors: Get error details on operation errors (like transient errors encountered, additional logs) if they exist. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesGetOperationErrors")
  @post
  virtualMachinesGetOperationErrors(
    ...Params,
    @body @doc("The request body") requestBody: GetOperationErrorsRequest,
  ): ArmResponse<GetOperationErrorsResponse> | ErrorResponse;

  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  get is ArmResourceRead<ScheduledAction>;
  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ScheduledAction>;
  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  update is ArmResourcePatchSync<ScheduledAction, ScheduledActionProperties>;
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
  @list
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
}

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@armResourceOperations
interface ScheduledActionExtension {
  listByVms is ArmResourceListByParent<ScheduledActionResources>;
}
