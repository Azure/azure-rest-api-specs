import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.ServiceBus.ServiceBusActiveMessagesAvailableWithNoListenersEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.ServiceBus.ServiceBusActiveMessagesAvailableWithNoListenersEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.ServiceBus.ServiceBusDeadletterMessagesAvailableWithNoListenersEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.ServiceBus.ServiceBusDeadletterMessagesAvailableWithNoListenersEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.ServiceBus.ServiceBusActiveMessagesAvailablePeriodicNotificationsEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.ServiceBus.ServiceBusActiveMessagesAvailablePeriodicNotificationsEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.ServiceBus.ServiceBusDeadletterMessagesAvailablePeriodicNotificationsEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.ServiceBus.ServiceBusDeadletterMessagesAvailablePeriodicNotificationsEventData,
  Access.public
);
//Enums
