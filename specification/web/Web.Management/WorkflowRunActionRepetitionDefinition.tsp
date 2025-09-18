import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkflowRunAction.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * The workflow run action repetition definition.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/beyond-nesting-levels" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(WorkflowRunAction)
model WorkflowRunActionRepetitionDefinition
  is Azure.ResourceManager.TrackedResource<
    WorkflowRunActionRepetitionProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = WorkflowRunActionRepetitionDefinition,
    KeyName = "repetitionName",
    SegmentName = "repetitions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface WorkflowRunActionRepetitionDefinitionOps
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
      },
      {
        /** The workflow repetition. */
        @path
        @segment("repetitions")
        @key
        repetitionName: string,
      }
    > {}

@armResourceOperations
interface WorkflowRunActionRepetitionDefinitions {
  /**
   * Get a workflow run action repetition.
   */
  get is WorkflowRunActionRepetitionDefinitionOps.Read<
    WorkflowRunActionRepetitionDefinition,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Get all of a workflow run action repetitions.
   */
  list is WorkflowRunActionRepetitionDefinitionOps.List<
    WorkflowRunActionRepetitionDefinition,
    Response = ArmResponse<WorkflowRunActionRepetitionDefinitionCollection>,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Lists a workflow run expression trace.
   */
  @list
  listExpressionTraces is WorkflowRunActionRepetitionDefinitionOps.ActionSync<
    WorkflowRunActionRepetitionDefinition,
    void,
    ArmResponse<ExpressionTraces>,
    OverrideErrorType = ErrorResponse
  >;
}
@armResourceOperations
interface WorkflowRunActionScopeRepetitionOps
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
      },
      {
        /** The workflow repetition. */
        @path
        @segment("scopeRepetitions")
        @key
        repetitionName: string,
      }
    > {}

@armResourceOperations
interface WorkflowRunActionScopeRepetitions {
  /**
   * Get a workflow run action scoped repetition.
   */
  get is WorkflowRunActionScopeRepetitionOps.Read<
    WorkflowRunActionRepetitionDefinition,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * List the workflow run action scoped repetitions.
   */
  list is WorkflowRunActionScopeRepetitionOps.List<
    WorkflowRunActionRepetitionDefinition,
    Response = ArmResponse<WorkflowRunActionRepetitionDefinitionCollection>,
    OverrideErrorType = ErrorResponse
  >;
}

@@doc(WorkflowRunActionRepetitionDefinition.name, "The workflow repetition.");
@@doc(WorkflowRunActionRepetitionDefinition.properties,
  "The workflow run action repetition properties definition."
);
