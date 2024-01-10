import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.OperationalInsights;
@doc("The top level storage insight resource container.")
@parentResource(Workspace)
model StorageInsight is ProxyResource<StorageInsightProperties> {
  @doc("Name of the storageInsightsConfigs resource")
  @key("storageInsightName")
  @segment("storageInsightConfigs")
  name: string;

  ...Azure.ResourceManager.EntityTag;
}

@armResourceOperations
@projectedName("client", "StorageInsightConfigs")
interface StorageInsights_StorageInsightConfigs {
  @doc("Gets a storage insight instance.")
  get is ArmResourceRead<StorageInsight>;

  @doc("Create or update a storage insight.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<StorageInsight>;

  @doc("Deletes a storageInsightsConfigs resource")
  delete is ArmResourceDeleteSync<StorageInsight>;

  @doc("Lists the storage insight instances within a workspace")
  listByWorkspace is ArmResourceListByParent<StorageInsight>;
}
