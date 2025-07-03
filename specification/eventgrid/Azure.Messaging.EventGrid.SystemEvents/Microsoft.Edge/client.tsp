import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.EdgeSolutionVersionPublishedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.EdgeSolutionVersionPublishedEventData,
  Access.public
);

//useSystemTextJsonConverter decorators
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.EdgeSolutionVersionPublishedEventData,
  "csharp"
);
