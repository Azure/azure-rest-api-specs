import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.EventGrid;

namespace Customization;

// C#-only union for PrivateEndpointConnectionsParentType without namespaces entry
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Matches source union pattern; string member has no inline docs"
union PrivateEndpointConnectionsParentTypeCsharp {
  string,

  /**
   * topics
   */
  topics: "topics",

  /**
   * domains
   */
  domains: "domains",

  /**
   * partnerNamespaces
   */
  partnerNamespaces: "partnerNamespaces",
}

@@alternateType(
  PrivateEndpointConnectionsParentType,
  PrivateEndpointConnectionsParentTypeCsharp,
  "csharp"
);

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

// Hide these two list routes from the C# SDK public surface to preserve GA/main API shape.
//
// WHY: On main, the (old) generator collapses FOUR event-subscription list routes into a
// single scope-dispatched EventSubscriptionCollection.GetAll(...) that branches on the
// parent resource type:
//   SubscriptionResource    -> ListGlobalBySubscription
//   ResourceGroupResource   -> ListGlobalByResourceGroup
//   DomainTopicResource     -> ListByDomainTopic   (this op)
//   (any other scope)       -> ListByResource      (this op)
// The new mgmt generator cannot reproduce that multi-route "scope collection" collapse, so
// EventSubscriptionCollection.GetAll is supplied by the SDK customization at
// src/Customized/EventSubscriptionCollection.cs.
//
// If we let these two ops generate normally, they surface as EXTRA public methods that do
// NOT exist on main: DomainTopicResource.GetByDomainTopic* and
// MockableEventGridArmClient.GetByResource*.
//
// Both ops are internalized (NOT scoped out): the customization's DomainTopicResource and
// default scope branches reuse these ops' GENERATED plumbing
// (EventSubscriptions*CollectionResultOfT + the REST client methods on the EventSubscriptions
// REST client), so the ops must keep generating internally. Internal access just removes the
// duplicate public methods.
//
// NOTE: listByDomainTopic (EventSubscriptions_ListByDomainTopic ->
// .../topics/{topic}/providers/Microsoft.EventGrid/eventSubscriptions) is a DIFFERENT REST
// route than DomainTopicEventSubscriptions_List
// (.../topics/{topic}/eventSubscriptions, used by DomainTopicEventSubscriptionCollection.GetAll).
// main's EventSubscriptionCollection.GetAll calls ListByDomainTopic, so the customization MUST
// use this op's plumbing (not delegate to DomainTopicEventSubscriptionCollection) to match main.
@@access(EventSubscriptions.listByDomainTopic, Access.internal, "csharp");
@@access(
  EventSubscriptionOperationGroup.listByResource,
  Access.internal,
  "csharp"
);

@@clientName(NetworkSecurityPerimeterConfigurations.get, "Get", "csharp");
// The six list* provider actions below intentionally share three GA-compatible client names
// (one pair each for the subscription-scope and resource-group-scope extension variants). The
// names are duplicated on purpose to preserve the pre-migration public method names; the two
// operations in each pair live on different extension scopes and are disambiguated by the SDK
// mockable layer, so the duplicate-client-name warning is expected and suppressed here.
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Intentional GA-compatible duplicate name across subscription/resource-group extension scopes."
@@clientName(
  EventSubscriptionsOperationGroup.listGlobalBySubscriptionForTopicType,
  "GetGlobalEventSubscriptionsDataForTopicType",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Intentional GA-compatible duplicate name across subscription/resource-group extension scopes."
@@clientName(
  EventSubscriptionsOperationGroup.listGlobalByResourceGroupForTopicType,
  "GetGlobalEventSubscriptionsDataForTopicType",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Intentional GA-compatible duplicate name across subscription/resource-group extension scopes."
@@clientName(
  EventSubscriptionsOperationGroup.listRegionalBySubscription,
  "GetRegionalEventSubscriptionsData",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Intentional GA-compatible duplicate name across subscription/resource-group extension scopes."
@@clientName(
  EventSubscriptionsOperationGroup.listRegionalByResourceGroup,
  "GetRegionalEventSubscriptionsData",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Intentional GA-compatible duplicate name across subscription/resource-group extension scopes."
@@clientName(
  EventSubscriptionsOperationGroup.listRegionalBySubscriptionForTopicType,
  "GetRegionalEventSubscriptionsDataForTopicType",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Intentional GA-compatible duplicate name across subscription/resource-group extension scopes."
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
  exact("CloudEventSchemaV1_0"),
  "csharp"
);
@@clientName(
  InputSchema.CloudEventSchemaV1_0,
  exact("CloudEventSchemaV1_0"),
  "csharp"
);
@@alternateType(PartnerDetails.setupUri, url, "csharp");
@@alternateType(
  CustomerManagedKeyEncryption.keyEncryptionKeyUrl,
  url,
  "csharp"
);
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
  AzureADPartnerClientAuthenticationProperties.azureActiveDirectoryApplicationIdOrUri,
  url,
  "csharp"
);
@@clientName(
  AlternativeAuthenticationNameSource.ClientCertificateIp,
  "ClientCertificateIP",
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
@@alternateType(EventSubscriptionFullUrl.endpointUrl, url, "csharp");
@@clientName(EventSubscriptionFullUrl.endpointUrl, "Endpoint", "csharp");

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

// Read-only resources that need mutable properties for GA API compatibility
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: GA SDK exposed public setters on read-only resource data types"
@@usage(VerifiedPartner, Usage.input | Usage.output, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: GA SDK exposed public setters on read-only resource data types"
@@usage(TopicTypeInfo, Usage.input | Usage.output, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: GA SDK exposed public setters on read-only resource data types"
@@usage(DomainTopic, Usage.input | Usage.output, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility: GA SDK exposed public setters on read-only resource data types"
@@usage(ExtensionTopic, Usage.input | Usage.output, "csharp");

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
