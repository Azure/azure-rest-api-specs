import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkflowTrigger.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * The workflow trigger history.
 */
@parentResource(WorkflowTrigger)
model WorkflowTriggerHistory
  is Azure.ResourceManager.ProxyResource<WorkflowTriggerHistoryProperties> {
  ...ResourceNameParameter<
    Resource = WorkflowTriggerHistory,
    KeyName = "historyName",
    SegmentName = "histories",
    NamePattern = ""
  >;
}

@armResourceOperations
interface WorkflowTriggerHistoriesOps
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

        /** The workflow trigger name. */
        @path
        @segment("triggers")
        @key
        triggerName: string,
      },
      {
        /** The workflow trigger history name. Corresponds to the run name for triggers that resulted in a run. */
        @path
        @segment("histories")
        @key
        historyName: string,
      }
    > {}

@armResourceOperations
interface WorkflowTriggerHistories {
  /**
   * Gets a workflow trigger history.
   */
  get is WorkflowTriggerHistoriesOps.Read<
    WorkflowTriggerHistory,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets a list of workflow trigger histories.
   */
  list is WorkflowTriggerHistoriesOps.List<
    WorkflowTriggerHistory,
    Parameters = {
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
    },
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Resubmits a workflow run based on the trigger history.
   */
  resubmit is WorkflowTriggerHistoriesOps.ActionAsync<
    WorkflowTriggerHistory,
    Request = void,
    Result = void,
    Response = ArmAcceptedLroResponse,
    OverrideErrorType = ErrorResponse
  >;
}

@@doc(WorkflowTriggerHistory.name,
  "The workflow trigger history name. Corresponds to the run name for triggers that resulted in a run."
);
@@doc(WorkflowTriggerHistory.properties,
  "Gets the workflow trigger history properties."
);
