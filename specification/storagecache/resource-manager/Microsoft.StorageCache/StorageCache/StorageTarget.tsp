import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cache.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageCache;
/**
 * Type of the Storage Target.
 */
@parentResource(Cache)
model StorageTarget
  is Azure.ResourceManager.ProxyResource<StorageTargetProperties> {
  ...ResourceNameParameter<
    Resource = StorageTarget,
    KeyName = "storageTargetName",
    SegmentName = "storageTargets",
    NamePattern = "^[-0-9a-zA-Z_]{1,80}$"
  >;

  /**
   * Region name string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface StorageTargets {
  /**
   * Returns a Storage Target from a cache.
   */
  get is ArmResourceRead<StorageTarget>;

  /**
   * Create or update a Storage Target. This operation is allowed at any time, but if the cache is down or unhealthy, the actual creation/modification of the Storage Target may be delayed until the cache is healthy again.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    StorageTarget,
    Response = ArmResourceUpdatedResponse<StorageTarget> | ArmResourceCreatedResponse<
      StorageTarget,
      ArmLroLocationHeader<FinalResult = StorageTarget> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Removes a Storage Target from a cache. This operation is allowed at any time, but if the cache is down or unhealthy, the actual removal of the Storage Target may be delayed until the cache is healthy again. Note that if the cache has data to flush to the Storage Target, the data will be flushed before the Storage Target will be deleted.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    StorageTarget,
    Parameters = {
      /**
       * Boolean value requesting the force delete operation for a storage target. Force delete discards unwritten-data in the cache instead of flushing it to back-end storage.
       */
      @query("force")
      force?: string;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns a list of Storage Targets for the specified cache.
   */
  listByCache is ArmResourceListByParent<
    StorageTarget,
    Response = ArmResponse<StorageTargetsResult>
  >;

  /**
   * Tells a storage target to refresh its DNS information.
   */
  dnsRefresh is ArmResourceActionAsync<
    StorageTarget,
    void,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Tells a storage target to restore its settings to their default values.
   */
  restoreDefaults is ArmResourceActionAsync<StorageTarget, void, OkResponse>;

  /**
   * Tells the cache to write all dirty data to the Storage Target's backend storage. Client requests to this storage target's namespace will return errors until the flush operation completes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StorageTarget_Flush")
  flush is ArmResourceActionAsync<
    StorageTarget,
    void,
    OkResponse | NoContentResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Suspends client access to a storage target.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StorageTarget_Suspend")
  suspend is ArmResourceActionAsync<
    StorageTarget,
    void,
    OkResponse | NoContentResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Resumes client access to a previously suspended storage target.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StorageTarget_Resume")
  resume is ArmResourceActionAsync<
    StorageTarget,
    void,
    OkResponse | NoContentResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Invalidate all cached data for a storage target. Cached files are discarded and fetched from the back end on the next request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StorageTarget_Invalidate")
  invalidate is ArmResourceActionAsync<
    StorageTarget,
    void,
    OkResponse | NoContentResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(StorageTarget.name, "Name of Storage Target.");
@@doc(StorageTarget.properties, "StorageTarget properties");
@@doc(StorageTargets.createOrUpdate::parameters.resource,
  "Object containing the definition of a Storage Target."
);
