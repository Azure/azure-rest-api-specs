import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageSyncService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageSync;
/**
 * Workflow resource.
 */
@parentResource(StorageSyncService)
model Workflow is Azure.ResourceManager.ProxyResource<WorkflowProperties> {
  ...ResourceNameParameter<
    Resource = Workflow,
    KeyName = "workflowId",
    SegmentName = "workflows",
    NamePattern = ""
  >;
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
  listByStorageSyncService is ArmResourceListByParent<
    Workflow,
    Response = ArmResponse<WorkflowArray>
  >;

  /**
   * Abort the given workflow.
   */
  abort is ArmResourceActionSync<Workflow, void, OkResponse>;
}

@@doc(Workflow.name, "workflow Id");
@@doc(Workflow.properties, "Workflow properties.");
