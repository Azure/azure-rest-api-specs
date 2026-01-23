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
 * The workflow trigger.
 */
@parentResource(Site)
model WorkflowTrigger
  is Azure.ResourceManager.ProxyResource<WorkflowTriggerProperties> {
  ...ResourceNameParameter<
    Resource = WorkflowTrigger,
    KeyName = "triggerName",
    SegmentName = "triggers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface WorkflowTriggersOps
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
        /** The workflow trigger name. */
        @path
        @segment("triggers")
        @key
        triggerName: string,
      }
    > {}

@armResourceOperations
interface WorkflowTriggers {
  /**
   * Gets a workflow trigger.
   */
  get is WorkflowTriggersOps.Read<
    WorkflowTrigger,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets a list of workflow triggers.
   */
  list is WorkflowTriggersOps.List<
    WorkflowTrigger,
    Parameters = {
      /**
       * The number of items to be included in the result.
       */
      @query("$top")
      $top?: int32;

      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    },
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Get the callback URL for a workflow trigger.
   */
  listCallbackUrl is WorkflowTriggersOps.ActionSync<
    WorkflowTrigger,
    void,
    ArmResponse<WorkflowTriggerCallbackUrl>,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Runs a workflow trigger.
   */
  run is WorkflowTriggersOps.ActionAsync<
    WorkflowTrigger,
    void,
    {
      @body body: void;
    },
    OverrideErrorType = ErrorResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Get the trigger schema as JSON.
   */
  @get
  @action("schemas/json")
  getSchemaJson is WorkflowTriggersOps.ActionSync<
    WorkflowTrigger,
    void,
    ArmResponse<JsonSchema>,
    OverrideErrorType = ErrorResponse
  >;
}

@@doc(WorkflowTrigger.name, "The workflow trigger name.");
@@doc(WorkflowTrigger.properties, "The workflow trigger properties.");
