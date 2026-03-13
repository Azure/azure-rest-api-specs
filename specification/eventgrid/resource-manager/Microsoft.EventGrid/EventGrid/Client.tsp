import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Namespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

namespace Microsoft.EventGrid;
/**
 * The Client resource.
 */
@parentResource(Namespace)
model Client is Azure.ResourceManager.ProxyResource<ClientProperties> {
  ...ResourceNameParameter<
    Resource = Client,
    KeyName = "clientName",
    SegmentName = "clients",
    NamePattern = "^[-a-zA-Z0-9:\\._]*$"
  >;
}

@armResourceOperations
interface Clients {
  /**
   * Get properties of a client.
   */
  @summary("Get a client.")
  get is ArmResourceRead<Client>;

  /**
   * Create or update a client with the specified parameters.
   */
  @summary("Create or update a client.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Client>;

  /**
   * Delete an existing client.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a client.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Client,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get all the permission bindings under a namespace.
   */
  @summary("List all permission bindings under a namespace.")
  listByNamespace is ArmResourceListByParent<
    Client,
    Parameters = {
      /**
       * The query used to filter the search results using OData syntax. Filtering is permitted on the 'name' property only and with limited number of OData operations. These operations are: the 'contains' function as well as the following logical operations: not, and, or, eq (for equal), and ne (for not equal). No arithmetic operations are supported. The following is a valid filter example: $filter=contains(namE, 'PATTERN') and name ne 'PATTERN-1'. The following is not a valid filter example: $filter=location eq 'westus'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of results to return per page for the list operation. Valid range for top parameter is 1 to 100. If not specified, the default number of results to be returned is 20 items per page.
       */
      @query("$top")
      $top?: int32;
    },
    Response = ArmResponse<ClientsListResult>
  >;
}

@@maxLength(Client.name, 128);
@@minLength(Client.name, 1);
@@doc(Client.name, "Name of the client.");
@@doc(Client.properties, "The properties of client.");
@@doc(Clients.createOrUpdate::parameters.resource, "Client information.");

@@clientName(TlsVersion.`1.0`, "One0", "go,javascript,csharp");
@@clientName(TlsVersion.`1.1`, "One1", "go,javascript,csharp");
@@clientName(TlsVersion.`1.2`, "One2", "go,javascript,csharp");

@@clientName(WebHookEventSubscriptionDestinationProperties,
  "WebhookEventSubscriptionDestinationProperties",
  "java"
);
@@clientName(WebHookEventSubscriptionDestination,
  "WebhookEventSubscriptionDestination",
  "java"
);
@@clientName(Microsoft.EventGrid,
  "EventGridManagementClient",
  "python, javascript"
);
@@clientName(TlsVersion.`1.0`, "ONE0", "python");
@@clientName(TlsVersion.`1.1`, "ONE1", "python");
@@clientName(TlsVersion.`1.2`, "ONE2", "python");
@@clientName(Azure.ResourceManager.ResourceProvisioningState,
  "ArmResourceProvisioningState",
  "python"
);

// csharp configuration — unique additions (type-level renames already in back-compatible.tsp are not repeated)

// Property renames
@@clientName(ChannelProperties.expirationTimeIfNotActivatedUtc,
  "ExpireOnIfNotActivated",
  "csharp"
);
@@clientName(ChannelUpdateParametersProperties.expirationTimeIfNotActivatedUtc,
  "ExpireOnIfNotActivated",
  "csharp"
);
@@clientName(DomainProperties.disableLocalAuth, "IsLocalAuthDisabled", "csharp");
@@clientName(DomainProperties.endpoint, "Endpoint", "csharp");
@@clientName(DomainUpdateParameterProperties.disableLocalAuth,
  "IsLocalAuthDisabled",
  "csharp"
);
@@clientName(EventSubscriptionUpdateParameters.expirationTimeUtc,
  "ExpireOn",
  "csharp"
);
@@clientName(EventSubscriptionProperties.expirationTimeUtc, "ExpireOn", "csharp");
@@clientName(Partner.authorizationExpirationTimeInUtc,
  "AuthorizationExpireOn",
  "csharp"
);
@@clientName(PartnerNamespaceProperties.disableLocalAuth,
  "IsLocalAuthDisabled",
  "csharp"
);
@@clientName(PartnerNamespaceProperties.endpoint, "Endpoint", "csharp");
@@clientName(PartnerNamespaceUpdateParameterProperties.disableLocalAuth,
  "IsLocalAuthDisabled",
  "csharp"
);
@@clientName(PartnerTopicProperties.expirationTimeIfNotActivatedUtc,
  "ExpireOnIfNotActivated",
  "csharp"
);
@@clientName(TopicProperties.disableLocalAuth, "IsLocalAuthDisabled", "csharp");
@@clientName(TopicProperties.endpoint, "Endpoint", "csharp");
@@clientName(TopicUpdateParameterProperties.disableLocalAuth,
  "IsLocalAuthDisabled",
  "csharp"
);
// Type renames not in back-compatible.tsp
@@clientName(EventSubscriptionUpdateParameters,
  "EventGridSubscriptionPatch",
  "csharp"
);
@@clientName(DomainRegenerateKeyRequest,
  "EventGridDomainRegenerateKeyContent",
  "csharp"
);
@@clientName(ConnectionState,
  "EventGridPrivateEndpointConnectionState",
  "csharp"
);
@@clientName(PersistedConnectionStatus,
  "EventGridPrivateEndpointPersistedConnectionStatus",
  "csharp"
);
@@clientName(IpActionType, "EventGridIPActionType", "csharp");
@@clientName(JsonInputSchemaMapping,
  "EventGridJsonInputSchemaMapping",
  "csharp"
);
@@clientName(DomainSharedAccessKeys,
  "EventGridDomainSharedAccessKeys",
  "csharp"
);
@@clientName(ClientProvisioningState,
  "EventGridNamespaceClientProvisioningState",
  "csharp"
);
@@clientName(ClientState, "EventGridNamespaceClientState", "csharp");
@@clientName(ResourceRegionType, "EventGridResourceRegionType", "csharp");
@@clientName(TopicRegenerateKeyRequest, "TopicRegenerateKeyContent", "csharp");

// Endpoint and resource ID type overrides
@@alternateType(DomainProperties.endpoint, url, "csharp");
@@alternateType(TopicProperties.endpoint, url, "csharp");
@@alternateType(PartnerNamespaceProperties.endpoint, url, "csharp");
@@alternateType(PartnerNamespaceProperties.partnerRegistrationFullyQualifiedId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(SystemTopicProperties.source,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(SystemTopicProperties.metricResourceId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(EventHubEventSubscriptionDestinationProperties.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(AzureFunctionEventSubscriptionDestinationProperties.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(HybridConnectionEventSubscriptionDestinationProperties.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ServiceBusQueueEventSubscriptionDestinationProperties.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ServiceBusTopicEventSubscriptionDestinationProperties.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(StorageBlobDeadLetterDestinationProperties.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(StorageQueueEventSubscriptionDestinationProperties.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(EventSubscriptionFilter.enableAdvancedFilteringOnArrays,
  "IsAdvancedFilteringOnArraysEnabled",
  "csharp"
);
@@clientName(EventType, "EventTypeUnderTopic", "csharp");
@@clientName(PartnerNamespaceUpdateParameterProperties.disableLocalAuth,
  "IsLocalAuthDisabled",
  "csharp"
);
@@alternateType(PartnerTopicInfo.azureSubscriptionId,
  Azure.Core.uuid,
  "csharp"
);
@@clientName(WebHookEventSubscriptionDestinationProperties.azureActiveDirectoryApplicationIdOrUri,
  "UriOrAzureActiveDirectoryApplicationId",
  "csharp"
);
@@alternateType(WebHookEventSubscriptionDestinationProperties.azureActiveDirectoryTenantId,
  Azure.Core.uuid,
  "csharp"
);
@@clientName(WebHookEventSubscriptionDestinationProperties.endpointUrl,
  "Endpoint",
  "csharp"
);
@@alternateType(WebHookEventSubscriptionDestinationProperties.endpointUrl,
  url,
  "csharp"
);
@@clientName(WebHookEventSubscriptionDestinationProperties.endpointBaseUrl,
  "BaseEndpoint",
  "csharp"
);
@@alternateType(WebHookEventSubscriptionDestinationProperties.endpointBaseUrl,
  url,
  "csharp"
);
@@clientName(EventSubscriptionFullUrl.endpointUrl, "Endpoint", "csharp");
@@alternateType(EventSubscriptionFullUrl.endpointUrl, url, "csharp");
@@clientName(SubscriptionProperties.expirationTimeUtc, "ExpireOn", "csharp");
@@clientName(SubscriptionUpdateParametersProperties.expirationTimeUtc,
  "ExpireOn",
  "csharp"
);
@@clientName(TopicsOperationGroup.listEventTypes, "GetEventTypes", "csharp");

@@clientName(NamespaceRegenerateKeyRequest,
  "NamespaceRegenerateKeyContent",
  "csharp"
);

@@clientName(PartnerNamespaceRegenerateKeyRequest,
  "PartnerNamespaceRegenerateKeyContent",
  "csharp"
);

@@usage(TopicTypeAdditionalEnforcedPermission, Usage.input, "csharp");

// Additional resource/model renames for C# backward compatibility
@@clientName(ClientGroup, "EventGridNamespaceClientGroup", "csharp");
@@clientName(PermissionBinding, "EventGridNamespacePermissionBinding", "csharp");
@@clientName(TopicTypeInfo, "TopicType", "csharp");
@@clientName(Subscription, "NamespaceTopicEventSubscription", "csharp");
@@clientName(SubscriptionUpdateParameters,
  "NamespaceTopicEventSubscriptionPatch",
  "csharp"
);
@@clientName(SubscriptionFullUrl, "SubscriptionFullUri", "csharp");
@@clientName(SubscriptionFullUrl.endpointUrl, "EndpointUri", "csharp");
@@alternateType(SubscriptionFullUrl.endpointUrl, url, "csharp");

// Identity type mapping - map EventGrid's IdentityInfo to ARM ManagedServiceIdentity
@@alternateType(Domain.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(Topic.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(Namespace.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(PartnerTopic.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(SystemTopic.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(DomainUpdateParameters.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(TopicUpdateParameters.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(NamespaceUpdateParameters.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(PartnerTopicUpdateParameters.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(SystemTopicUpdateParameters.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);

// Property renames for C# backward compatibility
@@clientName(DomainProperties.inboundIpRules, "InboundIPRules", "csharp");
@@clientName(TopicProperties.inboundIpRules, "InboundIPRules", "csharp");
@@clientName(NamespaceProperties.inboundIpRules, "InboundIPRules", "csharp");
@@clientName(PartnerNamespaceProperties.inboundIpRules, "InboundIPRules", "csharp");
@@clientName(DomainUpdateParameterProperties.inboundIpRules, "InboundIPRules", "csharp");
@@clientName(TopicUpdateParameterProperties.inboundIpRules, "InboundIPRules", "csharp");
@@clientName(NamespaceUpdateParameterProperties.inboundIpRules,
  "InboundIPRules",
  "csharp"
);
@@clientName(PartnerNamespaceUpdateParameterProperties.inboundIpRules,
  "InboundIPRules",
  "csharp"
);
@@clientName(RoutingIdentityInfo.type, "IdentityType", "csharp");
@@clientName(CustomDomainIdentity.type, "IdentityType", "csharp");
@@clientName(EventSubscriptionIdentity.type, "IdentityType", "csharp");
@@clientName(ClientCertificateValidationScheme.IpMatchesAuthenticationName,
  "IPMatchesAuthenticationName",
  "csharp"
);
@@clientName(InboundIpRule.ipMask, "IPMask", "csharp");

// Url→Uri type mappings (generator auto-renames name but type stays string)
@@alternateType(CustomDomainConfiguration.certificateUrl, url, "csharp");
@@alternateType(EventTypeProperties.schemaUrl, url, "csharp");
@@alternateType(InlineEventProperties.dataSchemaUrl, url, "csharp");
@@alternateType(InlineEventProperties.documentationUrl, url, "csharp");
@@alternateType(PartnerDetails.setupUri, url, "csharp");

// PartnerRegistrationImmutableId: string(@format("uuid")) → Guid
@@alternateType(Partner.partnerRegistrationImmutableId, Azure.Core.uuid, "csharp");
@@alternateType(PartnerRegistrationProperties.partnerRegistrationImmutableId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(PartnerTopicProperties.partnerRegistrationImmutableId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(PartnerDestinationProperties.partnerRegistrationImmutableId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(VerifiedPartnerProperties.partnerRegistrationImmutableId,
  Azure.Core.uuid,
  "csharp"
);

// Usage for models that need public constructor/setters
@@usage(PartnerDetails, Usage.input, "csharp");
@@usage(EventType, Usage.input, "csharp");
@@usage(TopicTypeProperties, Usage.input, "csharp");
@@usage(VerifiedPartnerProperties, Usage.input, "csharp");
@@usage(ExtensionTopic, Usage.input, "csharp");
@@usage(DomainTopic, Usage.input, "csharp");
@@usage(PartnerConfiguration, Usage.input, "csharp");

// GetFullUrl → GetFullUri (preserve old C# method name)
@@clientName(EventSubscriptions.getFullUrl, "GetFullUri", "csharp");
@@clientName(TopicEventSubscriptions.getFullUrl, "GetFullUri", "csharp");
@@clientName(DomainEventSubscriptions.getFullUrl, "GetFullUri", "csharp");
@@clientName(EventSubscriptionOperationGroup.getFullUrl, "GetFullUri", "csharp");
@@clientName(SystemTopicEventSubscriptions.getFullUrl, "GetFullUri", "csharp");
@@clientName(PartnerTopicEventSubscriptions.getFullUrl, "GetFullUri", "csharp");
@@clientName(Subscriptions.getFullUrl, "GetFullUri", "csharp");
@@clientName(Channels.getFullUrl, "GetFullUri", "csharp");
