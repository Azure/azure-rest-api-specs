import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
/**
 * Run resource properties
 */
@parentResource(Registry)
model Run is Azure.ResourceManager.ProxyResource<RunProperties> {
  ...ResourceNameParameter<
    Resource = Run,
    KeyName = "runId",
    SegmentName = "runs",
    NamePattern = ""
  >;
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
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Run, PatchModel = RunUpdateParameters>;

  /**
   * Gets all the runs for a registry.
   */
  @list
  list is ArmResourceListByParent<
    Run,
    Parameters = {
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
    },
    Response = ArmResponse<RunListResult>
  >;

  /**
   * Gets a link to download the run logs.
   */
  @action("listLogSasUrl")
  getLogSasUrl is ArmResourceActionSync<
    Run,
    void,
    ArmResponse<RunGetLogResult>
  >;

  /**
   * Cancel an existing run.
   */
  cancel is ArmResourceActionSync<Run, void, OkResponse>;
}

@@doc(Run.name, "The run ID.");
@@doc(Run.properties, "The properties of a run.");
@@doc(Runs.update::parameters.properties, "The run update properties.");
