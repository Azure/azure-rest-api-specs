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
interface WorkflowRuns {
  @doc("Gets a workflow run.")
  get is ArmResourceRead<WorkflowRun>;

  @doc("Cancels a workflow run.")
  cancel is ArmResourceActionSync<WorkflowRun, void, OkResponse>;
}

@@doc(WorkflowRun.name, "The workflow run name.");
@@doc(WorkflowRun.properties, "The workflow run properties.");
