import "./ServiceBus.tsp";
namespace Microsoft.EventGrid.SystemEvents;

const MicrosoftServiceBusActiveMessagesAvailableWithNoListenersExample: ServiceBusActiveMessagesAvailableWithNoListenersEventData = #{
  namespaceName: "othercloudtest",
  requestUri: "https://othercloudtest.servicebus.windows.net/gaoqueue/messages/head",
  entityType: "queue",
  queueName: "gaoqueue",
  topicName: null,
  subscriptionName: null,
};

const MicrosoftServiceBusDeadletterMessagesAvailableWithNoListenersExample: ServiceBusDeadletterMessagesAvailableWithNoListenersEventData = #{
  namespaceName: "YOUR SERVICE BUS NAMESPACE WILL SHOW HERE",
  requestUri: "https://{your-service-bus-namespace}.servicebus.windows.net/{your-topic}/subscriptions/{your-service-bus-subscription}/$deadletterqueue/messages/head",
  entityType: "subscriber",
  queueName: "QUEUE NAME IF QUEUE",
  topicName: "TOPIC NAME IF TOPIC",
  subscriptionName: "SUBSCRIPTION NAME",
};

const MicrosoftServiceBusActiveMessagesAvailablePeriodicNotificationsExample: ServiceBusActiveMessagesAvailablePeriodicNotificationsEventData = #{
  namespaceName: "{namespace}",
  requestUri: "https://{namespace}.servicebus.windows.net/{topic}/subscriptions/{subscription}/$deadletterqueue/messages/head",
  entityType: "subscriber",
  queueName: null,
  topicName: "{topic}",
  subscriptionName: "{subscription}",
};

const MicrosoftServiceBusDeadletterMessagesAvailablePeriodicNotificationsExample: ServiceBusDeadletterMessagesAvailablePeriodicNotificationsEventData = #{
  namespaceName: "{namespace}",
  requestUri: "https://{namespace}.servicebus.windows.net/{queue}/$deadletterqueue/messages/head",
  entityType: "subscriber",
  queueName: "{queue}",
  topicName: null,
  subscriptionName: null,
};
