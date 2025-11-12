import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Experiment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;
/**
 * Model that represents the execution of a Experiment.
 */
@parentResource(Experiment)
model ExperimentExecution is ProxyResource<ExperimentExecutionProperties> {
  /**
   * GUID that represents a Experiment execution detail.
   */
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  @path
  @key("executionId")
  @segment("executions")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface ExperimentExecutions {
  /**
   * Get an execution of an Experiment resource.
   */
  getExecution is ArmResourceRead<ExperimentExecution>;

  /**
   * Get a list of executions of an Experiment resource.
   */
  listAllExecutions is ArmResourceListByParent<ExperimentExecution>;

  /**
   * Execution details of an experiment resource.
   */
  executionDetails is ArmResourceActionSync<
    ExperimentExecution,
    void,
    ExperimentExecutionDetails
  >;
}
