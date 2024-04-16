import "@azure-tools/typespec-client-generator-core"; 
 
using Azure.ClientGenerator.Core; 
//Models 
@@usage(Microsoft.EventGrid.SystemEvents.ServiceBusActiveMessagesAvailableWithNoListenersEventData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ServiceBusActiveMessagesAvailableWithNoListenersEventData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ServiceBusDeadletterMessagesAvailableWithNoListenersEventData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ServiceBusDeadletterMessagesAvailableWithNoListenersEventData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ServiceBusActiveMessagesAvailablePeriodicNotificationsEventData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ServiceBusActiveMessagesAvailablePeriodicNotificationsEventData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ServiceBusDeadletterMessagesAvailablePeriodicNotificationsEventData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ServiceBusDeadletterMessagesAvailablePeriodicNotificationsEventData, Access.public);
//Enums 
