import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Workflow.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Logic;
@doc("The workflow version.")
@parentResource(Workflow)
model WorkflowVersion is TrackedResource<WorkflowVersionProperties> {
  @doc("The workflow versionId.")
  @key("versionId")
  @segment("versions")
  name: string;
}

@armResourceOperations
interface WorkflowVersions {
  @doc("Gets a workflow version.")
  get is ArmResourceRead<WorkflowVersion>;
  @doc("Gets a list of workflow versions.")
  list is ArmResourceListByParent<
    WorkflowVersion,
    {
      ...BaseParameters<WorkflowVersion>;

      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;
    }
  >;
}

@armResourceOperations
interface WorkflowVersionTriggers {
  @doc("Get the callback url for a trigger of a workflow version.")
  listCallbackUrl is ArmResourceActionSync<
    WorkflowVersion,
    GetCallbackUrlParameters,
    WorkflowTriggerCallbackUrl,
    {
      ...BaseParameters<WorkflowVersion>;

      @doc("The workflow trigger name.")
      @path
      triggerName: string;
    }
  >;
}
