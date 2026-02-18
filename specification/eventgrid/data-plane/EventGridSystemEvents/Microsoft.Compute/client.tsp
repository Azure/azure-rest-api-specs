import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.VMScaleSetLifecycleHookEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.VMScaleSetLifecycleHookEventData,
  Access.public
);

//useSystemTextJsonConverter decorators
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.VMScaleSetLifecycleHookEventData,
  "csharp"
);
