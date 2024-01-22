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
@parentResource(StorageSyncService)
model Workflow is ProxyResource<WorkflowProperties> {
  /**
   * workflow Id
   */
  @path
  @key("workflowId")
  @segment("workflows")
  name: string;
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
