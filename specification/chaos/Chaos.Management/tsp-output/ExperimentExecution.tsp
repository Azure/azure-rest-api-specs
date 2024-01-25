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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Experiment)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  ExperimentExecutionProperties
)
model ExperimentExecution extends ProxyResourceBase {
  /**
   * GUID that represents a Experiment execution detail.
   */
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  @path
  @key("executionId")
  @segment("executions")
  @visibility("read")
  name: string;

  /**
   * The properties of experiment execution status.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ExperimentExecutionProperties;
}

@armResourceOperations
interface ExperimentExecutions {
  /**
   * Get an execution of an Experiment resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Experiments_GetExecution")
  getExecution is ArmResourceRead<ExperimentExecution>;

  /**
   * Get a list of executions of an Experiment resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Experiments_ListAllExecutions")
  listAllExecutions is ArmResourceListByParent<ExperimentExecution>;

  /**
   * Execution details of an experiment resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Experiments_ExecutionDetails")
  executionDetails is ArmResourceActionSync<
    ExperimentExecution,
    void,
    ExperimentExecutionDetails
  >;
}
