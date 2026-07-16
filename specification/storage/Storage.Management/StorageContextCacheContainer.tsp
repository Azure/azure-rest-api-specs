import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageContextCache.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Storage;
/**
 * A container resource within a Context Cache
 */
@parentResource(ContextCache)
@added(Versions.v2026_06_01)
model ContextCacheContainer is Azure.ResourceManager.ProxyResource<
  ContextCacheContainerProperties,
  false
> {
  /**
   * The name of the context cache container
   */
  @pattern("^[a-z0-9](?!.*--)[a-z0-9-]{1,61}[a-z0-9]$")
  @key("contextCacheContainerName")
  @segment("contextCacheContainers")
  @path
  name: string;
}

@armResourceOperations
@added(Versions.v2026_06_01)
interface ContextCacheContainers {
  /**
   * Get a container in a Context Cache.
   */
  get is ArmResourceRead<ContextCacheContainer>;

  /**
   * Create or update a container in a Context Cache.
   */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ContextCacheContainer>;

  /**
   * Update a container in a Context Cache.
   */
  update is ArmCustomPatchAsync<
    ContextCacheContainer,
    ContextCacheContainerUpdate
  >;

  /**
   * Delete a container from a Context Cache.
   */
  delete is ArmResourceDeleteWithoutOkAsync<ContextCacheContainer>;

  /**
   * List all containers in a Context Cache.
   */
  listByContextCache is ArmResourceListByParent<ContextCacheContainer>;
}
