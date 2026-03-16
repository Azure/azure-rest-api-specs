import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.LifecycleHookEventsEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.LifecycleHookEventsEventData,
  Access.public
);

//useSystemTextJsonConverter decorators
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.LifecycleHookEventsEventData,
  "csharp"
);
