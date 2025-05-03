import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workflow.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
@doc("The workflow run.")
@parentResource(Workflow)
model WorkflowRun
  is Azure.ResourceManager.ProxyResource<WorkflowRunProperties> {
  ...ResourceNameParameter<
    Resource = WorkflowRun,
    KeyName = "runName",
    SegmentName = "runs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface WorkflowRunOps
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
      },
      KeysOf<ResourceNameParameter<
        Resource = WorkflowRun,
        KeyName = "runName",
        SegmentName = "runs",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface WorkflowRuns {
  @doc("Gets a workflow run.")
  get is WorkflowRunOps.Read<WorkflowRun>;

  @doc("Cancels a workflow run.")
  cancel is WorkflowRunOps.ActionSync<WorkflowRun, void, OkResponse>;
}
@armResourceOperations
interface WorkflowRunOperationOps
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
      },
      KeysOf<ResourceNameParameter<
        Resource = WorkflowRun,
        KeyName = "operationId",
        SegmentName = "operations",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface WorkflowRunOperations {
  @doc("Gets an operation for a run.")
  get is WorkflowRunOperationOps.Read<WorkflowRun>;

  @doc("Gets a list of workflow runs.")
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkflowRuns_List")
  list is WorkflowRunOperationOps.List<
    WorkflowRun,
    Parameters = {
      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;

      @doc("The filter to apply on the operation. Options for filters include: Status, StartTime, and ClientTrackingId.")
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@doc(WorkflowRun.name, "The workflow run name.");
@@doc(WorkflowRun.properties, "The workflow run properties.");
