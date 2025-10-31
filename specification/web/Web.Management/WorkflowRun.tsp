import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * The workflow run.
 */
@parentResource(Site)
model WorkflowRun
  is Azure.ResourceManager.ProxyResource<WorkflowRunProperties> {
  ...ResourceNameParameter<
    Resource = WorkflowRun,
    KeyName = "runName",
    SegmentName = "runs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface WorkflowRunsOps
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
      },
      {
        /** The workflow run name. */
        @path
        @segment("runs")
        @key
        runName: string,
      }
    > {}

@armResourceOperations
interface WorkflowRuns {
  /**
   * Gets a workflow run.
   */
  get is WorkflowRunsOps.Read<WorkflowRun, OverrideErrorType = ErrorResponse>;

  /**
   * Gets a list of workflow runs.
   */
  list is WorkflowRunsOps.List<
    WorkflowRun,
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
   * Cancels a workflow run.
   */
  cancel is WorkflowRunsOps.ActionSync<
    WorkflowRun,
    void,
    {
      @body body: void;
    },
    OverrideErrorType = ErrorResponse
  >;
}

@@doc(WorkflowRun.name, "The workflow run name.");
@@doc(WorkflowRun.properties, "The workflow run properties.");
