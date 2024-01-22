import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Registry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
/**
 * Run resource properties
 */
@parentResource(Registry)
model Run is ProxyResource<RunProperties> {
  /**
   * The run ID.
   */
  @path
  @key("runId")
  @segment("runs")
  name: string;
}

@armResourceOperations
interface Runs {
  /**
   * Gets the detailed information for a given run.
   */
  get is ArmResourceRead<Run>;

  /**
   * Patch the run properties.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<Run, RunUpdateParameters>;

  /**
   * Gets all the runs for a registry.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Runs_List")
  list is ArmResourceListByParent<
    Run,
    {
      ...BaseParameters<Run>;

      /**
       * The runs filter to apply on the operation. Arithmetic operators are not supported. The allowed string function is 'contains'. All logical operators except 'Not', 'Has', 'All' are allowed.
       */
      @query("$filter")
      $filter?: string;

      /**
       * $top is supported for get list of runs, which limits the maximum number of runs to return.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Gets a link to download the run logs.
   */
  getLogSasUrl is ArmResourceActionSync<Run, void, RunGetLogResult>;

  /**
   * Cancel an existing run.
   */
  cancel is ArmResourceActionAsync<Run, void, void>;
}

@@projectedName(Runs.update::parameters.properties,
  "json",
  "runUpdateParameters"
);
@@extension(Runs.update::parameters.properties,
  "x-ms-client-name",
  "runUpdateParameters"
);
@@doc(Runs.update::parameters.properties, "The run update properties.");
