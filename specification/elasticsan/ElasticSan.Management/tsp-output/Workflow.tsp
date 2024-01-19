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
@doc("Workflow resource.")
@parentResource(StorageSyncService)
model Workflow is ProxyResource<WorkflowProperties> {
  @doc("workflow Id")
  @path
  @key("workflowId")
  @segment("workflows")
  name: string;
}

@armResourceOperations
interface Workflows {
  @doc("Get Workflows resource")
  get is ArmResourceRead<Workflow>;

  @doc("Get a Workflow List")
  listByStorageSyncService is ArmResourceListByParent<Workflow>;

  @doc("Abort the given workflow.")
  abort is ArmResourceActionSync<Workflow, void, void>;
}
