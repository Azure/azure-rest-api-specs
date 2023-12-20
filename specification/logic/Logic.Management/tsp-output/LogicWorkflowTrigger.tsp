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
@doc("The workflow trigger.")
@parentResource(LogicWorkflow)
model LogicWorkflowTrigger is ProxyResource<WorkflowTriggerProperties> {
  @doc("The workflow trigger name.")
  @path
  @key("triggerName")
  @segment("triggers")
  name: string;
}

@armResourceOperations
interface LogicWorkflowTriggers {
  @doc("Gets a workflow trigger.")
  get is ArmResourceRead<LogicWorkflowTrigger>;
  @doc("Gets a list of workflow triggers.")
  list is ArmResourceListByParent<
    LogicWorkflowTrigger,
    {
      ...BaseParameters<LogicWorkflowTrigger>;

      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Resets a workflow trigger.")
  reset is ArmResourceActionSync<LogicWorkflowTrigger, void, void>;
  @doc("Runs a workflow trigger.")
  run is ArmResourceActionSync<LogicWorkflowTrigger, void, void>;
  @doc("Sets the state of a workflow trigger.")
  setState is ArmResourceActionSync<
    LogicWorkflowTrigger,
    SetTriggerStateActionDefinition,
    void
  >;
  @doc("Get the callback URL for a workflow trigger.")
  listCallbackUrl is ArmResourceActionSync<
    LogicWorkflowTrigger,
    void,
    WorkflowTriggerCallbackUrl
  >;
  @doc("Get the trigger schema as JSON.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/triggers/{triggerName}/schemas/json")
  @get
  GetSchemaJson is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription id.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("The workflow name.")
      @path
      workflowName: string;

      @doc("The workflow trigger name.")
      @path
      triggerName: string;
    },
    JsonSchema
  >;
}
