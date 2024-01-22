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
/**
 * The workflow run action.
 */
@parentResource(WorkflowRun)
model WorkflowRunAction is ProxyResource<WorkflowRunActionProperties> {
  /**
   * The workflow action name.
   */
  @path
  @key("actionName")
  @segment("actions")
  name: string;
}

@armResourceOperations
interface WorkflowRunActions {
  /**
   * Gets a workflow run action.
   */
  get is ArmResourceRead<WorkflowRunAction>;

  /**
   * Gets a list of workflow run actions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkflowRunActions_List")
  list is ArmResourceListByParent<
    WorkflowRunAction,
    {
      ...BaseParameters<WorkflowRunAction>;

      /**
       * The number of items to be included in the result.
       */
      @query("$top")
      $top?: int32;

      /**
       * The filter to apply on the operation. Options for filters include: Status.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Lists a workflow run expression trace.
   */
  listExpressionTraces is ArmResourceActionSync<
    WorkflowRunAction,
    void,
    ExpressionTraces
  >;
}
