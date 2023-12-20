import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./LogicWorkflow.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Logic;
@doc("The workflow version.")
@parentResource(LogicWorkflow)
model LogicWorkflowVersion is TrackedResource<WorkflowVersionProperties> {
  @doc("The workflow versionId.")
  @path
  @key("versionId")
  @segment("versions")
  name: string;
}

@armResourceOperations
interface LogicWorkflowVersions {
  @doc("Gets a workflow version.")
  get is ArmResourceRead<LogicWorkflowVersion>;
  @doc("Gets a list of workflow versions.")
  list is ArmResourceListByParent<
    LogicWorkflowVersion,
    {
      ...BaseParameters<LogicWorkflowVersion>;

      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Get the callback url for a trigger of a workflow version.")
  listCallbackUrl is ArmResourceActionSync<
    LogicWorkflowVersion,
    GetCallbackUrlParameters,
    WorkflowTriggerCallbackUrl,
    {
      ...BaseParameters<LogicWorkflowVersion>;

      @doc("The workflow trigger name.")
      @path
      triggerName: string;
    }
  >;
}
