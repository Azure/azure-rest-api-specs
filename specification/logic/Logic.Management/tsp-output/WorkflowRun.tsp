import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workflow.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
/**
 * The workflow run.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Workflow)
@includeInapplicableMetadataInPayload(false)
model WorkflowRun extends SubResource {
  /**
   * The workflow run name.
   */
  @path
  @key("runName")
  @segment("runs")
  @visibility("read")
  name: string;

  /**
   * Gets the workflow run type.
   */
  @visibility("read")
  type?: string;

  /**
   * The workflow run properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkflowRunProperties;
}

@armResourceOperations
interface WorkflowRuns {
  /**
   * Gets a workflow run.
   */
  get is ArmResourceRead<WorkflowRun>;

  /**
   * Gets a list of workflow runs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkflowRuns_List")
  list is ArmResourceListByParent<
    WorkflowRun,
    {
      ...BaseParameters<WorkflowRun>;

      /**
       * The number of items to be included in the result.
       */
      @query("$top")
      $top?: int32;

      /**
       * The filter to apply on the operation. Options for filters include: Status, StartTime, and ClientTrackingId.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Cancels a workflow run.
   */
  cancel is ArmResourceActionSync<WorkflowRun, void, void>;
}
