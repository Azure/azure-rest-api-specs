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

// csharp configuration
@@clientName(Channel, "PartnerNamespaceChannel", "csharp");
@@clientName(ChannelProperties.expirationTimeIfNotActivatedUtc,
  "ExpireOnIfNotActivated",
  "csharp"
);
@@clientName(ChannelUpdateParametersProperties.expirationTimeIfNotActivatedUtc,
  "ExpireOnIfNotActivated",
  "csharp"
);
@@clientName(ChannelType, "PartnerNamespaceChannelType", "csharp");
@@clientName(ChannelProvisioningState,
  "PartnerNamespaceChannelProvisioningState",
  "csharp"
);
@@clientName(ReadinessState, "PartnerTopicReadinessState", "csharp");
@@clientName(Domain, "EventGridDomain", "csharp");
@@clientName(DomainProperties.disableLocalAuth,
  "IsLocalAuthDisabled",
  "csharp"
);
@@clientName(DomainProperties.endpoint, "Endpoint", "csharp");
@@alternateType(DomainProperties.endpoint, url, "csharp");
@@clientName(DomainUpdateParameterProperties.disableLocalAuth,
  "IsLocalAuthDisabled",
  "csharp"
);
@@clientName(EventSubscription, "EventGridSubscription", "csharp");
@@clientName(EventSubscriptionUpdateParameters,
  "EventGridSubscriptionPatch",
  "csharp"
);
@@clientName(EventSubscriptionUpdateParameters.expirationTimeUtc,
  "ExpireOn",
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
@@clientName(EventSubscriptionProperties.expirationTimeUtc,
  "ExpireOn",
  "csharp"
);
@@clientName(RetryPolicy, "EventSubscriptionRetryPolicy", "csharp");
@@clientName(InboundIpRule, "EventGridInboundIPRule", "csharp");
@@clientName(IpActionType, "EventGridIPActionType", "csharp");
@@clientName(InputSchema, "EventGridInputSchema", "csharp");
@@clientName(InputSchemaMapping, "EventGridInputSchemaMapping", "csharp");
@@clientName(JsonInputSchemaMapping,
  "EventGridJsonInputSchemaMapping",
  "csharp"
);
@@clientName(DomainProvisioningState,
  "EventGridDomainProvisioningState",
  "csharp"
);
@@clientName(PublicNetworkAccess, "EventGridPublicNetworkAccess", "csharp");
@@clientName(DomainSharedAccessKeys,
  "EventGridDomainSharedAccessKeys",
  "csharp"
);
@@clientName(ResourceProvisioningState,
  "EventGridResourceProvisioningState",
  "csharp"
);
@@clientName(Partner, "EventGridPartnerContent", "csharp");
@@clientName(Partner.authorizationExpirationTimeInUtc,
  "AuthorizationExpireOn",
  "csharp"
);
@@clientName(PartnerNamespaceProperties.disableLocalAuth,
  "IsLocalAuthDisabled",
  "csharp"
);
@@clientName(PartnerNamespaceProperties.endpoint, "Endpoint", "csharp");
@@alternateType(PartnerNamespaceProperties.endpoint, url, "csharp");
@@alternateType(PartnerNamespaceProperties.partnerRegistrationFullyQualifiedId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(PartnerTopicProperties.expirationTimeIfNotActivatedUtc,
  "ExpireOnIfNotActivated",
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
@@clientName(Topic, "EventGridTopic", "csharp");
@@clientName(TopicRegenerateKeyRequest, "TopicRegenerateKeyContent", "csharp");
@@clientName(Client, "EventGridNamespaceClient", "csharp");
@@clientName(Namespace, "EventGridNamespace", "csharp");
@@clientName(ClientProvisioningState,
  "EventGridNamespaceClientProvisioningState",
  "csharp"
);
@@clientName(ClientState, "EventGridNamespaceClientState", "csharp");
@@clientName(Filter, "EventGridFilter", "csharp");
@@clientName(TopicProperties.disableLocalAuth, "IsLocalAuthDisabled", "csharp");
@@clientName(TopicProperties.endpoint, "Endpoint", "csharp");
@@alternateType(TopicProperties.endpoint, url, "csharp");
@@clientName(TopicUpdateParameterProperties.disableLocalAuth,
  "IsLocalAuthDisabled",
  "csharp"
);
@@clientName(TopicProvisioningState,
  "EventGridTopicProvisioningState",
  "csharp"
);
@@clientName(ResourceRegionType, "EventGridResourceRegionType", "csharp");
@@clientName(EventTypeInfo, "PartnerTopicEventTypeInfo", "csharp");
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
