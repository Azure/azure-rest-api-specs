import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./LogicWorkflowRun.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Logic;
@doc("The workflow run action.")
@parentResource(LogicWorkflowRun)
model LogicWorkflowRunAction is ProxyResource<WorkflowRunActionProperties> {
  @doc("The workflow action name.")
  @path
  @key("actionName")
  @segment("actions")
  name: string;
}

@armResourceOperations
interface LogicWorkflowRunActions {
  @doc("Gets a workflow run action.")
  get is ArmResourceRead<LogicWorkflowRunAction>;
  @doc("Gets a list of workflow run actions.")
  list is ArmResourceListByParent<
    LogicWorkflowRunAction,
    {
      ...BaseParameters<LogicWorkflowRunAction>;

      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;

      @doc("The filter to apply on the operation. Options for filters include: Status.")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Lists a workflow run expression trace.")
  listExpressionTraces is ArmResourceActionSync<
    LogicWorkflowRunAction,
    void,
    ExpressionTraces
  >;
}
