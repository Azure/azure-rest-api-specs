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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: CacheIdentity;

  /**
   * SKU for the cache.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sku?: CacheSku;
}

@armResourceOperations
interface Caches {
  /**
   * Returns a cache.
   */
  get is ArmResourceRead<Cache, Error = CloudError>;

  /**
   * Create or update a cache.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Cache,
    Response = ArmResourceUpdatedResponse<Cache> | ArmResourceCreatedResponse<
      Cache,
      ArmLroLocationHeader<FinalResult = Cache> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse,
    Error = CloudError
  >;

  /**
   * Update a cache instance.
   */
  @patch(#{ implicitOptionality: false })
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    Cache,
    PatchModel = Cache,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = Cache> &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true,
    Error = CloudError
  >;

  /**
   * Schedules a cache for deletion.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Cache,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Returns all caches the user has access to under a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Cache,
    Response = ArmResponse<CachesListResult>,
    Error = CloudError
  >;

  /**
   * Returns all caches the user has access to under a subscription.
   */
  list is ArmListBySubscription<
    Cache,
    Response = ArmResponse<CachesListResult>,
    Error = CloudError
  >;

  /**
   * Tells a cache to write generate debug info for support to process.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  debugInfo is ArmResourceActionAsync<
    Cache,
    void,
    OkResponse | NoContentResponse,
    LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Tells a cache to write all dirty data to the Storage Target(s). During the flush, clients will see errors returned until the flush is complete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  flush is ArmResourceActionAsync<
    Cache,
    void,
    OkResponse | NoContentResponse,
    LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Tells a Stopped state cache to transition to Active state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  start is ArmResourceActionAsync<
    Cache,
    void,
    OkResponse | NoContentResponse,
    LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Tells an Active cache to transition to Stopped state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  stop is ArmResourceActionAsync<
    Cache,
    void,
    OkResponse | NoContentResponse,
    LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Create a priming job. This operation is only allowed when the cache is healthy.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  startPrimingJob is ArmResourceActionAsyncBase<
    Cache,
    PrimingJob,
    ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Cache>,
    OptionalRequestBody = true,
    Error = CloudError
  >;

  /**
   * Schedule a priming job for deletion.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  stopPrimingJob is ArmResourceActionAsync<
    Cache,
    PrimingJobIdParameter,
    NoContentResponse,
    LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true,
    Error = CloudError
  >;

  /**
   * Schedule a priming job to be paused.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  pausePrimingJob is ArmResourceActionAsync<
    Cache,
    PrimingJobIdParameter,
    NoContentResponse,
    LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true,
    Error = CloudError
  >;

  /**
   * Resumes a paused priming job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  resumePrimingJob is ArmResourceActionAsync<
    Cache,
    PrimingJobIdParameter,
    NoContentResponse,
    LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true,
    Error = CloudError
  >;

  /**
   * Upgrade a cache's firmware if a new version is available. Otherwise, this operation has no effect.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @action("upgrade")
  upgradeFirmware is ArmResourceActionAsync<
    Cache,
    void,
    CreatedResponse | NoContentResponse,
    LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Update cache space allocation.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  spaceAllocation is ArmResourceActionAsyncBase<
    Cache,
    StorageTargetSpaceAllocation[],
    ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Cache>,
    OptionalRequestBody = true,
    Error = CloudError
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
