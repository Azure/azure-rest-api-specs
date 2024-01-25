import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageSyncService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageSync;
/**
 * Workflow resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(StorageSyncService)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(WorkflowProperties)
model Workflow extends ProxyResourceBase {
  /**
   * workflow Id
   */
  @path
  @key("workflowId")
  @segment("workflows")
  @visibility("read")
  name: string;

  /**
   * Workflow properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkflowProperties;
}

@armResourceOperations
interface Workflows {
  /**
   * Get Workflows resource
   */
  get is ArmResourceRead<Workflow>;

  /**
   * Get a Workflow List
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Workflows_ListByStorageSyncService")
  listByStorageSyncService is ArmResourceListByParent<Workflow>;

  /**
   * Abort the given workflow.
   */
  abort is ArmResourceActionSync<Workflow, void, void>;
}
