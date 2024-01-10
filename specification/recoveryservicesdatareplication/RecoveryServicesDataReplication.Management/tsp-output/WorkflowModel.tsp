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
  @key("jobName")
  @segment("jobs")
  name: string;
}

@armResourceOperations
@projectedName("client", "Workflow")
interface WorkflowModels_Workflow {
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
}
