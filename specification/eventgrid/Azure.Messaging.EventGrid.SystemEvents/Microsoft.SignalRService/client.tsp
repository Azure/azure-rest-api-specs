import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.SignalRService.SignalRServiceClientConnectionConnectedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.SignalRService.SignalRServiceClientConnectionConnectedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.SignalRService.SignalRServiceClientConnectionDisconnectedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.SignalRService.SignalRServiceClientConnectionDisconnectedEventData,
  Access.public
);
//Enums
