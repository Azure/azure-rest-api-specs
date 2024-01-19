import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkflowRun.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
@doc("The workflow run action.")
@parentResource(WorkflowRun)
model WorkflowRunAction is ProxyResource<WorkflowRunActionProperties> {
  @doc("The workflow action name.")
  @path
  @key("actionName")
  @segment("actions")
  name: string;
}

@armResourceOperations
interface WorkflowRunActions {
  @doc("Gets a workflow run action.")
  get is ArmResourceRead<WorkflowRunAction>;

  @doc("Gets a list of workflow run actions.")
  list is ArmResourceListByParent<
    WorkflowRunAction,
    {
      ...BaseParameters<WorkflowRunAction>;

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
    WorkflowRunAction,
    void,
    ExpressionTraces
  >;
}
