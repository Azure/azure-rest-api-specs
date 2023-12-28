import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WorkflowRunActionRepetitionDefinition.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Logic;
@doc("The request history.")
@parentResource(WorkflowRunActionRepetitionDefinition)
model RequestHistory is TrackedResource<RequestHistoryProperties> {
  @doc("The request history name.")
  @key("requestHistoryName")
  @segment("requestHistories")
  name: string;
}

@armResourceOperations
interface WorkflowRunActionRepetitionsRequestHistories {
  @doc("Gets a workflow run repetition request history.")
  get is ArmResourceRead<RequestHistory>;
  @doc("List a workflow run repetition request history.")
  list is ArmResourceListByParent<RequestHistory>;
}
