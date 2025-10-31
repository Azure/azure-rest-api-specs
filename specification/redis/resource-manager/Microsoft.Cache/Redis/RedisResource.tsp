import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Cache;
/**
 * A single Redis item in List or Get Operation.
 */
model RedisResource
  is Azure.ResourceManager.TrackedResource<RedisProperties, false> {
  ...ResourceNameParameter<
    Resource = RedisResource,
    KeyName = "cacheName",
    SegmentName = "redis",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]|[a-zA-Z0-9])$"
  >;
  ...Azure.ResourceManager.AvailabilityZonesProperty;

  /**
   * The identity of the resource.
   */
  ...ManagedServiceIdentityProperty;
}

@armResourceOperations
interface RedisResourcesOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = RedisResource,
        KeyName = "name",
        SegmentName = "redis",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface RedisResources {
  /**
   * Gets a Redis cache (resource description).
   */
  get is RedisResourcesOps.Read<RedisResource>;

  /**
   * Create or replace (overwrite/recreate, with potential downtime) an existing Redis cache.
   */
  create is RedisResourcesOps.CreateOrUpdateAsync<
    RedisResource,
    Request = RedisCreateParameters,
    Response = RedisResource | ArmResourceCreatedResponse<
      RedisResource,
      LroHeaders = ArmLroLocationHeader<FinalResult = RedisResource>
    >,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Update an existing Redis cache.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is RedisResourcesOps.CustomPatchAsync<
    RedisResource,
    PatchModel = RedisUpdateParameters,
    Response = RedisResource | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = RedisResource>> & {
      @bodyRoot
      _: RedisResource;
    })
  >;

  /**
   * Deletes a Redis cache.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Legacy approved usage of non-standard operation response codes. Consider revising in a future api version."
  delete is RedisResourcesOps.DeleteWithoutOkAsync<
    RedisResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Redis caches in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    RedisResource,
    Response = RedisListResult
  >;

  /**
   * Gets all Redis caches in the specified subscription.
   */
  listBySubscription is ArmListBySubscription<
    RedisResource,
    Response = RedisListResult
  >;

  /**
   * [Deprecated] Gets any upgrade notifications for a Redis cache.
   */
  @get
  @list
  listUpgradeNotifications is RedisResourcesOps.ActionSync<
    RedisResource,
    void,
    Response = NotificationListResponse,
    Parameters = {
      /**
       * how many minutes in past to look for upgrade notifications
       */
      @query("history")
      history: float64;
    }
  >;

  /**
   * Retrieve a Redis cache's access keys. This operation requires write permission to the cache resource.
   */
  listKeys is RedisResourcesOps.ActionSync<
    RedisResource,
    void,
    Response = RedisAccessKeys
  >;

  /**
   * Regenerate Redis cache's access keys. This operation requires write permission to the cache resource.
   */
  regenerateKey is RedisResourcesOps.ActionSync<
    RedisResource,
    RedisRegenerateKeyParameters,
    Response = RedisAccessKeys
  >;

  /**
   * Reboot specified Redis node(s). This operation requires write permission to the cache resource. There can be potential data loss.
   */
  forceReboot is RedisResourcesOps.ActionSync<
    RedisResource,
    RedisRebootParameters,
    Response = RedisForceRebootResponse
  >;

  /**
   * Import data into Redis cache.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Legacy non-standard usage of operation response codes. Consider revising in a future API version."
  @action("import")
  importData is RedisResourcesOps.ActionAsync<
    RedisResource,
    ImportRDBParameters,
    void,
    Response = OkResponse | ArmAcceptedLroResponse | ArmNoContentResponse
  >;

  /**
   * Export data from the redis cache to blobs in a container.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Legacy non-standard usage of operation response codes. Consider revising in a future API version."
  @action("export")
  exportData is RedisResourcesOps.ActionAsync<
    RedisResource,
    ExportRDBParameters,
    void,
    Response = OkResponse | ArmAcceptedLroResponse | ArmNoContentResponse
  >;

  /**
   * Deletes all of the keys in a cache.
   */
  @action("flush")
  flushCache is ArmResourceActionAsyncBase<
    RedisResource,
    void,
    Response = (ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult> &
      ArmCombinedLroHeaders<FinalResult = Azure.ResourceManager.CommonTypes.OperationStatusResult>) | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = Azure.ResourceManager.CommonTypes.OperationStatusResult>>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<RedisResource>,
    Error = ErrorResponse
  >;

  /**
   * Gets the private link resources that need to be created for a redis cache.
   */
  @get
  @list
  @action("privateLinkResources")
  listByRedisCache is ArmResourceActionSync<
    RedisResource,
    void,
    Response = ResourceListResult<Azure.ResourceManager.CommonTypes.PrivateLinkResource>
  >;
}

@@doc(RedisResource.name, "The name of the Redis cache.");
@@doc(RedisResource.properties, "Redis cache properties.");
@@doc(RedisResources.create::parameters.resource,
  "Parameters supplied to the Create Redis operation."
);
@@doc(RedisResources.update::parameters.properties,
  "Parameters supplied to the Update Redis operation."
);
@@doc(RedisResources.regenerateKey::parameters.body,
  "Specifies which key to regenerate."
);
@@doc(RedisResources.forceReboot::parameters.body,
  "Specifies which Redis node(s) to reboot."
);
@@doc(RedisResources.importData::parameters.body,
  "Parameters for Redis import operation."
);
@@doc(RedisResources.exportData::parameters.body,
  "Parameters for Redis export operation."
);
