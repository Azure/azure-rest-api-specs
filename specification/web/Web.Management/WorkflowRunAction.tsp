import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkflowRun.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * The workflow run action.
 */
@parentResource(WorkflowRun)
model WorkflowRunAction
  is Azure.ResourceManager.ProxyResource<WorkflowRunActionProperties> {
  ...ResourceNameParameter<
    Resource = WorkflowRunAction,
    KeyName = "actionName",
    SegmentName = "actions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface WorkflowRunActionsOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site name. */
        @path
        @segment("sites")
        @key
        name: string,

        /** undefined */
        @path
        @segment("hostruntime")
        @key
        runtime: "runtime",

        /** undefined */
        @path
        @segment("webhooks")
        @key
        workflow: "workflow",

        /** undefined */
        @path
        @segment("api")
        @key
        management: "management",

        /** The workflow name. */
        @path
        @segment("workflows")
        @key
        workflowName: string,

        /** The workflow run name. */
        @path
        @segment("runs")
        @key
        runName: string,
      },
      {
        /** The workflow action name. */
        @path
        @segment("actions")
        @key
        actionName: string,
      }
    > {}

@armResourceOperations
interface WorkflowRunActions {
  /**
   * Gets a workflow run action.
   */
  get is WorkflowRunActionsOps.Read<
    WorkflowRunAction,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets a list of workflow run actions.
   */
  list is WorkflowRunActionsOps.List<
    WorkflowRunAction,
    Parameters = {
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
    },
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Lists a workflow run expression trace.
   */
  @list
  listExpressionTraces is WorkflowRunActionsOps.ActionSync<
    WorkflowRunAction,
    void,
    ArmResponse<ExpressionTraces>,
    OverrideErrorType = ErrorResponse
  >;
}

@@doc(WorkflowRunAction.name, "The workflow action name.");
@@doc(WorkflowRunAction.properties, "The workflow run action properties.");
