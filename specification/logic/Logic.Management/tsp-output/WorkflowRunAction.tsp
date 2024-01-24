import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkflowRun.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
/**
 * The workflow run action.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(WorkflowRun)
@Azure.ResourceManager.Private.armResourceInternal(WorkflowRunActionProperties)
@includeInapplicableMetadataInPayload(false)
model WorkflowRunAction extends SubResource {
  /**
   * The workflow action name.
   */
  @path
  @key("actionName")
  @segment("actions")
  name: string;

  /**
   * The workflow run action properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkflowRunActionProperties;
}

@armResourceOperations
interface WorkflowRunActions {
  /**
   * Gets a workflow run action.
   */
  get is ArmResourceRead<WorkflowRunAction>;

  /**
   * Gets a list of workflow run actions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkflowRunActions_List")
  list is ArmResourceListByParent<
    WorkflowRunAction,
    {
      ...BaseParameters<WorkflowRunAction>;

      /**
       * The number of items to be included in the result.
       */
      @query("$top")
      $top?: int32;

      /**
       * The filter to apply on the operation. Options for filters include: Status.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Lists a workflow run expression trace.
   */
  listExpressionTraces is ArmResourceActionSync<
    WorkflowRunAction,
    void,
    ExpressionTraces
  >;
}
