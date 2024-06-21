import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.EventHub.EventHubCaptureFileCreatedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.EventHub.EventHubCaptureFileCreatedEventData,
  Access.public
);
//Enums
