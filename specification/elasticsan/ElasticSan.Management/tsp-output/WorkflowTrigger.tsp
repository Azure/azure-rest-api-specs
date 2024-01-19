import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workflow.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
@doc("The workflow trigger.")
@parentResource(Workflow)
model WorkflowTrigger is ProxyResource<WorkflowTriggerProperties> {
  @doc("The workflow trigger name.")
  @path
  @key("triggerName")
  @segment("triggers")
  name: string;
}

@armResourceOperations
interface WorkflowTriggers {
  @doc("Gets a workflow trigger.")
  get is ArmResourceRead<WorkflowTrigger>;

  @doc("Gets a list of workflow triggers.")
  list is ArmResourceListByParent<
    WorkflowTrigger,
    {
      ...BaseParameters<WorkflowTrigger>;

      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;

  @doc("Resets a workflow trigger.")
  reset is ArmResourceActionSync<WorkflowTrigger, void, void>;

  @doc("Runs a workflow trigger.")
  run is ArmResourceActionSync<WorkflowTrigger, void, void>;

  @doc("Sets the state of a workflow trigger.")
  setState is ArmResourceActionSync<
    WorkflowTrigger,
    SetTriggerStateActionDefinition,
    void
  >;

  @doc("Get the callback URL for a workflow trigger.")
  listCallbackUrl is ArmResourceActionSync<
    WorkflowTrigger,
    void,
    WorkflowTriggerCallbackUrl
  >;

  @doc("Get the trigger schema as JSON.")
  // FIXME: WorkflowTriggers_GetSchemaJson could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/triggers/{triggerName}/schemas/json")
  @get
  getSchemaJson is Azure.Core.Foundations.Operation<
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

@@projectedName(WorkflowTriggers.setState::parameters.body, "json", "setState");
@@extension(WorkflowTriggers.setState::parameters.body,
  "x-ms-client-name",
  "setState"
);
@@doc(WorkflowTriggers.setState::parameters.body,
  "The workflow trigger state."
);
