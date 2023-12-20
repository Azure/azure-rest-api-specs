import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./OperationalInsightsWorkspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.OperationalInsights;
@doc("The top level storage insight resource container.")
@parentResource(OperationalInsightsWorkspace)
model StorageInsight is ProxyResource<StorageInsightProperties> {
  @doc("Name of the storageInsightsConfigs resource")
  @path
  @key("storageInsightName")
  @segment("storageInsightConfigs")
  name: string;

  @doc("The ETag of the storage insight.")
  eTag?: string;

  ...Azure.ResourceManager.EntityTag;
}

@armResourceOperations
interface StorageInsights {
  @doc("Gets a storage insight instance.")
  get is ArmResourceRead<StorageInsight>;
  @doc("Create or update a storage insight.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<StorageInsight>;
  @doc("Deletes a storageInsightsConfigs resource")
  delete is ArmResourceDeleteSync<StorageInsight>;
  @doc("Lists the storage insight instances within a workspace")
  listByWorkspace is ArmResourceListByParent<StorageInsight>;
}
