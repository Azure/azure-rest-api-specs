import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.ApiCenterApiDefinitionAddedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.ApiCenterApiDefinitionAddedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.ApiCenterApiDefinitionUpdatedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.ApiCenterApiDefinitionUpdatedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.ApiCenterApiSpecification,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.ApiCenterApiSpecification,
  Access.public
);

//useSystemTextJsonConverter decorators
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.ApiCenterApiDefinitionAddedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.ApiCenterApiDefinitionUpdatedEventData,
  "csharp"
);
//Enums
