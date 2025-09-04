import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * The workflow trigger.
 */
@parentResource(Site)
model WorkflowTrigger
  is Azure.ResourceManager.ProxyResource<WorkflowTriggerProperties> {
  ...ResourceNameParameter<
    Resource = WorkflowTrigger,
    KeyName = "triggerName",
    SegmentName = "triggers",
    NamePattern = ""
  >;
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
  list is ArmResourceListByParent<
    WorkflowTrigger,
    Parameters = {
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
   * Get the callback URL for a workflow trigger.
   */
  listCallbackUrl is ArmResourceActionSync<
    WorkflowTrigger,
    void,
    ArmResponse<WorkflowTriggerCallbackUrl>
  >;

  /**
   * Runs a workflow trigger.
   */
  run is ArmResourceActionAsync<WorkflowTrigger, void, OkResponse>;

  /**
   * Get the trigger schema as JSON.
   */
  @get
  @action("json")
  getSchemaJson is ArmResourceActionSync<
    WorkflowTrigger,
    void,
    ArmResponse<JsonSchema>
  >;
}

@@doc(WorkflowTrigger.name, "The workflow trigger name.");
@@doc(WorkflowTrigger.properties, "The workflow trigger properties.");
