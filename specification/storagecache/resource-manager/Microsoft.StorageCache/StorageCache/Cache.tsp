import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageCache;
/**
 * A cache instance. Follows Azure Resource Manager standards: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md
 */
model Cache
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<CacheProperties> {
  ...ResourceNameParameter<
    Resource = Cache,
    KeyName = "cacheName",
    SegmentName = "caches",
    NamePattern = "^[-0-9a-zA-Z_]{1,80}$"
  >;

  /**
   * The identity of the cache, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: CacheIdentity;

  /**
   * SKU for the cache.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sku?: CacheSku;
}

@armResourceOperations
interface Caches {
  /**
   * Returns a cache.
   */
  get is ArmResourceRead<Cache>;

  /**
   * Create or update a cache.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Cache,
    Response = ArmResourceUpdatedResponse<Cache> | ArmResourceCreatedResponse<
      Cache,
      ArmLroLocationHeader<FinalResult = Cache> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Update a cache instance.
   */
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    Cache,
    PatchModel = Cache,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = Cache> &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  /**
   * Schedules a cache for deletion.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Cache,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns all caches the user has access to under a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<Cache>;

  /**
   * Returns all caches the user has access to under a subscription.
   */
  list is ArmListBySubscription<Cache>;

  /**
   * Tells a cache to write generate debug info for support to process.
   */
  debugInfo is ArmResourceActionAsync<
    Cache,
    void,
    OkResponse | NoContentResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Tells a cache to write all dirty data to the Storage Target(s). During the flush, clients will see errors returned until the flush is complete.
   */
  flush is ArmResourceActionAsync<
    Cache,
    void,
    OkResponse | NoContentResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Tells a Stopped state cache to transition to Active state.
   */
  start is ArmResourceActionAsync<
    Cache,
    void,
    OkResponse | NoContentResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Tells an Active cache to transition to Stopped state.
   */
  stop is ArmResourceActionAsync<
    Cache,
    void,
    OkResponse | NoContentResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Create a priming job. This operation is only allowed when the cache is healthy.
   */
  startPrimingJob is ArmResourceActionAsyncBase<
    Cache,
    PrimingJob,
    ArmAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Cache>,
    OptionalRequestBody = true
  >;

  /**
   * Schedule a priming job for deletion.
   */
  stopPrimingJob is ArmResourceActionAsync<
    Cache,
    PrimingJobIdParameter,
    NoContentResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  /**
   * Schedule a priming job to be paused.
   */
  pausePrimingJob is ArmResourceActionAsync<
    Cache,
    PrimingJobIdParameter,
    NoContentResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  /**
   * Resumes a paused priming job.
   */
  resumePrimingJob is ArmResourceActionAsync<
    Cache,
    PrimingJobIdParameter,
    NoContentResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  /**
   * Upgrade a cache's firmware if a new version is available. Otherwise, this operation has no effect.
   */
  @action("upgrade")
  upgradeFirmware is ArmResourceActionAsync<
    Cache,
    void,
    CreatedResponse | NoContentResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update cache space allocation.
   */
  spaceAllocation is ArmResourceActionAsyncBase<
    Cache,
    StorageTargetSpaceAllocation[],
    ArmAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Cache>,
    OptionalRequestBody = true
  >;
}

@@doc(Cache.name,
  "Name of cache. Length of name must not be greater than 80 and chars must be from the [-0-9a-zA-Z_] char class."
);
@@doc(Cache.properties, "Properties of the cache.");
@@doc(Caches.createOrUpdate::parameters.resource,
  "Object containing the user-selectable properties of the new cache. If read-only properties are included, they must match the existing values of those properties."
);
@@doc(Caches.update::parameters.properties,
  "Object containing the user-selectable properties of the cache. If read-only properties are included, they must match the existing values of those properties."
);
@@doc(Caches.startPrimingJob::parameters.body,
  "Object containing the definition of a priming job."
);
@@doc(Caches.stopPrimingJob::parameters.body,
  "Object containing the priming job ID."
);
@@doc(Caches.pausePrimingJob::parameters.body,
  "Object containing the priming job ID."
);
@@doc(Caches.resumePrimingJob::parameters.body,
  "Object containing the priming job ID."
);
@@doc(Caches.spaceAllocation::parameters.body,
  "List containing storage target cache space percentage allocations."
);
