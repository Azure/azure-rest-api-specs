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

namespace Microsoft.Logic;
@doc("The request history.")
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
  @doc("Gets a workflow run repetition request history.")
  get is ArmResourceRead<RequestHistory>;

  @doc("List a workflow run repetition request history.")
  list is ArmResourceListByParent<RequestHistory>;
}

@@doc(RequestHistory.name, "The request history name.");
@@doc(RequestHistory.properties, "The request history properties.");
