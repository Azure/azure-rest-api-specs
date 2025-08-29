import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.EventGrid;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ChannelUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DomainUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SubscriptionUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NamespaceUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NamespaceTopicUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Operation.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PartnerConfigurationUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PartnerNamespaceUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkSecurityPerimeterConfigurationIssues.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkSecurityPerimeterProfileAccessRule.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TopicUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EventType.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AzureADPartnerClientAuthentication.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WebhookPartnerDestinationInfo.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WebhookUpdatePartnerDestinationInfo.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(JsonInputSchemaMapping.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StaticDeliveryAttributeMapping.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DynamicDeliveryAttributeMapping.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageBlobDeadLetterDestination.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WebHookEventSubscriptionDestination.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EventHubEventSubscriptionDestination.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageQueueEventSubscriptionDestination.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HybridConnectionEventSubscriptionDestination.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServiceBusQueueEventSubscriptionDestination.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServiceBusTopicEventSubscriptionDestination.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AzureFunctionEventSubscriptionDestination.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PartnerEventSubscriptionDestination.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MonitorAlertEventSubscriptionDestination.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NamespaceTopicEventSubscriptionDestination.properties);

@@clientName(CaCertificates.createOrUpdate::parameters.resource,
  "caCertificateInfo"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CaCertificate.properties);

@@clientName(Channels.createOrUpdate::parameters.resource, "channelInfo");
@@clientName(Channels.update::parameters.properties, "channelUpdateParameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Channel.properties);

@@clientName(ClientGroups.createOrUpdate::parameters.resource,
  "clientGroupInfo"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ClientGroup.properties);

@@clientName(Clients.createOrUpdate::parameters.resource, "clientInfo");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Client.properties);

@@clientName(Domains.createOrUpdate::parameters.resource, "domainInfo");
@@clientName(Domains.update::parameters.properties, "domainUpdateParameters");
@@clientName(Domains.regenerateKey::parameters.body, "regenerateKeyRequest");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Domain.properties);

@@clientName(PrivateEndpointConnections.update::parameters.resource,
  "privateEndpointConnection"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DomainTopic.properties);

@@clientLocation(Subscriptions.get, "NamespaceTopicEventSubscriptions");
@@clientLocation(Subscriptions.createOrUpdate,
  "NamespaceTopicEventSubscriptions"
);
@@clientName(Subscriptions.createOrUpdate::parameters.resource,
  "eventSubscriptionInfo"
);
@@clientLocation(Subscriptions.update, "NamespaceTopicEventSubscriptions");
@@clientName(Subscriptions.update::parameters.properties,
  "eventSubscriptionUpdateParameters"
);
@@clientLocation(Subscriptions.delete, "NamespaceTopicEventSubscriptions");
@@clientLocation(Subscriptions.listByNamespaceTopic,
  "NamespaceTopicEventSubscriptions"
);
@@clientLocation(Subscriptions.getDeliveryAttributes,
  "NamespaceTopicEventSubscriptions"
);
@@clientLocation(Subscriptions.getFullUrl, "NamespaceTopicEventSubscriptions");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Subscription.properties);

@@clientLocation(EventSubscriptions.get, "DomainTopicEventSubscriptions");
@@clientLocation(EventSubscriptions.createOrUpdate,
  "DomainTopicEventSubscriptions"
);
@@clientName(EventSubscriptions.createOrUpdate::parameters.resource,
  "eventSubscriptionInfo"
);
@@clientLocation(EventSubscriptions.update, "DomainTopicEventSubscriptions");
@@clientName(EventSubscriptions.update::parameters.properties,
  "eventSubscriptionUpdateParameters"
);
@@clientLocation(EventSubscriptions.delete, "DomainTopicEventSubscriptions");
@@clientLocation(EventSubscriptions.list, "DomainTopicEventSubscriptions");
@@clientLocation(EventSubscriptions.getDeliveryAttributes,
  "DomainTopicEventSubscriptions"
);
@@clientLocation(EventSubscriptions.getFullUrl,
  "DomainTopicEventSubscriptions"
);
@@clientName(TopicEventSubscriptions.createOrUpdate::parameters.resource,
  "eventSubscriptionInfo"
);
@@clientName(TopicEventSubscriptions.update::parameters.properties,
  "eventSubscriptionUpdateParameters"
);
@@clientName(DomainEventSubscriptions.createOrUpdate::parameters.resource,
  "eventSubscriptionInfo"
);
@@clientName(DomainEventSubscriptions.update::parameters.properties,
  "eventSubscriptionUpdateParameters"
);
@@clientLocation(EventSubscriptionOperationGroup.get, EventSubscriptions);
@@clientLocation(EventSubscriptionOperationGroup.createOrUpdate,
  EventSubscriptions
);
@@clientName(EventSubscriptionOperationGroup.createOrUpdate::parameters.resource,
  "eventSubscriptionInfo"
);
@@clientLocation(EventSubscriptionOperationGroup.update, EventSubscriptions);
@@clientName(EventSubscriptionOperationGroup.update::parameters.properties,
  "eventSubscriptionUpdateParameters"
);
@@clientLocation(EventSubscriptionOperationGroup.delete, EventSubscriptions);
@@clientLocation(EventSubscriptionOperationGroup.listGlobalBySubscription,
  EventSubscriptions
);
@@clientLocation(EventSubscriptionOperationGroup.getDeliveryAttributes,
  EventSubscriptions
);
@@clientLocation(EventSubscriptionOperationGroup.getFullUrl,
  EventSubscriptions
);
@@clientName(SystemTopicEventSubscriptions.createOrUpdate::parameters.resource,
  "eventSubscriptionInfo"
);
@@clientName(SystemTopicEventSubscriptions.update::parameters.properties,
  "eventSubscriptionUpdateParameters"
);
@@clientName(PartnerTopicEventSubscriptions.createOrUpdate::parameters.resource,
  "eventSubscriptionInfo"
);
@@clientName(PartnerTopicEventSubscriptions.update::parameters.properties,
  "eventSubscriptionUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EventSubscription.properties);

@@clientName(Namespaces.createOrUpdate::parameters.resource, "namespaceInfo");
@@clientName(Namespaces.update::parameters.properties,
  "namespaceUpdateParameters"
);
@@clientName(Namespaces.regenerateKey::parameters.body, "regenerateKeyRequest");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Namespace.properties);

@@clientName(NamespaceTopics.createOrUpdate::parameters.resource,
  "namespaceTopicInfo"
);
@@clientName(NamespaceTopics.update::parameters.properties,
  "namespaceTopicUpdateParameters"
);
@@clientName(NamespaceTopics.regenerateKey::parameters.body,
  "regenerateKeyRequest"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NamespaceTopic.properties);

@@clientName(PartnerConfigurations.createOrUpdate::parameters.resource,
  "partnerConfigurationInfo"
);
@@clientName(PartnerConfigurations.update::parameters.properties,
  "partnerConfigurationUpdateParameters"
);
@@clientName(PartnerConfigurations.authorizePartner::parameters.body,
  "partnerInfo"
);
@@clientName(PartnerConfigurations.unauthorizePartner::parameters.body,
  "partnerInfo"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PartnerConfiguration.properties);

@@clientName(PartnerDestinations.createOrUpdate::parameters.resource,
  "partnerDestination"
);
@@clientName(PartnerDestinations.update::parameters.properties,
  "partnerDestinationUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PartnerDestination.properties);

@@clientName(PartnerNamespaces.createOrUpdate::parameters.resource,
  "partnerNamespaceInfo"
);
@@clientName(PartnerNamespaces.update::parameters.properties,
  "partnerNamespaceUpdateParameters"
);
@@clientName(PartnerNamespaces.regenerateKey::parameters.body,
  "regenerateKeyRequest"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PartnerNamespace.properties);

@@clientName(PartnerRegistrations.createOrUpdate::parameters.resource,
  "partnerRegistrationInfo"
);
@@clientName(PartnerRegistrations.update::parameters.properties,
  "partnerRegistrationUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PartnerRegistration.properties);

@@clientName(PartnerTopics.createOrUpdate::parameters.resource,
  "partnerTopicInfo"
);
@@clientName(PartnerTopics.update::parameters.properties,
  "partnerTopicUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PartnerTopic.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkSecurityPerimeterConfiguration.properties);

@@clientName(PermissionBindings.createOrUpdate::parameters.resource,
  "permissionBindingInfo"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PermissionBinding.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(SystemTopics.createOrUpdate::parameters.resource,
  "systemTopicInfo"
);
@@clientName(SystemTopics.update::parameters.properties,
  "systemTopicUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SystemTopic.properties);

@@clientName(Topics.createOrUpdate::parameters.resource, "topicInfo");
@@clientName(Topics.update::parameters.properties, "topicUpdateParameters");
@@clientName(Topics.regenerateKey::parameters.body, "regenerateKeyRequest");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Topic.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ExtensionTopic.properties);

@@clientName(TopicSpaces.createOrUpdate::parameters.resource, "topicSpaceInfo");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TopicSpace.properties);

@@clientLocation(TopicTypeInfos.get, "TopicTypes");
@@clientLocation(TopicTypeInfos.list, "TopicTypes");
@@clientLocation(TopicTypeInfos.listEventTypes, "TopicTypes");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TopicTypeInfo.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VerifiedPartner.properties);

@@clientLocation(EventSubscriptionsOperationGroup.listGlobalBySubscriptionForTopicType,
  EventSubscriptions
);
@@clientLocation(EventSubscriptionsOperationGroup.listGlobalByResourceGroupForTopicType,
  EventSubscriptions
);
@@clientLocation(EventSubscriptionsOperationGroup.listRegionalBySubscription,
  EventSubscriptions
);
@@clientLocation(EventSubscriptionsOperationGroup.listRegionalByResourceGroup,
  EventSubscriptions
);
@@clientLocation(EventSubscriptionsOperationGroup.listRegionalBySubscriptionForTopicType,
  EventSubscriptions
);
@@clientLocation(EventSubscriptionsOperationGroup.listRegionalByResourceGroupForTopicType,
  EventSubscriptions
);

@@clientLocation(TopicsOperationGroup.listEventTypes, Topics);
