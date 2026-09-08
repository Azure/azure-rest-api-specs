import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.ConnectedCache;

@removed(Versions.v2024_11_30_preview)
model CacheNodePreviewResource is TrackedResource<CacheNodeOldResponse> {
  @doc("Name of the Customer resource")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9\\_\\-]*")
  @key("customerResourceName")
  @segment("cacheNodes")
  @path
  name: string;
}

@removed(Versions.v2024_11_30_preview)
@armResourceOperations
interface CacheNodesOperations {
  @doc("Retrieves the properties of a cacheNodes")
  get is ArmResourceRead<CacheNodePreviewResource>;
  @doc("Creates a cacheNodes with the specified create parameters")
  createorUpdate is ArmResourceCreateOrReplaceAsync<CacheNodePreviewResource>;
  @doc("Deletes an existing cache Node")
  delete is ArmResourceDeleteSync<CacheNodePreviewResource>;
  @doc("updates an existing Cache Node")
  update is ArmCustomPatchSync<
    CacheNodePreviewResource,
    ConnectedCachePatchResource
  >;
  @doc("Retrieves the properties of all ConnectedCache")
  listByResourceGroup is ArmResourceListByParent<CacheNodePreviewResource>;
  @doc("Retrieves the properties of all ConnectedCaches")
  listBySubscription is ArmListBySubscription<CacheNodePreviewResource>;
}
