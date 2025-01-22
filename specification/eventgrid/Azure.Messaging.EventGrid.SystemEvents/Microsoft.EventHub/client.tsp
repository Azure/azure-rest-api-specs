import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.EventHubCaptureFileCreatedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.EventHubCaptureFileCreatedEventData,
  Access.public
);
//Enums
