import "@typespec/versioning";
using TypeSpec.Versioning;
/** Describes the schema of the Redis Cache events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents {
  alias RedisBaseEventData = {
    /** The time at which the event occurred. */
    timestamp?: utcDateTime;

    /** The name of this event. */
    name?: string;

    /** The status of this event. Failed or  succeeded */
    status?: string;
  };

  const MicrosoftCachePatchingCompletedExample: RedisPatchingCompletedEventData = #{
    name: "PatchingCompleted",
    timestamp: utcDateTime.fromISO("2020-12-09T13:50:19.9995668-08:00"),
    status: "Succeeded",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Cache.PatchingCompleted event. */
  @example(MicrosoftCachePatchingCompletedExample)
  model RedisPatchingCompletedEventData {
    ...RedisBaseEventData;
  }

  const MicrosoftCacheScalingCompletedExample: RedisScalingCompletedEventData = #{
    name: "ScalingCompleted",
    timestamp: utcDateTime.fromISO("2020-12-09T13:50:19.9995668-08:00"),
    status: "Succeeded",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Cache.ScalingCompleted event. */
  @example(MicrosoftCacheScalingCompletedExample)
  model RedisScalingCompletedEventData {
    ...RedisBaseEventData;
  }

  const MicrosoftCacheExportRDBCompletedExample: RedisExportRDBCompletedEventData = #{
    name: "ExportRDBCompleted",
    timestamp: utcDateTime.fromISO("2020-12-09T13:50:19.9995668-08:00"),
    status: "Succeeded",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Cache.ExportRDBCompleted event. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
  @example(MicrosoftCacheExportRDBCompletedExample)
  model RedisExportRDBCompletedEventData {
    ...RedisBaseEventData;
  }

  const MicrosoftCacheImportRDBCompletedExample: RedisImportRDBCompletedEventData = #{
    name: "ImportRDBCompleted",
    timestamp: utcDateTime.fromISO("2020-12-09T13:50:19.9995668-08:00"),
    status: "Succeeded",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Cache.ImportRDBCompleted event. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
  @example(MicrosoftCacheImportRDBCompletedExample)
  model RedisImportRDBCompletedEventData {
    ...RedisBaseEventData;
  }
}
