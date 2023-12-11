import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataReplicationVault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.RecoveryServicesDataReplication;
@doc("Workflow model.")
@parentResource(DataReplicationVault)
model DataReplicationWorkflow is ProxyResource<WorkflowModelProperties> {
  @doc("The job (workflow) name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("jobName")
  @segment("jobs")
  name: string;
}

@armResourceOperations
interface DataReplicationWorkflows {
  @doc("Gets the details of the job.")
  get is ArmResourceRead<DataReplicationWorkflow>;
  @doc("Gets the list of jobs in the given vault.")
  list is ArmResourceListByParent<
    DataReplicationWorkflow,
    {
      ...BaseParameters<DataReplicationWorkflow>;

      @doc("Filter string.")
      @query("$filter")
      $filter?: string;

      @doc("Continuation token.")
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
}
