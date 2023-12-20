import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./LogicWorkflow.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Logic;
@doc("The workflow run.")
@parentResource(LogicWorkflow)
model LogicWorkflowRun is ProxyResource<WorkflowRunProperties> {
  @doc("The workflow run name.")
  @path
  @key("runName")
  @segment("runs")
  name: string;
}

@armResourceOperations
interface LogicWorkflowRuns {
  @doc("Gets a workflow run.")
  get is ArmResourceRead<LogicWorkflowRun>;
  @doc("Gets a list of workflow runs.")
  list is ArmResourceListByParent<
    LogicWorkflowRun,
    {
      ...BaseParameters<LogicWorkflowRun>;

      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;

      @doc("The filter to apply on the operation. Options for filters include: Status, StartTime, and ClientTrackingId.")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Cancels a workflow run.")
  cancel is ArmResourceActionSync<LogicWorkflowRun, void, void>;
}
