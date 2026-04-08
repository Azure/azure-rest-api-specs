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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface StorageTargets {
  /**
   * Returns a Storage Target from a cache.
   */
  get is ArmResourceRead<StorageTarget, Error = CloudError>;

  /**
   * Create or update a Storage Target. This operation is allowed at any time, but if the cache is down or unhealthy, the actual creation/modification of the Storage Target may be delayed until the cache is healthy again.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    StorageTarget,
    Response = ArmResourceUpdatedResponse<StorageTarget> | ArmResourceCreatedResponse<
      StorageTarget,
      ArmLroLocationHeader<FinalResult = StorageTarget> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse,
    Error = CloudError
  >;

  /**
   * Removes a Storage Target from a cache. This operation is allowed at any time, but if the cache is down or unhealthy, the actual removal of the Storage Target may be delayed until the cache is healthy again. Note that if the cache has data to flush to the Storage Target, the data will be flushed before the Storage Target will be deleted.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    StorageTarget,
    Parameters = {
      /**
       * Boolean value requesting the force delete operation for a storage target. Force delete discards unwritten-data in the cache instead of flushing it to back-end storage.
       */
      @query("force")
      force?: string;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Returns a list of Storage Targets for the specified cache.
   */
  listByCache is ArmResourceListByParent<
    StorageTarget,
    Response = ArmResponse<StorageTargetsResult>,
    Error = CloudError
  >;

  /**
   * Tells a storage target to refresh its DNS information.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  dnsRefresh is ArmResourceActionAsync<
    StorageTarget,
    void,
    OkResponse,
    LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Tells a storage target to restore its settings to their default values.
   */
  restoreDefaults is ArmResourceActionAsync<
    StorageTarget,
    void,
    OkResponse,
    LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Tells the cache to write all dirty data to the Storage Target's backend storage. Client requests to this storage target's namespace will return errors until the flush operation completes.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @operationId("StorageTarget_Flush")
  flush is ArmResourceActionAsync<
    StorageTarget,
    void,
    OkResponse | NoContentResponse,
    LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Suspends client access to a storage target.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @operationId("StorageTarget_Suspend")
  suspend is ArmResourceActionAsync<
    StorageTarget,
    void,
    OkResponse | NoContentResponse,
    LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Resumes client access to a previously suspended storage target.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @operationId("StorageTarget_Resume")
  resume is ArmResourceActionAsync<
    StorageTarget,
    void,
    OkResponse | NoContentResponse,
    LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Invalidate all cached data for a storage target. Cached files are discarded and fetched from the back end on the next request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @operationId("StorageTarget_Invalidate")
  invalidate is ArmResourceActionAsync<
    StorageTarget,
    void,
    OkResponse | NoContentResponse,
    LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;
}

@@doc(StorageTarget.name, "Name of Storage Target.");
@@doc(StorageTarget.properties, "StorageTarget properties");
@@doc(StorageTargets.createOrUpdate::parameters.resource,
  "Object containing the definition of a Storage Target."
);
