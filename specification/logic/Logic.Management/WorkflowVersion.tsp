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
@doc("The workflow version.")
@parentResource(Workflow)
model WorkflowVersion
  is Azure.ResourceManager.TrackedResource<WorkflowVersionProperties> {
  ...ResourceNameParameter<
    Resource = WorkflowVersion,
    KeyName = "versionId",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface WorkflowVersions {
  @doc("Gets a workflow version.")
  get is ArmResourceRead<WorkflowVersion>;

  @doc("Gets a list of workflow versions.")
  list is ArmResourceListByParent<
    WorkflowVersion,
    Parameters = {
      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;
    }
  >;

  @doc("Get the callback url for a trigger of a workflow version.")
  listCallbackUrl is ArmResourceActionSync<
    WorkflowVersion,
    {
      @doc("The callback URL parameters.")
      @bodyRoot
      parameters?: GetCallbackUrlParameters;
    },
    ArmResponse<WorkflowTriggerCallbackUrl>,
    Parameters = {
      @doc("The workflow trigger name.")
      @path
      triggerName: string;
    }
  >;
}

@@doc(WorkflowVersion.name, "The workflow versionId.");
@@doc(WorkflowVersion.properties, "The workflow version properties.");
