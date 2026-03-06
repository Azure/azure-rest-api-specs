import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.Foundations;

namespace Microsoft.EventGrid;

/**
 * ARM proxy resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource
@summary("Resource")
model ProxyResource {
  /** Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName} */
  id?: armResourceIdentifier;

  /** The name of the resource */
  name?: string;

  /** The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts" */
  type?: armResourceType;

  /** Azure Resource Manager metadata containing createdBy and modifiedBy information. */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Result of the List Channels operation
 */
model ChannelsListResult is ResourceListResult<Channel>;
/**
 * Result of the List Operations operation
 */
model OperationsListResult is ResourceListResult<Operation>;

/**
 * Result of the List Topic Types operation
 */
model VerifiedPartnersListResult is ResourceListResult<VerifiedPartner>;

/**
 * Result of the List Domains operation.
 */
model DomainsListResult is ResourceListResult<Domain>;

/**
 * Result of the List EventSubscriptions operation
 */
model EventSubscriptionsListResult is ResourceListResult<EventSubscription>;

/**
 * Result of the List Namespaces operation.
 */
model NamespacesListResult is ResourceListResult<Namespace>;

/**
 * Result of the List Partner Destinations operation.
 */
model PartnerDestinationsListResult is ResourceListResult<PartnerDestination>;

/**
 * Result of the List Partner Namespaces operation
 */
model PartnerNamespacesListResult is ResourceListResult<PartnerNamespace>;
/**
 * Result of the List Partner Registrations operation.
 */
model PartnerRegistrationsListResult is ResourceListResult<PartnerRegistration>;

/**
 * Result of the List System topics operation.
 */
model SystemTopicsListResult is ResourceListResult<SystemTopic>;
/**
 * Result of the List Partner Topics operation.
 */
model PartnerTopicsListResult is ResourceListResult<PartnerTopic>;

/**
 * Result of the List Topics operation
 */
model TopicsListResult is ResourceListResult<Topic>;
/**
 * Result of the List partner configurations operation
 */
model PartnerConfigurationsListResult
  is ResourceListResult<PartnerConfiguration>;

/**
 * Result of the list of all private endpoint connections operation.
 */
model PrivateEndpointConnectionListResult
  is ResourceListResult<PrivateEndpointConnection>;

/**
 * Result of the List private link resources operation.
 */
model PrivateLinkResourcesListResult is ResourceListResult<PrivateLinkResource>;

/**
 * Result of the List Domain Topics operation.
 */
model DomainTopicsListResult is ResourceListResult<DomainTopic>;

/**
 * Result of the List CA Certificate operation.
 */
model CaCertificatesListResult is ResourceListResult<CaCertificate>;

/**
 * Result of the List Client Group operation.
 */
model ClientGroupsListResult is ResourceListResult<ClientGroup>;

/**
 * Result of the List Client operation.
 */
model ClientsListResult is ResourceListResult<Client>;

/**
 * Result of the List Permission Binding operation.
 */
model PermissionBindingsListResult is ResourceListResult<PermissionBinding>;

/**
 * Result of the List Topic Space operation.
 */
model TopicSpacesListResult is ResourceListResult<TopicSpace>;

/**
 * Result of the List namespace topics operation.
 */
model NamespaceTopicsListResult is ResourceListResult<NamespaceTopic>;

/**
 * Result of the List event subscriptions operation.
 */
model SubscriptionsListResult is ResourceListResult<Subscription>;

/**
 * Provisioning state of the CA Certificate resource.
 */
union CaCertificateProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Deleted
   */
  Deleted: "Deleted",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * The type of the event channel which represents the direction flow of events.
 */
union ChannelType {
  string,

  /**
   * PartnerTopic
   */
  PartnerTopic: "PartnerTopic",

  /**
   * PartnerDestination
   */
  PartnerDestination: "PartnerDestination",
}

/**
 * The kind of event type used.
 */
union EventDefinitionKind {
  string,

  /**
   * Inline
   */
  Inline: "Inline",
}

/**
 * Type of the endpoint for the partner destination
 */
union PartnerEndpointType {
  string,

  /**
   * WebHook
   */
  WebHook: "WebHook",
}

/**
 * Provisioning state of the channel.
 */
union ChannelProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * IdleDueToMirroredPartnerTopicDeletion
   */
  IdleDueToMirroredPartnerTopicDeletion: "IdleDueToMirroredPartnerTopicDeletion",

  /**
   * IdleDueToMirroredPartnerDestinationDeletion
   */
  IdleDueToMirroredPartnerDestinationDeletion: "IdleDueToMirroredPartnerDestinationDeletion",
}

/**
 * The readiness state of the corresponding partner topic.
 */
union ReadinessState {
  string,

  /**
   * NeverActivated
   */
  NeverActivated: "NeverActivated",

  /**
   * Activated
   */
  Activated: "Activated",
}

/**
 * Provisioning state of the ClientGroup resource.
 */
union ClientGroupProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Deleted
   */
  Deleted: "Deleted",
}

/**
 * The validation scheme used to authenticate the client. Default value is SubjectMatchesAuthenticationName.
 */
union ClientCertificateValidationScheme {
  string,

  /**
   * SubjectMatchesAuthenticationName
   */
  SubjectMatchesAuthenticationName: "SubjectMatchesAuthenticationName",

  /**
   * DnsMatchesAuthenticationName
   */
  DnsMatchesAuthenticationName: "DnsMatchesAuthenticationName",

  /**
   * UriMatchesAuthenticationName
   */
  UriMatchesAuthenticationName: "UriMatchesAuthenticationName",

  /**
   * IpMatchesAuthenticationName
   */
  IpMatchesAuthenticationName: "IpMatchesAuthenticationName",

  /**
   * EmailMatchesAuthenticationName
   */
  EmailMatchesAuthenticationName: "EmailMatchesAuthenticationName",

  /**
   * ThumbprintMatch
   */
  ThumbprintMatch: "ThumbprintMatch",
}

/**
 * Indicates if the client is enabled or not. Default value is Enabled.
 */
union ClientState {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Provisioning state of the Client resource.
 */
union ClientProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Deleted
   */
  Deleted: "Deleted",
}

/**
 * Status of the connection.
 */
union PersistedConnectionStatus {
  string,

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Approved
   */
  Approved: "Approved",

  /**
   * Rejected
   */
  Rejected: "Rejected",

  /**
   * Disconnected
   */
  Disconnected: "Disconnected",
}

/**
 * Provisioning state of the Private Endpoint Connection.
 */
union ResourceProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Provisioning state of the Event Grid Domain Resource.
 */
union DomainProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Minimum TLS version of the publisher allowed to publish to this domain
 */
union TlsVersion {
  string,

  /**
   * 1.0
   */
  `1.0`: "1.0",

  /**
   * 1.1
   */
  `1.1`: "1.1",

  /**
   * 1.2
   */
  `1.2`: "1.2",
}

/**
 * This determines the format that Event Grid should expect for incoming events published to the Event Grid Domain Resource.
 */
union InputSchema {
  string,

  /**
   * EventGridSchema
   */
  EventGridSchema: "EventGridSchema",

  /**
   * CustomEventSchema
   */
  CustomEventSchema: "CustomEventSchema",

  /**
   * CloudEventSchemaV1_0
   */
  CloudEventSchemaV1_0: "CloudEventSchemaV1_0",
}

/**
 * Type of the custom mapping
 */
union InputSchemaMappingType {
  string,

  /**
   * Json
   */
  Json: "Json",
}

/**
 * This determines if traffic is allowed over public network. By default it is enabled.
 * You can further restrict to specific IPs by configuring <seealso cref="P:Microsoft.Azure.Events.ResourceProvider.Common.Contracts.DomainProperties.InboundIpRules" />
 */
union PublicNetworkAccess {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * SecuredByPerimeter
   */
  SecuredByPerimeter: "SecuredByPerimeter",
}

/**
 * Action to perform based on the match or no match of the IpMask.
 */
union IpActionType {
  string,

  /**
   * Allow
   */
  Allow: "Allow",
}

/**
 * Data Residency Boundary of the resource.
 */
union DataResidencyBoundary {
  string,

  /**
   * WithinGeopair
   */
  WithinGeopair: "WithinGeopair",

  /**
   * WithinRegion
   */
  WithinRegion: "WithinRegion",
}

/**
 * The Sku name of the resource. The possible values are: Basic or Premium.
 */
union Sku {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * Premium
   */
  Premium: "Premium",
}

/**
 * The type of managed identity used. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user-assigned identities. The type 'None' will remove any identity.
 */
union IdentityType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * SystemAssigned
   */
  SystemAssigned: "SystemAssigned",

  /**
   * UserAssigned
   */
  UserAssigned: "UserAssigned",

  /**
   * SystemAssigned, UserAssigned
   */
  `SystemAssigned, UserAssigned`: "SystemAssigned, UserAssigned",
}

/**
 * Provisioning state of the domain topic.
 */
union DomainTopicProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Type of the delivery attribute or header name.
 */
union DeliveryAttributeMappingType {
  string,

  /**
   * Static
   */
  Static: "Static",

  /**
   * Dynamic
   */
  Dynamic: "Dynamic",
}

/**
 * Provisioning state of the event subscription.
 */
union SubscriptionProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * AwaitingManualAction
   */
  AwaitingManualAction: "AwaitingManualAction",

  /**
   * Deleted
   */
  Deleted: "Deleted",

  /**
   * DeleteFailed
   */
  DeleteFailed: "DeleteFailed",

  /**
   * CreateFailed
   */
  CreateFailed: "CreateFailed",

  /**
   * UpdatedFailed
   */
  UpdatedFailed: "UpdatedFailed",
}

/**
 * Delivery mode of the event subscription.
 */
union DeliveryMode {
  string,

  /**
   * Queue
   */
  Queue: "Queue",

  /**
   * Push
   */
  Push: "Push",
}

/**
 * The type of managed identity used. Can be either 'SystemAssigned' or 'UserAssigned'.
 */
union EventSubscriptionIdentityType {
  string,

  /**
   * SystemAssigned
   */
  SystemAssigned: "SystemAssigned",

  /**
   * UserAssigned
   */
  UserAssigned: "UserAssigned",
}

/**
 * Type of the endpoint for the dead letter destination
 */
union DeadLetterEndPointType {
  string,

  /**
   * StorageBlob
   */
  StorageBlob: "StorageBlob",
}

/**
 * Type of the endpoint for the event subscription destination.
 */
union EndpointType {
  string,

  /**
   * WebHook
   */
  WebHook: "WebHook",

  /**
   * EventHub
   */
  EventHub: "EventHub",

  /**
   * StorageQueue
   */
  StorageQueue: "StorageQueue",

  /**
   * HybridConnection
   */
  HybridConnection: "HybridConnection",

  /**
   * ServiceBusQueue
   */
  ServiceBusQueue: "ServiceBusQueue",

  /**
   * ServiceBusTopic
   */
  ServiceBusTopic: "ServiceBusTopic",

  /**
   * AzureFunction
   */
  AzureFunction: "AzureFunction",

  /**
   * PartnerDestination
   */
  PartnerDestination: "PartnerDestination",

  /**
   * MonitorAlert
   */
  MonitorAlert: "MonitorAlert",

  /**
   * NamespaceTopic
   */
  NamespaceTopic: "NamespaceTopic",
}

/**
 * The event delivery schema for the event subscription.
 */
union DeliverySchema {
  string,

  /**
   * CloudEventSchemaV1_0
   */
  CloudEventSchemaV1_0: "CloudEventSchemaV1_0",
}

/**
 * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
 */
union FilterOperatorType {
  string,

  /**
   * NumberIn
   */
  NumberIn: "NumberIn",

  /**
   * NumberNotIn
   */
  NumberNotIn: "NumberNotIn",

  /**
   * NumberLessThan
   */
  NumberLessThan: "NumberLessThan",

  /**
   * NumberGreaterThan
   */
  NumberGreaterThan: "NumberGreaterThan",

  /**
   * NumberLessThanOrEquals
   */
  NumberLessThanOrEquals: "NumberLessThanOrEquals",

  /**
   * NumberGreaterThanOrEquals
   */
  NumberGreaterThanOrEquals: "NumberGreaterThanOrEquals",

  /**
   * BoolEquals
   */
  BoolEquals: "BoolEquals",

  /**
   * StringIn
   */
  StringIn: "StringIn",

  /**
   * StringNotIn
   */
  StringNotIn: "StringNotIn",

  /**
   * StringBeginsWith
   */
  StringBeginsWith: "StringBeginsWith",

  /**
   * StringEndsWith
   */
  StringEndsWith: "StringEndsWith",

  /**
   * StringContains
   */
  StringContains: "StringContains",

  /**
   * NumberInRange
   */
  NumberInRange: "NumberInRange",

  /**
   * NumberNotInRange
   */
  NumberNotInRange: "NumberNotInRange",

  /**
   * StringNotBeginsWith
   */
  StringNotBeginsWith: "StringNotBeginsWith",

  /**
   * StringNotEndsWith
   */
  StringNotEndsWith: "StringNotEndsWith",

  /**
   * StringNotContains
   */
  StringNotContains: "StringNotContains",

  /**
   * IsNullOrUndefined
   */
  IsNullOrUndefined: "IsNullOrUndefined",

  /**
   * IsNotNull
   */
  IsNotNull: "IsNotNull",
}

/**
 * Provisioning state of the event subscription.
 */
union EventSubscriptionProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * AwaitingManualAction
   */
  AwaitingManualAction: "AwaitingManualAction",
}

/**
 * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
 */
union AdvancedFilterOperatorType {
  string,

  /**
   * NumberIn
   */
  NumberIn: "NumberIn",

  /**
   * NumberNotIn
   */
  NumberNotIn: "NumberNotIn",

  /**
   * NumberLessThan
   */
  NumberLessThan: "NumberLessThan",

  /**
   * NumberGreaterThan
   */
  NumberGreaterThan: "NumberGreaterThan",

  /**
   * NumberLessThanOrEquals
   */
  NumberLessThanOrEquals: "NumberLessThanOrEquals",

  /**
   * NumberGreaterThanOrEquals
   */
  NumberGreaterThanOrEquals: "NumberGreaterThanOrEquals",

  /**
   * BoolEquals
   */
  BoolEquals: "BoolEquals",

  /**
   * StringIn
   */
  StringIn: "StringIn",

  /**
   * StringNotIn
   */
  StringNotIn: "StringNotIn",

  /**
   * StringBeginsWith
   */
  StringBeginsWith: "StringBeginsWith",

  /**
   * StringEndsWith
   */
  StringEndsWith: "StringEndsWith",

  /**
   * StringContains
   */
  StringContains: "StringContains",

  /**
   * NumberInRange
   */
  NumberInRange: "NumberInRange",

  /**
   * NumberNotInRange
   */
  NumberNotInRange: "NumberNotInRange",

  /**
   * StringNotBeginsWith
   */
  StringNotBeginsWith: "StringNotBeginsWith",

  /**
   * StringNotEndsWith
   */
  StringNotEndsWith: "StringNotEndsWith",

  /**
   * StringNotContains
   */
  StringNotContains: "StringNotContains",

  /**
   * IsNullOrUndefined
   */
  IsNullOrUndefined: "IsNullOrUndefined",

  /**
   * IsNotNull
   */
  IsNotNull: "IsNotNull",
}

/**
 * The event delivery schema for the event subscription.
 */
union EventDeliverySchema {
  string,

  /**
   * EventGridSchema
   */
  EventGridSchema: "EventGridSchema",

  /**
   * CustomInputSchema
   */
  CustomInputSchema: "CustomInputSchema",

  /**
   * CloudEventSchemaV1_0
   */
  CloudEventSchemaV1_0: "CloudEventSchemaV1_0",
}

/**
 * Provisioning state of the namespace resource.
 */
union NamespaceProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Deleted
   */
  Deleted: "Deleted",

  /**
   * DeleteFailed
   */
  DeleteFailed: "DeleteFailed",

  /**
   * CreateFailed
   */
  CreateFailed: "CreateFailed",

  /**
   * UpdatedFailed
   */
  UpdatedFailed: "UpdatedFailed",
}

/**
 * Validation state for the custom domain. This is a read only property and is initially set to 'Pending' and will be updated to 'Approved' by Event Grid only after ownership of the domain name has been successfully validated.
 */
union CustomDomainValidationState {
  string,

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Approved
   */
  Approved: "Approved",

  /**
   * ErrorRetrievingDnsRecord
   */
  ErrorRetrievingDnsRecord: "ErrorRetrievingDnsRecord",
}

/**
 * The type of managed identity used. Can be either 'SystemAssigned' or 'UserAssigned'.
 */
union CustomDomainIdentityType {
  string,

  /**
   * SystemAssigned
   */
  SystemAssigned: "SystemAssigned",

  /**
   * UserAssigned
   */
  UserAssigned: "UserAssigned",
}

/**
 * Indicate if Topic Spaces Configuration is enabled for the namespace. Default is Disabled.
 */
union TopicSpacesConfigurationState {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * Static routing enrichment value type. For e.g. this property value can be 'String'.
 */
union StaticRoutingEnrichmentType {
  string,

  /**
   * String
   */
  String: "String",
}

/**
 * Alternative authentication name sources related to client authentication settings for namespace resource.
 */
union AlternativeAuthenticationNameSource {
  string,

  /**
   * ClientCertificateSubject
   */
  ClientCertificateSubject: "ClientCertificateSubject",

  /**
   * ClientCertificateDns
   */
  ClientCertificateDns: "ClientCertificateDns",

  /**
   * ClientCertificateUri
   */
  ClientCertificateUri: "ClientCertificateUri",

  /**
   * ClientCertificateIp
   */
  ClientCertificateIp: "ClientCertificateIp",

  /**
   * ClientCertificateEmail
   */
  ClientCertificateEmail: "ClientCertificateEmail",
}

/**
 * The type of managed identity used. Can be either 'SystemAssigned' or 'UserAssigned'.
 */
union CustomJwtAuthenticationManagedIdentityType {
  string,

  /**
   * SystemAssigned
   */
  SystemAssigned: "SystemAssigned",

  /**
   * UserAssigned
   */
  UserAssigned: "UserAssigned",
}

/**
 * The type of managed identity used. Can be either 'SystemAssigned' or 'UserAssigned'.
 */
union CustomWebhookAuthenticationManagedIdentityType {
  string,

  /**
   * SystemAssigned
   */
  SystemAssigned: "SystemAssigned",

  /**
   * UserAssigned
   */
  UserAssigned: "UserAssigned",
}

/**
 * Routing identity type for topic spaces configuration.
 */
union RoutingIdentityType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * SystemAssigned
   */
  SystemAssigned: "SystemAssigned",

  /**
   * UserAssigned
   */
  UserAssigned: "UserAssigned",
}

/**
 * The name of the SKU.
 */
union SkuName {
  string,

  /**
   * Standard
   */
  Standard: "Standard",
}

/**
 * Provisioning state of the namespace topic.
 */
union NamespaceTopicProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Deleted
   */
  Deleted: "Deleted",

  /**
   * DeleteFailed
   */
  DeleteFailed: "DeleteFailed",

  /**
   * CreateFailed
   */
  CreateFailed: "CreateFailed",

  /**
   * UpdatedFailed
   */
  UpdatedFailed: "UpdatedFailed",
}

/**
 * Publisher type of the namespace topic.
 */
union PublisherType {
  string,

  /**
   * Custom
   */
  Custom: "Custom",
}

/**
 * This determines the format that is expected for incoming events published to the topic.
 */
union EventInputSchema {
  string,

  /**
   * CloudEventSchemaV1_0
   */
  CloudEventSchemaV1_0: "CloudEventSchemaV1_0",
}

/**
 * Provisioning state of the partner configuration.
 */
union PartnerConfigurationProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Provisioning state of the partner destination.
 */
union PartnerDestinationProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * IdleDueToMirroredChannelResourceDeletion
   */
  IdleDueToMirroredChannelResourceDeletion: "IdleDueToMirroredChannelResourceDeletion",
}

/**
 * Activation state of the partner destination.
 */
union PartnerDestinationActivationState {
  string,

  /**
   * NeverActivated
   */
  NeverActivated: "NeverActivated",

  /**
   * Activated
   */
  Activated: "Activated",
}

/**
 * Provisioning state of the partner namespace.
 */
union PartnerNamespaceProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * This determines if events published to this partner namespace should use the source attribute in the event payload
 * or use the channel name in the header when matching to the partner topic. If none is specified, source attribute routing will be used to match the partner topic.
 */
union PartnerTopicRoutingMode {
  string,

  /**
   * SourceEventAttribute
   */
  SourceEventAttribute: "SourceEventAttribute",

  /**
   * ChannelNameHeader
   */
  ChannelNameHeader: "ChannelNameHeader",
}

/**
 * Provisioning state of the partner registration.
 */
union PartnerRegistrationProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Provisioning state of the partner topic.
 */
union PartnerTopicProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * IdleDueToMirroredChannelResourceDeletion
   */
  IdleDueToMirroredChannelResourceDeletion: "IdleDueToMirroredChannelResourceDeletion",
}

/**
 * Activation state of the partner topic.
 */
union PartnerTopicActivationState {
  string,

  /**
   * NeverActivated
   */
  NeverActivated: "NeverActivated",

  /**
   * Activated
   */
  Activated: "Activated",

  /**
   * Deactivated
   */
  Deactivated: "Deactivated",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union NetworkSecurityPerimeterResourceType {
  string,

  /**
   * topics
   */
  topics: "topics",

  /**
   * domains
   */
  domains: "domains",
}

/**
 * Provisioning state to reflect configuration state and indicate status of nsp profile configuration retrieval.
 */
union NetworkSecurityPerimeterConfigProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Deleted
   */
  Deleted: "Deleted",

  /**
   * Accepted
   */
  Accepted: "Accepted",
}

/**
 * Provisioning issue type.
 */
union NetworkSecurityPerimeterConfigurationIssueType {
  string,

  /**
   * MissingPerimeterConfiguration
   */
  MissingPerimeterConfiguration: "MissingPerimeterConfiguration",

  /**
   * MissingIdentityConfiguration
   */
  MissingIdentityConfiguration: "MissingIdentityConfiguration",

  /**
   * ConfigurationPropagationFailure
   */
  ConfigurationPropagationFailure: "ConfigurationPropagationFailure",

  /**
   * Other
   */
  Other: "Other",
}

/**
 * Provisioning issue severity.
 */
union NetworkSecurityPerimeterConfigurationIssueSeverity {
  string,

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Error
   */
  Error: "Error",
}

/**
 * Network security perimeter access mode.
 */
union NetworkSecurityPerimeterAssociationAccessMode {
  string,

  /**
   * Learning
   */
  Learning: "Learning",

  /**
   * Enforced
   */
  Enforced: "Enforced",

  /**
   * Audit
   */
  Audit: "Audit",
}

/**
 * NSP access rule direction.
 */
union NetworkSecurityPerimeterProfileAccessRuleDirection {
  string,

  /**
   * Inbound
   */
  Inbound: "Inbound",

  /**
   * Outbound
   */
  Outbound: "Outbound",
}

/**
 * The allowed permission.
 */
union PermissionType {
  string,

  /**
   * Publisher
   */
  Publisher: "Publisher",

  /**
   * Subscriber
   */
  Subscriber: "Subscriber",
}

/**
 * Provisioning state of the PermissionBinding resource.
 */
union PermissionBindingProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Deleted
   */
  Deleted: "Deleted",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union PrivateEndpointConnectionsParentType {
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

  /**
   * namespaces
   */
  namespaces: "namespaces",
}

/**
 * The type of managed identity used. Only UserAssigned or SystemAssigned Identity are supported.
 */
union KeyEncryptionIdentityType {
  string,

  /**
   * SystemAssigned
   */
  SystemAssigned: "SystemAssigned",

  /**
   * UserAssigned
   */
  UserAssigned: "UserAssigned",
}

/**
 * The state of the Customer Managed Key (CMK) encryption. This is a read-only property which determines if the associated key is active and valid and used
 * actively by runtime as expected. When the associated CMK becomes invalid (e.g., if it is deleted, or if versioned CMK is not current anymore), Event Grid
 * Service will set this state to disabled to indicate that this key is not valid anymore and requires action from user.
 */
union KeyEncryptionKeyStatus {
  string,

  /**
   * Active
   */
  Active: "Active",

  /**
   * Revoked
   */
  Revoked: "Revoked",
}

/**
 * This property specifies the mode of the Azure Confidential Compute configuration.
 * Possible values are 'Disabled' or 'Enabled'.
 * This is an immutable property set at the time of resource creation and cannot be modified later.
 * Enabling this property ensures that messages are processed and stored in a Azure Confidential Compute environment.
 */
union ConfidentialComputeMode {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * Provisioning state of the topic.
 */
union TopicProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Kind of the resource.
 */
union ResourceKind {
  string,

  /**
   * Azure
   */
  Azure: "Azure",

  /**
   * AzureArc
   */
  AzureArc: "AzureArc",
}

/**
 * Provisioning state of the TopicSpace resource.
 */
union TopicSpaceProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Deleted
   */
  Deleted: "Deleted",
}

/**
 * Region type of the resource.
 */
union ResourceRegionType {
  string,

  /**
   * RegionalResource
   */
  RegionalResource: "RegionalResource",

  /**
   * GlobalResource
   */
  GlobalResource: "GlobalResource",
}

/**
 * Provisioning state of the topic type.
 */
union TopicTypeProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union TopicTypeSourceScope {
  string,

  /**
   * Resource
   */
  Resource: "Resource",

  /**
   * ResourceGroup
   */
  ResourceGroup: "ResourceGroup",

  /**
   * AzureSubscription
   */
  AzureSubscription: "AzureSubscription",

  /**
   * ManagementGroup
   */
  ManagementGroup: "ManagementGroup",
}

/**
 * Provisioning state of the verified partner.
 */
union VerifiedPartnerProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Type of client authentication
 */
union PartnerClientAuthenticationType {
  string,

  /**
   * AzureAD
   */
  AzureAD: "AzureAD",
}

/**
 * The severity that will be attached to every Alert fired through this event subscription.
 * This field must be provided.
 */
union MonitorAlertSeverity {
  string,

  /**
   * Sev0
   */
  Sev0: "Sev0",

  /**
   * Sev1
   */
  Sev1: "Sev1",

  /**
   * Sev2
   */
  Sev2: "Sev2",

  /**
   * Sev3
   */
  Sev3: "Sev3",

  /**
   * Sev4
   */
  Sev4: "Sev4",
}

/**
 * The properties of CA certificate.
 */
model CaCertificateProperties {
  /**
   * Description for the CA Certificate resource.
   */
  description?: string;

  /**
   * Base64 encoded PEM (Privacy Enhanced Mail) format certificate data.
   */
  encodedCertificate?: string;

  /**
   * Certificate issue time in UTC. This is a read-only field.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  issueTimeInUtc?: utcDateTime;

  /**
   * Certificate expiry time in UTC. This is a read-only field.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTimeInUtc?: utcDateTime;

  /**
   * Provisioning state of the CA Certificate resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: CaCertificateProvisioningState;
}

/**
 * Definition of a Resource.
 */
model Resource {
  /**
   * Fully qualified identifier of the resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Properties of the Channel.
 */
model ChannelProperties {
  /**
   * The type of the event channel which represents the direction flow of events.
   */
  channelType?: ChannelType;

  /**
   * This property should be populated when channelType is PartnerTopic and represents information about the partner topic resource corresponding to the channel.
   */
  partnerTopicInfo?: PartnerTopicInfo;

  /**
   * This property should be populated when channelType is PartnerDestination and represents information about the partner destination resource corresponding to the channel.
   */
  partnerDestinationInfo?: PartnerDestinationInfo;

  /**
   * Context or helpful message that can be used during the approval process by the subscriber.
   */
  messageForActivation?: string;

  /**
   * Provisioning state of the channel.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: ChannelProvisioningState;

  /**
   * The readiness state of the corresponding partner topic.
   */
  readinessState?: ReadinessState;

  /**
   * Expiration time of the channel. If this timer expires while the corresponding partner topic is never activated,
   * the channel and corresponding partner topic are deleted.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeIfNotActivatedUtc?: utcDateTime;
}

/**
 * Properties of the corresponding partner topic of a Channel.
 */
model PartnerTopicInfo {
  /**
   * Azure subscription ID of the subscriber. The partner topic associated with the channel will be
   * created under this Azure subscription.
   */
  azureSubscriptionId?: string;

  /**
   * Azure Resource Group of the subscriber. The partner topic associated with the channel will be
   * created under this resource group.
   */
  resourceGroupName?: string;

  /**
   * Name of the partner topic associated with the channel.
   */
  name?: string;

  /**
   * Event Type Information for the partner topic. This information is provided by the publisher and can be used by the
   * subscriber to view different types of events that are published.
   */
  eventTypeInfo?: EventTypeInfo;

  /**
   * The source information is provided by the publisher to determine the scope or context from which the events
   * are originating. This information can be used by the subscriber during the approval process of the
   * created partner topic.
   */
  source?: string;
}

/**
 * The event type information for Channels.
 */
model EventTypeInfo {
  /**
   * The kind of event type used.
   */
  kind?: EventDefinitionKind;

  /**
   * A collection of inline event types for the resource. The inline event type keys are of type string which represents the name of the event.
   * An example of a valid inline event name is "Contoso.OrderCreated".
   * The inline event type values are of type InlineEventProperties and will contain additional information for every inline event type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  inlineEventTypes?: Record<InlineEventProperties>;
}

/**
 * Additional information about every inline event.
 */
model InlineEventProperties {
  /**
   * The description for the inline event.
   */
  description?: string;

  /**
   * The displayName for the inline event.
   */
  displayName?: string;

  /**
   * The documentationUrl for the inline event.
   */
  documentationUrl?: string;

  /**
   * The dataSchemaUrl for the inline event.
   */
  dataSchemaUrl?: string;
}

/**
 * Properties of the corresponding partner destination of a Channel.
 */
@discriminator("endpointType")
model PartnerDestinationInfo {
  /**
   * Azure subscription ID of the subscriber. The partner destination associated with the channel will be
   * created under this Azure subscription.
   */
  azureSubscriptionId?: string;

  /**
   * Azure Resource Group of the subscriber. The partner destination associated with the channel will be
   * created under this resource group.
   */
  resourceGroupName?: string;

  /**
   * Name of the partner destination associated with the channel.
   */
  name?: string;

  /**
   * Type of the endpoint for the partner destination
   */
  endpointType: PartnerEndpointType = PartnerEndpointType.WebHook;

  /**
   * Additional context of the partner destination endpoint.
   */
  endpointServiceContext?: string;

  /**
   * Change history of the resource move.
   */
  @identifiers(#[])
  resourceMoveChangeHistory?: ResourceMoveChangeHistory[];
}

/**
 * The change history of the resource move.
 */
model ResourceMoveChangeHistory {
  /**
   * Azure subscription ID of the resource.
   */
  azureSubscriptionId?: string;

  /**
   * Azure Resource Group of the resource.
   */
  resourceGroupName?: string;

  /**
   * UTC timestamp of when the resource was changed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTimeUtc?: utcDateTime;
}

/**
 * Properties of the Channel update.
 */
model ChannelUpdateParameters {
  /**
   * Properties of the channel update parameters.
   */
  properties?: ChannelUpdateParametersProperties;
}

/**
 * Properties of the channel update parameters.
 */
model ChannelUpdateParametersProperties {
  /**
   * Expiration time of the channel. If this timer expires while the corresponding partner topic or partner destination is never activated,
   * the channel and corresponding partner topic or partner destination are deleted.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeIfNotActivatedUtc?: utcDateTime;

  /**
   * Partner destination properties which can be updated if the channel is of type PartnerDestination.
   */
  partnerDestinationInfo?: PartnerUpdateDestinationInfo;

  /**
   * Partner topic properties which can be updated if the channel is of type PartnerTopic.
   */
  partnerTopicInfo?: PartnerUpdateTopicInfo;
}

/**
 * Properties of the corresponding partner destination of a Channel.
 */
@discriminator("endpointType")
model PartnerUpdateDestinationInfo {
  /**
   * Type of the endpoint for the partner destination
   */
  endpointType: PartnerEndpointType = PartnerEndpointType.WebHook;
}

/**
 * Update properties for the corresponding partner topic of a channel.
 */
model PartnerUpdateTopicInfo {
  /**
   * Event type info for the partner topic
   */
  eventTypeInfo?: EventTypeInfo;
}

/**
 * Full endpoint URL of an event subscription
 */
model EventSubscriptionFullUrl {
  /**
   * The URL that represents the endpoint of the destination of an event subscription.
   */
  endpointUrl?: string;
}

/**
 * The properties of client group.
 */
model ClientGroupProperties {
  /**
   * Description for the Client Group resource.
   */
  description?: string;

  /**
   * The grouping query for the clients.
   * Example : attributes.keyName IN ['a', 'b', 'c'].
   */
  query?: string;

  /**
   * Provisioning state of the ClientGroup resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ClientGroupProvisioningState;
}

/**
 * The properties of client.
 */
model ClientProperties {
  /**
   * Description for the Client resource.
   */
  description?: string;

  /**
   * The name presented by the client for authentication. The default value is the name of the resource.
   */
  authenticationName?: string;

  /**
   * The client certificate authentication information.
   */
  clientCertificateAuthentication?: ClientCertificateAuthentication;

  /**
   * Indicates if the client is enabled or not. Default value is Enabled.
   */
  state?: ClientState = ClientState.Enabled;

  /**
   * Attributes for the client. Supported values are int, bool, string, string[].
   * Example:
   * "attributes": { "room": "345", "floor": 12, "deviceTypes": ["Fan", "Light"] }
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  attributes?: Record<unknown>;

  /**
   * Provisioning state of the Client resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ClientProvisioningState;
}

/**
 * The certificate authentication properties for the client.
 */
model ClientCertificateAuthentication {
  /**
   * The validation scheme used to authenticate the client. Default value is SubjectMatchesAuthenticationName.
   */
  validationScheme?: ClientCertificateValidationScheme;

  /**
   * The list of thumbprints that are allowed during client authentication. This property is required only if the validationScheme is 'ThumbprintMatch'.
   */
  allowedThumbprints?: string[];
}

/**
 * Properties of the Event Grid Domain Resource.
 */
model DomainProperties {
  /**
   * List of private endpoint connections.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Provisioning state of the Event Grid Domain Resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DomainProvisioningState;

  /**
   * Minimum TLS version of the publisher allowed to publish to this domain
   */
  minimumTlsVersionAllowed?: TlsVersion;

  /**
   * Endpoint for the Event Grid Domain Resource which is used for publishing the events.
   */
  @visibility(Lifecycle.Read)
  endpoint?: string;

  /**
   * This determines the format that Event Grid should expect for incoming events published to the Event Grid Domain Resource.
   */
  inputSchema?: InputSchema = InputSchema.EventGridSchema;

  /**
   * Event Type Information for the domain. This information is provided by the publisher and can be used by the
   * subscriber to view different types of events that are published.
   */
  eventTypeInfo?: EventTypeInfo;

  /**
   * Information about the InputSchemaMapping which specified the info about mapping event payload.
   */
  inputSchemaMapping?: InputSchemaMapping;

  /**
   * Metric resource id for the Event Grid Domain Resource.
   */
  @visibility(Lifecycle.Read)
  metricResourceId?: string;

  /**
   * This determines if traffic is allowed over public network. By default it is enabled.
   * You can further restrict to specific IPs by configuring <seealso cref="P:Microsoft.Azure.Events.ResourceProvider.Common.Contracts.DomainProperties.InboundIpRules" />
   */
  publicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.Enabled;

  /**
   * This can be used to restrict traffic from specific IPs instead of all IPs. Note: These are considered only if PublicNetworkAccess is enabled.
   */
  @identifiers(#[])
  inboundIpRules?: InboundIpRule[];

  /**
   * This boolean is used to enable or disable local auth. Default value is false. When the property is set to true, only Microsoft Entra ID token will be used to authenticate if user is allowed to publish to the domain.
   */
  disableLocalAuth?: boolean = false;

  /**
   * This Boolean is used to specify the creation mechanism for 'all' the Event Grid Domain Topics associated with this Event Grid Domain resource.
   * In this context, creation of domain topic can be auto-managed (when true) or self-managed (when false). The default value for this property is true.
   * When this property is null or set to true, Event Grid is responsible of automatically creating the domain topic when the first event subscription is
   * created at the scope of the domain topic. If this property is set to false, then creating the first event subscription will require creating a domain topic
   * by the user. The self-management mode can be used if the user wants full control of when the domain topic is created, while auto-managed mode provides the
   * flexibility to perform less operations and manage fewer resources by the user. Also, note that in auto-managed creation mode, user is allowed to create the
   * domain topic on demand if needed.
   */
  autoCreateTopicWithFirstSubscription?: boolean = true;

  /**
   * This Boolean is used to specify the deletion mechanism for 'all' the Event Grid Domain Topics associated with this Event Grid Domain resource.
   * In this context, deletion of domain topic can be auto-managed (when true) or self-managed (when false). The default value for this property is true.
   * When this property is set to true, Event Grid is responsible of automatically deleting the domain topic when the last event subscription at the scope
   * of the domain topic is deleted. If this property is set to false, then the user needs to manually delete the domain topic when it is no longer needed
   * (e.g., when last event subscription is deleted and the resource needs to be cleaned up). The self-management mode can be used if the user wants full
   * control of when the domain topic needs to be deleted, while auto-managed mode provides the flexibility to perform less operations and manage fewer
   * resources by the user.
   */
  autoDeleteTopicWithLastSubscription?: boolean = true;

  /**
   * Data Residency Boundary of the resource.
   */
  dataResidencyBoundary?: DataResidencyBoundary;
}

/**
 * Properties of the private endpoint connection resource.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The Private Endpoint resource for this Connection.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * GroupIds from the private link service resource.
   */
  groupIds?: string[];

  /**
   * Details about the state of the connection.
   */
  privateLinkServiceConnectionState?: ConnectionState;

  /**
   * Provisioning state of the Private Endpoint Connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: ResourceProvisioningState;
}

/**
 * PrivateEndpoint information.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for Private Endpoint.
   */
  id?: string;
}

/**
 * ConnectionState information.
 */
model ConnectionState {
  /**
   * Status of the connection.
   */
  status?: PersistedConnectionStatus;

  /**
   * Description of the connection state.
   */
  description?: string;

  /**
   * Actions required (if any).
   */
  actionsRequired?: string;
}

/**
 * By default, Event Grid expects events to be in the Event Grid event schema. Specifying an input schema mapping enables publishing to Event Grid using a custom input schema. Currently, the only supported type of InputSchemaMapping is 'JsonInputSchemaMapping'.
 */
@discriminator("inputSchemaMappingType")
model InputSchemaMapping {
  /**
   * Type of the custom mapping
   */
  inputSchemaMappingType: InputSchemaMappingType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InboundIpRule {
  /**
   * IP Address in CIDR notation e.g., 10.0.0.0/8.
   */
  ipMask?: string;

  /**
   * Action to perform based on the match or no match of the IpMask.
   */
  action?: IpActionType;
}

/**
 * Describes an EventGrid Resource Sku.
 */
model ResourceSku {
  /**
   * The Sku name of the resource. The possible values are: Basic or Premium.
   */
  name?: Sku = Sku.Basic;
}

/**
 * The identity information for the resource.
 */
model IdentityInfo {
  /**
   * The type of managed identity used. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user-assigned identities. The type 'None' will remove any identity.
   */
  type?: IdentityType;

  /**
   * The principal ID of resource identity.
   */
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  tenantId?: string;

  /**
   * The list of user identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form:
   * '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   * This property is currently not used and reserved for future usage.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserIdentityProperties>;
}

/**
 * The information about the user identity.
 */
model UserIdentityProperties {
  /**
   * The principal id of user assigned identity.
   */
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  clientId?: string;
}

/**
 * Definition of a Tracked Resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TrackedResource extends Resource {
  /**
   * Location of the resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Tags of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Properties of the Domain update.
 */
model DomainUpdateParameters {
  /**
   * Tags of the domains resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Properties of the resource.
   */
  properties?: DomainUpdateParameterProperties;

  /**
   * Identity information for the resource.
   */
  identity?: IdentityInfo;

  /**
   * The Sku pricing tier for the domain.
   */
  sku?: ResourceSku;
}

/**
 * Information of domain update parameter properties.
 */
model DomainUpdateParameterProperties {
  /**
   * This determines if traffic is allowed over public network. By default it is enabled.
   * You can further restrict to specific IPs by configuring <seealso cref="P:Microsoft.Azure.Events.ResourceProvider.Common.Contracts.DomainUpdateParameterProperties.InboundIpRules" />
   */
  publicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.Enabled;

  /**
   * This can be used to restrict traffic from specific IPs instead of all IPs. Note: These are considered only if PublicNetworkAccess is enabled.
   */
  @identifiers(#[])
  inboundIpRules?: InboundIpRule[];

  /**
   * Minimum TLS version of the publisher allowed to publish to this domain
   */
  minimumTlsVersionAllowed?: TlsVersion;

  /**
   * This boolean is used to enable or disable local auth. Default value is false. When the property is set to true, only Microsoft Entra ID token will be used to authenticate if user is allowed to publish to the domain.
   */
  disableLocalAuth?: boolean;

  /**
   * This Boolean is used to specify the creation mechanism for 'all' the Event Grid Domain Topics associated with this Event Grid Domain resource.
   * In this context, creation of domain topic can be auto-managed (when true) or self-managed (when false). The default value for this property is true.
   * When this property is null or set to true, Event Grid is responsible of automatically creating the domain topic when the first event subscription is
   * created at the scope of the domain topic. If this property is set to false, then creating the first event subscription will require creating a domain topic
   * by the user. The self-management mode can be used if the user wants full control of when the domain topic is created, while auto-managed mode provides the
   * flexibility to perform less operations and manage fewer resources by the user. Also, note that in auto-managed creation mode, user is allowed to create the
   * domain topic on demand if needed.
   */
  autoCreateTopicWithFirstSubscription?: boolean;

  /**
   * This Boolean is used to specify the deletion mechanism for 'all' the Event Grid Domain Topics associated with this Event Grid Domain resource.
   * In this context, deletion of domain topic can be auto-managed (when true) or self-managed (when false). The default value for this property is true.
   * When this property is set to true, Event Grid is responsible of automatically deleting the domain topic when the last event subscription at the scope
   * of the domain topic is deleted. If this property is set to false, then the user needs to manually delete the domain topic when it is no longer needed
   * (e.g., when last event subscription is deleted and the resource needs to be cleaned up). The self-management mode can be used if the user wants full
   * control of when the domain topic needs to be deleted, while auto-managed mode provides the flexibility to perform less operations and manage fewer
   * resources by the user.
   */
  autoDeleteTopicWithLastSubscription?: boolean;

  /**
   * The data residency boundary for the domain.
   */
  dataResidencyBoundary?: DataResidencyBoundary;

  /**
   * The eventTypeInfo for the domain.
   */
  eventTypeInfo?: EventTypeInfo;
}

/**
 * Shared access keys of the Domain.
 */
model DomainSharedAccessKeys {
  /**
   * Shared access key1 for the domain.
   */
  key1?: string;

  /**
   * Shared access key2 for the domain.
   */
  key2?: string;
}

/**
 * Domain regenerate share access key request.
 */
model DomainRegenerateKeyRequest {
  /**
   * Key name to regenerate key1 or key2.
   */
  keyName: string;
}

/**
 * Properties of the Domain Topic.
 */
model DomainTopicProperties {
  /**
   * Provisioning state of the domain topic.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DomainTopicProvisioningState;
}

/**
 * Result of the Get delivery attributes operation.
 */
model DeliveryAttributeListResult {
  /**
   * A collection of DeliveryAttributeMapping
   */
  @pageItems
  value?: DeliveryAttributeMapping[];
}

/**
 * Delivery attribute mapping details.
 */
@discriminator("type")
model DeliveryAttributeMapping {
  /**
   * Name of the delivery attribute or header.
   */
  name?: string;

  /**
   * Type of the delivery attribute or header name.
   */
  type: DeliveryAttributeMappingType;
}

/**
 * Properties of the event subscription.
 */
model SubscriptionProperties {
  /**
   * Provisioning state of the event subscription.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: SubscriptionProvisioningState;

  /**
   * Information about the delivery configuration of the event subscription.
   */
  deliveryConfiguration?: DeliveryConfiguration;

  /**
   * The event delivery schema for the event subscription.
   */
  eventDeliverySchema?: DeliverySchema;

  /**
   * Information about the filter for the event subscription.
   */
  filtersConfiguration?: FiltersConfiguration;

  /**
   * Expiration time of the event subscription.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeUtc?: utcDateTime;

  /**
   * Tags relating to Event Subscription resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Properties of the delivery configuration information of the event subscription.
 */
model DeliveryConfiguration {
  /**
   * Delivery mode of the event subscription.
   */
  deliveryMode?: DeliveryMode;

  /**
   * This property should be populated when deliveryMode is queue and represents information about the queue subscription.
   */
  queue?: QueueInfo;

  /**
   * This property should be populated when deliveryMode is push and represents information about the push subscription.
   */
  push?: PushInfo;
}

/**
 * Properties of the Queue info for event subscription.
 */
model QueueInfo {
  /**
   * Maximum period in seconds in which once the message is in received (by the client) state and waiting to be accepted, released or rejected.
   * If this time elapsed after a message has been received by the client and not transitioned into accepted (not processed), released or rejected,
   * the message is available for redelivery. This is an optional field, where default is 60 seconds, minimum is 60 seconds and maximum is 300 seconds.
   */
  receiveLockDurationInSeconds?: int32;

  /**
   * The maximum delivery count of the events.
   */
  maxDeliveryCount?: int32;

  /**
   * The dead letter destination of the event subscription. Any event that cannot be delivered to its' destination is sent to the dead letter destination.
   * Uses the managed identity setup on the parent resource (namely, topic) to acquire the authentication tokens being used during delivery / dead-lettering.
   */
  deadLetterDestinationWithResourceIdentity?: DeadLetterWithResourceIdentity;

  /**
   * Time span duration in ISO 8601 format that determines how long messages are available to the subscription from the time the message was published.
   * This duration value is expressed using the following format: \'P(n)Y(n)M(n)DT(n)H(n)M(n)S\', where:
   *     - (n) is replaced by the value of each time element that follows the (n).
   *     - P is the duration (or Period) designator and is always placed at the beginning of the duration.
   *     - Y is the year designator, and it follows the value for the number of years.
   *     - M is the month designator, and it follows the value for the number of months.
   *     - W is the week designator, and it follows the value for the number of weeks.
   *     - D is the day designator, and it follows the value for the number of days.
   *     - T is the time designator, and it precedes the time components.
   *     - H is the hour designator, and it follows the value for the number of hours.
   *     - M is the minute designator, and it follows the value for the number of minutes.
   *     - S is the second designator, and it follows the value for the number of seconds.
   * This duration value cannot be set greater than the topic’s EventRetentionInDays. It is is an optional field where its minimum value is 1 minute, and its maximum is determined
   * by topic’s EventRetentionInDays value. The followings are examples of valid values:
   *     - \'P0DT23H12M\' or \'PT23H12M\': for duration of 23 hours and 12 minutes.
   *     - \'P1D\' or \'P1DT0H0M0S\': for duration of 1 day.
   */
  eventTimeToLive?: duration;
}

/**
 * Information about the deadletter destination with resource identity.
 */
model DeadLetterWithResourceIdentity {
  /**
   * The identity to use when dead-lettering events.
   */
  identity?: EventSubscriptionIdentity;

  /**
   * Information about the destination where events have to be delivered for the event subscription.
   * Uses the managed identity setup on the parent resource (namely, topic or domain) to acquire the authentication tokens being used during dead-lettering.
   */
  deadLetterDestination?: DeadLetterDestination;
}

/**
 * The identity information with the event subscription.
 */
model EventSubscriptionIdentity {
  /**
   * The type of managed identity used. Can be either 'SystemAssigned' or 'UserAssigned'.
   */
  type?: EventSubscriptionIdentityType;

  /**
   * The user identity associated with the resource.
   */
  userAssignedIdentity?: string;

  /**
   * The details of the Federated Identity Credential (FIC) used with the resource delivery.
   */
  federatedIdentityCredentialInfo?: FederatedIdentityCredentialInfo;
}

/**
 * The details of the Federated Identity Credential (FIC) used with the resource.
 */
model FederatedIdentityCredentialInfo {
  /**
   * The Multi-Tenant Microsoft Entra ID Application where the Federated Identity Credential (FIC) is associated with.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @format("uuid")
  federatedClientId: string;
}

/**
 * Information about the dead letter destination for an event subscription. To configure a deadletter destination, do not directly instantiate an object of this class. Instead, instantiate an object of a derived class. Currently, StorageBlobDeadLetterDestination is the only class that derives from this class.
 */
@discriminator("endpointType")
model DeadLetterDestination {
  /**
   * Type of the endpoint for the dead letter destination
   */
  endpointType: DeadLetterEndPointType;
}

/**
 * Properties of the destination info for event subscription supporting push.
 */
model PushInfo {
  /**
   * The maximum delivery count of the events.
   */
  maxDeliveryCount?: int32;

  /**
   * Time span duration in ISO 8601 format that determines how long messages are available to the subscription from the time the message was published.
   * This duration value is expressed using the following format: \'P(n)Y(n)M(n)DT(n)H(n)M(n)S\', where:
   *     - (n) is replaced by the value of each time element that follows the (n).
   *     - P is the duration (or Period) designator and is always placed at the beginning of the duration.
   *     - Y is the year designator, and it follows the value for the number of years.
   *     - M is the month designator, and it follows the value for the number of months.
   *     - W is the week designator, and it follows the value for the number of weeks.
   *     - D is the day designator, and it follows the value for the number of days.
   *     - T is the time designator, and it precedes the time components.
   *     - H is the hour designator, and it follows the value for the number of hours.
   *     - M is the minute designator, and it follows the value for the number of minutes.
   *     - S is the second designator, and it follows the value for the number of seconds.
   * This duration value cannot be set greater than the topic’s EventRetentionInDays. It is is an optional field where its minimum value is 1 minute, and its maximum is determined
   * by topic’s EventRetentionInDays value. The followings are examples of valid values:
   *     - \'P0DT23H12M\' or \'PT23H12M\': for duration of 23 hours and 12 minutes.
   *     - \'P1D\' or \'P1DT0H0M0S\': for duration of 1 day.
   */
  eventTimeToLive?: string;

  /**
   * The dead letter destination of the event subscription. Any event that cannot be delivered to its' destination is sent to the dead letter destination.
   * Uses the managed identity setup on the parent resource (namely, namespace) to acquire the authentication tokens being used during dead-lettering.
   */
  deadLetterDestinationWithResourceIdentity?: DeadLetterWithResourceIdentity;

  /**
   * Information about the destination where events have to be delivered for the event subscription.
   * Uses the managed identity setup on the parent resource (namely, topic or domain) to acquire the authentication tokens being used during delivery.
   */
  deliveryWithResourceIdentity?: DeliveryWithResourceIdentity;

  /**
   * Information about the destination where events have to be delivered for the event subscription.
   * Uses Azure Event Grid's identity to acquire the authentication tokens being used during delivery.
   */
  destination?: EventSubscriptionDestination;
}

/**
 * Information about the delivery for an event subscription with resource identity.
 */
model DeliveryWithResourceIdentity {
  /**
   * The identity to use when delivering events.
   */
  identity?: EventSubscriptionIdentity;

  /**
   * Information about the destination where events have to be delivered for the event subscription.
   * Uses the managed identity setup on the parent resource (namely, topic or domain) to acquire the authentication tokens being used during delivery.
   */
  destination?: EventSubscriptionDestination;
}

/**
 * Information about the destination for an event subscription.
 */
@discriminator("endpointType")
model EventSubscriptionDestination {
  /**
   * Type of the endpoint for the event subscription destination.
   */
  endpointType: EndpointType;
}

/**
 * Filters configuration for the Event Subscription.
 */
model FiltersConfiguration {
  /**
   * A list of applicable event types that need to be part of the event subscription. If it is desired to subscribe to all default event types, set the IncludedEventTypes to null.
   */
  includedEventTypes?: string[];

  /**
   * An array of filters that are used for filtering event subscriptions.
   */
  @identifiers(#[])
  filters?: Filter[];
}

/**
 * This is the base type that represents a filter. To configure a filter, do not directly instantiate an object of this class. Instead, instantiate
 * an object of a derived class such as BoolEqualsFilter, NumberInFilter etc depending on the type of the key based on
 * which you want to filter.
 */
@discriminator("operatorType")
model Filter {
  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: FilterOperatorType;

  /**
   * The field/property in the event based on which you want to filter.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  key?: string;
}

/**
 * Properties of the Event Subscription update.
 */
model SubscriptionUpdateParameters {
  /**
   * Properties of the Event Subscription update parameters.
   */
  properties?: SubscriptionUpdateParametersProperties;
}

/**
 * Properties of the Event Subscription update parameters.
 */
model SubscriptionUpdateParametersProperties {
  /**
   * Information about the delivery configuration of the event subscription.
   */
  deliveryConfiguration?: DeliveryConfiguration;

  /**
   * The event delivery schema for the event subscription.
   */
  eventDeliverySchema?: DeliverySchema;

  /**
   * Information about the filter for the event subscription.
   */
  filtersConfiguration?: FiltersConfiguration;

  /**
   * Expiration time of the event subscription.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeUtc?: utcDateTime;

  /**
   * Tags relating to Event Subscription resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Properties of the Event Subscription.
 */
model EventSubscriptionProperties {
  /**
   * Name of the topic of the event subscription.
   */
  @visibility(Lifecycle.Read)
  topic?: string;

  /**
   * Provisioning state of the event subscription.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: EventSubscriptionProvisioningState;

  /**
   * Information about the destination where events have to be delivered for the event subscription.
   * Uses Azure Event Grid's identity to acquire the authentication tokens being used during delivery / dead-lettering.
   */
  destination?: EventSubscriptionDestination;

  /**
   * Information about the destination where events have to be delivered for the event subscription.
   * Uses the managed identity setup on the parent resource (namely, topic or domain) to acquire the authentication tokens being used during delivery / dead-lettering.
   */
  deliveryWithResourceIdentity?: DeliveryWithResourceIdentity;

  /**
   * Information about the filter for the event subscription.
   */
  filter?: EventSubscriptionFilter;

  /**
   * List of user defined labels.
   */
  labels?: string[];

  /**
   * Expiration time of the event subscription.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeUtc?: utcDateTime;

  /**
   * The event delivery schema for the event subscription.
   */
  eventDeliverySchema?: EventDeliverySchema = EventDeliverySchema.EventGridSchema;

  /**
   * The retry policy for events. This can be used to configure maximum number of delivery attempts and time to live for events.
   */
  retryPolicy?: RetryPolicy;

  /**
   * The dead letter destination of the event subscription. Any event that cannot be delivered to its' destination is sent to the dead letter destination.
   * Uses Azure Event Grid's identity to acquire the authentication tokens being used during delivery / dead-lettering.
   */
  deadLetterDestination?: DeadLetterDestination;

  /**
   * The dead letter destination of the event subscription. Any event that cannot be delivered to its' destination is sent to the dead letter destination.
   * Uses the managed identity setup on the parent resource (namely, topic or domain) to acquire the authentication tokens being used during delivery / dead-lettering.
   */
  deadLetterWithResourceIdentity?: DeadLetterWithResourceIdentity;
}

/**
 * Filter for the Event Subscription.
 */
model EventSubscriptionFilter {
  /**
   * An optional string to filter events for an event subscription based on a resource path prefix.
   * The format of this depends on the publisher of the events.
   * Wildcard characters are not supported in this path.
   */
  subjectBeginsWith?: string;

  /**
   * An optional string to filter events for an event subscription based on a resource path suffix.
   * Wildcard characters are not supported in this path.
   */
  subjectEndsWith?: string;

  /**
   * A list of applicable event types that need to be part of the event subscription. If it is desired to subscribe to all default event types, set the IncludedEventTypes to null.
   */
  includedEventTypes?: string[];

  /**
   * Specifies if the SubjectBeginsWith and SubjectEndsWith properties of the filter
   * should be compared in a case sensitive manner.
   */
  isSubjectCaseSensitive?: boolean = false;

  /**
   * Allows advanced filters to be evaluated against an array of values instead of expecting a singular value.
   */
  enableAdvancedFilteringOnArrays?: boolean;

  /**
   * An array of advanced filters that are used for filtering event subscriptions.
   */
  @identifiers(#[])
  advancedFilters?: AdvancedFilter[];
}

/**
 * This is the base type that represents an advanced filter. To configure an advanced filter, do not directly instantiate an object of this class. Instead, instantiate an object of a derived class such as BoolEqualsAdvancedFilter, NumberInAdvancedFilter, StringEqualsAdvancedFilter etc. depending on the type of the key based on which you want to filter.
 */
@discriminator("operatorType")
model AdvancedFilter {
  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: AdvancedFilterOperatorType;

  /**
   * The field/property in the event based on which you want to filter.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  key?: string;
}

/**
 * Information about the retry policy for an event subscription.
 */
model RetryPolicy {
  /**
   * Maximum number of delivery retry attempts for events.
   */
  maxDeliveryAttempts?: int32 = 30;

  /**
   * Time To Live (in minutes) for events.
   */
  eventTimeToLiveInMinutes?: int32 = 1440;
}

/**
 * Properties of the Event Subscription update.
 */
model EventSubscriptionUpdateParameters {
  /**
   * Information about the destination where events have to be delivered for the event subscription.
   * Uses Azure Event Grid's identity to acquire the authentication tokens being used during delivery / dead-lettering.
   */
  destination?: EventSubscriptionDestination;

  /**
   * Information about the destination where events have to be delivered for the event subscription.
   * Uses the managed identity setup on the parent resource (topic / domain) to acquire the authentication tokens being used during delivery / dead-lettering.
   */
  deliveryWithResourceIdentity?: DeliveryWithResourceIdentity;

  /**
   * Information about the filter for the event subscription.
   */
  filter?: EventSubscriptionFilter;

  /**
   * List of user defined labels.
   */
  labels?: string[];

  /**
   * Information about the expiration time for the event subscription.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeUtc?: utcDateTime;

  /**
   * The event delivery schema for the event subscription.
   */
  eventDeliverySchema?: EventDeliverySchema;

  /**
   * The retry policy for events. This can be used to configure maximum number of delivery attempts and time to live for events.
   */
  retryPolicy?: RetryPolicy;

  /**
   * The dead letter destination of the event subscription. Any event that cannot be delivered to its' destination is sent to the dead letter destination.
   * Uses Azure Event Grid's identity to acquire the authentication tokens being used during delivery / dead-lettering.
   */
  deadLetterDestination?: DeadLetterDestination;

  /**
   * The dead letter destination of the event subscription. Any event that cannot be delivered to its' destination is sent to the dead letter destination.
   * Uses the managed identity setup on the parent resource (topic / domain) to acquire the authentication tokens being used during delivery / dead-lettering.
   */
  deadLetterWithResourceIdentity?: DeadLetterWithResourceIdentity;
}

/**
 * Properties of the namespace resource.
 */
model NamespaceProperties {
  /**
   * List of private endpoint connections.
   */
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Provisioning state of the namespace resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NamespaceProvisioningState;

  /**
   * Topics configuration information for the namespace resource
   */
  topicsConfiguration?: TopicsConfiguration;

  /**
   * Topic spaces configuration information for the namespace resource
   */
  topicSpacesConfiguration?: TopicSpacesConfiguration;

  /**
   * This is an optional property and it allows the user to specify if the namespace resource supports zone-redundancy capability or not. If this
   * property is not specified explicitly by the user, its default value depends on the following conditions:
   *     a. For Availability Zones enabled regions - The default property value would be true.
   *     b. For non-Availability Zones enabled regions - The default property value would be false.
   * Once specified, this property cannot be updated.
   */
  isZoneRedundant?: boolean;

  /**
   * This determines if traffic is allowed over public network. By default it is enabled.
   * You can further restrict to specific IPs by configuring <seealso cref="P:Microsoft.Azure.Events.ResourceProvider.Common.Contracts.PubSub.NamespaceProperties.InboundIpRules" />
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * This can be used to restrict traffic from specific IPs instead of all IPs. Note: These are considered only if PublicNetworkAccess is enabled.
   */
  @identifiers(#[])
  inboundIpRules?: InboundIpRule[];

  /**
   * Minimum TLS version of the publisher allowed to publish to this namespace. Only TLS version 1.2 is supported.
   */
  minimumTlsVersionAllowed?: TlsVersion;
}

/**
 * Properties of the Topics Configuration.
 */
model TopicsConfiguration {
  /**
   * The hostname for the topics configuration. This is a read-only property.
   */
  @visibility(Lifecycle.Read)
  hostname?: string;

  /**
   * List of custom domain configurations for the namespace.
   */
  @identifiers(#[])
  customDomains?: CustomDomainConfiguration[];
}

/**
 * A custom domain configuration that allows users to publish to their own domain name.
 */
model CustomDomainConfiguration {
  /**
   * Fully Qualified Domain Name (FQDN) for the custom domain.
   */
  fullyQualifiedDomainName: string;

  /**
   * Validation state for the custom domain. This is a read only property and is initially set to 'Pending' and will be updated to 'Approved' by Event Grid only after ownership of the domain name has been successfully validated.
   */
  validationState?: CustomDomainValidationState;

  /**
   * Identity info for accessing the certificate for the custom domain. This identity info must match an identity that has been set on the namespace.
   */
  identity?: CustomDomainIdentity;

  /**
   * The URL for the certificate that is used for publishing to the custom domain. We currently support certificates stored in Azure Key Vault only. While certificate URL can be either
   * versioned URL of the following format https://{key-vault-name}.vault.azure.net/certificates/{certificate-name}/{version-id}, or unversioned URL of the following format (e.g.,
   * https://contosovault.vault.azure.net/certificates/contosocert, we support unversioned certificate URL only (e.g., https://contosovault.vault.azure.net/certificates/contosocert)
   */
  certificateUrl?: string;

  /**
   * Expected DNS TXT record name. Event Grid will check for a TXT record with this name in the DNS record set of the custom domain name to prove ownership over the domain.
   * The values under this TXT record must contain the expected TXT record value.
   */
  expectedTxtRecordName?: string;

  /**
   * Expected DNS TXT record value. Event Grid will check for a TXT record with this value in the DNS record set of the custom domain name to prove ownership over the domain.
   */
  expectedTxtRecordValue?: string;
}

/**
 * The identity information for retrieving the certificate for the custom domain.
 */
model CustomDomainIdentity {
  /**
   * The type of managed identity used. Can be either 'SystemAssigned' or 'UserAssigned'.
   */
  type?: CustomDomainIdentityType;

  /**
   * The user identity associated with the resource.
   */
  userAssignedIdentity?: string;
}

/**
 * Properties of the Topic Spaces Configuration.
 */
model TopicSpacesConfiguration {
  /**
   * Indicate if Topic Spaces Configuration is enabled for the namespace. Default is Disabled.
   */
  state?: TopicSpacesConfigurationState = TopicSpacesConfigurationState.Disabled;

  /**
   * Fully qualified Azure Resource Id for the Event Grid Topic to which events will be routed to from TopicSpaces under a namespace.
   * This property should be in the following format '/subscriptions/{subId}/resourcegroups/{resourceGroupName}/providers/microsoft.EventGrid/topics/{topicName}'.
   * This topic should reside in the same region where namespace is located.
   */
  routeTopicResourceId?: string;

  /**
   * The endpoint for the topic spaces configuration. This is a read-only property.
   */
  @visibility(Lifecycle.Read)
  hostname?: string;

  /**
   * Routing enrichments for topic spaces configuration
   */
  routingEnrichments?: RoutingEnrichments;

  /**
   * Client authentication settings for topic spaces configuration.
   */
  clientAuthentication?: ClientAuthenticationSettings;

  /**
   * The maximum session expiry in hours. The property default value is 1 hour.
   * Min allowed value is 1 hour and max allowed value is 8 hours.
   */
  maximumSessionExpiryInHours?: int32;

  /**
   * The maximum number of sessions per authentication name. The property default value is 1.
   * Min allowed value is 1 and max allowed value is 100.
   */
  maximumClientSessionsPerAuthenticationName?: int32;

  /**
   * Routing identity info for topic spaces configuration.
   */
  routingIdentityInfo?: RoutingIdentityInfo;

  /**
   * List of custom domain configurations for the namespace.
   */
  @identifiers(#[])
  customDomains?: CustomDomainConfiguration[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RoutingEnrichments {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  static?: StaticRoutingEnrichment[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  dynamic?: DynamicRoutingEnrichment[];
}

/**
 * Static routing enrichment details.
 */
@discriminator("valueType")
model StaticRoutingEnrichment {
  /**
   * Static routing enrichment key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  key?: string;

  /**
   * Static routing enrichment value type. For e.g. this property value can be 'String'.
   */
  valueType: StaticRoutingEnrichmentType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DynamicRoutingEnrichment {
  /**
   * Dynamic routing enrichment key.
   */
  key?: string;

  /**
   * Dynamic routing enrichment value.
   */
  value?: string;
}

/**
 * Client authentication settings for namespace resource.
 */
model ClientAuthenticationSettings {
  /**
   * Alternative authentication name sources related to client authentication settings for namespace resource.
   */
  alternativeAuthenticationNameSources?: AlternativeAuthenticationNameSource[];

  /**
   * Custom JWT authentication settings for namespace resource.
   */
  customJwtAuthentication?: CustomJwtAuthenticationSettings;

  /**
   * Authentication settings for a webhook endpoint within a Namespace resource.
   */
  webhookAuthentication?: WebhookAuthenticationSettings;
}

/**
 * Custom JWT authentication settings for namespace resource.
 */
model CustomJwtAuthenticationSettings {
  /**
   * Expected JWT token issuer.
   */
  tokenIssuer?: string;

  /**
   * Information about the certificates that are used for token validation. We currently support maximum 2 certificates.
   */
  @identifiers(#[])
  issuerCertificates?: IssuerCertificateInfo[];

  /**
   * Information about the encoded public certificates that are used for custom authentication.
   */
  @identifiers(#[])
  encodedIssuerCertificates?: EncodedIssuerCertificateInfo[];
}

/**
 * Information about the certificate that is used for token validation.
 */
model IssuerCertificateInfo {
  /**
   * Keyvault certificate URL in https://keyvaultname.vault.azure.net/certificates/certificateName/certificateVersion format.
   */
  certificateUrl: string;

  /**
   * The identity that will be used to access the certificate.
   */
  identity?: CustomJwtAuthenticationManagedIdentity;
}

/**
 * The identity information for retrieving the certificate for custom JWT authentication.
 */
model CustomJwtAuthenticationManagedIdentity {
  /**
   * The type of managed identity used. Can be either 'SystemAssigned' or 'UserAssigned'.
   */
  type: CustomJwtAuthenticationManagedIdentityType;

  /**
   * The user identity associated with the resource.
   */
  userAssignedIdentity?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

/**
 * Information about the public certificate that is used for custom authentication.
 */
model EncodedIssuerCertificateInfo {
  /**
   * Identifier for the certificate.
   */
  kid: string;

  /**
   * Certificate in pem format.
   */
  encodedCertificate: string;
}

/**
 * Authentication settings for a webhook endpoint within a Namespace resource.
 */
model WebhookAuthenticationSettings {
  /**
   * The identity configuration required for authenticating a custom webhook.
   */
  identity: CustomWebhookAuthenticationManagedIdentity;

  /**
   * The URL endpoint where the Event Grid service sends authenticated webhook requests using the specified managed identity.
   */
  endpointUrl: url;

  /**
   * The base URL endpoint where the Event Grid service sends authenticated webhook requests using the specified managed identity.
   */
  endpointBaseUrl?: url;

  /**
   * Microsoft Entra ID Application ID or URI to get the access token that will be included as the bearer token in delivery requests.
   */
  azureActiveDirectoryApplicationIdOrUri: string;

  /**
   * Microsoft Entra ID Tenant ID to get the access token that will be included as the bearer token in delivery requests.
   */
  azureActiveDirectoryTenantId: string;
}

/**
 * The identity configuration required for authenticating a custom webhook.
 */
model CustomWebhookAuthenticationManagedIdentity {
  /**
   * The type of managed identity used. Can be either 'SystemAssigned' or 'UserAssigned'.
   */
  type: CustomWebhookAuthenticationManagedIdentityType;

  /**
   * The user identity associated with the resource.
   */
  userAssignedIdentity?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

/**
 * Routing identity info for topic spaces configuration.
 */
model RoutingIdentityInfo {
  /**
   * Routing identity type for topic spaces configuration.
   */
  type?: RoutingIdentityType;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentity?: string;
}

/**
 * Represents available Sku pricing tiers.
 */
model NamespaceSku {
  /**
   * The name of the SKU.
   */
  name?: SkuName;

  /**
   * Specifies the number of Throughput Units that defines the capacity for the namespace. The property default value is
   * 1 which signifies 1 Throughput Unit = 1MB/s ingress and 2MB/s egress per namespace. Min capacity is 1 and
   * max allowed capacity is 20.
   */
  capacity?: int32;
}

/**
 * Properties to update namespace.
 */
model NamespaceUpdateParameters {
  /**
   * Tags of the namespace resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Namespace resource identity information.
   */
  identity?: IdentityInfo;

  /**
   * Represents available Sku pricing tiers.
   */
  sku?: NamespaceSku;

  /**
   * Properties of the namespace resource.
   */
  properties?: NamespaceUpdateParameterProperties;
}

/**
 * Information of namespace update parameter properties.
 */
model NamespaceUpdateParameterProperties {
  /**
   * Topic spaces configuration properties that can be updated.
   */
  topicSpacesConfiguration?: UpdateTopicSpacesConfigurationInfo;

  /**
   * Topics configuration properties that can be updated.
   */
  topicsConfiguration?: UpdateTopicsConfigurationInfo;

  /**
   * This determines if traffic is allowed over public network. By default it is enabled.
   * You can further restrict to specific IPs by configuring <seealso cref="P:Microsoft.Azure.Events.ResourceProvider.Common.Contracts.PubSub.NamespaceUpdateParameterProperties.InboundIpRules" />
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * This can be used to restrict traffic from specific IPs instead of all IPs. Note: These are considered only if PublicNetworkAccess is enabled.
   */
  @identifiers(#[])
  inboundIpRules?: InboundIpRule[];
}

/**
 * Properties of the topic spaces configuration info of a namespace.
 */
model UpdateTopicSpacesConfigurationInfo {
  /**
   * Indicate if Topic Spaces Configuration is enabled for the namespace. Default is Disabled.
   */
  state?: TopicSpacesConfigurationState;

  /**
   * This property is used to specify custom topic to which events will be routed to from topic spaces configuration under namespace.
   */
  routeTopicResourceId?: string;

  /**
   * Routing enrichments for topic spaces configuration.
   */
  routingEnrichments?: RoutingEnrichments;

  /**
   * Client authentication settings for topic spaces configuration.
   */
  clientAuthentication?: ClientAuthenticationSettings;

  /**
   * The maximum session expiry in hours. The property default value is 1 hour.
   * Min allowed value is 1 hour and max allowed value is 8 hours.
   */
  maximumSessionExpiryInHours?: int32;

  /**
   * The maximum number of sessions per authentication name. The property default value is 1.
   * Min allowed value is 1 and max allowed value is 100.
   */
  maximumClientSessionsPerAuthenticationName?: int32;

  /**
   * Routing identity info for topic spaces configuration.
   */
  routingIdentityInfo?: RoutingIdentityInfo;

  /**
   * Custom domain info for topic spaces configuration.
   */
  @identifiers(#[])
  customDomains?: CustomDomainConfiguration[];
}

/**
 * Properties of the topics configuration info of a namespace.
 */
model UpdateTopicsConfigurationInfo {
  /**
   * Custom domain info for topics configuration.
   */
  @identifiers(#[])
  customDomains?: CustomDomainConfiguration[];
}

/**
 * Shared access keys of the Namespace.
 */
model NamespaceSharedAccessKeys {
  /**
   * Shared access key1 for the namespace.
   */
  @secret
  key1?: string;

  /**
   * Shared access key2 for the namespace.
   */
  @secret
  key2?: string;
}

/**
 * Namespace regenerate share access key request.
 */
model NamespaceRegenerateKeyRequest {
  /**
   * Key name to regenerate key1 or key2.
   */
  keyName: string;
}

/**
 * Properties of the namespace topic.
 */
model NamespaceTopicProperties {
  /**
   * Provisioning state of the namespace topic.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NamespaceTopicProvisioningState;

  /**
   * Publisher type of the namespace topic.
   */
  publisherType?: PublisherType;

  /**
   * This determines the format that is expected for incoming events published to the topic.
   */
  inputSchema?: EventInputSchema = EventInputSchema.CloudEventSchemaV1_0;

  /**
   * Event retention for the namespace topic expressed in days. The property default value is 1 day.
   * Min event retention duration value is 1 day and max event retention duration value is 1 day.
   */
  eventRetentionInDays?: int32;
}

/**
 * Properties of the namespace topic update.
 */
model NamespaceTopicUpdateParameters {
  /**
   * Properties of the namespace topic resource.
   */
  properties?: NamespaceTopicUpdateParameterProperties;
}

/**
 * Information of namespace topic update parameter properties.
 */
model NamespaceTopicUpdateParameterProperties {
  /**
   * Event retention for the namespace topic expressed in days. The property default value is 1 day.
   * Min event retention duration value is 1 day and max event retention duration value is 1 day.
   */
  eventRetentionInDays?: int32;
}

/**
 * Shared access keys of the Topic
 */
model TopicSharedAccessKeys {
  /**
   * Shared access key1 for the topic.
   */
  key1?: string;

  /**
   * Shared access key2 for the topic.
   */
  key2?: string;
}

/**
 * Topic regenerate share access key request
 */
model TopicRegenerateKeyRequest {
  /**
   * Key name to regenerate key1 or key2
   */
  keyName: string;
}

/**
 * Represents an operation returned by the GetOperations request.
 */
model Operation {
  /**
   * Name of the operation.
   */
  name?: string;

  /**
   * Display name of the operation.
   */
  display?: OperationInfo;

  /**
   * Origin of the operation.
   */
  origin?: string;

  /**
   * This Boolean is used to determine if the operation is a data plane action or not.
   */
  isDataAction?: boolean;

  /**
   * Properties of the operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: unknown;
}

/**
 * Information about an operation
 */
model OperationInfo {
  /**
   * Name of the provider
   */
  provider?: string;

  /**
   * Name of the resource type
   */
  resource?: string;

  /**
   * Name of the operation
   */
  operation?: string;

  /**
   * Description of the operation
   */
  description?: string;
}

/**
 * Properties of the partner configuration.
 */
model PartnerConfigurationProperties {
  /**
   * The details of authorized partners.
   */
  partnerAuthorization?: PartnerAuthorization;

  /**
   * Provisioning state of the partner configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: PartnerConfigurationProvisioningState;
}

/**
 * The partner authorization details.
 */
model PartnerAuthorization {
  /**
   * Time used to validate the authorization expiration time for each authorized partner. If DefaultMaximumExpirationTimeInDays is
   * not specified, the default is 7 days. Otherwise, allowed values are between 1 and 365 days.
   */
  defaultMaximumExpirationTimeInDays?: int32;

  /**
   * The list of authorized partners.
   */
  @identifiers(#[])
  authorizedPartnersList?: Partner[];
}

/**
 * Information about the partner.
 */
model Partner {
  /**
   * The immutableId of the corresponding partner registration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @format("uuid")
  partnerRegistrationImmutableId?: string;

  /**
   * The partner name.
   */
  partnerName?: string;

  /**
   * Expiration time of the partner authorization. If this timer expires, any request from this partner to create, update or delete resources in subscriber's
   * context will fail. If specified, the allowed values are between 1 to the value of defaultMaximumExpirationTimeInDays specified in PartnerConfiguration.
   * If not specified, the default value will be the value of defaultMaximumExpirationTimeInDays specified in PartnerConfiguration or 7 if this value is not specified.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  authorizationExpirationTimeInUtc?: utcDateTime;
}

/**
 * Properties of the partner configuration update.
 */
model PartnerConfigurationUpdateParameters {
  /**
   * Tags of the partner configuration resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Properties of the Topic resource.
   */
  properties?: PartnerConfigurationUpdateParameterProperties;
}

/**
 * Information of partner configuration update parameter properties.
 */
model PartnerConfigurationUpdateParameterProperties {
  /**
   * The default time used to validate the maximum expiration time for each authorized partners in days. Allowed values ar between 1 and 365 days.
   */
  defaultMaximumExpirationTimeInDays?: int32;
}

/**
 * Properties of the Partner Destination.
 */
model PartnerDestinationProperties {
  /**
   * The immutable Id of the corresponding partner registration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @format("uuid")
  partnerRegistrationImmutableId?: string;

  /**
   * Endpoint context associated with this partner destination.
   */
  endpointServiceContext?: string;

  /**
   * Expiration time of the partner destination. If this timer expires and the partner destination was never activated,
   * the partner destination and corresponding channel are deleted.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeIfNotActivatedUtc?: utcDateTime;

  /**
   * Provisioning state of the partner destination.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PartnerDestinationProvisioningState;

  /**
   * Activation state of the partner destination.
   */
  activationState?: PartnerDestinationActivationState;

  /**
   * Endpoint Base URL of the partner destination
   */
  endpointBaseUrl?: url;

  /**
   * Context or helpful message that can be used during the approval process.
   */
  messageForActivation?: string;
}

/**
 * Properties of the Partner Destination that can be updated.
 */
model PartnerDestinationUpdateParameters {
  /**
   * Tags of the Partner Destination resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Properties of the partner namespace.
 */
model PartnerNamespaceProperties {
  /**
   * List of private endpoint connections.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Provisioning state of the partner namespace.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PartnerNamespaceProvisioningState;

  /**
   * The fully qualified ARM Id of the partner registration that should be associated with this partner namespace. This takes the following format:
   * /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventGrid/partnerRegistrations/{partnerRegistrationName}.
   */
  partnerRegistrationFullyQualifiedId?: string;

  /**
   * Minimum TLS version of the publisher allowed to publish to this partner namespace
   */
  minimumTlsVersionAllowed?: TlsVersion;

  /**
   * Endpoint for the partner namespace.
   */
  @visibility(Lifecycle.Read)
  endpoint?: string;

  /**
   * This determines if traffic is allowed over public network. By default it is enabled.
   * You can further restrict to specific IPs by configuring <seealso cref="P:Microsoft.Azure.Events.ResourceProvider.Common.Contracts.PartnerNamespaceProperties.InboundIpRules" />
   */
  publicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.Enabled;

  /**
   * This can be used to restrict traffic from specific IPs instead of all IPs. Note: These are considered only if PublicNetworkAccess is enabled.
   */
  @identifiers(#[])
  inboundIpRules?: InboundIpRule[];

  /**
   * This boolean is used to enable or disable local auth. Default value is false. When the property is set to true, only Microsoft Entra ID token will be used to authenticate if user is allowed to publish to the partner namespace.
   */
  disableLocalAuth?: boolean = false;

  /**
   * This determines if events published to this partner namespace should use the source attribute in the event payload
   * or use the channel name in the header when matching to the partner topic. If none is specified, source attribute routing will be used to match the partner topic.
   */
  partnerTopicRoutingMode?: PartnerTopicRoutingMode = PartnerTopicRoutingMode.SourceEventAttribute;
}

/**
 * Properties of the Partner Namespace update.
 */
model PartnerNamespaceUpdateParameters {
  /**
   * Tags of the Partner Namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Properties of the Partner Namespace.
   */
  properties?: PartnerNamespaceUpdateParameterProperties;
}

/**
 * Information of Partner Namespace update parameter properties.
 */
model PartnerNamespaceUpdateParameterProperties {
  /**
   * This determines if traffic is allowed over public network. By default it is enabled.
   * You can further restrict to specific IPs by configuring <seealso cref="P:Microsoft.Azure.Events.ResourceProvider.Common.Contracts.PartnerNamespaceUpdateParameterProperties.InboundIpRules" />
   */
  publicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.Enabled;

  /**
   * This can be used to restrict traffic from specific IPs instead of all IPs. Note: These are considered only if PublicNetworkAccess is enabled.
   */
  @identifiers(#[])
  inboundIpRules?: InboundIpRule[];

  /**
   * Minimum TLS version of the publisher allowed to publish to this domain
   */
  minimumTlsVersionAllowed?: TlsVersion;

  /**
   * This boolean is used to enable or disable local auth. Default value is false. When the property is set to true, only Microsoft Entra ID token will be used to authenticate if user is allowed to publish to the partner namespace.
   */
  disableLocalAuth?: boolean;
}

/**
 * Shared access keys of the partner namespace.
 */
model PartnerNamespaceSharedAccessKeys {
  /**
   * Shared access key1 for the partner namespace.
   */
  key1?: string;

  /**
   * Shared access key2 for the partner namespace.
   */
  key2?: string;
}

/**
 * PartnerNamespace regenerate shared access key request.
 */
model PartnerNamespaceRegenerateKeyRequest {
  /**
   * Key name to regenerate (key1 or key2).
   */
  keyName: string;
}

/**
 * Properties of the partner registration.
 */
model PartnerRegistrationProperties {
  /**
   * Provisioning state of the partner registration.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PartnerRegistrationProvisioningState;

  /**
   * The immutableId of the corresponding partner registration.
   * Note: This property is marked for deprecation and is not supported in any future GA API version
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @format("uuid")
  partnerRegistrationImmutableId?: string;
}

/**
 * Properties of the Partner Registration update.
 */
model PartnerRegistrationUpdateParameters {
  /**
   * Tags of the partner registration resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Properties of the Partner Topic.
 */
model PartnerTopicProperties {
  /**
   * The immutableId of the corresponding partner registration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @format("uuid")
  partnerRegistrationImmutableId?: string;

  /**
   * Source associated with this partner topic. This represents a unique partner resource.
   */
  source?: string;

  /**
   * Event Type information from the corresponding event channel.
   */
  eventTypeInfo?: EventTypeInfo;

  /**
   * Expiration time of the partner topic. If this timer expires while the partner topic is still never activated,
   * the partner topic and corresponding event channel are deleted.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeIfNotActivatedUtc?: utcDateTime;

  /**
   * Provisioning state of the partner topic.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PartnerTopicProvisioningState;

  /**
   * Activation state of the partner topic.
   */
  activationState?: PartnerTopicActivationState;

  /**
   * Friendly description about the topic. This can be set by the publisher/partner to show custom description for the customer partner topic.
   * This will be helpful to remove any ambiguity of the origin of creation of the partner topic for the customer.
   */
  partnerTopicFriendlyDescription?: string;

  /**
   * Context or helpful message that can be used during the approval process by the subscriber.
   */
  messageForActivation?: string;
}

/**
 * Properties of the Partner Topic update.
 */
model PartnerTopicUpdateParameters {
  /**
   * Tags of the Partner Topic resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Identity information for the Partner Topic resource.
   */
  identity?: IdentityInfo;
}

/**
 * Network security perimeter configuration information to reflect latest association and nsp profile configuration.
 */
model NetworkSecurityPerimeterConfigurationProperties {
  /**
   * Provisioning state to reflect configuration state and indicate status of nsp profile configuration retrieval.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: NetworkSecurityPerimeterConfigProvisioningState;

  /**
   * Provisioning issues to reflect status when attempting to retrieve nsp profile configuration.
   */
  @identifiers(#[])
  provisioningIssues?: NetworkSecurityPerimeterConfigurationIssues[];

  /**
   * Perimeter info for nsp association.
   */
  networkSecurityPerimeter?: NetworkSecurityPerimeterInfo;

  /**
   * Nsp association name and access mode of association.
   */
  resourceAssociation?: ResourceAssociation;

  /**
   * Nsp profile configuration, access rules and diagnostic settings.
   */
  profile?: NetworkSecurityPerimeterConfigurationProfile;
}

/**
 * Network security perimeter configuration issues.
 */
model NetworkSecurityPerimeterConfigurationIssues {
  /**
   * Provisioning issue name.
   */
  name?: string;

  /**
   * Provisioning issue properties.
   */
  properties?: NetworkSecurityPerimeterConfigurationIssuesProperties;
}

/**
 * Network security perimeter configuration issues properties.
 */
model NetworkSecurityPerimeterConfigurationIssuesProperties {
  /**
   * Provisioning issue type.
   */
  issueType?: NetworkSecurityPerimeterConfigurationIssueType;

  /**
   * Provisioning issue severity.
   */
  severity?: NetworkSecurityPerimeterConfigurationIssueSeverity;

  /**
   * Provisioning issue description.
   */
  description?: string;

  /**
   * ARM IDs of resources that can be associated to the same perimeter to remediate the issue.
   */
  suggestedResourceIds?: string[];

  /**
   * Access rules that can be added to the same profile to remediate the issue.
   */
  suggestedAccessRules?: string[];
}

/**
 * Network security perimeter info.
 */
model NetworkSecurityPerimeterInfo {
  /**
   * Arm id for network security perimeter.
   */
  id?: string;

  /**
   * Network security perimeter guid.
   */
  perimeterGuid?: string;

  /**
   * Network security perimeter location.
   */
  location?: string;
}

/**
 * Nsp resource association
 */
model ResourceAssociation {
  /**
   * Association name
   */
  name?: string;

  /**
   * Network security perimeter access mode.
   */
  accessMode?: NetworkSecurityPerimeterAssociationAccessMode;
}

/**
 * Nsp configuration with profile information.
 */
model NetworkSecurityPerimeterConfigurationProfile {
  /**
   * Nsp configuration profile name.
   */
  name?: string;

  /**
   * Access rules version number for nsp profile.
   */
  accessRulesVersion?: string;

  /**
   * List of inbound or outbound access rule setup on the nsp profile.
   */
  @identifiers(#[])
  accessRules?: NetworkSecurityPerimeterProfileAccessRule[];

  /**
   * Diagnostic settings version number for nsp profile.
   */
  diagnosticSettingsVersion?: string;

  /**
   * Enabled log categories for nsp profile.
   */
  enabledLogCategories?: string[];
}

/**
 * Network security perimeter profile access rule.
 */
model NetworkSecurityPerimeterProfileAccessRule {
  /**
   * Fully Qualified Arm id for network security perimeter profile access rule.
   */
  fullyQualifiedArmId?: string;

  /**
   * Name for nsp access rule.
   */
  name?: string;

  /**
   * nsp access rule type.
   */
  type?: string;

  /**
   * NSP access rule properties.
   */
  properties?: NetworkSecurityPerimeterProfileAccessRuleProperties;
}

/**
 * Network security perimeter profile access rule properties.
 */
model NetworkSecurityPerimeterProfileAccessRuleProperties {
  /**
   * NSP access rule direction.
   */
  direction?: NetworkSecurityPerimeterProfileAccessRuleDirection;

  /**
   * Address prefixes.
   */
  addressPrefixes?: string[];

  /**
   * List of subscriptions.
   */
  subscriptions?: NetworkSecurityPerimeterSubscription[];

  /**
   * Network security perimeters.
   */
  networkSecurityPerimeters?: NetworkSecurityPerimeterInfo[];

  /**
   * Fully qualified domain names.
   */
  fullyQualifiedDomainNames?: string[];

  /**
   * List of email addresses.
   */
  emailAddresses?: string[];

  /**
   * List of phone numbers.
   */
  phoneNumbers?: string[];
}

/**
 * Network security perimeter subscription inbound access rule.
 */
model NetworkSecurityPerimeterSubscription {
  /**
   * Subscription id.
   */
  id?: string;
}

/**
 * Network security perimeter configuration List.
 */
model NetworkSecurityPerimeterConfigurationList
  is Azure.Core.Page<NetworkSecurityPerimeterConfiguration>;

/**
 * The properties of permission binding.
 */
model PermissionBindingProperties {
  /**
   * Description for the Permission Binding resource.
   */
  description?: string;

  /**
   * The name of the Topic Space resource that the permission is bound to.
   * The Topic space needs to be a resource under the same namespace the permission binding is a part of.
   */
  topicSpaceName?: string;

  /**
   * The allowed permission.
   */
  permission?: PermissionType;

  /**
   * The name of the client group resource that the permission is bound to.
   * The client group needs to be a resource under the same namespace the permission binding is a part of.
   */
  clientGroupName?: string;

  /**
   * Provisioning state of the PermissionBinding resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PermissionBindingProvisioningState;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateLinkResourceProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  groupId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  displayName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requiredMembers?: string[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requiredZoneNames?: string[];
}

/**
 * Properties of the System Topic.
 */
model SystemTopicProperties {
  /**
   * Provisioning state of the system topic.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * Source for the system topic.
   */
  source?: string;

  /**
   * TopicType for the system topic.
   */
  topicType?: string;

  /**
   * Metric resource id for the system topic.
   */
  @visibility(Lifecycle.Read)
  metricResourceId?: string;

  /**
   * Key encryption configuration properties of the system topic resource. This is an optional property. When not specified, no key encryption is used.
   */
  encryption?: KeyEncryption;

  /**
   * Represents the platform capabilities of the resource, including Azure Confidential Compute related properties.
   */
  platformCapabilities?: PlatformCapabilities;
}

/**
 * Properties of the Encryption settings.
 */
model KeyEncryption {
  /**
   * List of all customer-managed key encryption properties for the resource. However only one key is supported at a time.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  customerManagedKeyEncryption: CustomerManagedKeyEncryption[];
}

/**
 * All Customer-managed key encryption properties for the resource.
 */
model CustomerManagedKeyEncryption {
  /**
   * Key encryption key URL. This URL can be either versioned (e.g., https://contosovault.vault.azure.net/keys/contosokek/562a4bb76b524a1493a6afe8e536ee78), or unversioned (e.g.,
   * https://contosovault.vault.azure.net/keys/contosokek. When versioned URL is used, this version of the key will be used by Event Grid Runtime even if it is rotated. It is user
   * responsibility to update the URL with the new version by updating the namespace resource. When URL without version is used, Event Grid will query and get latest version and will
   * be used automatically.
   */
  keyEncryptionKeyUrl: string;

  /**
   * All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault. This is an optional property.
   * When not specified, the SystemAssigned identity will be used.
   */
  keyEncryptionKeyIdentity?: KeyEncryptionKeyIdentity;

  /**
   * The state of the Customer Managed Key (CMK) encryption. This is a read-only property which determines if the associated key is active and valid and used
   * actively by runtime as expected. When the associated CMK becomes invalid (e.g., if it is deleted, or if versioned CMK is not current anymore), Event Grid
   * Service will set this state to disabled to indicate that this key is not valid anymore and requires action from user.
   */
  @visibility(Lifecycle.Read)
  keyEncryptionKeyStatus?: KeyEncryptionKeyStatus;

  /**
   * Friendly description about the Customer Managed Key (CMK) encryption state. This is a read-only property which determines why the associated key is revoked which
   * will help user to mitigate the issue and re-enable the CMK key.
   */
  @visibility(Lifecycle.Read)
  keyEncryptionKeyStatusFriendlyDescription?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model KeyEncryptionKeyIdentity {
  /**
   * The type of managed identity used. Only UserAssigned or SystemAssigned Identity are supported.
   */
  type: KeyEncryptionIdentityType;

  /**
   * Azure Resource fully qualified Id for the user-assigned identity associated with the resource. The resource Id takes the following format:
   * '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  userAssignedIdentityResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

/**
 * Platform capabilities properties of the resource.
 */
model PlatformCapabilities {
  /**
   * Represents the Azure Confidential Compute properties of the resource.
   */
  confidentialCompute?: ConfidentialCompute;
}

/**
 * Azure Confidential Compute properties of the resource.
 */
model ConfidentialCompute {
  /**
   * This property specifies the mode of the Azure Confidential Compute configuration.
   * Possible values are 'Disabled' or 'Enabled'.
   * This is an immutable property set at the time of resource creation and cannot be modified later.
   * Enabling this property ensures that messages are processed and stored in a Azure Confidential Compute environment.
   */
  mode: ConfidentialComputeMode;
}

/**
 * Properties of the System Topic update.
 */
model SystemTopicUpdateParameters {
  /**
   * Tags of the system topic.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Resource identity information.
   */
  identity?: IdentityInfo;
}

/**
 * Properties of the Topic.
 */
model TopicProperties {
  /**
   * List of private endpoint connections.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Provisioning state of the topic.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: TopicProvisioningState;

  /**
   * Endpoint for the topic.
   */
  @visibility(Lifecycle.Read)
  endpoint?: string;

  /**
   * Event Type Information for the user topic. This information is provided by the publisher and can be used by the
   * subscriber to view different types of events that are published.
   */
  eventTypeInfo?: EventTypeInfo;

  /**
   * Minimum TLS version of the publisher allowed to publish to this topic
   */
  minimumTlsVersionAllowed?: TlsVersion;

  /**
   * This determines the format that Event Grid should expect for incoming events published to the topic.
   */
  inputSchema?: InputSchema = InputSchema.EventGridSchema;

  /**
   * This enables publishing using custom event schemas. An InputSchemaMapping can be specified to map various properties of a source schema to various required properties of the EventGridEvent schema.
   */
  inputSchemaMapping?: InputSchemaMapping;

  /**
   * Metric resource id for the topic.
   */
  @visibility(Lifecycle.Read)
  metricResourceId?: string;

  /**
   * This determines if traffic is allowed over public network. By default it is enabled.
   * You can further restrict to specific IPs by configuring <seealso cref="P:Microsoft.Azure.Events.ResourceProvider.Common.Contracts.TopicProperties.InboundIpRules" />
   */
  publicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.Enabled;

  /**
   * This can be used to restrict traffic from specific IPs instead of all IPs. Note: These are considered only if PublicNetworkAccess is enabled.
   */
  @identifiers(#[])
  inboundIpRules?: InboundIpRule[];

  /**
   * This boolean is used to enable or disable local auth. Default value is false. When the property is set to true, only Microsoft Entra ID token will be used to authenticate if user is allowed to publish to the topic.
   */
  disableLocalAuth?: boolean = false;

  /**
   * Data Residency Boundary of the resource.
   */
  dataResidencyBoundary?: DataResidencyBoundary;

  /**
   * Key encryption configuration properties of the topic resource. This is an optional property. When not specified, no key encryption is used.
   */
  encryption?: KeyEncryption;

  /**
   * Represents the platform capabilities of the resource, including Azure Confidential Compute related properties.
   */
  platformCapabilities?: PlatformCapabilities;
}

/**
 * Definition of an Extended Location
 */
model ExtendedLocation {
  /**
   * Fully qualified name of the extended location.
   */
  name?: string;

  /**
   * Type of the extended location.
   */
  type?: string;
}

/**
 * Properties of the Topic update
 */
model TopicUpdateParameters {
  /**
   * Tags of the Topic resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Topic resource identity information.
   */
  identity?: IdentityInfo;

  /**
   * Properties of the Topic resource.
   */
  properties?: TopicUpdateParameterProperties;

  /**
   * The Sku pricing tier for the topic.
   */
  sku?: ResourceSku;
}

/**
 * Information of topic update parameter properties.
 */
model TopicUpdateParameterProperties {
  /**
   * This determines if traffic is allowed over public network. By default it is enabled.
   * You can further restrict to specific IPs by configuring <seealso cref="P:Microsoft.Azure.Events.ResourceProvider.Common.Contracts.TopicUpdateParameterProperties.InboundIpRules" />
   */
  publicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.Enabled;

  /**
   * This can be used to restrict traffic from specific IPs instead of all IPs. Note: These are considered only if PublicNetworkAccess is enabled.
   */
  @identifiers(#[])
  inboundIpRules?: InboundIpRule[];

  /**
   * Minimum TLS version of the publisher allowed to publish to this domain
   */
  minimumTlsVersionAllowed?: TlsVersion;

  /**
   * This boolean is used to enable or disable local auth. Default value is false. When the property is set to true, only Microsoft Entra ID token will be used to authenticate if user is allowed to publish to the topic.
   */
  disableLocalAuth?: boolean;

  /**
   * The data residency boundary for the topic.
   */
  dataResidencyBoundary?: DataResidencyBoundary;

  /**
   * The eventTypeInfo for the topic.
   */
  eventTypeInfo?: EventTypeInfo;
}

/**
 * Result of the List Event Types operation
 */
model EventTypesListResult {
  /**
   * A collection of event types
   */
  @pageItems
  value?: EventType[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * Event Type for a subject under a topic
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EventType extends Resource {
  /**
   * Properties of the event type.
   */
  properties?: EventTypeProperties;
}

/**
 * Properties of the event type
 */
model EventTypeProperties {
  /**
   * Display name of the event type.
   */
  displayName?: string;

  /**
   * Description of the event type.
   */
  description?: string;

  /**
   * URL of the schema for this event type.
   */
  schemaUrl?: string;

  /**
   * IsInDefaultSet flag of the event type.
   */
  isInDefaultSet?: boolean;
}

/**
 * Properties of the Extension Topic
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ExtensionTopicProperties {
  /**
   * Description of the extension topic.
   */
  description?: string;

  /**
   * System topic resource id which is mapped to the source.
   */
  systemTopic?: string;
}

/**
 * The properties of topic space.
 */
model TopicSpaceProperties {
  /**
   * Description for the Topic Space resource.
   */
  description?: string;

  /**
   * The topic filters in the topic space.
   * Example: "topicTemplates": [
   *               "devices/foo/bar",
   *               "devices/topic1/+",
   *               "devices/${principal.name}/${principal.attributes.keyName}" ].
   */
  topicTemplates?: string[];

  /**
   * Provisioning state of the TopicSpace resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: TopicSpaceProvisioningState;
}

/**
 * Result of the List Topic Types operation
 */
model TopicTypesListResult {
  /**
   * A collection of topic types
   */
  @pageItems
  value?: TopicTypeInfo[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * Properties of a topic type.
 */
model TopicTypeProperties {
  /**
   * Namespace of the provider of the topic type.
   */
  provider?: string;

  /**
   * Display Name for the topic type.
   */
  displayName?: string;

  /**
   * Description of the topic type.
   */
  description?: string;

  /**
   * Region type of the resource.
   */
  resourceRegionType?: ResourceRegionType;

  /**
   * Provisioning state of the topic type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: TopicTypeProvisioningState;

  /**
   * List of locations supported by this topic type.
   */
  supportedLocations?: string[];

  /**
   * Source resource format.
   */
  sourceResourceFormat?: string;

  /**
   * Supported source scopes.
   */
  supportedScopesForSource?: TopicTypeSourceScope[];

  /**
   * Flag to indicate that a topic type can support both regional or global system topics.
   */
  areRegionalAndGlobalSourcesSupported?: boolean;

  /**
   * Permissions which are enforced for creating and updating system topics of this this topic type.
   */
  @identifiers(#[])
  additionalEnforcedPermissions?: TopicTypeAdditionalEnforcedPermission[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TopicTypeAdditionalEnforcedPermission {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  permissionName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isDataAction?: boolean;
}

/**
 * Properties of the verified partner.
 */
model VerifiedPartnerProperties {
  /**
   * ImmutableId of the corresponding partner registration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @format("uuid")
  partnerRegistrationImmutableId?: string;

  /**
   * Official name of the Partner.
   */
  organizationName?: string;

  /**
   * Display name of the verified partner.
   */
  partnerDisplayName?: string;

  /**
   * Details of the partner topic scenario.
   */
  partnerTopicDetails?: PartnerDetails;

  /**
   * Details of the partner destination scenario.
   */
  partnerDestinationDetails?: PartnerDetails;

  /**
   * Provisioning state of the verified partner.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: VerifiedPartnerProvisioningState;
}

/**
 * Information about the partner.
 */
model PartnerDetails {
  /**
   * This is short description about the partner. The length of this description should not exceed 256 characters.
   */
  description?: string;

  /**
   * Long description for the partner's scenarios and integration.Length of this description should not exceed 2048 characters.
   */
  longDescription?: string;

  /**
   * URI of the partner website that can be used by Azure customers to setup Event Grid
   * integration on an event source.
   */
  setupUri?: string;
}

/**
 * Namespace custom domain ownership validation result.
 */
model CustomDomainOwnershipValidationResult {
  /**
   * List of custom domain configurations for the namespace under topics configuration.
   */
  @identifiers(#[])
  customDomainsForTopicsConfiguration?: CustomDomainConfiguration[];

  /**
   * List of custom domain configurations for the namespace under topic spaces configuration.
   */
  @identifiers(#[])
  customDomainsForTopicSpacesConfiguration?: CustomDomainConfiguration[];
}

/**
 * Full endpoint URL of an event subscription
 */
model SubscriptionFullUrl {
  /**
   * The URL that represents the endpoint of the destination of an event subscription.
   */
  endpointUrl?: string;
}

/**
 * Properties of a partner destination webhook.
 */
model WebhookPartnerDestinationProperties {
  /**
   * The URL that represents the endpoint of the partner destination.
   */
  endpointUrl?: url;

  /**
   * The base URL that represents the endpoint of the partner destination.
   */
  endpointBaseUrl?: url;

  /**
   * Partner client authentication
   */
  clientAuthentication?: PartnerClientAuthentication;
}

/**
 * Partner client authentication
 */
@discriminator("clientAuthenticationType")
model PartnerClientAuthentication {
  /**
   * Type of client authentication
   */
  clientAuthenticationType: PartnerClientAuthenticationType = PartnerClientAuthenticationType.AzureAD;
}

/**
 * Properties of a Microsoft Entra ID Partner Client Authentication.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureADPartnerClientAuthenticationProperties {
  /**
   * The Microsoft Entra ID Tenant ID to get the access token that will be included as the bearer token in delivery requests.
   */
  azureActiveDirectoryTenantId?: string;

  /**
   * The Microsoft Entra ID Application ID or URI to get the access token that will be included as the bearer token in delivery requests.
   */
  azureActiveDirectoryApplicationIdOrUri?: string;
}

/**
 * Microsoft Entra ID Partner Client Authentication
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureADPartnerClientAuthentication extends PartnerClientAuthentication {
  /**
   * Microsoft Entra ID ClientAuthentication Properties
   */
  properties?: AzureADPartnerClientAuthenticationProperties;

  /**
   * Type of client authentication
   */
  clientAuthenticationType: "AzureAD";
}

/**
 * Information about the WebHook of the partner destination.
 */
model WebhookPartnerDestinationInfo extends PartnerDestinationInfo {
  /**
   * WebHook Properties of the partner destination.
   */
  properties?: WebhookPartnerDestinationProperties;

  /**
   * Change history of the resource move.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceMoveChangeHistory?: ResourceMoveChangeHistory[];

  /**
   * Type of the endpoint for the partner destination
   */
  endpointType: "WebHook";
}

/**
 * Information about the update of the WebHook of the partner destination.
 */
model WebhookUpdatePartnerDestinationInfo extends PartnerUpdateDestinationInfo {
  /**
   * WebHook Properties of the partner destination.
   */
  properties?: WebhookPartnerDestinationProperties;

  /**
   * Type of the endpoint for the partner destination
   */
  endpointType: "WebHook";
}

/**
 * This can be used to map properties of a source schema (or default values, for certain supported properties) to properties of the EventGridEvent schema.
 */
model JsonInputSchemaMappingProperties {
  /**
   * The mapping information for the Id property of the Event Grid Event.
   */
  id?: JsonField;

  /**
   * The mapping information for the Topic property of the Event Grid Event.
   */
  topic?: JsonField;

  /**
   * The mapping information for the EventTime property of the Event Grid Event.
   */
  eventTime?: JsonField;

  /**
   * The mapping information for the EventType property of the Event Grid Event.
   */
  eventType?: JsonFieldWithDefault;

  /**
   * The mapping information for the Subject property of the Event Grid Event.
   */
  subject?: JsonFieldWithDefault;

  /**
   * The mapping information for the DataVersion property of the Event Grid Event.
   */
  dataVersion?: JsonFieldWithDefault;
}

/**
 * This is used to express the source of an input schema mapping for a single target field in the Event Grid Event schema. This is currently used in the mappings for the 'id', 'topic' and 'eventtime' properties. This represents a field in the input event schema.
 */
model JsonField {
  /**
   * Name of a field in the input event schema that's to be used as the source of a mapping.
   */
  sourceField?: string;
}

/**
 * This is used to express the source of an input schema mapping for a single target field
 * in the Event Grid Event schema. This is currently used in the mappings for the 'subject',
 * 'eventtype' and 'dataversion' properties. This represents a field in the input event schema
 * along with a default value to be used, and at least one of these two properties should be provided.
 */
model JsonFieldWithDefault {
  /**
   * Name of a field in the input event schema that's to be used as the source of a mapping.
   */
  sourceField?: string;

  /**
   * The default value to be used for mapping when a SourceField is not provided or if there's no property with the specified name in the published JSON event payload.
   */
  defaultValue?: string;
}

/**
 * This enables publishing to Event Grid using a custom input schema. This can be used to map properties from a custom input JSON schema to the Event Grid event schema.
 */
model JsonInputSchemaMapping extends InputSchemaMapping {
  /**
   * JSON Properties of the input schema mapping
   */
  properties?: JsonInputSchemaMappingProperties;

  /**
   * Type of the custom mapping
   */
  inputSchemaMappingType: "Json";
}

/**
 * Properties of static delivery attribute mapping.
 */
model StaticDeliveryAttributeMappingProperties {
  /**
   * Value of the delivery attribute.
   */
  value?: string;

  /**
   * Boolean flag to tell if the attribute contains sensitive information .
   */
  @secret
  isSecret?: boolean = false;
}

/**
 * Static delivery attribute mapping details.
 */
model StaticDeliveryAttributeMapping extends DeliveryAttributeMapping {
  /**
   * Properties of static delivery attribute mapping.
   */
  properties?: StaticDeliveryAttributeMappingProperties;

  /**
   * Type of the delivery attribute or header name.
   */
  type: "Static";
}

/**
 * Properties of dynamic delivery attribute mapping.
 */
model DynamicDeliveryAttributeMappingProperties {
  /**
   * JSON path in the event which contains attribute value.
   */
  sourceField?: string;
}

/**
 * Dynamic delivery attribute mapping details.
 */
model DynamicDeliveryAttributeMapping extends DeliveryAttributeMapping {
  /**
   * Properties of dynamic delivery attribute mapping.
   */
  properties?: DynamicDeliveryAttributeMappingProperties;

  /**
   * Type of the delivery attribute or header name.
   */
  type: "Dynamic";
}

/**
 * Properties of the storage blob based dead letter destination.
 */
model StorageBlobDeadLetterDestinationProperties {
  /**
   * The Azure Resource ID of the storage account that is the destination of the deadletter events
   */
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  /**
   * The name of the Storage blob container that is the destination of the deadletter events
   */
  blobContainerName?: string;
}

/**
 * Information about the storage blob based dead letter destination.
 */
model StorageBlobDeadLetterDestination extends DeadLetterDestination {
  /**
   * The properties of the Storage Blob based deadletter destination
   */
  properties?: StorageBlobDeadLetterDestinationProperties;

  /**
   * Type of the endpoint for the dead letter destination
   */
  endpointType: "StorageBlob";
}

/**
 * NumberIn Filter.
 */
model NumberInFilter extends Filter {
  /**
   * The set of filter values.
   */
  values?: float64[];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "NumberIn";
}

/**
 * NumberNotIn Filter.
 */
model NumberNotInFilter extends Filter {
  /**
   * The set of filter values.
   */
  values?: float64[];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "NumberNotIn";
}

/**
 * NumberLessThan Filter.
 */
model NumberLessThanFilter extends Filter {
  /**
   * The filter value.
   */
  value?: float64;

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "NumberLessThan";
}

/**
 * NumberGreaterThan Filter.
 */
model NumberGreaterThanFilter extends Filter {
  /**
   * The filter value.
   */
  value?: float64;

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "NumberGreaterThan";
}

/**
 * NumberLessThanOrEquals Filter.
 */
model NumberLessThanOrEqualsFilter extends Filter {
  /**
   * The filter value.
   */
  value?: float64;

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "NumberLessThanOrEquals";
}

/**
 * NumberGreaterThanOrEquals Filter.
 */
model NumberGreaterThanOrEqualsFilter extends Filter {
  /**
   * The filter value.
   */
  value?: float64;

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "NumberGreaterThanOrEquals";
}

/**
 * BoolEquals Filter.
 */
model BoolEqualsFilter extends Filter {
  /**
   * The boolean filter value.
   */
  value?: boolean;

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "BoolEquals";
}

/**
 * StringIn Filter.
 */
model StringInFilter extends Filter {
  /**
   * The set of filter values.
   */
  values?: string[];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "StringIn";
}

/**
 * StringNotIn Filter.
 */
model StringNotInFilter extends Filter {
  /**
   * The set of filter values.
   */
  values?: string[];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "StringNotIn";
}

/**
 * StringBeginsWith Filter.
 */
model StringBeginsWithFilter extends Filter {
  /**
   * The set of filter values.
   */
  values?: string[];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "StringBeginsWith";
}

/**
 * StringEndsWith Filter.
 */
model StringEndsWithFilter extends Filter {
  /**
   * The set of filter values.
   */
  values?: string[];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "StringEndsWith";
}

/**
 * StringContains Filter.
 */
model StringContainsFilter extends Filter {
  /**
   * The set of filter values.
   */
  values?: string[];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "StringContains";
}

/**
 * NumberInRange Filter.
 */
model NumberInRangeFilter extends Filter {
  /**
   * The set of filter values.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  values?: float64[][];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "NumberInRange";
}

/**
 * NumberNotInRange Filter.
 */
model NumberNotInRangeFilter extends Filter {
  /**
   * The set of filter values.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  values?: float64[][];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "NumberNotInRange";
}

/**
 * StringNotBeginsWith Filter.
 */
model StringNotBeginsWithFilter extends Filter {
  /**
   * The set of filter values.
   */
  values?: string[];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "StringNotBeginsWith";
}

/**
 * StringNotEndsWith Filter.
 */
model StringNotEndsWithFilter extends Filter {
  /**
   * The set of filter values.
   */
  values?: string[];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "StringNotEndsWith";
}

/**
 * StringNotContains Filter.
 */
model StringNotContainsFilter extends Filter {
  /**
   * The set of filter values.
   */
  values?: string[];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "StringNotContains";
}

/**
 * IsNullOrUndefined Filter.
 */
model IsNullOrUndefinedFilter extends Filter {
  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "IsNullOrUndefined";
}

/**
 * IsNotNull Filter.
 */
model IsNotNullFilter extends Filter {
  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "IsNotNull";
}

/**
 * Information about the webhook destination properties for an event subscription.
 */
model WebHookEventSubscriptionDestinationProperties {
  /**
   * The URL that represents the endpoint of the destination of an event subscription.
   */
  @secret
  endpointUrl?: string;

  /**
   * The base URL that represents the endpoint of the destination of an event subscription.
   */
  @visibility(Lifecycle.Read)
  endpointBaseUrl?: string;

  /**
   * Maximum number of events per batch.
   */
  maxEventsPerBatch?: int32 = 1;

  /**
   * Preferred batch size in Kilobytes.
   */
  preferredBatchSizeInKilobytes?: int32 = 64;

  /**
   * The Microsoft Entra ID Tenant ID to get the access token that will be included as the bearer token in delivery requests.
   */
  azureActiveDirectoryTenantId?: string;

  /**
   * The Microsoft Entra ID Application ID or URI to get the access token that will be included as the bearer token in delivery requests.
   */
  azureActiveDirectoryApplicationIdOrUri?: string;

  /**
   * Delivery attribute details.
   */
  deliveryAttributeMappings?: DeliveryAttributeMapping[];

  /**
   * Minimum TLS version that should be supported by webhook endpoint
   */
  minimumTlsVersionAllowed?: TlsVersion;
}

/**
 * NumberIn Advanced Filter.
 */
model NumberInAdvancedFilter extends AdvancedFilter {
  /**
   * The set of filter values.
   */
  values?: float64[];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "NumberIn";
}

/**
 * NumberNotIn Advanced Filter.
 */
model NumberNotInAdvancedFilter extends AdvancedFilter {
  /**
   * The set of filter values.
   */
  values?: float64[];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "NumberNotIn";
}

/**
 * NumberLessThan Advanced Filter.
 */
model NumberLessThanAdvancedFilter extends AdvancedFilter {
  /**
   * The filter value.
   */
  value?: float64;

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "NumberLessThan";
}

/**
 * NumberGreaterThan Advanced Filter.
 */
model NumberGreaterThanAdvancedFilter extends AdvancedFilter {
  /**
   * The filter value.
   */
  value?: float64;

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "NumberGreaterThan";
}

/**
 * NumberLessThanOrEquals Advanced Filter.
 */
model NumberLessThanOrEqualsAdvancedFilter extends AdvancedFilter {
  /**
   * The filter value.
   */
  value?: float64;

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "NumberLessThanOrEquals";
}

/**
 * NumberGreaterThanOrEquals Advanced Filter.
 */
model NumberGreaterThanOrEqualsAdvancedFilter extends AdvancedFilter {
  /**
   * The filter value.
   */
  value?: float64;

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "NumberGreaterThanOrEquals";
}

/**
 * BoolEquals Advanced Filter.
 */
model BoolEqualsAdvancedFilter extends AdvancedFilter {
  /**
   * The boolean filter value.
   */
  value?: boolean;

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "BoolEquals";
}

/**
 * StringIn Advanced Filter.
 */
model StringInAdvancedFilter extends AdvancedFilter {
  /**
   * The set of filter values.
   */
  values?: string[];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "StringIn";
}

/**
 * StringNotIn Advanced Filter.
 */
model StringNotInAdvancedFilter extends AdvancedFilter {
  /**
   * The set of filter values.
   */
  values?: string[];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "StringNotIn";
}

/**
 * StringBeginsWith Advanced Filter.
 */
model StringBeginsWithAdvancedFilter extends AdvancedFilter {
  /**
   * The set of filter values.
   */
  values?: string[];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "StringBeginsWith";
}

/**
 * StringEndsWith Advanced Filter.
 */
model StringEndsWithAdvancedFilter extends AdvancedFilter {
  /**
   * The set of filter values.
   */
  values?: string[];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "StringEndsWith";
}

/**
 * StringContains Advanced Filter.
 */
model StringContainsAdvancedFilter extends AdvancedFilter {
  /**
   * The set of filter values.
   */
  values?: string[];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "StringContains";
}

/**
 * NumberInRange Advanced Filter.
 */
model NumberInRangeAdvancedFilter extends AdvancedFilter {
  /**
   * The set of filter values.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  values?: float64[][];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "NumberInRange";
}

/**
 * NumberNotInRange Advanced Filter.
 */
model NumberNotInRangeAdvancedFilter extends AdvancedFilter {
  /**
   * The set of filter values.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  values?: float64[][];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "NumberNotInRange";
}

/**
 * StringNotBeginsWith Advanced Filter.
 */
model StringNotBeginsWithAdvancedFilter extends AdvancedFilter {
  /**
   * The set of filter values.
   */
  values?: string[];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "StringNotBeginsWith";
}

/**
 * StringNotEndsWith Advanced Filter.
 */
model StringNotEndsWithAdvancedFilter extends AdvancedFilter {
  /**
   * The set of filter values.
   */
  values?: string[];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "StringNotEndsWith";
}

/**
 * StringNotContains Advanced Filter.
 */
model StringNotContainsAdvancedFilter extends AdvancedFilter {
  /**
   * The set of filter values.
   */
  values?: string[];

  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "StringNotContains";
}

/**
 * IsNullOrUndefined Advanced Filter.
 */
model IsNullOrUndefinedAdvancedFilter extends AdvancedFilter {
  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "IsNullOrUndefined";
}

/**
 * IsNotNull Advanced Filter.
 */
model IsNotNullAdvancedFilter extends AdvancedFilter {
  /**
   * The operator type used for filtering, e.g., NumberIn, StringContains, BoolEquals and others.
   */
  operatorType: "IsNotNull";
}

/**
 * Information about the webhook destination for an event subscription.
 */
model WebHookEventSubscriptionDestination extends EventSubscriptionDestination {
  /**
   * WebHook Properties of the event subscription destination.
   */
  properties?: WebHookEventSubscriptionDestinationProperties;

  /**
   * Type of the endpoint for the event subscription destination.
   */
  endpointType: "WebHook";
}

/**
 * The properties for a event hub destination.
 */
model EventHubEventSubscriptionDestinationProperties {
  /**
   * The Azure Resource Id that represents the endpoint of an Event Hub destination of an event subscription.
   */
  resourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Delivery attribute details.
   */
  deliveryAttributeMappings?: DeliveryAttributeMapping[];
}

/**
 * Information about the event hub destination for an event subscription.
 */
model EventHubEventSubscriptionDestination
  extends EventSubscriptionDestination {
  /**
   * Event Hub Properties of the event subscription destination.
   */
  properties?: EventHubEventSubscriptionDestinationProperties;

  /**
   * Type of the endpoint for the event subscription destination.
   */
  endpointType: "EventHub";
}

/**
 * The properties for a storage queue destination.
 */
model StorageQueueEventSubscriptionDestinationProperties {
  /**
   * The Azure Resource ID of the storage account that contains the queue that is the destination of an event subscription.
   */
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts/queues";
    }
  ]>;

  /**
   * The name of the Storage queue under a storage account that is the destination of an event subscription.
   */
  queueName?: string;

  /**
   * Storage queue message time to live in seconds. This value cannot be zero or negative with the exception of using -1 to indicate that the Time To Live of the message is Infinite.
   */
  queueMessageTimeToLiveInSeconds?: int64;
}

/**
 * Information about the storage queue destination for an event subscription.
 */
model StorageQueueEventSubscriptionDestination
  extends EventSubscriptionDestination {
  /**
   * Storage Queue Properties of the event subscription destination.
   */
  properties?: StorageQueueEventSubscriptionDestinationProperties;

  /**
   * Type of the endpoint for the event subscription destination.
   */
  endpointType: "StorageQueue";
}

/**
 * The properties for a hybrid connection destination.
 */
model HybridConnectionEventSubscriptionDestinationProperties {
  /**
   * The Azure Resource ID of an hybrid connection that is the destination of an event subscription.
   */
  resourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Delivery attribute details.
   */
  deliveryAttributeMappings?: DeliveryAttributeMapping[];
}

/**
 * Information about the HybridConnection destination for an event subscription.
 */
model HybridConnectionEventSubscriptionDestination
  extends EventSubscriptionDestination {
  /**
   * Hybrid connection Properties of the event subscription destination.
   */
  properties?: HybridConnectionEventSubscriptionDestinationProperties;

  /**
   * Type of the endpoint for the event subscription destination.
   */
  endpointType: "HybridConnection";
}

/**
 * The properties that represent the Service Bus destination of an event subscription.
 */
model ServiceBusQueueEventSubscriptionDestinationProperties {
  /**
   * The Azure Resource Id that represents the endpoint of the Service Bus destination of an event subscription.
   */
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ServiceBus/namespaces/queues";
    }
  ]>;

  /**
   * Delivery attribute details.
   */
  deliveryAttributeMappings?: DeliveryAttributeMapping[];
}

/**
 * Information about the service bus destination for an event subscription.
 */
model ServiceBusQueueEventSubscriptionDestination
  extends EventSubscriptionDestination {
  /**
   * Service Bus Properties of the event subscription destination.
   */
  properties?: ServiceBusQueueEventSubscriptionDestinationProperties;

  /**
   * Type of the endpoint for the event subscription destination.
   */
  endpointType: "ServiceBusQueue";
}

/**
 * The properties that represent the Service Bus Topic destination of an event subscription.
 */
model ServiceBusTopicEventSubscriptionDestinationProperties {
  /**
   * The Azure Resource Id that represents the endpoint of the Service Bus Topic destination of an event subscription.
   */
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ServiceBus/namespaces/topics";
    }
  ]>;

  /**
   * Delivery attribute details.
   */
  deliveryAttributeMappings?: DeliveryAttributeMapping[];
}

/**
 * Information about the service bus topic destination for an event subscription.
 */
model ServiceBusTopicEventSubscriptionDestination
  extends EventSubscriptionDestination {
  /**
   * Service Bus Topic Properties of the event subscription destination.
   */
  properties?: ServiceBusTopicEventSubscriptionDestinationProperties;

  /**
   * Type of the endpoint for the event subscription destination.
   */
  endpointType: "ServiceBusTopic";
}

/**
 * The properties that represent the Azure Function destination of an event subscription.
 */
model AzureFunctionEventSubscriptionDestinationProperties {
  /**
   * The Azure Resource Id that represents the endpoint of the Azure Function destination of an event subscription.
   */
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Web/sites/functions";
    }
  ]>;

  /**
   * Maximum number of events per batch.
   */
  maxEventsPerBatch?: int32 = 1;

  /**
   * Preferred batch size in Kilobytes.
   */
  preferredBatchSizeInKilobytes?: int32 = 64;

  /**
   * Delivery attribute details.
   */
  deliveryAttributeMappings?: DeliveryAttributeMapping[];
}

/**
 * Information about the azure function destination for an event subscription.
 */
model AzureFunctionEventSubscriptionDestination
  extends EventSubscriptionDestination {
  /**
   * Azure Function Properties of the event subscription destination.
   */
  properties?: AzureFunctionEventSubscriptionDestinationProperties;

  /**
   * Type of the endpoint for the event subscription destination.
   */
  endpointType: "AzureFunction";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PartnerEventSubscriptionDestinationProperties {
  /**
   * The Azure Resource Id that represents the endpoint of a Partner Destination of an event subscription.
   */
  resourceId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PartnerEventSubscriptionDestination extends EventSubscriptionDestination {
  /**
   * Partner Destination Properties of the event subscription destination.
   */
  properties?: PartnerEventSubscriptionDestinationProperties;

  /**
   * Type of the endpoint for the event subscription destination.
   */
  endpointType: "PartnerDestination";
}

/**
 * The properties that represent the Monitor Alert destination of an event subscription.
 */
model MonitorAlertEventSubscriptionDestinationProperties {
  /**
   * The severity that will be attached to every Alert fired through this event subscription.
   * This field must be provided.
   */
  severity?: MonitorAlertSeverity;

  /**
   * The description that will be attached to every Alert fired through this event subscription.
   */
  description?: string;

  /**
   * The list of ARM Ids of Action Groups that will be triggered on every Alert fired through this event subscription.
   * Each resource ARM Id should follow this pattern: /subscriptions/{AzureSubscriptionId}/resourceGroups/{ResourceGroupName}/providers/Microsoft.Insights/actionGroups/{ActionGroupName}.
   */
  actionGroups?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Insights/actiongroups";
    }
  ]>[];
}

/**
 * Information about the Monitor Alert destination for an event subscription.
 */
model MonitorAlertEventSubscriptionDestination
  extends EventSubscriptionDestination {
  /**
   * Monitor Alert properties of the event subscription destination.
   */
  properties?: MonitorAlertEventSubscriptionDestinationProperties;

  /**
   * Type of the endpoint for the event subscription destination.
   */
  endpointType: "MonitorAlert";
}

/**
 * The properties that represent the Event Grid Namespace Topic destination of an event subscription.
 */
model NamespaceTopicEventSubscriptionDestinationProperties {
  /**
   * The Azure resource Id that represents the endpoint of the Event Grid Namespace Topic destination of an event subscription.
   * This field is required and the Namespace Topic resource listed must already exist.
   * The resource ARM Id should follow this pattern: /subscriptions/{AzureSubscriptionId}/resourceGroups/{ResourceGroupName}/providers/Microsoft.EventGrid/namespaces/{NamespaceName}/topics/{TopicName}.
   */
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.EventGrid/namespaces/topics";
    }
  ]>;
}

/**
 * Information about the Namespace Topic destination for an event subscription.
 */
model NamespaceTopicEventSubscriptionDestination
  extends EventSubscriptionDestination {
  /**
   * Namespace Topic properties of the event subscription destination.
   */
  properties?: NamespaceTopicEventSubscriptionDestinationProperties;

  /**
   * Type of the endpoint for the event subscription destination.
   */
  endpointType: "NamespaceTopic";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticStringRoutingEnrichment extends StaticRoutingEnrichment {
  /**
   * String type routing enrichment value.
   */
  value?: string;

  /**
   * Static routing enrichment value type. For e.g. this property value can be 'String'.
   */
  valueType: "String";
}
