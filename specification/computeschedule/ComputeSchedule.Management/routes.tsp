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

alias LocationParameter = {
  /** The location name. */
  @path
  @minLength(1)
  @segment("locations")
  @key
  locationparameter: Azure.Core.azureLocation;
};

@armResourceOperations(#{
  omitTags: true,
})
interface ScheduledActions {
  // -------------- Routes -------------
  /** VirtualMachinesSubmitDeallocate: Schedule deallocate operation for a batch of virtual machines at datetime in future. */
  virtualMachinesSubmitDeallocate is ArmProviderActionSync<
    Request = {
      /** The request body */
      @bodyRoot
      requestBody: SubmitDeallocateRequest;
    },
    Response = ArmResponse<DeallocateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesSubmitHibernate: Schedule hibernate operation for a batch of virtual machines at datetime in future. */
  virtualMachinesSubmitHibernate is ArmProviderActionSync<
    Request = {
      /** The request body */
      @bodyRoot
      requestBody: SubmitHibernateRequest;
    },
    Response = ArmResponse<HibernateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesSubmitStart: Schedule start operation for a batch of virtual machines at datetime in future. */
  virtualMachinesSubmitStart is ArmProviderActionSync<
    Request = {
      /** The request body */
      @bodyRoot
      requestBody: SubmitStartRequest;
    },
    Response = ArmResponse<StartResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesExecuteDeallocate: Execute deallocate operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  virtualMachinesExecuteDeallocate is ArmProviderActionSync<
    Request = {
      /** The request body */
      @bodyRoot
      requestBody: ExecuteDeallocateRequest;
    },
    Response = ArmResponse<DeallocateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesExecuteHibernate: Execute hibernate operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  virtualMachinesExecuteHibernate is ArmProviderActionSync<
    Request = {
      /** The request body */
      @bodyRoot
      requestBody: ExecuteHibernateRequest;
    },
    Response = ArmResponse<HibernateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesExecuteStart: Execute start operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  virtualMachinesExecuteStart is ArmProviderActionSync<
    Request = {
      /** The request body */
      @bodyRoot
      requestBody: ExecuteStartRequest;
    },
    Response = ArmResponse<StartResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesExecuteCreate: Execute create operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  @added(Microsoft.ComputeSchedule.Versions.`2025-05-01`)
  virtualMachinesExecuteCreate is ArmProviderActionSync<
    Request = {
      /** The request body */
      @bodyRoot
      @added(Microsoft.ComputeSchedule.Versions.`2025-05-01`)
      requestBody: ExecuteCreateRequest;
    },
    Response = ArmResponse<CreateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesExecuteDelete: Execute delete operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  @added(Microsoft.ComputeSchedule.Versions.`2025-05-01`)
  virtualMachinesExecuteDelete is ArmProviderActionSync<
    Request = {
      /** The request body */
      @bodyRoot
      @added(Microsoft.ComputeSchedule.Versions.`2025-05-01`)
      requestBody: ExecuteDeleteRequest;
    },
    Response = ArmResponse<DeleteResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesGetOperationStatus: Polling endpoint to read status of operations performed on virtual machines */
  virtualMachinesGetOperationStatus is ArmProviderActionSync<
    Request = {
      /** The request body */
      @bodyRoot
      requestBody: GetOperationStatusRequest;
    },
    Response = ArmResponse<GetOperationStatusResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesCancelOperations: Cancel a previously submitted (start/deallocate/hibernate) request */
  virtualMachinesCancelOperations is ArmProviderActionSync<
    Request = {
      /** The request body */
      @bodyRoot
      requestBody: CancelOperationsRequest;
    },
    Response = ArmResponse<CancelOperationsResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesGetOperationErrors: Get error details on operation errors (like transient errors encountered, additional logs) if they exist. */
  virtualMachinesGetOperationErrors is ArmProviderActionSync<
    Request = {
      /** The request body */
      @bodyRoot
      requestBody: GetOperationErrorsRequest;
    },
    Response = ArmResponse<GetOperationErrorsResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

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
  @doc("List resources attached to Scheduled Actions")
  @get
  @action("resources")
  @list
  listResources is ArmResourceActionSync<
    ScheduledAction,
    Request = void,
    Response = ArmResponse<ResourceListResponse>
  >;

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

// Recurring scheduledaction extension routes
@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@armResourceOperations
interface ScheduledActionExtension {
  listByVms is ArmResourceListByParent<ScheduledActionResources>;
}
// Recurring scheduledaction extension routes
