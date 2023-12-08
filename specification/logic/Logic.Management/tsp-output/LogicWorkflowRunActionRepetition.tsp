import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./LogicWorkflowRunAction.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Logic;
@doc("The workflow run action repetition definition.")
@parentResource(LogicWorkflowRunAction)
model LogicWorkflowRunActionRepetition
  is TrackedResource<WorkflowRunActionRepetitionProperties> {
  @doc("The workflow repetition.")
  @path
  @key("repetitionName")
  @segment("repetitions")
  name: string;
}

@armResourceOperations
interface LogicWorkflowRunActionRepetitions {
  @doc("Get a workflow run action repetition.")
  get is ArmResourceRead<LogicWorkflowRunActionRepetition>;
  @doc("Get all of a workflow run action repetitions.")
  list is ArmResourceListByParent<LogicWorkflowRunActionRepetition>;
  @doc("Lists a workflow run expression trace.")
  listExpressionTraces is ArmResourceActionSync<
    LogicWorkflowRunActionRepetition,
    {},
    ExpressionTraces
  >;
}
