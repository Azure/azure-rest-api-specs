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
@doc("The workflow trigger history.")
@parentResource(WorkflowTrigger)
model WorkflowTriggerHistory
  is ProxyResource<WorkflowTriggerHistoryProperties> {
  @doc("The workflow trigger history name. Corresponds to the run name for triggers that resulted in a run.")
  @path
  @key("historyName")
  @segment("histories")
  name: string;
}

@armResourceOperations
interface WorkflowTriggerHistories {
  @doc("Gets a workflow trigger history.")
  get is ArmResourceRead<WorkflowTriggerHistory>;

  @doc("Gets a list of workflow trigger histories.")
  list is ArmResourceListByParent<
    WorkflowTriggerHistory,
    {
      ...BaseParameters<WorkflowTriggerHistory>;

      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;

      @doc("The filter to apply on the operation. Options for filters include: Status, StartTime, and ClientTrackingId.")
      @query("$filter")
      $filter?: string;
    }
  >;

  @doc("Resubmits a workflow run based on the trigger history.")
  resubmit is ArmResourceActionNoContentSync<WorkflowTriggerHistory, void>;
}
