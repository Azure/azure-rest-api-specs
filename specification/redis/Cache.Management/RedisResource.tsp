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
  @put
  create is Azure.ResourceManager.Legacy.UpdateOperation<
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;
      ...Azure.ResourceManager.Legacy.Provider;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @segment("redis")
      @path
      name: string;
    },
    RedisCreateParameters,
    RedisResource | ArmResourceCreatedResponse<
      RedisResource,
      LroHeaders = ArmLroLocationHeader<FinalResult = RedisResource>
    >,
    ErrorResponse
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
   * Gets any upgrade notifications for a Redis cache.
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  flushCache is ArmResourceActionAsync<
    RedisResource,
    void,
    Azure.ResourceManager.CommonTypes.OperationStatusResult
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
@@doc(RedisResources.create::parameters.properties,
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
