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

namespace Microsoft.Logic;
@doc("The workflow run action repetition definition.")
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
        ...KeysOf<ResourceNameParameter<
          Resource = Workflow,
          KeyName = "workflowName",
          SegmentName = "workflows",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = WorkflowRun,
          KeyName = "runName",
          SegmentName = "runs",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = WorkflowRunAction,
          KeyName = "actionName",
          SegmentName = "actions",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = WorkflowRunActionRepetitionDefinition,
        KeyName = "repetitionName",
        SegmentName = "repetitions",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface WorkflowRunActionRepetitionDefinitions {
  @doc("Get a workflow run action repetition.")
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkflowRunActionRepetitions_Get")
  get is WorkflowRunActionRepetitionDefinitionOps.Read<WorkflowRunActionRepetitionDefinition>;

  // @doc("Get all of a workflow run action repetitions.")
  // #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  // @operationId("WorkflowRunActionRepetitions_List")
  // list is WorkflowRunActionRepetitionDefinitionOps.List<
  //   WorkflowRunActionRepetitionDefinition,
  //   Response = ArmResponse<WorkflowRunActionRepetitionDefinitionCollection>
  // >;

  @doc("Lists a workflow run expression trace.")
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkflowRunActionRepetitions_ListExpressionTraces")
  listExpressionTraces is WorkflowRunActionRepetitionDefinitionOps.ActionSync<
    WorkflowRunActionRepetitionDefinition,
    void,
    ArmResponse<ExpressionTraces>
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
        ...KeysOf<ResourceNameParameter<
          Resource = Workflow,
          KeyName = "workflowName",
          SegmentName = "workflows",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = WorkflowRun,
          KeyName = "runName",
          SegmentName = "runs",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = WorkflowRunAction,
          KeyName = "actionName",
          SegmentName = "actions",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = WorkflowRunActionRepetitionDefinition,
        KeyName = "repetitionName",
        SegmentName = "scopeRepetitions",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface WorkflowRunActionScopeRepetitions {
  @doc("Get a workflow run action scoped repetition.")
  get is WorkflowRunActionScopeRepetitionOps.Read<WorkflowRunActionRepetitionDefinition>;

  @doc("List the workflow run action scoped repetitions.")
  list is WorkflowRunActionScopeRepetitionOps.List<
    WorkflowRunActionRepetitionDefinition,
    Response = ArmResponse<WorkflowRunActionRepetitionDefinitionCollection>
  >;
}

@@doc(WorkflowRunActionRepetitionDefinition.name, "The workflow repetition.");
@@doc(WorkflowRunActionRepetitionDefinition.properties,
  "The workflow run action repetition properties definition."
);
