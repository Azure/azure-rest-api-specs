import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./StorageSyncService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.StorageSync;
@doc("Workflow resource.")
@parentResource(StorageSyncService)
model StorageSyncWorkflow is ProxyResource<WorkflowProperties> {
  @doc("workflow Id")
  @path
  @key("workflowId")
  @segment("workflows")
  name: string;
}

@armResourceOperations
interface StorageSyncWorkflows {
  @doc("Get Workflows resource")
  get is ArmResourceRead<StorageSyncWorkflow>;
  @doc("Get a Workflow List")
  listByStorageSyncService is ArmResourceListByParent<StorageSyncWorkflow>;
  @doc("Abort the given workflow.")
  abort is ArmResourceActionSync<StorageSyncWorkflow, void, void>;
}
