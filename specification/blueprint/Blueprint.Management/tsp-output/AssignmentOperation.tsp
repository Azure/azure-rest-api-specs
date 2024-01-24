import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Assignment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Blueprint;
/**
 * Represents underlying deployment detail for each update to the blueprint assignment.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Assignment)
@Azure.ResourceManager.Private.armResourceInternal(
  AssignmentOperationProperties
)
@includeInapplicableMetadataInPayload(false)
model AssignmentOperation extends ProxyResourceBase {
  /**
   * Name of the blueprint assignment operation.
   */
  @path
  @key("assignmentOperationName")
  @segment("assignmentOperations")
  name: string;

  /**
   * Properties for AssignmentOperation.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AssignmentOperationProperties;
}

@armResourceOperations
interface AssignmentOperations {
  /**
   * Get a blueprint assignment operation.
   */
  get is ArmResourceRead<AssignmentOperation>;

  /**
   * List operations for given blueprint assignment within a subscription or a management group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AssignmentOperations_List")
  list is ArmResourceListByParent<AssignmentOperation>;
}
