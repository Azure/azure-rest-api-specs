import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.DataBoxCopyStartedEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.DataBoxCopyStartedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.DataBoxCopyCompletedEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.DataBoxCopyCompletedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.DataBoxOrderCompletedEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.DataBoxOrderCompletedEventData,
  Access.public
);
//Enums
@@usage(Microsoft.EventGrid.SystemEvents.DataBoxStageName,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.DataBoxStageName, Access.public);

//useSystemTextJsonConverter decorators
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.DataBoxCopyCompletedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.DataBoxCopyStartedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.DataBoxOrderCompletedEventData,
  "csharp"
);
