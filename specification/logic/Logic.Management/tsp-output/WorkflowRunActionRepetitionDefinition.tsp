import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WorkflowRunAction.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Logic;
@doc("The workflow run action repetition definition.")
@parentResource(WorkflowRunAction)
model WorkflowRunActionRepetitionDefinition
  is TrackedResource<WorkflowRunActionRepetitionProperties> {
  @doc("The workflow repetition.")
  @key("repetitionName")
  @segment("repetitions")
  name: string;
}

@armResourceOperations
interface WorkflowRunActionRepetitions {
  @doc("Get a workflow run action repetition.")
  get is ArmResourceRead<WorkflowRunActionRepetitionDefinition>;
  @doc("Get all of a workflow run action repetitions.")
  list is ArmResourceListByParent<WorkflowRunActionRepetitionDefinition>;
  @doc("Lists a workflow run expression trace.")
  listExpressionTraces is ArmResourceActionSync<
    WorkflowRunActionRepetitionDefinition,
    void,
    ExpressionTraces
  >;
}
