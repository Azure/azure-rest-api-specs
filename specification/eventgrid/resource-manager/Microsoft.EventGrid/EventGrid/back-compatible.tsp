import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.EventGrid;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ChannelUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DomainUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SubscriptionUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NamespaceUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NamespaceTopicUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Operation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PartnerConfigurationUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PartnerNamespaceUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkSecurityPerimeterConfigurationIssues.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkSecurityPerimeterProfileAccessRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(TopicUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(EventType.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureADPartnerClientAuthentication.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WebhookPartnerDestinationInfo.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WebhookUpdatePartnerDestinationInfo.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(JsonInputSchemaMapping.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(StaticDeliveryAttributeMapping.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DynamicDeliveryAttributeMapping.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(StorageBlobDeadLetterDestination.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WebHookEventSubscriptionDestination.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(EventHubEventSubscriptionDestination.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(StorageQueueEventSubscriptionDestination.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HybridConnectionEventSubscriptionDestination.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ServiceBusQueueEventSubscriptionDestination.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ServiceBusTopicEventSubscriptionDestination.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureFunctionEventSubscriptionDestination.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PartnerEventSubscriptionDestination.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MonitorAlertEventSubscriptionDestination.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NamespaceTopicEventSubscriptionDestination.properties);

@@clientName(CaCertificates.createOrUpdate::parameters.resource,
  "caCertificateInfo"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CaCertificate.properties);

@@clientName(Channels.createOrUpdate::parameters.resource, "channelInfo");
@@clientName(Channels.update::parameters.properties, "channelUpdateParameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Channel.properties);

@@clientName(ClientGroups.createOrUpdate::parameters.resource,
  "clientGroupInfo"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ClientGroup.properties);

@@clientName(Clients.createOrUpdate::parameters.resource, "clientInfo");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Client.properties);

@@clientName(Domains.createOrUpdate::parameters.resource, "domainInfo");
@@clientName(Domains.update::parameters.properties, "domainUpdateParameters");
@@clientName(Domains.regenerateKey::parameters.body, "regenerateKeyRequest");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Domain.properties);

@@clientName(PrivateEndpointConnections.update::parameters.body,
  "privateEndpointConnection"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DomainTopic.properties);

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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Subscription.properties);

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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(EventSubscription.properties);

@@clientName(Namespaces.createOrUpdate::parameters.resource, "namespaceInfo");
@@clientName(Namespaces.update::parameters.properties,
  "namespaceUpdateParameters"
);
@@clientName(Namespaces.regenerateKey::parameters.body, "regenerateKeyRequest");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Namespace.properties);

@@clientName(NamespaceTopics.createOrUpdate::parameters.resource,
  "namespaceTopicInfo"
);
@@clientName(NamespaceTopics.update::parameters.properties,
  "namespaceTopicUpdateParameters"
);
@@clientName(NamespaceTopics.regenerateKey::parameters.body,
  "regenerateKeyRequest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NamespaceTopic.properties);

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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PartnerConfiguration.properties);

@@clientName(PartnerDestinations.createOrUpdate::parameters.resource,
  "partnerDestination"
);
@@clientName(PartnerDestinations.update::parameters.properties,
  "partnerDestinationUpdateParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PartnerDestination.properties);

@@clientName(PartnerNamespaces.createOrUpdate::parameters.resource,
  "partnerNamespaceInfo"
);
@@clientName(PartnerNamespaces.update::parameters.properties,
  "partnerNamespaceUpdateParameters"
);
@@clientName(PartnerNamespaces.regenerateKey::parameters.body,
  "regenerateKeyRequest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PartnerNamespace.properties);

@@clientName(PartnerRegistrations.createOrUpdate::parameters.resource,
  "partnerRegistrationInfo"
);
@@clientName(PartnerRegistrations.update::parameters.properties,
  "partnerRegistrationUpdateParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PartnerRegistration.properties);

@@clientName(PartnerTopics.createOrUpdate::parameters.resource,
  "partnerTopicInfo"
);
@@clientName(PartnerTopics.update::parameters.properties,
  "partnerTopicUpdateParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PartnerTopic.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkSecurityPerimeterConfiguration.properties);

@@clientName(PermissionBindings.createOrUpdate::parameters.resource,
  "permissionBindingInfo"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PermissionBinding.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrivateLinkResource.properties);

@@clientName(SystemTopics.createOrUpdate::parameters.resource,
  "systemTopicInfo"
);
@@clientName(SystemTopics.update::parameters.properties,
  "systemTopicUpdateParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SystemTopic.properties);

@@clientName(Topics.createOrUpdate::parameters.resource, "topicInfo");
@@clientName(Topics.update::parameters.properties, "topicUpdateParameters");
@@clientName(Topics.regenerateKey::parameters.body, "regenerateKeyRequest");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Topic.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ExtensionTopic.properties);

@@clientName(TopicSpaces.createOrUpdate::parameters.resource, "topicSpaceInfo");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(TopicSpace.properties);

@@clientLocation(TopicTypeInfos.get, "TopicTypes");
@@clientLocation(TopicTypeInfos.list, "TopicTypes");
@@clientLocation(TopicTypeInfos.listEventTypes, "TopicTypes");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(TopicTypeInfo.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(VerifiedPartner.properties);

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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Operation.properties);

@@visibility(DomainTopic.properties, Lifecycle.Read);
