import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ServiceBus;

interface Operations extends Azure.ResourceManager.Operations {}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum TlsVersion {
  `1.0`,
  `1.1`,
  `1.2`,
}

enum ServiceBusPrivateLinkConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

enum ServiceBusPrivateEndpointConnectionProvisioningState {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Canceled,
  Failed,
}

enum PublicNetworkAccess {
  Enabled,
  Disabled,
  SecuredByPerimeter,
}

enum MigrationConfigurationName {
  $default,
}

enum ServiceBusNetworkRuleSetDefaultAction {
  Allow,
  Deny,
}

enum ServiceBusNetworkRuleIPAction {
  Allow,
}

enum ServiceBusPublicNetworkAccessFlag {
  Enabled,
  Disabled,
}
@Azure.Core.fixed
enum SkuName {
  Basic,
  Standard,
  Premium,
}
@Azure.Core.fixed
enum SkuTier {
  Basic,
  Standard,
  Premium,
}
@Azure.Core.fixed
enum ManagedServiceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}
@Azure.Core.fixed
enum ServiceBusDisasterRecoveryProvisioningState {
  Accepted,
  Succeeded,
  Failed,
}
@Azure.Core.fixed
enum ServiceBusDisasterRecoveryRole {
  Primary,
  PrimaryNotReplicating,
  Secondary,
}
@Azure.Core.fixed
enum ServiceBusAccessRight {
  Manage,
  Send,
  Listen,
}
@Azure.Core.fixed
enum ServiceBusAccessKeyType {
  PrimaryKey,
  SecondaryKey,
}
@Azure.Core.fixed
enum EntityStatus {
  Active,
  Disabled,
  Restoring,
  SendDisabled,
  ReceiveDisabled,
  Creating,
  Deleting,
  Renaming,
  Unknown,
}
@Azure.Core.fixed
enum FilterType {
  SqlFilter,
  CorrelationFilter,
}
@Azure.Core.fixed
enum UnavailableReason {
  None,
  InvalidName,
  SubscriptionIsDisabled,
  NameInUse,
  NameInLockdown,
  TooManyNamespaceInCurrentSubscription,
}

@doc("SKU of the namespace.")
model Sku {
  @doc("Name of this SKU.")
  name: SkuName;

  @doc("The billing tier of this particular SKU.")
  tier?: SkuTier;

  @doc("Messaging units for your service bus premium namespace. Valid capacities are {1, 2, 4, 8, 16} multiples of your properties.premiumMessagingPartitions setting. For example, If properties.premiumMessagingPartitions is 1 then possible capacity values are 1, 2, 4, 8, and 16. If properties.premiumMessagingPartitions is 4 then possible capacity values are 4, 8, 16, 32 and 64")
  capacity?: int32;
}

@doc("Properties to configure User Assigned Identities for Bring your Own Keys")
model Identity {
  @doc("ObjectId from the KeyVault")
  @visibility("read")
  principalId?: string;

  @doc("TenantId from the KeyVault")
  @visibility("read")
  tenantId?: string;

  @doc("Type of managed service identity.")
  type?: ManagedServiceIdentityType;

  @doc("Properties for User Assigned Identities")
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

@doc("Properties of the namespace.")
model SBNamespaceProperties {
  @doc("The minimum TLS version for the cluster to support, e.g. '1.2'")
  minimumTlsVersion?: TlsVersion;

  @doc("Provisioning state of the namespace.")
  @visibility("read")
  provisioningState?: string;

  @doc("Status of the namespace.")
  @visibility("read")
  status?: string;

  @doc("The time the namespace was created")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The time the namespace was updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  @doc("Endpoint you can use to perform Service Bus operations.")
  @visibility("read")
  serviceBusEndpoint?: string;

  @doc("Identifier for Azure Insights metrics")
  @visibility("read")
  metricId?: string;

  @doc("Enabling this property creates a Premium Service Bus Namespace in regions supported availability zones.")
  @visibility("read", "create")
  zoneRedundant?: boolean;

  @doc("Properties of BYOK Encryption description")
  encryption?: ServiceBusEncryption;

  @doc("List of private endpoint connections.")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("This property disables SAS authentication for the Service Bus namespace.")
  disableLocalAuth?: boolean;

  @doc("Alternate name for namespace")
  alternateName?: string;

  @doc("This determines if traffic is allowed over public network. By default it is enabled.")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("The number of partitions of a Service Bus namespace. This property is only applicable to Premium SKU namespaces. The default value is 1 and possible values are 1, 2 and 4")
  premiumMessagingPartitions?: int32;
}

@doc("Properties to configure Encryption")
model ServiceBusEncryption {
  @doc("Properties of KeyVault")
  keyVaultProperties?: ServiceBusKeyVaultProperties[];

  @doc("Enumerates the possible value of keySource for Encryption")
  keySource?: "Microsoft.KeyVault";

  @doc("Enable Infrastructure Encryption (Double Encryption)")
  requireInfrastructureEncryption?: boolean;
}

@doc("Properties to configure keyVault Properties")
model ServiceBusKeyVaultProperties {
  @doc("Name of the Key from KeyVault")
  keyName?: string;

  @doc("Uri of KeyVault")
  keyVaultUri?: string;

  @doc("Version of KeyVault")
  keyVersion?: string;

  identity?: UserAssignedIdentityProperties;
}

model UserAssignedIdentityProperties {
  @doc("ARM ID of user Identity selected for encryption")
  userAssignedIdentity?: string;
}

@doc("Properties of the private endpoint connection resource.")
model PrivateEndpointConnectionProperties {
  @doc("The Private Endpoint resource for this Connection.")
  privateEndpoint?: PrivateEndpoint;

  @doc("Details about the state of the connection.")
  privateLinkServiceConnectionState?: ServiceBusPrivateLinkServiceConnectionState;

  @doc("Provisioning state of the Private Endpoint Connection.")
  provisioningState?: ServiceBusPrivateEndpointConnectionProvisioningState;
}

@doc("PrivateEndpoint information.")
model PrivateEndpoint {
  @doc("The ARM identifier for Private Endpoint.")
  id?: string;
}

@doc("ConnectionState information.")
model ServiceBusPrivateLinkServiceConnectionState {
  @doc("Status of the connection.")
  status?: ServiceBusPrivateLinkConnectionStatus;

  @doc("Description of the connection state.")
  description?: string;
}

@doc("The Resource definition for other than namespace.")
model Resource {
  @doc("Resource Id")
  @visibility("read")
  id?: string;

  @doc("Resource name")
  @visibility("read")
  name?: string;

  @doc("Resource type")
  @visibility("read")
  type?: string;
}

@doc("The error object.")
model ErrorResponseError {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error target.")
  @visibility("read")
  target?: string;

  @doc("The error details.")
  @visibility("read")
  details?: ErrorResponse[];

  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("Description of a namespace resource.")
model ServiceBusNamespaceUpdateParameters extends ResourceNamespacePatch {
  @doc("Properties of SKU")
  sku?: Sku;

  @doc("Properties of the namespace.")
  properties?: SBNamespaceUpdateProperties;

  @doc("Properties of BYOK Identity description")
  identity?: Identity;
}

@doc("Properties of the namespace.")
model SBNamespaceUpdateProperties {
  @doc("Provisioning state of the namespace.")
  @visibility("read")
  provisioningState?: string;

  @doc("Status of the namespace.")
  @visibility("read")
  status?: string;

  @doc("The time the namespace was created")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The time the namespace was updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  @doc("Endpoint you can use to perform Service Bus operations.")
  @visibility("read")
  serviceBusEndpoint?: string;

  @doc("Identifier for Azure Insights metrics")
  @visibility("read")
  metricId?: string;

  @doc("Properties of BYOK Encryption description")
  encryption?: ServiceBusEncryption;

  @doc("List of private endpoint connections.")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("This property disables SAS authentication for the Service Bus namespace.")
  disableLocalAuth?: boolean;

  @doc("Alternate name for namespace")
  alternateName?: string;
}

@doc("The Resource definition.")
model ResourceNamespacePatch extends Resource {
  @doc("Resource location")
  location?: string;

  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("Result of the List private link resources operation.")
model PrivateLinkResourcesListResult {
  @doc("A collection of private link resources")
  value?: PrivateLinkResource[];

  @doc("A link for the next page of private link resources.")
  nextLink?: string;
}

@doc("Information of the private link resource.")
model PrivateLinkResource {
  @doc("Properties of the private link resource.")
  properties?: PrivateLinkResourceProperties;

  @doc("Fully qualified identifier of the resource.")
  id?: string;

  @doc("Name of the resource")
  name?: string;

  @doc("Type of the resource")
  type?: string;
}

@doc("Properties of PrivateLinkResource")
model PrivateLinkResourceProperties {
  groupId?: string;

  @doc("Required Members")
  requiredMembers?: string[];

  @doc("Required Zone Names")
  requiredZoneNames?: string[];
}

@doc("Properties required to the Create Or Update Alias(Disaster Recovery configurations)")
model ArmDisasterRecoveryProperties {
  @doc("Provisioning state of the Alias(Disaster Recovery configuration) - possible values 'Accepted' or 'Succeeded' or 'Failed'")
  @visibility("read")
  provisioningState?: ServiceBusDisasterRecoveryProvisioningState;

  @doc("Number of entities pending to be replicated.")
  @visibility("read")
  pendingReplicationOperationsCount?: int32;

  @doc("ARM Id of the Primary/Secondary eventhub namespace name, which is part of GEO DR pairing")
  partnerNamespace?: string;

  @doc("Primary/Secondary eventhub namespace name, which is part of GEO DR pairing")
  alternateName?: string;

  @doc("role of namespace in GEO DR - possible values 'Primary' or 'PrimaryNotReplicating' or 'Secondary'")
  @visibility("read")
  role?: ServiceBusDisasterRecoveryRole;
}

@doc("Safe failover is to indicate the service should wait for pending replication to finish before switching to the secondary.")
model FailoverProperties {
  @doc("Safe failover is to indicate the service should wait for pending replication to finish before switching to the secondary.")
  properties?: FailoverPropertiesProperties;
}

@doc("Safe failover is to indicate the service should wait for pending replication to finish before switching to the secondary.")
model FailoverPropertiesProperties {
  @doc("Safe failover is to indicate the service should wait for pending replication to finish before switching to the secondary.")
  IsSafeFailover?: boolean;
}

@doc("Properties required to the Create Migration Configuration")
model MigrationConfigPropertiesProperties {
  @doc("Provisioning state of Migration Configuration ")
  @visibility("read")
  provisioningState?: string;

  @doc("Number of entities pending to be replicated.")
  @visibility("read")
  pendingReplicationOperationsCount?: int32;

  @doc("Existing premium Namespace ARM Id name which has no entities, will be used for migration")
  @projectedName("json", "targetNamespace")
  targetServiceBusNamespace: string;

  @doc("Name to access Standard Namespace after migration")
  postMigrationName: string;

  @doc("State in which Standard to Premium Migration is, possible values : Unknown, Reverting, Completing, Initiating, Syncing, Active")
  @visibility("read")
  migrationState?: string;
}

@doc("NetworkRuleSet properties")
model NetworkRuleSetProperties {
  @doc("Value that indicates whether Trusted Service Access is Enabled or not.")
  trustedServiceAccessEnabled?: boolean;

  @doc("Default Action for Network Rule Set")
  defaultAction?: ServiceBusNetworkRuleSetDefaultAction;

  @doc("List VirtualNetwork Rules")
  virtualNetworkRules?: ServiceBusNetworkRuleSetVirtualNetworkRules[];

  @doc("List of IpRules")
  ipRules?: ServiceBusNetworkRuleSetIPRules[];

  @doc("This determines if traffic is allowed over public network. By default it is enabled.")
  publicNetworkAccess?: ServiceBusPublicNetworkAccessFlag;
}

@doc("Description of VirtualNetworkRules - NetworkRules resource.")
model ServiceBusNetworkRuleSetVirtualNetworkRules {
  @doc("Subnet properties")
  subnet?: Subnet;

  @doc("Value that indicates whether to ignore missing VNet Service Endpoint")
  ignoreMissingVnetServiceEndpoint?: boolean;
}

@doc("Properties supplied for Subnet")
model Subnet {
  @doc("Resource ID of Virtual Network Subnet")
  id: string;
}

@doc("Description of NetWorkRuleSet - IpRules resource.")
model ServiceBusNetworkRuleSetIPRules {
  @doc("IP Mask")
  ipMask?: string;

  @doc("The IP Filter Action")
  action?: ServiceBusNetworkRuleIPAction;
}

@doc("AuthorizationRule properties.")
model SBAuthorizationRuleProperties {
  @doc("The rights associated with the rule.")
  rights: ServiceBusAccessRight[];
}

@doc("Namespace/ServiceBus Connection String")
model ServiceBusAccessKeys {
  @doc("Primary connection string of the created namespace authorization rule.")
  @visibility("read")
  primaryConnectionString?: string;

  @doc("Secondary connection string of the created namespace authorization rule.")
  @visibility("read")
  secondaryConnectionString?: string;

  @doc("Primary connection string of the alias if GEO DR is enabled")
  @visibility("read")
  aliasPrimaryConnectionString?: string;

  @doc("Secondary  connection string of the alias if GEO DR is enabled")
  @visibility("read")
  aliasSecondaryConnectionString?: string;

  @doc("A base64-encoded 256-bit primary key for signing and validating the SAS token.")
  @visibility("read")
  primaryKey?: string;

  @doc("A base64-encoded 256-bit primary key for signing and validating the SAS token.")
  @visibility("read")
  secondaryKey?: string;

  @doc("A string that describes the authorization rule.")
  @visibility("read")
  keyName?: string;
}

@doc("Parameters supplied to the Regenerate Authorization Rule operation, specifies which key needs to be reset.")
model ServiceBusRegenerateAccessKeyContent {
  @doc("The access key to regenerate.")
  keyType: ServiceBusAccessKeyType;

  @doc("Optional, if the key value provided, is reset for KeyType value or autogenerate Key value set for keyType")
  key?: string;
}

@doc("The Queue Properties definition.")
model SBQueueProperties {
  @doc("Message Count Details.")
  @visibility("read")
  countDetails?: MessageCountDetails;

  @doc("The exact time the message was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The exact time the message was updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  @doc("Last time a message was sent, or the last time there was a receive request to this queue.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  accessedAt?: utcDateTime;

  @doc("The size of the queue, in bytes.")
  @visibility("read")
  sizeInBytes?: int32;

  @doc("The number of messages in the queue.")
  @visibility("read")
  messageCount?: int32;

  @doc("ISO 8601 timespan duration of a peek-lock; that is, the amount of time that the message is locked for other receivers. The maximum value for LockDuration is 5 minutes; the default value is 1 minute.")
  lockDuration?: duration;

  @doc("The maximum size of the queue in megabytes, which is the size of memory allocated for the queue. Default is 1024.")
  maxSizeInMegabytes?: int32;

  @doc("Maximum size (in KB) of the message payload that can be accepted by the queue. This property is only used in Premium today and default is 1024.")
  maxMessageSizeInKilobytes?: int32;

  @doc("A value indicating if this queue requires duplicate detection.")
  requiresDuplicateDetection?: boolean;

  @doc("A value that indicates whether the queue supports the concept of sessions.")
  requiresSession?: boolean;

  @doc("ISO 8601 default message timespan to live value. This is the duration after which the message expires, starting from when the message is sent to Service Bus. This is the default value used when TimeToLive is not set on a message itself.")
  defaultMessageTimeToLive?: duration;

  @doc("A value that indicates whether this queue has dead letter support when a message expires.")
  deadLetteringOnMessageExpiration?: boolean;

  @doc("ISO 8601 timeSpan structure that defines the duration of the duplicate detection history. The default value is 10 minutes.")
  duplicateDetectionHistoryTimeWindow?: duration;

  @doc("The maximum delivery count. A message is automatically deadlettered after this number of deliveries. default value is 10.")
  maxDeliveryCount?: int32;

  @doc("Enumerates the possible values for the status of a messaging entity.")
  status?: EntityStatus;

  @doc("Value that indicates whether server-side batched operations are enabled.")
  enableBatchedOperations?: boolean;

  @doc("ISO 8061 timeSpan idle interval after which the queue is automatically deleted. The minimum duration is 5 minutes.")
  autoDeleteOnIdle?: duration;

  @doc("A value that indicates whether the queue is to be partitioned across multiple message brokers.")
  enablePartitioning?: boolean;

  @doc("A value that indicates whether Express Entities are enabled. An express queue holds a message in memory temporarily before writing it to persistent storage.")
  enableExpress?: boolean;

  @doc("Queue/Topic name to forward the messages")
  forwardTo?: string;

  @doc("Queue/Topic name to forward the Dead Letter message")
  forwardDeadLetteredMessagesTo?: string;
}

@doc("Message Count Details.")
model MessageCountDetails {
  @doc("Number of active messages in the queue, topic, or subscription.")
  @visibility("read")
  activeMessageCount?: int32;

  @doc("Number of messages that are dead lettered.")
  @visibility("read")
  deadLetterMessageCount?: int32;

  @doc("Number of scheduled messages.")
  @visibility("read")
  scheduledMessageCount?: int32;

  @doc("Number of messages transferred to another queue, topic, or subscription.")
  @visibility("read")
  transferMessageCount?: int32;

  @doc("Number of messages transferred into dead letters.")
  @visibility("read")
  transferDeadLetterMessageCount?: int32;
}

@doc("The Topic Properties definition.")
model SBTopicProperties {
  @doc("Size of the topic, in bytes.")
  @visibility("read")
  sizeInBytes?: int32;

  @doc("Exact time the message was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The exact time the message was updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  @doc("Last time the message was sent, or a request was received, for this topic.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  accessedAt?: utcDateTime;

  @doc("Number of subscriptions.")
  @visibility("read")
  subscriptionCount?: int32;

  @doc("Message count details")
  @visibility("read")
  countDetails?: MessageCountDetails;

  @doc("ISO 8601 Default message timespan to live value. This is the duration after which the message expires, starting from when the message is sent to Service Bus. This is the default value used when TimeToLive is not set on a message itself.")
  defaultMessageTimeToLive?: duration;

  @doc("Maximum size of the topic in megabytes, which is the size of the memory allocated for the topic. Default is 1024.")
  maxSizeInMegabytes?: int32;

  @doc("Maximum size (in KB) of the message payload that can be accepted by the topic. This property is only used in Premium today and default is 1024.")
  maxMessageSizeInKilobytes?: int32;

  @doc("Value indicating if this topic requires duplicate detection.")
  requiresDuplicateDetection?: boolean;

  @doc("ISO8601 timespan structure that defines the duration of the duplicate detection history. The default value is 10 minutes.")
  duplicateDetectionHistoryTimeWindow?: duration;

  @doc("Value that indicates whether server-side batched operations are enabled.")
  enableBatchedOperations?: boolean;

  @doc("Enumerates the possible values for the status of a messaging entity.")
  status?: EntityStatus;

  @doc("Value that indicates whether the topic supports ordering.")
  supportOrdering?: boolean;

  @doc("ISO 8601 timespan idle interval after which the topic is automatically deleted. The minimum duration is 5 minutes.")
  autoDeleteOnIdle?: duration;

  @doc("Value that indicates whether the topic to be partitioned across multiple message brokers is enabled.")
  enablePartitioning?: boolean;

  @doc("Value that indicates whether Express Entities are enabled. An express topic holds a message in memory temporarily before writing it to persistent storage.")
  enableExpress?: boolean;
}

@doc("Description of Rule Resource.")
model Ruleproperties {
  @doc("Represents the filter actions which are allowed for the transformation of a message that have been matched by a filter expression.")
  action?: FilterAction;

  @doc("Filter type that is evaluated against a BrokeredMessage.")
  filterType?: FilterType;

  @doc("Properties of sqlFilter")
  sqlFilter?: SqlFilter;

  @doc("Properties of correlationFilter")
  correlationFilter?: CorrelationFilter;
}

@doc("Represents the filter actions which are allowed for the transformation of a message that have been matched by a filter expression.")
model FilterAction {
  @doc("SQL expression. e.g. MyProperty='ABC'")
  sqlExpression?: string;

  @doc("This property is reserved for future use. An integer value showing the compatibility level, currently hard-coded to 20.")
  compatibilityLevel?: int32;

  @doc("Value that indicates whether the rule action requires preprocessing.")
  requiresPreprocessing?: boolean;
}

@doc("Represents a filter which is a composition of an expression and an action that is executed in the pub/sub pipeline.")
model SqlFilter {
  @doc("The SQL expression. e.g. MyProperty='ABC'")
  sqlExpression?: string;

  @doc("This property is reserved for future use. An integer value showing the compatibility level, currently hard-coded to 20.")
  compatibilityLevel?: int32;

  @doc("Value that indicates whether the rule action requires preprocessing.")
  requiresPreprocessing?: boolean;
}

@doc("Represents the correlation filter expression.")
model CorrelationFilter {
  @doc("dictionary object for custom filters")
  properties?: Record<string>;

  @doc("Identifier of the correlation.")
  correlationId?: string;

  @doc("Identifier of the message.")
  messageId?: string;

  @doc("Address to send to.")
  @projectedName("json", "to")
  sendTo?: string;

  @doc("Address of the queue to reply to.")
  replyTo?: string;

  @doc("Application specific label.")
  label?: string;

  @doc("Session identifier.")
  sessionId?: string;

  @doc("Session identifier to reply to.")
  replyToSessionId?: string;

  @doc("Content type of the message.")
  contentType?: string;

  @doc("Value that indicates whether the rule action requires preprocessing.")
  requiresPreprocessing?: boolean;
}

@doc("Description of Subscription Resource.")
model SBSubscriptionProperties {
  @doc("Number of messages.")
  @visibility("read")
  messageCount?: int32;

  @doc("Exact time the message was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("Last time there was a receive request to this subscription.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  accessedAt?: utcDateTime;

  @doc("The exact time the message was updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  @doc("Message count details")
  @visibility("read")
  countDetails?: MessageCountDetails;

  @doc("ISO 8061 lock duration timespan for the subscription. The default value is 1 minute.")
  lockDuration?: duration;

  @doc("Value indicating if a subscription supports the concept of sessions.")
  requiresSession?: boolean;

  @doc("ISO 8061 Default message timespan to live value. This is the duration after which the message expires, starting from when the message is sent to Service Bus. This is the default value used when TimeToLive is not set on a message itself.")
  defaultMessageTimeToLive?: duration;

  @doc("Value that indicates whether a subscription has dead letter support on filter evaluation exceptions.")
  deadLetteringOnFilterEvaluationExceptions?: boolean;

  @doc("Value that indicates whether a subscription has dead letter support when a message expires.")
  deadLetteringOnMessageExpiration?: boolean;

  @doc("ISO 8601 timeSpan structure that defines the duration of the duplicate detection history. The default value is 10 minutes.")
  duplicateDetectionHistoryTimeWindow?: duration;

  @doc("Number of maximum deliveries.")
  maxDeliveryCount?: int32;

  @doc("Enumerates the possible values for the status of a messaging entity.")
  status?: EntityStatus;

  @doc("Value that indicates whether server-side batched operations are enabled.")
  enableBatchedOperations?: boolean;

  @doc("ISO 8061 timeSpan idle interval after which the topic is automatically deleted. The minimum duration is 5 minutes.")
  autoDeleteOnIdle?: duration;

  @doc("Queue/Topic name to forward the messages")
  forwardTo?: string;

  @doc("Queue/Topic name to forward the Dead Letter message")
  forwardDeadLetteredMessagesTo?: string;

  @doc("Value that indicates whether the subscription has an affinity to the client id.")
  isClientAffine?: boolean;

  @doc("Properties specific to client affine subscriptions.")
  clientAffineProperties?: ServiceBusClientAffineProperties;
}

@doc("Properties specific to client affine subscriptions.")
model ServiceBusClientAffineProperties {
  @doc("Indicates the Client ID of the application that created the client-affine subscription.")
  clientId?: string;

  @doc("For client-affine subscriptions, this value indicates whether the subscription is durable or not.")
  isDurable?: boolean;

  @doc("For client-affine subscriptions, this value indicates whether the subscription is shared or not.")
  isShared?: boolean;
}

@doc("Description of a Check Name availability request properties.")
model ServiceBusNameAvailabilityContent {
  @doc("The Name to check the namespace name availability and The namespace name can contain only letters, numbers, and hyphens. The namespace must start with a letter, and it must end with a letter or number.")
  name: string;
}

@doc("Description of a Check Name availability request properties.")
model ServiceBusNameAvailabilityResult {
  @doc("The detailed info regarding the reason associated with the namespace.")
  @visibility("read")
  message?: string;

  @doc("Value indicating namespace is availability, true if the namespace is available; otherwise, false.")
  nameAvailable?: boolean;

  @doc("The reason for unavailability of a namespace.")
  reason?: UnavailableReason;
}

@doc("Represents set of actions written in SQL language-based syntax that is performed against a ServiceBus.Messaging.BrokeredMessage ")
model SqlRuleAction extends FilterAction {}