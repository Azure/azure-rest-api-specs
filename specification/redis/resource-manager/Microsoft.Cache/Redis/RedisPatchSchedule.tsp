import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RedisResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Cache;
/**
 * Response to put/get patch schedules for Redis cache.
 */
@parentResource(RedisResource)
model RedisPatchSchedule
  is Azure.ResourceManager.ProxyResource<ScheduleEntries, false> {
  ...ResourceNameParameter<
    Resource = RedisPatchSchedule,
    SegmentName = "patchSchedules",
    NamePattern = "",
    Type = DefaultName
  >;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface RedisPatchSchedulesOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * The name of the redis cache.
         */
        @path
        @segment("redis")
        name: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = RedisPatchSchedule,
        KeyName = "default",
        SegmentName = "patchSchedules",
        NamePattern = "",
        Type = DefaultName
      >>
    > {}

@armResourceOperations
interface RedisPatchSchedules {
  /**
   * Gets the patching schedule of a redis cache.
   */
  get is RedisPatchSchedulesOps.Read<RedisPatchSchedule>;

  /**
   * Create or replace the patching schedule for Redis cache.
   */
  createOrUpdate is RedisPatchSchedulesOps.CreateOrUpdateSync<RedisPatchSchedule>;

  /**
   * Deletes the patching schedule of a redis cache.
   */
  delete is RedisPatchSchedulesOps.DeleteSync<RedisPatchSchedule>;

  /**
   * Gets all patch schedules in the specified redis cache (there is only one).
   */
  listByRedisResource is ArmResourceListByParent<RedisPatchSchedule>;
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
