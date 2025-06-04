import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.RedisPatchingCompletedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.RedisPatchingCompletedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.RedisScalingCompletedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.RedisScalingCompletedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.RedisExportRDBCompletedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.RedisExportRDBCompletedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.RedisImportRDBCompletedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.RedisImportRDBCompletedEventData,
  Access.public
);
//Enums

//useSystemTextJsonConverter decorators
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.RedisPatchingCompletedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.RedisScalingCompletedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.RedisExportRDBCompletedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.RedisImportRDBCompletedEventData,
  "csharp"
);
