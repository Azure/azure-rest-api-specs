import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Storage;
/**
 * A Context Cache resource
 */
@added(Versions.v2026_06_01)
model ContextCache is Azure.ResourceManager.TrackedResource<
  ContextCacheProperties,
  false
> {
  /**
   * The name of the context cache
   */
  @pattern("^[a-z0-9][a-z0-9-]{1,22}[a-z0-9]$")
  @key("contextCacheName")
  @segment("contextCaches")
  @path
  name: string;

  ...ManagedSystemAssignedIdentityProperty;
}

@armResourceOperations
@added(Versions.v2026_06_01)
interface ContextCaches {
  /**
   * Get a Context Cache.
   */
  get is ArmResourceRead<ContextCache>;

  /**
   * Create or update a Context Cache.
   */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ContextCache>;

  /**
   * Update a Context Cache.
   */
  update is ArmCustomPatchAsync<ContextCache, ContextCacheUpdate>;

  /**
   * Delete a Context Cache.
   */
  delete is ArmResourceDeleteWithoutOkAsync<ContextCache>;

  /**
   * List Context Caches by resource group.
   */
  listByResourceGroup is ArmResourceListByParent<ContextCache>;

  /**
   * List Context Caches by subscription.
   */
  listBySubscription is ArmListBySubscription<ContextCache>;
}
