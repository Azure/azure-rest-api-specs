import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.EventGrid;

namespace Customization;

@@clientName(Microsoft.EventGrid.Channel, "PartnerNamespaceChannel", "csharp");
@@clientName(
  ChannelProvisioningState,
  "PartnerNamespaceChannelProvisioningState",
  "csharp"
);
@@clientName(ChannelType, "PartnerNamespaceChannelType", "csharp");
@@clientName(Microsoft.EventGrid.Client, "EventGridNamespaceClient", "csharp");
@@clientName(
  Microsoft.EventGrid.ClientGroup,
  "EventGridNamespaceClientGroup",
  "csharp"
);
@@clientName(
  ClientProvisioningState,
  "EventGridNamespaceClientProvisioningState",
  "csharp"
);
@@clientName(ClientState, "EventGridNamespaceClientState", "csharp");
@@clientName(
  ResourceProvisioningState,
  "EventGridResourceProvisioningState",
  "csharp"
);
@@clientName(
  ConnectionState,
  "EventGridPrivateEndpointConnectionState",
  "csharp"
);
@@clientName(Microsoft.EventGrid.Domain, "EventGridDomain", "csharp");
@@clientName(
  DomainSharedAccessKeys,
  "EventGridDomainSharedAccessKeys",
  "csharp"
);
@@clientName(
  Microsoft.EventGrid.EventSubscription,
  "EventGridSubscription",
  "csharp"
);
@@clientName(
  DomainProvisioningState,
  "EventGridDomainProvisioningState",
  "csharp"
);
@@clientName(
  DomainRegenerateKeyRequest,
  "EventGridDomainRegenerateKeyContent",
  "csharp"
);
@@clientName(EventTypeInfo, "PartnerTopicEventTypeInfo", "csharp");
@@clientName(InputSchema, "EventGridInputSchema", "csharp");
@@clientName(InputSchemaMapping, "EventGridInputSchemaMapping", "csharp");
@@clientName(
  JsonInputSchemaMapping,
  "EventGridJsonInputSchemaMapping",
  "csharp"
);
@@clientName(
  EventSubscriptionUpdateParameters,
  "EventGridSubscriptionPatch",
  "csharp"
);
@@clientName(Filter, "EventGridFilter", "csharp");
@@clientName(InboundIpRule, "EventGridInboundIPRule", "csharp");
@@clientName(IpActionType, "EventGridIPActionType", "csharp");
@@clientName(Microsoft.EventGrid.Namespace, "EventGridNamespace", "csharp");
@@clientName(
  Microsoft.EventGrid.Subscription,
  "NamespaceTopicEventSubscription",
  "csharp"
);
@@clientName(
  NamespaceRegenerateKeyRequest,
  "NamespaceRegenerateKeyContent",
  "csharp"
);
@@clientName(Partner, "EventGridPartnerContent", "csharp");
@@clientName(
  PartnerNamespaceRegenerateKeyRequest,
  "PartnerNamespaceRegenerateKeyContent",
  "csharp"
);
@@clientName(
  Microsoft.EventGrid.PermissionBinding,
  "EventGridNamespacePermissionBinding",
  "csharp"
);
@@clientName(
  PersistedConnectionStatus,
  "EventGridPrivateEndpointPersistedConnectionStatus",
  "csharp"
);
@@clientName(PublicNetworkAccess, "EventGridPublicNetworkAccess", "csharp");
@@clientName(ReadinessState, "PartnerTopicReadinessState", "csharp");
@@clientName(ResourceRegionType, "EventGridResourceRegionType", "csharp");
@@clientName(RetryPolicy, "EventSubscriptionRetryPolicy", "csharp");
@@clientName(EventType, "EventTypeUnderTopic", "csharp");
@@clientName(Microsoft.EventGrid.Topic, "EventGridTopic", "csharp");
@@clientName(
  TopicProvisioningState,
  "EventGridTopicProvisioningState",
  "csharp"
);
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
@@clientName(
  EventSubscriptionOperationGroup.getFullUrl,
  "GetFullUri",
  "csharp"
);
@@clientName(SystemTopicEventSubscriptions.getFullUrl, "GetFullUri", "csharp");
@@clientName(PartnerTopicEventSubscriptions.getFullUrl, "GetFullUri", "csharp");
@@clientName(Channels.getFullUrl, "GetFullUri", "csharp");
@@clientLocation(
  EventSubscriptionsOperationGroup.listGlobalBySubscriptionForTopicType,
  "EventSubscriptionsSubscriptionScope",
  "csharp"
);
@@clientLocation(
  EventSubscriptionsOperationGroup.listGlobalByResourceGroupForTopicType,
  "EventSubscriptionsResourceGroupScope",
  "csharp"
);
@@clientLocation(
  EventSubscriptionsOperationGroup.listRegionalBySubscription,
  "EventSubscriptionsSubscriptionScope",
  "csharp"
);
@@clientLocation(
  EventSubscriptionsOperationGroup.listRegionalByResourceGroup,
  "EventSubscriptionsResourceGroupScope",
  "csharp"
);
@@clientLocation(
  EventSubscriptionsOperationGroup.listRegionalBySubscriptionForTopicType,
  "EventSubscriptionsSubscriptionScope",
  "csharp"
);
@@clientLocation(
  EventSubscriptionsOperationGroup.listRegionalByResourceGroupForTopicType,
  "EventSubscriptionsResourceGroupScope",
  "csharp"
);
@@clientName(
  EventSubscriptionsOperationGroup.listGlobalBySubscriptionForTopicType,
  "GetGlobalEventSubscriptionsDataForTopicType",
  "csharp"
);
@@clientName(
  EventSubscriptionsOperationGroup.listGlobalByResourceGroupForTopicType,
  "GetGlobalEventSubscriptionsDataForTopicType",
  "csharp"
);
@@clientName(
  EventSubscriptionsOperationGroup.listRegionalBySubscription,
  "GetRegionalEventSubscriptionsData",
  "csharp"
);
@@clientName(
  EventSubscriptionsOperationGroup.listRegionalByResourceGroup,
  "GetRegionalEventSubscriptionsData",
  "csharp"
);
@@clientName(
  EventSubscriptionsOperationGroup.listRegionalBySubscriptionForTopicType,
  "GetRegionalEventSubscriptionsDataForTopicType",
  "csharp"
);
@@clientName(
  EventSubscriptionsOperationGroup.listRegionalByResourceGroupForTopicType,
  "GetRegionalEventSubscriptionsDataForTopicType",
  "csharp"
);

@@clientName(
  DomainProperties.disableLocalAuth,
  "IsLocalAuthDisabled",
  "csharp"
);
@@clientName(DomainProperties.inboundIpRules, "InboundIPRules", "csharp");
@@clientName(
  DomainUpdateParameterProperties.disableLocalAuth,
  "IsLocalAuthDisabled",
  "csharp"
);
@@clientName(
  DomainUpdateParameterProperties.inboundIpRules,
  "InboundIPRules",
  "csharp"
);
@@clientName(
  PartnerNamespaceProperties.disableLocalAuth,
  "IsLocalAuthDisabled",
  "csharp"
);
@@clientName(
  PartnerNamespaceProperties.inboundIpRules,
  "InboundIPRules",
  "csharp"
);
@@clientName(
  PartnerNamespaceUpdateParameterProperties.disableLocalAuth,
  "IsLocalAuthDisabled",
  "csharp"
);
@@clientName(
  PartnerNamespaceUpdateParameterProperties.inboundIpRules,
  "InboundIPRules",
  "csharp"
);
@@clientName(
  ChannelProperties.expirationTimeIfNotActivatedUtc,
  "ExpireOnIfNotActivated",
  "csharp"
);
@@clientName(
  ChannelUpdateParametersProperties.expirationTimeIfNotActivatedUtc,
  "ExpireOnIfNotActivated",
  "csharp"
);
@@clientName(InboundIpRule.ipMask, "IPMask", "csharp");
@@clientName(EventSubscriptionIdentity.type, "IdentityType", "csharp");
@@clientName(
  EventSubscriptionFilter.enableAdvancedFilteringOnArrays,
  "IsAdvancedFilteringOnArraysEnabled",
  "csharp"
);
@@clientName(
  EventSubscriptionUpdateParameters.expirationTimeUtc,
  "ExpireOn",
  "csharp"
);
@@clientName(
  SubscriptionUpdateParametersProperties.expirationTimeUtc,
  "ExpireOn",
  "csharp"
);
@@clientName(
  Partner.authorizationExpirationTimeInUtc,
  "AuthorizationExpireOn",
  "csharp"
);
@@clientName(CustomDomainIdentity.type, "IdentityType", "csharp");
@@clientName(
  CustomJwtAuthenticationManagedIdentity.type,
  "IdentityType",
  "csharp"
);
@@clientName(
  CustomWebhookAuthenticationManagedIdentity.type,
  "IdentityType",
  "csharp"
);
@@clientName(NamespaceProperties.inboundIpRules, "InboundIPRules", "csharp");
@@clientName(
  NamespaceUpdateParameterProperties.inboundIpRules,
  "InboundIPRules",
  "csharp"
);
@@clientName(
  UpdateTopicsConfigurationInfo.customDomains,
  "TopicsCustomDomains",
  "csharp"
);
@@clientName(
  PartnerTopicProperties.expirationTimeIfNotActivatedUtc,
  "ExpireOnIfNotActivated",
  "csharp"
);
@@clientName(
  PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@clientName(PrivateEndpoint.id, "PrivateEndpointId", "csharp");
@@clientName(RoutingIdentityInfo.type, "IdentityType", "csharp");
@@clientName(TopicProperties.disableLocalAuth, "IsLocalAuthDisabled", "csharp");
@@clientName(TopicProperties.inboundIpRules, "InboundIPRules", "csharp");
@@clientName(
  TopicUpdateParameterProperties.disableLocalAuth,
  "IsLocalAuthDisabled",
  "csharp"
);
@@clientName(
  TopicUpdateParameterProperties.inboundIpRules,
  "InboundIPRules",
  "csharp"
);
@@clientName(SubscriptionProperties.expirationTimeUtc, "ExpireOn", "csharp");
@@clientName(
  EventSubscriptionProperties.expirationTimeUtc,
  "ExpireOn",
  "csharp"
);

@@alternateType(DomainProperties.endpoint, url, "csharp");
@@alternateType(
  Microsoft.EventGrid.Namespace.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(PartnerNamespaceProperties.endpoint, url, "csharp");
@@alternateType(EventTypeProperties.schemaUrl, url, "csharp");
@@alternateType(PrivateEndpoint.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(
  Domain.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  Microsoft.EventGrid.Topic.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  PartnerTopic.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(TopicProperties.endpoint, url, "csharp");
@@alternateType(
  PartnerNamespaceProperties.partnerRegistrationFullyQualifiedId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Partner.partnerRegistrationImmutableId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  PartnerDestinationProperties.partnerRegistrationImmutableId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  PartnerRegistrationProperties.partnerRegistrationImmutableId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  PartnerTopicProperties.partnerRegistrationImmutableId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  SystemTopic.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  SystemTopicProperties.source,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SystemTopicProperties.metricResourceId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  Microsoft.EventGrid.Topic.extendedLocation,
  Azure.ResourceManager.Foundations.ExtendedLocation,
  "csharp"
);
@@alternateType(IssuerCertificateInfo.certificateUrl, url, "csharp");
@@alternateType(
  EventSubscriptionsOperationGroup.listRegionalBySubscription::parameters.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  EventSubscriptionsOperationGroup.listRegionalByResourceGroup::parameters.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  EventSubscriptionsOperationGroup.listRegionalBySubscriptionForTopicType::parameters.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  EventSubscriptionsOperationGroup.listRegionalByResourceGroupForTopicType::parameters.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  NetworkSecurityPerimeterInfo.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@usage(
  NetworkSecurityPerimeterConfiguration,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(
  NetworkSecurityPerimeterConfigurationProperties,
  Usage.input | Usage.output,
  "csharp"
);
@@clientName(
  ClientCertificateValidationScheme.IpMatchesAuthenticationName,
  "IPMatchesAuthenticationName",
  "csharp"
);
@@clientName(
  EventDeliverySchema.CloudEventSchemaV1_0,
  "CloudEventSchemaV1_0",
  "csharp"
);
@@clientName(
  InputSchema.CloudEventSchemaV1_0,
  "CloudEventSchemaV1_0",
  "csharp"
);
@@alternateType(PartnerDetails.setupUri, url, "csharp");
@@alternateType(
  PartnerEventSubscriptionDestinationProperties.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  VerifiedPartnerProperties.partnerRegistrationImmutableId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  WebhookAuthenticationSettings.azureActiveDirectoryApplicationIdOrUri,
  url,
  "csharp"
);
@@alternateType(
  WebHookEventSubscriptionDestinationProperties.azureActiveDirectoryTenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  WebHookEventSubscriptionDestinationProperties.endpointBaseUrl,
  url,
  "csharp"
);
@@alternateType(
  WebHookEventSubscriptionDestinationProperties.endpointUrl,
  url,
  "csharp"
);

@@clientName(
  WebHookEventSubscriptionDestinationProperties.azureActiveDirectoryApplicationIdOrUri,
  "UriOrAzureActiveDirectoryApplicationId",
  "csharp"
);
@@clientName(
  WebHookEventSubscriptionDestinationProperties.endpointBaseUrl,
  "BaseEndpoint",
  "csharp"
);
@@clientName(
  WebHookEventSubscriptionDestinationProperties.endpointUrl,
  "Endpoint",
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(Domain.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(DomainUpdateParameters.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(DomainTopic.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(EventType.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(ExtensionTopic.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(JsonInputSchemaMapping.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(NamespaceUpdateParameters.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(
  NamespaceUpdateParameterProperties.topicsConfiguration,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(PartnerConfiguration.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(ChannelUpdateParametersProperties.partnerTopicInfo, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(PartnerNamespace.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(PartnerNamespaceUpdateParameters.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(PartnerRegistration.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(PartnerTopic.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(PrivateEndpointConnection.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(
  PrivateEndpointConnectionProperties.privateEndpoint,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(SystemTopic.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(Topic.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(TopicUpdateParameters.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(TopicTypeInfo.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: force legacy flattening for migrated EventGrid ARM data models"
@@flattenProperty(VerifiedPartner.properties, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@markAsPageable(Subscriptions.getDeliveryAttributes, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@markAsPageable(EventSubscriptions.getDeliveryAttributes, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@markAsPageable(TopicEventSubscriptions.getDeliveryAttributes, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@markAsPageable(DomainEventSubscriptions.getDeliveryAttributes, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@markAsPageable(
  EventSubscriptionOperationGroup.getDeliveryAttributes,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@markAsPageable(SystemTopicEventSubscriptions.getDeliveryAttributes, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@markAsPageable(
  PartnerTopicEventSubscriptions.getDeliveryAttributes,
  "csharp"
);
