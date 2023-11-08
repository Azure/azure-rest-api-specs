import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Experiment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Chaos;
@doc("Model that represents the execution of a Experiment.")
@parentResource(Experiment)
model ExperimentExecution is ProxyResource<ExperimentExecutionProperties> {
  @doc("GUID that represents a Experiment execution detail.")
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  @path
  @key("executionId")
  @segment("executions")
  name: string;
}

@armResourceOperations
interface ExperimentExecutions {
  @doc("Get an execution of an Experiment resource.")
  getExecution is ArmResourceRead<ExperimentExecution>;
  @doc("Get a list of executions of an Experiment resource.")
  listAllExecutions is ArmResourceListByParent<ExperimentExecution>;
  @doc("Execution details of an experiment resource.")
  executionDetails is ArmResourceActionSync<
    ExperimentExecution,
    {},
    ExperimentExecutionDetails
  >;
}
