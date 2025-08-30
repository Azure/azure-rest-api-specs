import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkflowRunActionRepetitionDefinition.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * The request history.
 */
@parentResource(WorkflowRunActionRepetitionDefinition)
model RequestHistory
  is Azure.ResourceManager.TrackedResource<RequestHistoryProperties> {
  ...ResourceNameParameter<
    Resource = RequestHistory,
    KeyName = "requestHistoryName",
    SegmentName = "requestHistories",
    NamePattern = ""
  >;
}

@armResourceOperations
interface RequestHistories {
  /**
   * Gets a workflow run repetition request history.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkflowRunActionRepetitionsRequestHistories_Get")
  get is ArmResourceRead<RequestHistory>;

  /**
   * List a workflow run repetition request history.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkflowRunActionRepetitionsRequestHistories_List")
  list is ArmResourceListByParent<RequestHistory>;
}

@@doc(RequestHistory.name, "The request history name.");
@@doc(RequestHistory.properties, "The request history properties.");
