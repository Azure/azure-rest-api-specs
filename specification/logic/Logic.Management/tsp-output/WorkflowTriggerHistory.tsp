import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkflowTrigger.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
/**
 * The workflow trigger history.
 */
@parentResource(WorkflowTrigger)
model WorkflowTriggerHistory
  is ProxyResource<WorkflowTriggerHistoryProperties> {
  /**
   * The workflow trigger history name. Corresponds to the run name for triggers that resulted in a run.
   */
  @path
  @key("historyName")
  @segment("histories")
  name: string;
}

@armResourceOperations
interface WorkflowTriggerHistories {
  /**
   * Gets a workflow trigger history.
   */
  get is ArmResourceRead<WorkflowTriggerHistory>;

  /**
   * Gets a list of workflow trigger histories.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkflowTriggerHistories_List")
  list is ArmResourceListByParent<
    WorkflowTriggerHistory,
    {
      ...BaseParameters<WorkflowTriggerHistory>;

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
   * Resubmits a workflow run based on the trigger history.
   */
  resubmit is ArmResourceActionNoContentSync<WorkflowTriggerHistory, void>;
}
