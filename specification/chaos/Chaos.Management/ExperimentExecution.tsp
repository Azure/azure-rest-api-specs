import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Experiment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;
/**
 * Model that represents the execution of a Experiment.
 */
@parentResource(Experiment)
model ExperimentExecution
  is Azure.ResourceManager.ProxyResource<ExperimentExecutionProperties> {
  ...ResourceNameParameter<
    Resource = ExperimentExecution,
    KeyName = "executionId",
    SegmentName = "executions",
    NamePattern = "^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$"
  >;
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
  listAllExecutions is ArmResourceListByParent<
    ExperimentExecution,
    Response = ExperimentExecutionListResult
  >;

  /**
   * Execution details of an experiment resource.
   */
  executionDetails is ArmResourceActionSync<
    ExperimentExecution,
    void,
    ExperimentExecutionDetails
  >;
}

@@doc(ExperimentExecution.name,
  "GUID that represents a Experiment execution detail."
);
@@doc(ExperimentExecution.properties,
  "The properties of experiment execution status."
);