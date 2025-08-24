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
interface RequestHistoryOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Workflow,
          KeyName = "workflowName",
          SegmentName = "workflows",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = WorkflowRun,
          KeyName = "runName",
          SegmentName = "runs",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = WorkflowRunAction,
          KeyName = "actionName",
          SegmentName = "actions",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = WorkflowRunActionRepetitionDefinition,
          KeyName = "repetitionName",
          SegmentName = "repetitions",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = RequestHistory,
        KeyName = "requestHistoryName",
        SegmentName = "requestHistories",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface RequestHistories {
  @doc("Gets a workflow run repetition request history.")
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkflowRunActionRepetitionsRequestHistories_Get")
  get is RequestHistoryOps.Read<RequestHistory>;

  @doc("List a workflow run repetition request history.")
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkflowRunActionRepetitionsRequestHistories_List")
  list is RequestHistoryOps.List<RequestHistory>;
}
@armResourceOperations
interface WorkflowRunActionRequestHistoryOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Workflow,
          KeyName = "workflowName",
          SegmentName = "workflows",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = WorkflowRun,
          KeyName = "runName",
          SegmentName = "runs",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = WorkflowRunAction,
          KeyName = "actionName",
          SegmentName = "actions",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = RequestHistory,
        KeyName = "requestHistoryName",
        SegmentName = "requestHistories",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface WorkflowRunActionRequestHistories {
  @doc("Gets a workflow run request history.")
  get is WorkflowRunActionRequestHistoryOps.Read<RequestHistory>;

  @doc("List a workflow run request history.")
  list is WorkflowRunActionRequestHistoryOps.List<RequestHistory>;
}

@@doc(RequestHistory.name, "The request history name.");
@@doc(RequestHistory.properties, "The request history properties.");
