import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VaultModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataReplication;
@doc("Workflow model.")
@parentResource(VaultModel)
model WorkflowModel is ProxyResource<WorkflowModelProperties> {
  @doc("The job (workflow) name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("jobName")
  @segment("jobs")
  name: string;
}

@armResourceOperations
interface WorkflowModels {
  @doc("Gets the details of the job.")
  get is ArmResourceRead<WorkflowModel>;
  @doc("Gets the list of jobs in the given vault.")
  list is ArmResourceListByParent<
    WorkflowModel,
    {
      ...BaseParameters<WorkflowModel>;

      @doc("Filter string.")
      @query("$filter")
      $filter?: string;

      @doc("Continuation token.")
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
  @summary("Gets the job (workflow) operation status.")
  @doc("Tracks the results of an asynchronous operation on the job.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/jobs/{jobName}/operations/{operationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @pattern("^[a-zA-Z0-9]*$")
      @path
      vaultName: string;

      @doc("The job (workflow) name.")
      @pattern("^[a-zA-Z0-9]*$")
      @path
      jobName: string;

      @doc("The ID of an ongoing async operation.")
      @minLength(1)
      @path
      operationId: string;
    },
    OperationStatus
  >;
}
