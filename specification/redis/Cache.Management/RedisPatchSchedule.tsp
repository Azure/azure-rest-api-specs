import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RedisResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cache;
/**
 * Response to put/get patch schedules for Redis cache.
 */
@parentResource(RedisResource)
model RedisPatchSchedule
  is Azure.ResourceManager.ProxyResource<ScheduleEntries, false> {
  ...ResourceNameParameter<
    Resource = RedisPatchSchedule,
    KeyName = "default",
    SegmentName = "patchSchedules",
    NamePattern = "",
    Type = DefaultName
  >;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface RedisPatchSchedules {
  /**
   * Gets the patching schedule of a redis cache.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PatchSchedules_Get")
  get is ArmResourceRead<RedisPatchSchedule>;

  /**
   * Create or replace the patching schedule for Redis cache.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PatchSchedules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<RedisPatchSchedule>;

  /**
   * Deletes the patching schedule of a redis cache.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PatchSchedules_Delete")
  delete is ArmResourceDeleteSync<RedisPatchSchedule>;

  /**
   * Gets all patch schedules in the specified redis cache (there is only one).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PatchSchedules_ListByRedisResource")
  listByRedisResource is ArmResourceListByParent<
    RedisPatchSchedule,
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

@@doc(RedisPatchSchedule.name,
  "Default string modeled as parameter for auto generation to work correctly."
);
@@doc(RedisPatchSchedule.properties,
  "List of patch schedules for a Redis cache."
);
@@doc(RedisPatchSchedules.createOrUpdate::parameters.resource,
  "Parameters to set the patching schedule for Redis cache."
);
