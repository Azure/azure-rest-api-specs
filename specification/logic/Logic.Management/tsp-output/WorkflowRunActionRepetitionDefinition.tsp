import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkflowRunAction.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
@doc("The workflow run action repetition definition.")
@parentResource(WorkflowRunAction)
model WorkflowRunActionRepetitionDefinition
  is TrackedResource<WorkflowRunActionRepetitionProperties> {
  @doc("The workflow repetition.")
  @path
  @key("repetitionName")
  @segment("repetitions")
  name: string;
}

@armResourceOperations
interface WorkflowRunActionRepetitionDefinitions {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a workflow run action repetition.")
  @operationId("WorkflowRunActionRepetitions_Get")
  get is ArmResourceRead<WorkflowRunActionRepetitionDefinition>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get all of a workflow run action repetitions.")
  @operationId("WorkflowRunActionRepetitions_List")
  list is ArmResourceListByParent<WorkflowRunActionRepetitionDefinition>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists a workflow run expression trace.")
  @operationId("WorkflowRunActionRepetitions_ListExpressionTraces")
  listExpressionTraces is ArmResourceActionSync<
    WorkflowRunActionRepetitionDefinition,
    void,
    ExpressionTraces
  >;
}
