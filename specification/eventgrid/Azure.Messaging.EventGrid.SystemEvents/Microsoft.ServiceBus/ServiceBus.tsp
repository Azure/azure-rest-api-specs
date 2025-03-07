/** Describes the schema of the Azure ServiceBus Messaging events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents {
  const MicrosoftServiceBusActiveMessagesAvailableWithNoListenersExample: ServiceBusActiveMessagesAvailableWithNoListenersEventData = #{
    namespaceName: "othercloudtest",
    requestUri: "https://othercloudtest.servicebus.windows.net/gaoqueue/messages/head",
    entityType: "queue",
    queueName: "gaoqueue",
    topicName: null,
    subscriptionName: null,
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.ServiceBus.ActiveMessagesAvailableWithNoListeners event. */
  @example(MicrosoftServiceBusActiveMessagesAvailableWithNoListenersExample)
  model ServiceBusActiveMessagesAvailableWithNoListenersEventData {
    ...ServiceBusBaseEventData;
  }

  const MicrosoftServiceBusDeadletterMessagesAvailableWithNoListenersExample: ServiceBusDeadletterMessagesAvailableWithNoListenersEventData = #{
    namespaceName: "YOUR SERVICE BUS NAMESPACE WILL SHOW HERE",
    requestUri: "https://{your-service-bus-namespace}.servicebus.windows.net/{your-topic}/subscriptions/{your-service-bus-subscription}/$deadletterqueue/messages/head",
    entityType: "subscriber",
    queueName: "QUEUE NAME IF QUEUE",
    topicName: "TOPIC NAME IF TOPIC",
    subscriptionName: "SUBSCRIPTION NAME",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.ServiceBus.DeadletterMessagesAvailableWithNoListeners event. */
  @example(MicrosoftServiceBusDeadletterMessagesAvailableWithNoListenersExample)
  model ServiceBusDeadletterMessagesAvailableWithNoListenersEventData {
    ...ServiceBusBaseEventData;
  }

  const MicrosoftServiceBusActiveMessagesAvailablePeriodicNotificationsExample: ServiceBusActiveMessagesAvailablePeriodicNotificationsEventData = #{
    namespaceName: "{namespace}",
    requestUri: "https://{namespace}.servicebus.windows.net/{topic}/subscriptions/{subscription}/$deadletterqueue/messages/head",
    entityType: "subscriber",
    queueName: null,
    topicName: "{topic}",
    subscriptionName: "{subscription}",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.ServiceBus.ActiveMessagesAvailablePeriodicNotifications event. */
  @example(
    MicrosoftServiceBusActiveMessagesAvailablePeriodicNotificationsExample
  )
  model ServiceBusActiveMessagesAvailablePeriodicNotificationsEventData {
    ...ServiceBusBaseEventData;
  }

  const MicrosoftServiceBusDeadletterMessagesAvailablePeriodicNotificationsExample: ServiceBusDeadletterMessagesAvailablePeriodicNotificationsEventData = #{
    namespaceName: "{namespace}",
    requestUri: "https://{namespace}.servicebus.windows.net/{queue}/$deadletterqueue/messages/head",
    entityType: "subscriber",
    queueName: "{queue}",
    topicName: null,
    subscriptionName: null,
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.ServiceBus.DeadletterMessagesAvailablePeriodicNotifications event. */
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
