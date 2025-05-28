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
    KeyName = "name",
    SegmentName = "redis",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.AvailabilityZonesProperty;

  /**
   * The identity of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

@armResourceOperations
interface RedisResources {
  /**
   * Gets a Redis cache (resource description).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Redis_Get")
  get is ArmResourceRead<RedisResource>;

  /**
   * Create or replace (overwrite/recreate, with potential downtime) an existing Redis cache.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Redis_Create")
  create is ArmResourceCreateOrReplaceAsync<
    RedisResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update an existing Redis cache.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("Redis_Update")
  update is ArmCustomPatchAsync<
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Redis_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    RedisResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Redis caches in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Redis_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<RedisResource>;

  /**
   * Gets all Redis caches in the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Redis_ListBySubscription")
  listBySubscription is ArmListBySubscription<RedisResource>;

  /**
   * Gets any upgrade notifications for a Redis cache.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @operationId("Redis_ListUpgradeNotifications")
  listUpgradeNotifications is ArmResourceActionSync<
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Redis_ListKeys")
  listKeys is ArmResourceActionSync<
    RedisResource,
    void,
    ArmResponse<RedisAccessKeys>
  >;

  /**
   * Regenerate Redis cache's access keys. This operation requires write permission to the cache resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Redis_RegenerateKey")
  regenerateKey is ArmResourceActionSync<
    RedisResource,
    RedisRegenerateKeyParameters,
    ArmResponse<RedisAccessKeys>
  >;

  /**
   * Reboot specified Redis node(s). This operation requires write permission to the cache resource. There can be potential data loss.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Redis_ForceReboot")
  forceReboot is ArmResourceActionSync<
    RedisResource,
    RedisRebootParameters,
    ArmResponse<RedisForceRebootResponse>
  >;

  /**
   * Import data into Redis cache.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("import")
  @operationId("Redis_ImportData")
  importData is ArmResourceActionAsync<
    RedisResource,
    ImportRDBParameters,
    OkResponse | NoContentResponse
  >;

  /**
   * Export data from the redis cache to blobs in a container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("export")
  @operationId("Redis_ExportData")
  exportData is ArmResourceActionAsync<
    RedisResource,
    ExportRDBParameters,
    OkResponse
  >;

  /**
   * Deletes all of the keys in a cache.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("flush")
  @operationId("Redis_FlushCache")
  flushCache is ArmResourceActionAsync<
    RedisResource,
    void,
    ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult>,
    Parameters = {
      /**
       * The name of the Redis cache.
       */
      @pattern("^([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]|[a-zA-Z0-9])$")
      @path
      cacheName: string;
    }
  >;

  /**
   * Gets the private link resources that need to be created for a redis cache.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("privateLinkResources")
  @operationId("PrivateLinkResources_ListByRedisCache")
  listByRedisCache is ArmResourceActionSync<
    RedisResource,
    void,
    ArmResponse<Azure.ResourceManager.CommonTypes.PrivateLinkResourceListResultV5>,
    Parameters = {
      /**
       * The name of the Redis cache.
       */
      @pattern("^([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]|[a-zA-Z0-9])$")
      @path
      cacheName: string;
    }
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
