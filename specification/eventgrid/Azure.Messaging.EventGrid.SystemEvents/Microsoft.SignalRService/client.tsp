import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.SignalRServiceClientConnectionConnectedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.SignalRServiceClientConnectionConnectedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.SignalRServiceClientConnectionDisconnectedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.SignalRServiceClientConnectionDisconnectedEventData,
  Access.public
);
//Enums
