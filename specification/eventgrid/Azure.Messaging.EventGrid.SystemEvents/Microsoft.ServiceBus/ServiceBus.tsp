import "@typespec/versioning";
using TypeSpec.Versioning;
/** Describes the schema of the Azure ServiceBus Messaging events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents {
  /** Schema of the Data property of an EventGridEvent for a Microsoft.ServiceBus.ActiveMessagesAvailableWithNoListeners event. */
  model ServiceBusActiveMessagesAvailableWithNoListenersEventData {
    ...ServiceBusBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.ServiceBus.DeadletterMessagesAvailableWithNoListeners event. */
  model ServiceBusDeadletterMessagesAvailableWithNoListenersEventData {
    ...ServiceBusBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.ServiceBus.ActiveMessagesAvailablePeriodicNotifications event. */
  model ServiceBusActiveMessagesAvailablePeriodicNotificationsEventData {
    ...ServiceBusBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.ServiceBus.DeadletterMessagesAvailablePeriodicNotifications event. */
  model ServiceBusDeadletterMessagesAvailablePeriodicNotificationsEventData {
    ...ServiceBusBaseEventData;
  }

  alias ServiceBusBaseEventData = {
    /** The namespace name of the Microsoft.ServiceBus resource. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    namespaceName: string;

    /** The endpoint of the Microsoft.ServiceBus resource. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    requestUri: string;

    /** The entity type of the Microsoft.ServiceBus resource. Could be one of 'queue' or 'subscriber'. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    entityType: string;

    /** The name of the Microsoft.ServiceBus queue. If the entity type is of type 'subscriber', then this value will be null. */
    queueName?: string ;

    /** The name of the Microsoft.ServiceBus topic. If the entity type is of type 'queue', then this value will be null. */
    topicName?: string;

    /** The name of the Microsoft.ServiceBus topic's subscription. If the entity type is of type 'queue', then this value will be null. */
    subscriptionName?: string;
  };
}
