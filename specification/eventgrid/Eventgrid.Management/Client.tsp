import "./main.tsp";
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
@@flattenProperty(TopicUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PartnerConfigurationUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PartnerNamespaceUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EventType.properties);

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

@@clientName(Subscriptions.createOrUpdate::parameters.resource,
  "eventSubscriptionInfo"
);
@@clientName(Subscriptions.update::parameters.properties,
  "eventSubscriptionUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Subscription.properties);

@@clientName(EventSubscriptions.createOrUpdate::parameters.resource,
  "eventSubscriptionInfo"
);
@@clientName(EventSubscriptions.update::parameters.properties,
  "eventSubscriptionUpdateParameters"
);
@@clientName(DomainEventSubscriptions.createOrUpdate::parameters.resource,
  "eventSubscriptionInfo"
);
@@clientName(DomainEventSubscriptions.update::parameters.properties,
  "eventSubscriptionUpdateParameters"
);
@@clientName(EventSubscriptionOperationGroup.createOrUpdate::parameters.resource,
  "eventSubscriptionInfo"
);
@@clientName(EventSubscriptionOperationGroup.update::parameters.properties,
  "eventSubscriptionUpdateParameters"
);
@@clientName(DomainTopicEventSubscriptions.createOrUpdate::parameters.resource,
  "eventSubscriptionInfo"
);
@@clientName(DomainTopicEventSubscriptions.update::parameters.properties,
  "eventSubscriptionUpdateParameters"
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

@@clientName(Topics.createOrUpdate::parameters.resource, "topicInfo");
@@clientName(Topics.update::parameters.properties, "topicUpdateParameters");
@@clientName(Topics.regenerateKey::parameters.body, "regenerateKeyRequest");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Topic.properties);

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

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ExtensionTopic.properties);

@@clientName(TopicSpaces.createOrUpdate::parameters.resource, "topicSpaceInfo");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TopicSpace.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TopicTypeInfo.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VerifiedPartner.properties);
