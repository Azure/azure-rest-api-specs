import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.ApiCenter.ApiCenterApiDefinitionAddedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.ApiCenter.ApiCenterApiDefinitionAddedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.ApiCenter.ApiCenterApiDefinitionUpdatedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Apicenter.ApiCenterApiDefinitionUpdatedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.ApiCenter.ApiCenterApiSpecification,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.ApiCenter.ApiCenterApiSpecification,
  Access.public
);
//Enums
