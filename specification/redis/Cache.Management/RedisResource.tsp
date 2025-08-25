import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "An identity is a valid resource property. Possibly the problem is that it is a duplicate, of one on TrackedResource??"
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Redis_Get")
  get is RedisResourcesOps.Read<RedisResource>;

  /**
   * Create or replace (overwrite/recreate, with potential downtime) an existing Redis cache.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Redis_Create")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @operationId("Redis_Update")
  update is RedisResourcesOps.CustomPatchAsync<
    RedisResource,
    PatchModel = RedisUpdateParameters,
    Response = ArmResponse<RedisResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: RedisResource;
    })
  >;

  /**
   * Deletes a Redis cache.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Legacy approved usage of operation response codes. Consider updating in a future API version."
  @operationId("Redis_Delete")
  delete is RedisResourcesOps.DeleteWithoutOkAsync<
    RedisResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Redis caches in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Redis_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    RedisResource,
    Response = ArmResponse<RedisListResult>
  >;

  /**
   * Gets all Redis caches in the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Redis_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    RedisResource,
    Response = ArmResponse<RedisListResult>
  >;

  /**
   * Gets any upgrade notifications for a Redis cache.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @operationId("Redis_ListUpgradeNotifications")
  listUpgradeNotifications is RedisResourcesOps.ActionSync<
    RedisResource,
    void,
    ArmResponse<NotificationListResponse>,
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Redis_ListKeys")
  listKeys is RedisResourcesOps.ActionSync<
    RedisResource,
    void,
    ArmResponse<RedisAccessKeys>
  >;

  /**
   * Regenerate Redis cache's access keys. This operation requires write permission to the cache resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Redis_RegenerateKey")
  regenerateKey is RedisResourcesOps.ActionSync<
    RedisResource,
    RedisRegenerateKeyParameters,
    ArmResponse<RedisAccessKeys>
  >;

  /**
   * Reboot specified Redis node(s). This operation requires write permission to the cache resource. There can be potential data loss.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Redis_ForceReboot")
  forceReboot is RedisResourcesOps.ActionSync<
    RedisResource,
    RedisRebootParameters,
    ArmResponse<RedisForceRebootResponse>
  >;

  /**
   * Import data into Redis cache.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Legacy approved usage of operation response codes. Consider updating in a future API version."
  @action("import")
  @operationId("Redis_ImportData")
  importData is RedisResourcesOps.ActionAsync<
    RedisResource,
    ImportRDBParameters,
    void,
    Response = OkResponse | ArmAcceptedLroResponse | ArmNoContentResponse
  >;

  /**
   * Export data from the redis cache to blobs in a container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Legacy approved usage of operation response codes. Consider updating in a future API version."
  @action("export")
  @operationId("Redis_ExportData")
  exportData is RedisResourcesOps.ActionAsync<
    RedisResource,
    ExportRDBParameters,
    void,
    Response = OkResponse | ArmAcceptedLroResponse | ArmNoContentResponse
  >;

  /**
   * Deletes all of the keys in a cache.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("flush")
  @operationId("Redis_FlushCache")
  flushCache is ArmResourceActionAsync<
    RedisResource,
    void,
    Azure.ResourceManager.CommonTypes.OperationStatusResult
  >;

  /**
   * Gets the private link resources that need to be created for a redis cache.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("privateLinkResources")
  @operationId("PrivateLinkResources_ListByRedisCache")
  listByRedisCache is ArmResourceActionSync<
    RedisResource,
    void,
    Response = ArmResponse<ResourceListResult<Azure.ResourceManager.CommonTypes.PrivateLinkResource>>
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
