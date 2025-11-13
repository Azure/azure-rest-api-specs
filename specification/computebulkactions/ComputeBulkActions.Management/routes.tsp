import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ComputeBulkActions;

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface BulkActions {
  @doc("Gets a list of LaunchBulkInstancesOperations.")
  @get
  @armResourceRead(LaunchBulkInstancesOperation)
  get(
    ...CustomParams,
  ): ArmResponse<LaunchBulkInstancesOperation> | ErrorResponse;

  @doc("Creates or updates LaunchBulkInstancesOperations.")
  @put
  @armResourceCreateOrUpdate(LaunchBulkInstancesOperation)
  createOrUpdate(
    ...CustomParams,
  ): ArmResourceUpdatedResponse<LaunchBulkInstancesOperation> | ArmResourceCreatedResponse<LaunchBulkInstancesOperation> | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "The field name `name` is the valid field name."
  @doc("Deletes the LaunchBulkInstancesOperations.")
  @delete
  @armResourceDelete(LaunchBulkInstancesOperation)
  delete(
    ...CustomParams,
  ): ArmDeletedResponse | ArmDeletedNoContentResponse | ErrorResponse;

  @doc("Cancels the instances that have not yet launched.")
  @post
  @armResourceAction(LaunchBulkInstancesOperation)
  cancel(...CustomParams): ArmNoContentResponse | ErrorResponse;

  @doc("List LaunchBulkInstancesOperation resources by resource group.")
  @get
  @list
  @listsResource(LaunchBulkInstancesOperation)
  @armResourceList(LaunchBulkInstancesOperation)
  listByResourceGroup(
    ...CommonParams,
    ...ProviderNamespace<LaunchBulkInstancesOperation>,
    ...LocationParameter,
  ): ArmResponse<LaunchBulkInstancesOperationListResult> | ErrorResponse;

  @doc("List LaunchBulkInstancesOperation resources by subscriptionId.")
  @get
  @list
  @listsResource(LaunchBulkInstancesOperation)
  @armResourceList(LaunchBulkInstancesOperation)
  listBySubscription(
    ...SubscriptionParams,
    ...ProviderNamespace<LaunchBulkInstancesOperation>,
    ...LocationParameter,
  ): ArmResponse<LaunchBulkInstancesOperationListResult> | ErrorResponse;

  @doc("List VirtualMachine resources of a LaunchBulkInstancesOperation.")
  @autoRoute
  @listsResource(VirtualMachine)
  @armResourceList(VirtualMachine)
  @list
  @get
  listVirtualMachines(
    ...CustomParams,

    @doc("Filter expression to filter the virtual machines.")
    @query
    $filter?: string,

    @doc("Skip token for pagination. Uses the token from a previous response to fetch the next page of results.")
    @query
    $skiptoken?: string,
  ): ArmResponse<VirtualMachineListResult> | ErrorResponse;

  // ------------------ Scheduledaction endpoints ---------------
  /** VirtualMachinesSubmitDeallocate: Schedule deallocate operation for a batch of virtual machines at datetime in future. */
  virtualMachinesSubmitDeallocate is ArmProviderActionSync<
    Request = SubmitDeallocateRequest,
    Response = ArmResponse<DeallocateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesSubmitHibernate: Schedule hibernate operation for a batch of virtual machines at datetime in future. */
  virtualMachinesSubmitHibernate is ArmProviderActionSync<
    Request = SubmitHibernateRequest,
    Response = ArmResponse<HibernateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesSubmitStart: Schedule start operation for a batch of virtual machines at datetime in future. */
  virtualMachinesSubmitStart is ArmProviderActionSync<
    Request = SubmitStartRequest,
    Response = ArmResponse<StartResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesExecuteDeallocate: Execute deallocate operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  virtualMachinesExecuteDeallocate is ArmProviderActionSync<
    Request = ExecuteDeallocateRequest,
    Response = ArmResponse<DeallocateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesExecuteHibernate: Execute hibernate operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  virtualMachinesExecuteHibernate is ArmProviderActionSync<
    Request = ExecuteHibernateRequest,
    Response = ArmResponse<HibernateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesExecuteStart: Execute start operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  virtualMachinesExecuteStart is ArmProviderActionSync<
    Request = ExecuteStartRequest,
    Response = ArmResponse<StartResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesExecuteCreate: Execute create operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  virtualMachinesExecuteCreate is ArmProviderActionSync<
    Request = ExecuteCreateRequest,
    Response = ArmResponse<CreateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesExecuteDelete: Execute delete operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  virtualMachinesExecuteDelete is ArmProviderActionSync<
    Request = ExecuteDeleteRequest,
    Response = ArmResponse<DeleteResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesGetOperationStatus: Polling endpoint to read status of operations performed on virtual machines */
  virtualMachinesGetOperationStatus is ArmProviderActionSync<
    Request = GetOperationStatusRequest,
    Response = ArmResponse<GetOperationStatusResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesCancelOperations: Cancel a previously submitted (start/deallocate/hibernate) request */
  virtualMachinesCancelOperations is ArmProviderActionSync<
    Request = CancelOperationsRequest,
    Response = ArmResponse<CancelOperationsResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesGetOperationErrors: Get error details on operation errors (like transient errors encountered, additional logs) if they exist. */
  virtualMachinesGetOperationErrors is ArmProviderActionSync<
    Request = GetOperationErrorsRequest,
    Response = ArmResponse<GetOperationErrorsResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;
  // ------------------ Scheduledaction endpoints ---------------
}
