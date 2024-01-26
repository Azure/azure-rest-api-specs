import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ServiceBus;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The minimum TLS version for the cluster to support, e.g. '1.2'
 */
enum TlsVersion {
  `1.0`,
  `1.1`,
  `1.2`,
}

/**
 * Status of the connection.
 */
enum ServiceBusPrivateLinkConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

/**
 * Provisioning state of the Private Endpoint Connection.
 */
enum ServiceBusPrivateEndpointConnectionProvisioningState {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Canceled,
  Failed,
}

/**
 * This determines if traffic is allowed over public network. By default it is enabled.
 */
enum PublicNetworkAccess {
  Enabled,
  Disabled,
  SecuredByPerimeter,
}

enum MigrationConfigurationName {
  $default,
}

/**
 * Default Action for Network Rule Set
 */
enum ServiceBusNetworkRuleSetDefaultAction {
  Allow,
  Deny,
}

/**
 * The IP Filter Action
 */
enum ServiceBusNetworkRuleIPAction {
  Allow,
}

/**
 * This determines if traffic is allowed over public network. By default it is enabled.
 */
enum ServiceBusPublicNetworkAccessFlag {
  Enabled,
  Disabled,
}

/**
 * Name of this SKU.
 */
@fixed
enum SkuName {
  Basic,
  Standard,
  Premium,
}

/**
 * The billing tier of this particular SKU.
 */
@fixed
enum SkuTier {
  Basic,
  Standard,
  Premium,
}

/**
 * Type of managed service identity.
 */
@fixed
enum ManagedServiceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

/**
 * Provisioning state of the Alias(Disaster Recovery configuration) - possible values 'Accepted' or 'Succeeded' or 'Failed'
 */
@fixed
enum ServiceBusDisasterRecoveryProvisioningState {
  Accepted,
  Succeeded,
  Failed,
}

/**
 * role of namespace in GEO DR - possible values 'Primary' or 'PrimaryNotReplicating' or 'Secondary'
 */
@fixed
enum ServiceBusDisasterRecoveryRole {
  Primary,
  PrimaryNotReplicating,
  Secondary,
}

@fixed
enum ServiceBusAccessRight {
  Manage,
  Send,
  Listen,
}

/**
 * The access key to regenerate.
 */
@fixed
enum ServiceBusAccessKeyType {
  PrimaryKey,
  SecondaryKey,
}

/**
 * Entity status.
 */
@fixed
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

/**
 * Rule filter types
 */
@fixed
enum FilterType {
  SqlFilter,
  CorrelationFilter,
}

/**
 * Specifies the reason for the unavailability of the service.
 */
@fixed
enum UnavailableReason {
  None,
  InvalidName,
  SubscriptionIsDisabled,
  NameInUse,
  NameInLockdown,
  TooManyNamespaceInCurrentSubscription,
}

/**
 * SKU of the namespace.
 */
model Sku {
  /**
   * Name of this SKU.
   */
  name: SkuName;

  /**
   * The billing tier of this particular SKU.
   */
  tier?: SkuTier;

  /**
   * Messaging units for your service bus premium namespace. Valid capacities are {1, 2, 4, 8, 16} multiples of your properties.premiumMessagingPartitions setting. For example, If properties.premiumMessagingPartitions is 1 then possible capacity values are 1, 2, 4, 8, and 16. If properties.premiumMessagingPartitions is 4 then possible capacity values are 4, 8, 16, 32 and 64
   */
  capacity?: int32;
}

/**
 * Properties to configure User Assigned Identities for Bring your Own Keys
 */
model Identity {
  /**
   * ObjectId from the KeyVault
   */
  @visibility("read")
  principalId?: string;

  /**
   * TenantId from the KeyVault
   */
  @visibility("read")
  tenantId?: string;

  /**
   * Type of managed service identity.
   */
  type?: ManagedServiceIdentityType;

  /**
   * Properties for User Assigned Identities
   */
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Recognized Dictionary value.
 */
model UserAssignedIdentity {
  /**
   * Principal Id of user assigned identity
   */
  @visibility("read")
  principalId?: string;

  /**
   * Client Id of user assigned identity
   */
  @visibility("read")
  clientId?: string;
}

/**
 * Properties of the namespace.
 */
model SBNamespaceProperties {
  /**
   * The minimum TLS version for the cluster to support, e.g. '1.2'
   */
  minimumTlsVersion?: TlsVersion;

  /**
   * Provisioning state of the namespace.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Status of the namespace.
   */
  @visibility("read")
  status?: string;

  /**
   * The time the namespace was created
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The time the namespace was updated.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  /**
   * Endpoint you can use to perform Service Bus operations.
   */
  @visibility("read")
  serviceBusEndpoint?: string;

  /**
   * Identifier for Azure Insights metrics
   */
  @visibility("read")
  metricId?: string;

  /**
   * Enabling this property creates a Premium Service Bus Namespace in regions supported availability zones.
   */
  @visibility("read", "create")
  zoneRedundant?: boolean;

  /**
   * Properties of BYOK Encryption description
   */
  encryption?: ServiceBusEncryption;

  /**
   * List of private endpoint connections.
   */
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * This property disables SAS authentication for the Service Bus namespace.
   */
  disableLocalAuth?: boolean;

  /**
   * Alternate name for namespace
   */
  alternateName?: string;

  /**
   * This determines if traffic is allowed over public network. By default it is enabled.
   */
  publicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.Enabled;

  /**
   * The number of partitions of a Service Bus namespace. This property is only applicable to Premium SKU namespaces. The default value is 1 and possible values are 1, 2 and 4
   */
  premiumMessagingPartitions?: int32;
}

/**
 * Properties to configure Encryption
 */
model ServiceBusEncryption {
  /**
   * Properties of KeyVault
   */
  keyVaultProperties?: ServiceBusKeyVaultProperties[];

  /**
   * Enumerates the possible value of keySource for Encryption
   */
  keySource?: "Microsoft.KeyVault" = "Microsoft.KeyVault";

  /**
   * Enable Infrastructure Encryption (Double Encryption)
   */
  requireInfrastructureEncryption?: boolean;
}

/**
 * Properties to configure keyVault Properties
 */
model ServiceBusKeyVaultProperties {
  /**
   * Name of the Key from KeyVault
   */
  keyName?: string;

  /**
   * Uri of KeyVault
   */
  keyVaultUri?: string;

  /**
   * Version of KeyVault
   */
  keyVersion?: string;

  identity?: UserAssignedIdentityProperties;
}

model UserAssignedIdentityProperties {
  /**
   * ARM ID of user Identity selected for encryption
   */
  userAssignedIdentity?: string;
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
   * Details about the state of the connection.
   */
  privateLinkServiceConnectionState?: ServiceBusPrivateLinkServiceConnectionState;

  /**
   * Provisioning state of the Private Endpoint Connection.
   */
  provisioningState?: ServiceBusPrivateEndpointConnectionProvisioningState;
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
model ServiceBusPrivateLinkServiceConnectionState {
  /**
   * Status of the connection.
   */
  status?: ServiceBusPrivateLinkConnectionStatus;

  /**
   * Description of the connection state.
   */
  description?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model ProxyResource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.EventHub/Namespaces" or "Microsoft.EventHub/Namespaces/EventHubs"
   */
  @visibility("read")
  type?: string;

  /**
   * The geo-location where the resource lives
   */
  @visibility("read")
  location?: string;
}

/**
 * The Resource definition.
 */
model TrackedResource extends Resource {
  /**
   * The Geo-location where the resource lives
   */
  @visibility("read", "create")
  location: string;

  /**
   * Resource tags
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;
}

/**
 * The Resource definition for other than namespace.
 */
model Resource {
  /**
   * Resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;
}

/**
 * The error object.
 */
model ErrorResponseError {
  /**
   * The error code.
   */
  @visibility("read")
  code?: string;

  /**
   * The error message.
   */
  @visibility("read")
  message?: string;

  /**
   * The error target.
   */
  @visibility("read")
  target?: string;

  /**
   * The error details.
   */
  @visibility("read")
  details?: ErrorResponse[];

  /**
   * The error additional info.
   */
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

/**
 * Description of a namespace resource.
 */
model ServiceBusNamespaceUpdateParameters extends ResourceNamespacePatch {
  /**
   * Properties of SKU
   */
  sku?: Sku;

  /**
   * Properties of the namespace.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SBNamespaceUpdateProperties;

  /**
   * Properties of BYOK Identity description
   */
  identity?: Identity;
}

/**
 * Properties of the namespace.
 */
model SBNamespaceUpdateProperties {
  /**
   * Provisioning state of the namespace.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Status of the namespace.
   */
  @visibility("read")
  status?: string;

  /**
   * The time the namespace was created
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The time the namespace was updated.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  /**
   * Endpoint you can use to perform Service Bus operations.
   */
  @visibility("read")
  serviceBusEndpoint?: string;

  /**
   * Identifier for Azure Insights metrics
   */
  @visibility("read")
  metricId?: string;

  /**
   * Properties of BYOK Encryption description
   */
  encryption?: ServiceBusEncryption;

  /**
   * List of private endpoint connections.
   */
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * This property disables SAS authentication for the Service Bus namespace.
   */
  disableLocalAuth?: boolean;

  /**
   * Alternate name for namespace
   */
  alternateName?: string;
}

/**
 * The Resource definition.
 */
model ResourceNamespacePatch extends Resource {
  /**
   * Resource location
   */
  location?: string;

  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * Result of the List private link resources operation.
 */
model PrivateLinkResourcesListResult {
  /**
   * A collection of private link resources
   */
  value?: PrivateLinkResource[];

  /**
   * A link for the next page of private link resources.
   */
  nextLink?: string;
}

/**
 * Information of the private link resource.
 */
model PrivateLinkResource {
  /**
   * Properties of the private link resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PrivateLinkResourceProperties;

  /**
   * Fully qualified identifier of the resource.
   */
  id?: string;

  /**
   * Name of the resource
   */
  name?: string;

  /**
   * Type of the resource
   */
  type?: string;
}

/**
 * Properties of PrivateLinkResource
 */
model PrivateLinkResourceProperties {
  groupId?: string;

  /**
   * Required Members
   */
  requiredMembers?: string[];

  /**
   * Required Zone Names
   */
  requiredZoneNames?: string[];
}

/**
 * Properties required to the Create Or Update Alias(Disaster Recovery configurations)
 */
model ArmDisasterRecoveryProperties {
  /**
   * Provisioning state of the Alias(Disaster Recovery configuration) - possible values 'Accepted' or 'Succeeded' or 'Failed'
   */
  @visibility("read")
  provisioningState?: ServiceBusDisasterRecoveryProvisioningState;

  /**
   * Number of entities pending to be replicated.
   */
  @visibility("read")
  pendingReplicationOperationsCount?: int64;

  /**
   * ARM Id of the Primary/Secondary eventhub namespace name, which is part of GEO DR pairing
   */
  partnerNamespace?: string;

  /**
   * Primary/Secondary eventhub namespace name, which is part of GEO DR pairing
   */
  alternateName?: string;

  /**
   * role of namespace in GEO DR - possible values 'Primary' or 'PrimaryNotReplicating' or 'Secondary'
   */
  @visibility("read")
  role?: ServiceBusDisasterRecoveryRole;
}

/**
 * Safe failover is to indicate the service should wait for pending replication to finish before switching to the secondary.
 */
model FailoverProperties {
  /**
   * Safe failover is to indicate the service should wait for pending replication to finish before switching to the secondary.
   */
  @extension("x-ms-client-flatten", true)
  properties?: FailoverPropertiesProperties;
}

/**
 * Safe failover is to indicate the service should wait for pending replication to finish before switching to the secondary.
 */
model FailoverPropertiesProperties {
  /**
   * Safe failover is to indicate the service should wait for pending replication to finish before switching to the secondary.
   */
  IsSafeFailover?: boolean;
}

/**
 * Properties required to the Create Migration Configuration
 */
model MigrationConfigPropertiesProperties {
  /**
   * Provisioning state of Migration Configuration
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Number of entities pending to be replicated.
   */
  @visibility("read")
  pendingReplicationOperationsCount?: int64;

  /**
   * Existing premium Namespace ARM Id name which has no entities, will be used for migration
   */
  @projectedName("json", "targetNamespace")
  targetServiceBusNamespace: string;

  /**
   * Name to access Standard Namespace after migration
   */
  postMigrationName: string;

  /**
   * State in which Standard to Premium Migration is, possible values : Unknown, Reverting, Completing, Initiating, Syncing, Active
   */
  @visibility("read")
  migrationState?: string;
}

/**
 * NetworkRuleSet properties
 */
model NetworkRuleSetProperties {
  /**
   * Value that indicates whether Trusted Service Access is Enabled or not.
   */
  trustedServiceAccessEnabled?: boolean;

  /**
   * Default Action for Network Rule Set
   */
  defaultAction?: ServiceBusNetworkRuleSetDefaultAction;

  /**
   * List VirtualNetwork Rules
   */
  virtualNetworkRules?: ServiceBusNetworkRuleSetVirtualNetworkRules[];

  /**
   * List of IpRules
   */
  ipRules?: ServiceBusNetworkRuleSetIPRules[];

  /**
   * This determines if traffic is allowed over public network. By default it is enabled.
   */
  publicNetworkAccess?: ServiceBusPublicNetworkAccessFlag = ServiceBusPublicNetworkAccessFlag.Enabled;
}

/**
 * Description of VirtualNetworkRules - NetworkRules resource.
 */
model ServiceBusNetworkRuleSetVirtualNetworkRules {
  /**
   * Subnet properties
   */
  subnet?: Subnet;

  /**
   * Value that indicates whether to ignore missing VNet Service Endpoint
   */
  ignoreMissingVnetServiceEndpoint?: boolean;
}

/**
 * Properties supplied for Subnet
 */
model Subnet {
  /**
   * Resource ID of Virtual Network Subnet
   */
  id: string;
}

/**
 * Description of NetWorkRuleSet - IpRules resource.
 */
model ServiceBusNetworkRuleSetIPRules {
  /**
   * IP Mask
   */
  ipMask?: string;

  /**
   * The IP Filter Action
   */
  action?: ServiceBusNetworkRuleIPAction = ServiceBusNetworkRuleIPAction.Allow;
}

/**
 * AuthorizationRule properties.
 */
model SBAuthorizationRuleProperties {
  /**
   * The rights associated with the rule.
   */
  rights: ServiceBusAccessRight[];
}

/**
 * Namespace/ServiceBus Connection String
 */
model ServiceBusAccessKeys {
  /**
   * Primary connection string of the created namespace authorization rule.
   */
  @visibility("read")
  primaryConnectionString?: string;

  /**
   * Secondary connection string of the created namespace authorization rule.
   */
  @visibility("read")
  secondaryConnectionString?: string;

  /**
   * Primary connection string of the alias if GEO DR is enabled
   */
  @visibility("read")
  aliasPrimaryConnectionString?: string;

  /**
   * Secondary  connection string of the alias if GEO DR is enabled
   */
  @visibility("read")
  aliasSecondaryConnectionString?: string;

  /**
   * A base64-encoded 256-bit primary key for signing and validating the SAS token.
   */
  @visibility("read")
  primaryKey?: string;

  /**
   * A base64-encoded 256-bit primary key for signing and validating the SAS token.
   */
  @visibility("read")
  secondaryKey?: string;

  /**
   * A string that describes the authorization rule.
   */
  @visibility("read")
  keyName?: string;
}

/**
 * Parameters supplied to the Regenerate Authorization Rule operation, specifies which key needs to be reset.
 */
model ServiceBusRegenerateAccessKeyContent {
  /**
   * The access key to regenerate.
   */
  keyType: ServiceBusAccessKeyType;

  /**
   * Optional, if the key value provided, is reset for KeyType value or autogenerate Key value set for keyType
   */
  key?: string;
}

/**
 * The Queue Properties definition.
 */
model SBQueueProperties {
  /**
   * Message Count Details.
   */
  @visibility("read")
  countDetails?: MessageCountDetails;

  /**
   * The exact time the message was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The exact time the message was updated.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  /**
   * Last time a message was sent, or the last time there was a receive request to this queue.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  accessedAt?: utcDateTime;

  /**
   * The size of the queue, in bytes.
   */
  @visibility("read")
  sizeInBytes?: int64;

  /**
   * The number of messages in the queue.
   */
  @visibility("read")
  messageCount?: int64;

  /**
   * ISO 8601 timespan duration of a peek-lock; that is, the amount of time that the message is locked for other receivers. The maximum value for LockDuration is 5 minutes; the default value is 1 minute.
   */
  lockDuration?: duration;

  /**
   * The maximum size of the queue in megabytes, which is the size of memory allocated for the queue. Default is 1024.
   */
  maxSizeInMegabytes?: int32;

  /**
   * Maximum size (in KB) of the message payload that can be accepted by the queue. This property is only used in Premium today and default is 1024.
   */
  maxMessageSizeInKilobytes?: int64;

  /**
   * A value indicating if this queue requires duplicate detection.
   */
  requiresDuplicateDetection?: boolean;

  /**
   * A value that indicates whether the queue supports the concept of sessions.
   */
  requiresSession?: boolean;

  /**
   * ISO 8601 default message timespan to live value. This is the duration after which the message expires, starting from when the message is sent to Service Bus. This is the default value used when TimeToLive is not set on a message itself.
   */
  defaultMessageTimeToLive?: duration;

  /**
   * A value that indicates whether this queue has dead letter support when a message expires.
   */
  deadLetteringOnMessageExpiration?: boolean;

  /**
   * ISO 8601 timeSpan structure that defines the duration of the duplicate detection history. The default value is 10 minutes.
   */
  duplicateDetectionHistoryTimeWindow?: duration;

  /**
   * The maximum delivery count. A message is automatically deadlettered after this number of deliveries. default value is 10.
   */
  maxDeliveryCount?: int32;

  /**
   * Enumerates the possible values for the status of a messaging entity.
   */
  status?: EntityStatus;

  /**
   * Value that indicates whether server-side batched operations are enabled.
   */
  enableBatchedOperations?: boolean;

  /**
   * ISO 8061 timeSpan idle interval after which the queue is automatically deleted. The minimum duration is 5 minutes.
   */
  autoDeleteOnIdle?: duration;

  /**
   * A value that indicates whether the queue is to be partitioned across multiple message brokers.
   */
  enablePartitioning?: boolean;

  /**
   * A value that indicates whether Express Entities are enabled. An express queue holds a message in memory temporarily before writing it to persistent storage.
   */
  enableExpress?: boolean;

  /**
   * Queue/Topic name to forward the messages
   */
  forwardTo?: string;

  /**
   * Queue/Topic name to forward the Dead Letter message
   */
  forwardDeadLetteredMessagesTo?: string;
}

/**
 * Message Count Details.
 */
model MessageCountDetails {
  /**
   * Number of active messages in the queue, topic, or subscription.
   */
  @visibility("read")
  activeMessageCount?: int64;

  /**
   * Number of messages that are dead lettered.
   */
  @visibility("read")
  deadLetterMessageCount?: int64;

  /**
   * Number of scheduled messages.
   */
  @visibility("read")
  scheduledMessageCount?: int64;

  /**
   * Number of messages transferred to another queue, topic, or subscription.
   */
  @visibility("read")
  transferMessageCount?: int64;

  /**
   * Number of messages transferred into dead letters.
   */
  @visibility("read")
  transferDeadLetterMessageCount?: int64;
}

/**
 * The Topic Properties definition.
 */
model SBTopicProperties {
  /**
   * Size of the topic, in bytes.
   */
  @visibility("read")
  sizeInBytes?: int64;

  /**
   * Exact time the message was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The exact time the message was updated.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  /**
   * Last time the message was sent, or a request was received, for this topic.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  accessedAt?: utcDateTime;

  /**
   * Number of subscriptions.
   */
  @visibility("read")
  subscriptionCount?: int32;

  /**
   * Message count details
   */
  @visibility("read")
  countDetails?: MessageCountDetails;

  /**
   * ISO 8601 Default message timespan to live value. This is the duration after which the message expires, starting from when the message is sent to Service Bus. This is the default value used when TimeToLive is not set on a message itself.
   */
  defaultMessageTimeToLive?: duration;

  /**
   * Maximum size of the topic in megabytes, which is the size of the memory allocated for the topic. Default is 1024.
   */
  maxSizeInMegabytes?: int32;

  /**
   * Maximum size (in KB) of the message payload that can be accepted by the topic. This property is only used in Premium today and default is 1024.
   */
  maxMessageSizeInKilobytes?: int64;

  /**
   * Value indicating if this topic requires duplicate detection.
   */
  requiresDuplicateDetection?: boolean;

  /**
   * ISO8601 timespan structure that defines the duration of the duplicate detection history. The default value is 10 minutes.
   */
  duplicateDetectionHistoryTimeWindow?: duration;

  /**
   * Value that indicates whether server-side batched operations are enabled.
   */
  enableBatchedOperations?: boolean;

  /**
   * Enumerates the possible values for the status of a messaging entity.
   */
  status?: EntityStatus;

  /**
   * Value that indicates whether the topic supports ordering.
   */
  supportOrdering?: boolean;

  /**
   * ISO 8601 timespan idle interval after which the topic is automatically deleted. The minimum duration is 5 minutes.
   */
  autoDeleteOnIdle?: duration;

  /**
   * Value that indicates whether the topic to be partitioned across multiple message brokers is enabled.
   */
  enablePartitioning?: boolean;

  /**
   * Value that indicates whether Express Entities are enabled. An express topic holds a message in memory temporarily before writing it to persistent storage.
   */
  enableExpress?: boolean;
}

/**
 * Description of Rule Resource.
 */
model Ruleproperties {
  /**
   * Represents the filter actions which are allowed for the transformation of a message that have been matched by a filter expression.
   */
  action?: FilterAction;

  /**
   * Filter type that is evaluated against a BrokeredMessage.
   */
  filterType?: FilterType;

  /**
   * Properties of sqlFilter
   */
  sqlFilter?: SqlFilter;

  /**
   * Properties of correlationFilter
   */
  correlationFilter?: CorrelationFilter;
}

/**
 * Represents the filter actions which are allowed for the transformation of a message that have been matched by a filter expression.
 */
model FilterAction {
  /**
   * SQL expression. e.g. MyProperty='ABC'
   */
  sqlExpression?: string;

  /**
   * This property is reserved for future use. An integer value showing the compatibility level, currently hard-coded to 20.
   */
  compatibilityLevel?: int32;

  /**
   * Value that indicates whether the rule action requires preprocessing.
   */
  requiresPreprocessing?: boolean = true;
}

/**
 * Represents a filter which is a composition of an expression and an action that is executed in the pub/sub pipeline.
 */
model SqlFilter {
  /**
   * The SQL expression. e.g. MyProperty='ABC'
   */
  sqlExpression?: string;

  /**
   * This property is reserved for future use. An integer value showing the compatibility level, currently hard-coded to 20.
   */
  compatibilityLevel?: int32;

  /**
   * Value that indicates whether the rule action requires preprocessing.
   */
  requiresPreprocessing?: boolean = true;
}

/**
 * Represents the correlation filter expression.
 */
model CorrelationFilter {
  /**
   * dictionary object for custom filters
   */
  properties?: Record<string>;

  /**
   * Identifier of the correlation.
   */
  correlationId?: string;

  /**
   * Identifier of the message.
   */
  messageId?: string;

  /**
   * Address to send to.
   */
  @projectedName("json", "to")
  sendTo?: string;

  /**
   * Address of the queue to reply to.
   */
  replyTo?: string;

  /**
   * Application specific label.
   */
  label?: string;

  /**
   * Session identifier.
   */
  sessionId?: string;

  /**
   * Session identifier to reply to.
   */
  replyToSessionId?: string;

  /**
   * Content type of the message.
   */
  contentType?: string;

  /**
   * Value that indicates whether the rule action requires preprocessing.
   */
  requiresPreprocessing?: boolean = true;
}

/**
 * Description of Subscription Resource.
 */
model SBSubscriptionProperties {
  /**
   * Number of messages.
   */
  @visibility("read")
  messageCount?: int64;

  /**
   * Exact time the message was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Last time there was a receive request to this subscription.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  accessedAt?: utcDateTime;

  /**
   * The exact time the message was updated.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  /**
   * Message count details
   */
  @visibility("read")
  countDetails?: MessageCountDetails;

  /**
   * ISO 8061 lock duration timespan for the subscription. The default value is 1 minute.
   */
  lockDuration?: duration;

  /**
   * Value indicating if a subscription supports the concept of sessions.
   */
  requiresSession?: boolean;

  /**
   * ISO 8061 Default message timespan to live value. This is the duration after which the message expires, starting from when the message is sent to Service Bus. This is the default value used when TimeToLive is not set on a message itself.
   */
  defaultMessageTimeToLive?: duration;

  /**
   * Value that indicates whether a subscription has dead letter support on filter evaluation exceptions.
   */
  deadLetteringOnFilterEvaluationExceptions?: boolean;

  /**
   * Value that indicates whether a subscription has dead letter support when a message expires.
   */
  deadLetteringOnMessageExpiration?: boolean;

  /**
   * ISO 8601 timeSpan structure that defines the duration of the duplicate detection history. The default value is 10 minutes.
   */
  duplicateDetectionHistoryTimeWindow?: duration;

  /**
   * Number of maximum deliveries.
   */
  maxDeliveryCount?: int32;

  /**
   * Enumerates the possible values for the status of a messaging entity.
   */
  status?: EntityStatus;

  /**
   * Value that indicates whether server-side batched operations are enabled.
   */
  enableBatchedOperations?: boolean;

  /**
   * ISO 8061 timeSpan idle interval after which the topic is automatically deleted. The minimum duration is 5 minutes.
   */
  autoDeleteOnIdle?: duration;

  /**
   * Queue/Topic name to forward the messages
   */
  forwardTo?: string;

  /**
   * Queue/Topic name to forward the Dead Letter message
   */
  forwardDeadLetteredMessagesTo?: string;

  /**
   * Value that indicates whether the subscription has an affinity to the client id.
   */
  isClientAffine?: boolean;

  /**
   * Properties specific to client affine subscriptions.
   */
  clientAffineProperties?: ServiceBusClientAffineProperties;
}

/**
 * Properties specific to client affine subscriptions.
 */
model ServiceBusClientAffineProperties {
  /**
   * Indicates the Client ID of the application that created the client-affine subscription.
   */
  clientId?: string;

  /**
   * For client-affine subscriptions, this value indicates whether the subscription is durable or not.
   */
  isDurable?: boolean;

  /**
   * For client-affine subscriptions, this value indicates whether the subscription is shared or not.
   */
  isShared?: boolean;
}

/**
 * Description of a Check Name availability request properties.
 */
model ServiceBusNameAvailabilityContent {
  /**
   * The Name to check the namespace name availability and The namespace name can contain only letters, numbers, and hyphens. The namespace must start with a letter, and it must end with a letter or number.
   */
  name: string;
}

/**
 * Description of a Check Name availability request properties.
 */
model ServiceBusNameAvailabilityResult {
  /**
   * The detailed info regarding the reason associated with the namespace.
   */
  @visibility("read")
  message?: string;

  /**
   * Value indicating namespace is availability, true if the namespace is available; otherwise, false.
   */
  nameAvailable?: boolean;

  /**
   * The reason for unavailability of a namespace.
   */
  reason?: UnavailableReason;
}

/**
 * Represents set of actions written in SQL language-based syntax that is performed against a ServiceBus.Messaging.BrokeredMessage
 */
model SqlRuleAction extends FilterAction {}
