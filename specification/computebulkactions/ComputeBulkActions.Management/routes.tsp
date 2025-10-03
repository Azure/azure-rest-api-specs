import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ComputeBulkActions;

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface BulkActions {
  @doc("Gets a list of LaunchBulkInstancesOperations.")
  get is ArmResourceRead<LaunchBulkInstancesOperation>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @doc("Creates or updates LaunchBulkInstancesOperations.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceSync<LaunchBulkInstancesOperation>;

  @doc("Deletes the LaunchBulkInstancesOperations.")
  delete is ArmResourceDeleteSync<LaunchBulkInstancesOperation>;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @doc("Cancels the instances that have not yet launched.")
  cancel is ArmResourceActionNoContentSync<LaunchBulkInstancesOperation, void>;

  @doc("List VirtualMachine resources of a LaunchBulkInstancesOperation.")
  @autoRoute
  @listsResource(VirtualMachine)
  @armResourceList(VirtualMachine)
  @list
  @get
  listVirtualMachines(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...ProviderNamespace<LaunchBulkInstancesOperation>,
    ...ResourceNameParameter<
      LaunchBulkInstancesOperation,
      NamePattern = "^[^_\\W][\\w\\-._]{0,79}(?<![-.])$"
    >,

    @doc("Filter expression to filter the virtual machines.")
    @query
    $filter?: string,

    @doc("Skip token for pagination. Uses the token from a previous response to fetch the next page of results.")
    @query
    $skiptoken?: string,
  ): ArmResponse<VirtualMachineListResult> | ErrorResponse;
}
