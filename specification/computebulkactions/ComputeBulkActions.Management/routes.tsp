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
    ...CommonParams,
    ...ProviderNamespace<LaunchBulkInstancesOperation>,
    ...LocationParameter,
    ...ResourceNameParameter<
      LaunchBulkInstancesOperation,
      NamePattern = "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$"
    >,
  ): LaunchBulkInstancesOperation | ErrorResponse;

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
  ): LaunchBulkInstancesOperationListResult | ErrorResponse;

  @doc("List LaunchBulkInstancesOperation resources by subscriptionId.")
  @get
  @list
  @listsResource(LaunchBulkInstancesOperation)
  @armResourceList(LaunchBulkInstancesOperation)
  listBySubscription(
    ...SubscriptionParams,
    ...ProviderNamespace<LaunchBulkInstancesOperation>,
    ...LocationParameter,
  ): LaunchBulkInstancesOperationListResult | ErrorResponse;

  @doc("List VirtualMachine resources of a LaunchBulkInstancesOperation.")
  @autoRoute
  @listsResource(VirtualMachine)
  @armResourceList(VirtualMachine)
  @list
  @get
  listVirtualMachines(
    ...CommonParams,
    ...ProviderNamespace<LaunchBulkInstancesOperation>,
    ...LocationParameter,
    ...ResourceNameParameter<
      LaunchBulkInstancesOperation,
      NamePattern = "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$"
    >,

    @doc("Filter expression to filter the virtual machines.")
    @query
    $filter?: string,

    @doc("Skip token for pagination. Uses the token from a previous response to fetch the next page of results.")
    @query
    $skiptoken?: string,
  ): ArmResponse<VirtualMachineListResult> | ErrorResponse;
}
