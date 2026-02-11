import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkflowRunActionRepetitionDefinition.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * The request history.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/beyond-nesting-levels" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(WorkflowRunActionRepetitionDefinition)
model RequestHistory
  is Azure.ResourceManager.TrackedResource<RequestHistoryProperties> {
  ...ResourceNameParameter<
    Resource = RequestHistory,
    KeyName = "requestHistoryName",
    SegmentName = "requestHistories",
    NamePattern = ""
  >;
}

@armResourceOperations
interface RequestHistoryOps
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

        /** The workflow action name. */
        @path
        @segment("actions")
        @key
        actionName: string,

        /** The workflow repetition. */
        @path
        @segment("repetitions")
        @key
        repetitionName: string,
      },
      {
        /** The workflow repetition. */
        @path
        @segment("requestHistories")
        @key
        requestHistoryName: string,
      }
    > {}

@armResourceOperations
interface RequestHistories {
  /**
   * Gets a workflow run repetition request history.
   */
  get is RequestHistoryOps.Read<
    RequestHistory,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * List a workflow run repetition request history.
   */
  list is RequestHistoryOps.List<
    RequestHistory,
    OverrideErrorType = ErrorResponse
  >;
}

@@doc(RequestHistory.name, "The request history name.");
@@doc(RequestHistory.properties, "The request history properties.");
