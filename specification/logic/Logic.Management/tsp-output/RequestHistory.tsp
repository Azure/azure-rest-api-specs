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
/**
 * The request history.
 */
@parentResource(WorkflowRunActionRepetitionDefinition)
model RequestHistory is TrackedResource<RequestHistoryProperties> {
  /**
   * The request history name.
   */
  @path
  @key("requestHistoryName")
  @segment("requestHistories")
  name: string;
}

@armResourceOperations
interface RequestHistories {
  /**
   * Gets a workflow run repetition request history.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkflowRunActionRepetitionsRequestHistories_Get")
  get is ArmResourceRead<RequestHistory>;

  /**
   * List a workflow run repetition request history.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkflowRunActionRepetitionsRequestHistories_List")
  list is ArmResourceListByParent<RequestHistory>;
}
