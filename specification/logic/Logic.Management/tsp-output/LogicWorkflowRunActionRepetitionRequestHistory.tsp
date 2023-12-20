import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./LogicWorkflowRunActionRepetition.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Logic;
@doc("The request history.")
@parentResource(LogicWorkflowRunActionRepetition)
model LogicWorkflowRunActionRepetitionRequestHistory
  is TrackedResource<RequestHistoryProperties> {
  @doc("The request history name.")
  @path
  @key("requestHistoryName")
  @segment("requestHistories")
  name: string;
}

@armResourceOperations
interface LogicWorkflowRunActionRepetitionRequestHistories {
  @doc("Gets a workflow run repetition request history.")
  get is ArmResourceRead<LogicWorkflowRunActionRepetitionRequestHistory>;
  @doc("List a workflow run repetition request history.")
  list is ArmResourceListByParent<LogicWorkflowRunActionRepetitionRequestHistory>;
}
