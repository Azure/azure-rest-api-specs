import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.ComputeBulkActions;

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations(#{ allowStaticRoutes: true })
interface BulkActions {
  @doc("Gets an instance of LaunchBulkInstancesOperations.")
  get is ArmResourceRead<
    Resource = LocationBasedLaunchBulkInstancesOperation,
    Parameters = LaunchBulkInstancesOperationId,
    Response = ArmResponse<LocationBasedLaunchBulkInstancesOperation>
  >;

  @doc("Get the status of a LaunchBulkInstancesOperation.")
  getOperationStatus is ArmResourceRead<
    Resource = LocationBasedLaunchBulkInstancesOperation,
    Parameters = OperationParameter,
    Response = ArmResponse<OperationStatus>,
    BaseParameters = SubscriptionParams
  >;

  @doc("Creates or updates LaunchBulkInstancesOperations.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Resource = LocationBasedLaunchBulkInstancesOperation,
    Parameters = LaunchBulkInstancesOperationId
  >;

  @doc("Deletes LaunchBulkInstancesOperations.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Resource = LocationBasedLaunchBulkInstancesOperation,
    Parameters = LaunchBulkInstancesOperationId & DeleteInstancesParameter
  >;

  @doc("Cancels LaunchBulkInstancesOperation instances that have not yet launched.")
  cancel is ArmResourceActionNoResponseContentAsync<
    Resource = LocationBasedLaunchBulkInstancesOperation,
    Request = void,
    Parameters = LaunchBulkInstancesOperationId
  >;

  @doc("List LaunchBulkInstancesOperation resources by resource group.")
  @get
  @autoRoute
  @action("launchBulkInstancesOperations")
  @list
  @listsResource(LaunchBulkInstancesOperation)
  @armResourceList(LocationBasedLaunchBulkInstancesOperation)
  listByResourceGroup(
    ...CommonParams,
    ...ProviderNamespace<LocationBasedLaunchBulkInstancesOperation>,
    ...LocationParameter,
  ): ArmResponse<LaunchBulkInstancesOperationListResult> | ErrorResponse;

  @doc("List LaunchBulkInstancesOperation resources by subscriptionId.")
  @get
  @autoRoute
  @action("launchBulkInstancesOperations")
  @list
  @listsResource(LaunchBulkInstancesOperation)
  @armResourceList(LocationBasedLaunchBulkInstancesOperation)
  listBySubscription(
    ...SubscriptionParams,
    ...ProviderNamespace<LocationBasedLaunchBulkInstancesOperation>,
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
  @autoRoute
  virtualMachinesSubmitDeallocate is ArmProviderActionSync<
    Request = SubmitDeallocateRequest,
    Response = ArmResponse<DeallocateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesSubmitHibernate: Schedule hibernate operation for a batch of virtual machines at datetime in future. */
  @autoRoute
  virtualMachinesSubmitHibernate is ArmProviderActionSync<
    Request = SubmitHibernateRequest,
    Response = ArmResponse<HibernateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesSubmitStart: Schedule start operation for a batch of virtual machines at datetime in future. */
  @autoRoute
  virtualMachinesSubmitStart is ArmProviderActionSync<
    Request = SubmitStartRequest,
    Response = ArmResponse<StartResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesExecuteDeallocate: Execute deallocate operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  @autoRoute
  virtualMachinesExecuteDeallocate is ArmProviderActionSync<
    Request = ExecuteDeallocateRequest,
    Response = ArmResponse<DeallocateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesExecuteHibernate: Execute hibernate operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  @autoRoute
  virtualMachinesExecuteHibernate is ArmProviderActionSync<
    Request = ExecuteHibernateRequest,
    Response = ArmResponse<HibernateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesExecuteStart: Execute start operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  @autoRoute
  virtualMachinesExecuteStart is ArmProviderActionSync<
    Request = ExecuteStartRequest,
    Response = ArmResponse<StartResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesExecuteCreate: Execute create operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  @removed(Microsoft.ComputeBulkActions.Versions.`2026-02-01-preview`)
  @autoRoute
  virtualMachinesExecuteCreate is ArmProviderActionSync<
    Request = ExecuteCreateRequest,
    Response = ArmResponse<CreateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesExecuteDelete: Execute delete operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  @removed(Microsoft.ComputeBulkActions.Versions.`2026-02-01-preview`)
  @autoRoute
  virtualMachinesExecuteDelete is ArmProviderActionSync<
    Request = ExecuteDeleteRequest,
    Response = ArmResponse<DeleteResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesGetOperationStatus: Polling endpoint to read status of operations performed on virtual machines */
  @autoRoute
  virtualMachinesGetOperationStatus is ArmProviderActionSync<
    Request = GetOperationStatusRequest,
    Response = ArmResponse<GetOperationStatusResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesCancelOperations: Cancel a previously submitted (start/deallocate/hibernate) request */
  @autoRoute
  virtualMachinesCancelOperations is ArmProviderActionSync<
    Request = CancelOperationsRequest,
    Response = ArmResponse<CancelOperationsResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesGetOperationErrors: Get error details on operation errors (like transient errors encountered, additional logs) if they exist. */
  @autoRoute
  virtualMachinesGetOperationErrors is ArmProviderActionSync<
    Request = GetOperationErrorsRequest,
    Response = ArmResponse<GetOperationErrorsResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;
  // ------------------ Scheduledaction endpoints ---------------
}
