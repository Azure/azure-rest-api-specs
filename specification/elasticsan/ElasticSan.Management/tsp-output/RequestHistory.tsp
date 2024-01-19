import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkflowRunActionRepetitionDefinition.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
@doc("The request history.")
@parentResource(WorkflowRunActionRepetitionDefinition)
model RequestHistory is TrackedResource<RequestHistoryProperties> {
  @doc("The request history name.")
  @path
  @key("requestHistoryName")
  @segment("requestHistories")
  name: string;
}

@armResourceOperations
interface RequestHistories {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a workflow run repetition request history.")
  @operationId("WorkflowRunActionRepetitionsRequestHistories_Get")
  get is ArmResourceRead<RequestHistory>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List a workflow run repetition request history.")
  @operationId("WorkflowRunActionRepetitionsRequestHistories_List")
  list is ArmResourceListByParent<RequestHistory>;
}
