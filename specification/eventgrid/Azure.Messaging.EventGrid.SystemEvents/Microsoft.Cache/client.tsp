import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.RedisCache.RedisPatchingCompletedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.RedisCache.RedisPatchingCompletedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.RedisCache.RedisScalingCompletedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.RedisCache.RedisScalingCompletedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.RedisCache.RedisExportRDBCompletedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.RedisCache.RedisExportRDBCompletedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.RedisCache.RedisImportRDBCompletedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.RedisCache.RedisImportRDBCompletedEventData,
  Access.public
);
//Enums
