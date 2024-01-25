import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkflowRunAction.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
/**
 * The workflow run action repetition definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(WorkflowRunAction)
@includeInapplicableMetadataInPayload(false)
model WorkflowRunActionRepetitionDefinition extends Resource {
  /**
   * The workflow repetition.
   */
  @path
  @key("repetitionName")
  @segment("repetitions")
  @visibility("read")
  name: string;

  /**
   * The workflow run action repetition properties definition.
   */
  @extension("x-ms-client-flatten", true)
  properties: WorkflowRunActionRepetitionProperties;
}

@armResourceOperations
interface WorkflowRunActionRepetitionDefinitions {
  /**
   * Get a workflow run action repetition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkflowRunActionRepetitions_Get")
  get is ArmResourceRead<WorkflowRunActionRepetitionDefinition>;

  /**
   * Get all of a workflow run action repetitions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkflowRunActionRepetitions_List")
  list is ArmResourceListByParent<WorkflowRunActionRepetitionDefinition>;

  /**
   * Lists a workflow run expression trace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkflowRunActionRepetitions_ListExpressionTraces")
  listExpressionTraces is ArmResourceActionSync<
    WorkflowRunActionRepetitionDefinition,
    void,
    ExpressionTraces
  >;
}
