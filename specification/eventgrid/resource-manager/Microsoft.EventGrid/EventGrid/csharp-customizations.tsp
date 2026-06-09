import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.EventGrid;

namespace Customization;

@@clientName(Microsoft.EventGrid.Channel, "PartnerNamespaceChannel", "csharp");
@@clientName(ChannelProvisioningState, "PartnerNamespaceChannelProvisioningState", "csharp");
@@clientName(ChannelType, "PartnerNamespaceChannelType", "csharp");
@@clientName(Microsoft.EventGrid.Client, "EventGridNamespaceClient", "csharp");
@@clientName(Microsoft.EventGrid.ClientGroup, "EventGridNamespaceClientGroup", "csharp");
@@clientName(ClientProvisioningState, "EventGridNamespaceClientProvisioningState", "csharp");
@@clientName(ClientState, "EventGridNamespaceClientState", "csharp");
@@clientName(ResourceProvisioningState, "EventGridResourceProvisioningState", "csharp");
@@clientName(ConnectionState, "EventGridPrivateEndpointConnectionState", "csharp");
@@clientName(Microsoft.EventGrid.Domain, "EventGridDomain", "csharp");
@@clientName(DomainSharedAccessKeys, "EventGridDomainSharedAccessKeys", "csharp");
@@clientName(Microsoft.EventGrid.EventSubscription, "EventGridSubscription", "csharp");
@@clientName(DomainProvisioningState, "EventGridDomainProvisioningState", "csharp");
@@clientName(DomainRegenerateKeyRequest, "EventGridDomainRegenerateKeyContent", "csharp");
@@clientName(EventTypeInfo, "PartnerTopicEventTypeInfo", "csharp");
@@clientName(InputSchema, "EventGridInputSchema", "csharp");
@@clientName(InputSchemaMapping, "EventGridInputSchemaMapping", "csharp");
@@clientName(EventSubscriptionUpdateParameters, "EventGridSubscriptionPatch", "csharp");
@@clientName(Filter, "EventGridFilter", "csharp");
@@clientName(InboundIpRule, "EventGridInboundIPRule", "csharp");
@@clientName(IpActionType, "EventGridIPActionType", "csharp");
@@clientName(Microsoft.EventGrid.Namespace, "EventGridNamespace", "csharp");
@@clientName(Microsoft.EventGrid.Subscription, "NamespaceTopicEventSubscription", "csharp");
@@clientName(NamespaceRegenerateKeyRequest, "NamespaceRegenerateKeyContent", "csharp");
@@clientName(Partner, "EventGridPartnerContent", "csharp");
@@clientName(PartnerNamespaceRegenerateKeyRequest, "PartnerNamespaceRegenerateKeyContent", "csharp");
@@clientName(Microsoft.EventGrid.PermissionBinding, "EventGridNamespacePermissionBinding", "csharp");
@@clientName(PersistedConnectionStatus, "EventGridPrivateEndpointPersistedConnectionStatus", "csharp");
@@clientName(PublicNetworkAccess, "EventGridPublicNetworkAccess", "csharp");
@@clientName(ReadinessState, "PartnerTopicReadinessState", "csharp");
@@clientName(ResourceRegionType, "EventGridResourceRegionType", "csharp");
@@clientName(RetryPolicy, "EventSubscriptionRetryPolicy", "csharp");
@@clientName(EventType, "EventTypeUnderTopic", "csharp");
@@clientName(Microsoft.EventGrid.Topic, "EventGridTopic", "csharp");
@@clientName(TopicProvisioningState, "EventGridTopicProvisioningState", "csharp");
@@clientName(TopicRegenerateKeyRequest, "TopicRegenerateKeyContent", "csharp");
@@clientName(Microsoft.EventGrid.TopicTypeInfo, "TopicType", "csharp");

#suppress "@azure-tools/typespec-client-generator-core/client-option" "Customize expanded private endpoint resource names for GA compatibility"
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "Customize expanded private endpoint resource names for GA compatibility"
@@clientOption(
  PrivateEndpointConnections.get,
  "resource-name",
  #{
    topics: "EventGridTopicPrivateEndpointConnection",
    domains: "EventGridDomainPrivateEndpointConnection",
    partnerNamespaces: "EventGridPartnerNamespacePrivateEndpointConnection",
    namespaces: "EventGridNamespacePrivateEndpointConnection",
  },
  "csharp"
);

@@clientName(Subscriptions.getFullUrl, "GetFullUri", "csharp");
@@clientName(EventSubscriptions.getFullUrl, "GetFullUri", "csharp");
@@clientName(TopicEventSubscriptions.getFullUrl, "GetFullUri", "csharp");
@@clientName(DomainEventSubscriptions.getFullUrl, "GetFullUri", "csharp");
@@clientName(EventSubscriptionOperationGroup.getFullUrl, "GetFullUri", "csharp");
@@clientName(SystemTopicEventSubscriptions.getFullUrl, "GetFullUri", "csharp");
@@clientName(PartnerTopicEventSubscriptions.getFullUrl, "GetFullUri", "csharp");
@@clientName(Channels.getFullUrl, "GetFullUri", "csharp");

@@clientName(DomainProperties.disableLocalAuth, "IsLocalAuthDisabled", "csharp");
@@clientName(PartnerNamespaceProperties.disableLocalAuth, "IsLocalAuthDisabled", "csharp");
@@clientName(ChannelProperties.expirationTimeIfNotActivatedUtc, "ExpireOnIfNotActivated", "csharp");
@@clientName(EventSubscriptionProperties.expirationTimeUtc, "ExpireOn", "csharp");
@@clientName(NamespaceProperties.inboundIpRules, "InboundIPRules", "csharp");
@@clientName(PrivateEndpointConnectionProperties.privateLinkServiceConnectionState, "ConnectionState", "csharp");
@@clientName(TopicProperties.disableLocalAuth, "IsLocalAuthDisabled", "csharp");
@@clientName(TopicProperties.inboundIpRules, "InboundIPRules", "csharp");
@@clientName(SubscriptionProperties.expirationTimeUtc, "ExpireOn", "csharp");

@@alternateType(DomainProperties.endpoint, url, "csharp");
@@alternateType(Microsoft.EventGrid.Namespace.identity, Azure.ResourceManager.CommonTypes.ManagedServiceIdentity, "csharp");
@@alternateType(PartnerNamespaceProperties.endpoint, url, "csharp");
@@alternateType(EventTypeProperties.schemaUrl, url, "csharp");
@@alternateType(PrivateEndpoint.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(Domain.identity, Azure.ResourceManager.CommonTypes.ManagedServiceIdentity, "csharp");
@@alternateType(Microsoft.EventGrid.Topic.identity, Azure.ResourceManager.CommonTypes.ManagedServiceIdentity, "csharp");
@@alternateType(TopicProperties.endpoint, url, "csharp");
@@alternateType(PartnerNamespaceProperties.partnerRegistrationFullyQualifiedId, Azure.Core.armResourceIdentifier, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@markAsPageable(Subscriptions.getDeliveryAttributes, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@markAsPageable(EventSubscriptions.getDeliveryAttributes, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@markAsPageable(TopicEventSubscriptions.getDeliveryAttributes, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@markAsPageable(DomainEventSubscriptions.getDeliveryAttributes, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@markAsPageable(EventSubscriptionOperationGroup.getDeliveryAttributes, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@markAsPageable(SystemTopicEventSubscriptions.getDeliveryAttributes, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@markAsPageable(PartnerTopicEventSubscriptions.getDeliveryAttributes, "csharp");
