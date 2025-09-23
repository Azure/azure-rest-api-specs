import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./experiment.tsp";
import "./experimentExecution.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;

@armResourceOperations
interface ExperimentExecutions {
  /**
   * Get an execution of an Experiment resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required to not break existing SDKs"
  getExecution is ArmResourceRead<ExperimentExecution>;

  /**
   * Get a list of executions of an Experiment resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required to not break existing SDKs"
  listAllExecutions is ArmResourceListByParent<
    ExperimentExecution,
    Response = ExperimentExecutionListResult
  >;

  /**
   * Execution details of an experiment resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required to not break existing SDKs"
  getExecutionDetails is ArmResourceActionSync<
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
