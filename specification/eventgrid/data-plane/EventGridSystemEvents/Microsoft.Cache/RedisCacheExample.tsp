import "./RedisCache.tsp";

namespace Microsoft.EventGrid.SystemEvents;

const MicrosoftCachePatchingCompletedExample: RedisPatchingCompletedEventData = #{
  name: "PatchingCompleted",
  timestamp: utcDateTime.fromISO("2020-12-09T13:50:19.9995668-08:00"),
  status: "Succeeded",
};

const MicrosoftCacheScalingCompletedExample: RedisScalingCompletedEventData = #{
  name: "ScalingCompleted",
  timestamp: utcDateTime.fromISO("2020-12-09T13:50:19.9995668-08:00"),
  status: "Succeeded",
};

const MicrosoftCacheExportRDBCompletedExample: RedisExportRDBCompletedEventData = #{
  name: "ExportRDBCompleted",
  timestamp: utcDateTime.fromISO("2020-12-09T13:50:19.9995668-08:00"),
  status: "Succeeded",
};

const MicrosoftCacheImportRDBCompletedExample: RedisImportRDBCompletedEventData = #{
  name: "ImportRDBCompleted",
  timestamp: utcDateTime.fromISO("2020-12-09T13:50:19.9995668-08:00"),
  status: "Succeeded",
};
