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
interface WorkflowRunActionRepetitionDefinitions {
  @doc("Get a workflow run action repetition.")
  get is ArmResourceRead<WorkflowRunActionRepetitionDefinition>;

  @doc("Get all of a workflow run action repetitions.")
  list is ArmResourceListByParent<
    WorkflowRunActionRepetitionDefinition,
    Response = ArmResponse<WorkflowRunActionRepetitionDefinitionCollection>
  >;

  @doc("Lists a workflow run expression trace.")
  listExpressionTraces is ArmResourceActionSync<
    WorkflowRunActionRepetitionDefinition,
    void,
    ArmResponse<ExpressionTraces>
  >;
}

@@doc(WorkflowRunActionRepetitionDefinition.name, "The workflow repetition.");
@@doc(WorkflowRunActionRepetitionDefinition.properties,
  "The workflow run action repetition properties definition."
);
