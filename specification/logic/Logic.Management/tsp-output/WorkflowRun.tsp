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
@doc("The workflow run.")
@parentResource(Workflow)
model WorkflowRun is ProxyResource<WorkflowRunProperties> {
  @doc("The workflow run name.")
  @path
  @key("runName")
  @segment("runs")
  name: string;
}

@armResourceOperations
interface WorkflowRuns {
  @doc("Gets a workflow run.")
  get is ArmResourceRead<WorkflowRun>;

  @doc("Gets a list of workflow runs.")
  list is ArmResourceListByParent<
    WorkflowRun,
    {
      ...BaseParameters<WorkflowRun>;

      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;

      @doc("The filter to apply on the operation. Options for filters include: Status, StartTime, and ClientTrackingId.")
      @query("$filter")
      $filter?: string;
    }
  >;

  @doc("Cancels a workflow run.")
  cancel is ArmResourceActionSync<WorkflowRun, void, void>;
}
