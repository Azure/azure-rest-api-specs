import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.PolicyInsights.PolicyInsightsPolicyStateCreatedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.PolicyInsights.PolicyInsightsPolicyStateCreatedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.PolicyInsights.PolicyInsightsPolicyStateChangedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.PolicyInsights.PolicyInsightsPolicyStateChangedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.PolicyInsights.PolicyInsightsPolicyStateDeletedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.PolicyInsights.PolicyInsightsPolicyStateDeletedEventData,
  Access.public
);
//Enums
