import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.PolicyInsightsPolicyStateCreatedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.PolicyInsightsPolicyStateCreatedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.PolicyInsightsPolicyStateChangedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.PolicyInsightsPolicyStateChangedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.PolicyInsightsPolicyStateDeletedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.PolicyInsightsPolicyStateDeletedEventData,
  Access.public
);
//Enums

//useSystemTextJsonConverter decorators
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.PolicyInsightsPolicyStateCreatedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.PolicyInsightsPolicyStateChangedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.PolicyInsightsPolicyStateDeletedEventData,
  "csharp"
);
