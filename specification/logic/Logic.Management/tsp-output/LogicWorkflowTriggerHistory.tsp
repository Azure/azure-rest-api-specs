import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./LogicWorkflowTrigger.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Logic;
@doc("The workflow trigger history.")
@parentResource(LogicWorkflowTrigger)
model LogicWorkflowTriggerHistory
  is ProxyResource<WorkflowTriggerHistoryProperties> {
  @doc("The workflow trigger history name. Corresponds to the run name for triggers that resulted in a run.")
  @path
  @key("historyName")
  @segment("histories")
  name: string;
}

@armResourceOperations
interface LogicWorkflowTriggerHistories {
  @doc("Gets a workflow trigger history.")
  get is ArmResourceRead<LogicWorkflowTriggerHistory>;
  @doc("Gets a list of workflow trigger histories.")
  list is ArmResourceListByParent<
    LogicWorkflowTriggerHistory,
    {
      ...BaseParameters<LogicWorkflowTriggerHistory>;

      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;

      @doc("The filter to apply on the operation. Options for filters include: Status, StartTime, and ClientTrackingId.")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Resubmits a workflow run based on the trigger history.")
  resubmit is ArmResourceActionNoContentSync<LogicWorkflowTriggerHistory, void>;
}
