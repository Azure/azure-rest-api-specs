import "./ServiceBusExample.tsp";
/** Describes the schema of the Azure ServiceBus Messaging events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents {
  /** Schema of the Data property of an EventGridEvent for a Microsoft.ServiceBus.ActiveMessagesAvailableWithNoListeners event. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
  @example(MicrosoftServiceBusActiveMessagesAvailableWithNoListenersExample)
  model ServiceBusActiveMessagesAvailableWithNoListenersEventData {
    ...ServiceBusBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.ServiceBus.DeadletterMessagesAvailableWithNoListeners event. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
  @example(MicrosoftServiceBusDeadletterMessagesAvailableWithNoListenersExample)
  model ServiceBusDeadletterMessagesAvailableWithNoListenersEventData {
    ...ServiceBusBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.ServiceBus.ActiveMessagesAvailablePeriodicNotifications event. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
  @example(
    MicrosoftServiceBusActiveMessagesAvailablePeriodicNotificationsExample
  )
  model ServiceBusActiveMessagesAvailablePeriodicNotificationsEventData {
    ...ServiceBusBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.ServiceBus.DeadletterMessagesAvailablePeriodicNotifications event. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
  @example(
    MicrosoftServiceBusDeadletterMessagesAvailablePeriodicNotificationsExample
  )
  model ServiceBusDeadletterMessagesAvailablePeriodicNotificationsEventData {
    ...ServiceBusBaseEventData;
  }

  alias ServiceBusBaseEventData = {
    /** The namespace name of the Microsoft.ServiceBus resource. */
    namespaceName: string;

    /** The endpoint of the Microsoft.ServiceBus resource. */
    requestUri: string;

    /** The entity type of the Microsoft.ServiceBus resource. Could be one of 'queue' or 'subscriber'. */
    entityType: string;

    /** The name of the Microsoft.ServiceBus queue. If the entity type is of type 'subscriber', then this value will be null. */
    #suppress "@azure-tools/typespec-azure-core/no-nullable" "Nullable backcompat with existing models"
    queueName: string | null;

    /** The name of the Microsoft.ServiceBus topic. If the entity type is of type 'queue', then this value will be null. */
    #suppress "@azure-tools/typespec-azure-core/no-nullable" "Nullable backcompat with existing models"
    topicName: string | null;

    /** The name of the Microsoft.ServiceBus topic's subscription. If the entity type is of type 'queue', then this value will be null. */
    #suppress "@azure-tools/typespec-azure-core/no-nullable" "Nullable backcompat with existing models"
    subscriptionName: string | null;
  };
}
