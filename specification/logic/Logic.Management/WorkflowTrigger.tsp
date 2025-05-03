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
@doc("The workflow trigger.")
@parentResource(Workflow)
model WorkflowTrigger
  is Azure.ResourceManager.ProxyResource<WorkflowTriggerProperties> {
  ...ResourceNameParameter<
    Resource = WorkflowTrigger,
    KeyName = "triggerName",
    SegmentName = "triggers",
    NamePattern = "[a-zA-Z0-9_.()-]{0,79}$"
  >;
}

@armResourceOperations
interface WorkflowTriggers {
  @doc("Gets a workflow trigger.")
  get is ArmResourceRead<WorkflowTrigger>;

  @doc("Gets a list of workflow triggers.")
  list is ArmResourceListByParent<
    WorkflowTrigger,
    Parameters = {
      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;

  @doc("Resets a workflow trigger.")
  reset is ArmResourceActionSync<WorkflowTrigger, void, OkResponse>;

  @doc("Runs a workflow trigger.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "For backward compatibility"
  run is ArmResourceActionSync<
    WorkflowTrigger,
    void,
    OkResponse | ArmAcceptedLroResponse
  >;

  @doc("Get the trigger schema as JSON.")
  @get
  @action("json")
  getSchemaJson is ArmResourceActionSync<
    WorkflowTrigger,
    void,
    ArmResponse<JsonSchema>
  >;

  @doc("Sets the state of a workflow trigger.")
  setState is ArmResourceActionSync<
    WorkflowTrigger,
    SetTriggerStateActionDefinition,
    OkResponse
  >;

  @doc("Get the callback URL for a workflow trigger.")
  listCallbackUrl is ArmResourceActionSync<
    WorkflowTrigger,
    void,
    ArmResponse<WorkflowTriggerCallbackUrl>
  >;
}

@@doc(WorkflowTrigger.name, "The workflow trigger name.");
@@doc(WorkflowTrigger.properties, "The workflow trigger properties.");
@@doc(WorkflowTriggers.setState::parameters.body,
  "The workflow trigger state."
);
