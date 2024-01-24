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
/**
 * The workflow trigger.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Workflow)
@Azure.ResourceManager.Private.armResourceInternal(WorkflowTriggerProperties)
@includeInapplicableMetadataInPayload(false)
model WorkflowTrigger extends SubResource {
  /**
   * The workflow trigger name.
   */
  @path
  @key("triggerName")
  @segment("triggers")
  name: string;

  /**
   * The workflow trigger properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkflowTriggerProperties;
}

@armResourceOperations
interface WorkflowTriggers {
  /**
   * Gets a workflow trigger.
   */
  get is ArmResourceRead<WorkflowTrigger>;

  /**
   * Gets a list of workflow triggers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkflowTriggers_List")
  list is ArmResourceListByParent<
    WorkflowTrigger,
    {
      ...BaseParameters<WorkflowTrigger>;

      /**
       * The number of items to be included in the result.
       */
      @query("$top")
      $top?: int32;

      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Resets a workflow trigger.
   */
  reset is ArmResourceActionSync<WorkflowTrigger, void, void>;

  /**
   * Runs a workflow trigger.
   */
  run is ArmResourceActionSync<WorkflowTrigger, void, void>;

  /**
   * Sets the state of a workflow trigger.
   */
  setState is ArmResourceActionSync<
    WorkflowTrigger,
    SetTriggerStateActionDefinition,
    void
  >;

  /**
   * Get the callback URL for a workflow trigger.
   */
  listCallbackUrl is ArmResourceActionSync<
    WorkflowTrigger,
    void,
    WorkflowTriggerCallbackUrl
  >;

  /**
   * Get the trigger schema as JSON.
   */
  // FIXME: WorkflowTriggers_GetSchemaJson could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/triggers/{triggerName}/schemas/json")
  @get
  getSchemaJson is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription id.
       */
      @path
      subscriptionId: string;

      /**
       * The resource group name.
       */
      @path
      resourceGroupName: string;

      /**
       * The workflow name.
       */
      @path
      workflowName: string;

      /**
       * The workflow trigger name.
       */
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
