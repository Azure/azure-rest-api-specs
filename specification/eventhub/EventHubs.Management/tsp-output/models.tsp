import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.EventHub;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Name of this SKU.")
enum EventHubsClusterSkuName {
  Dedicated,
}

@doc("Name of this SKU.")
enum SkuName {
  Basic,
  Standard,
  Premium,
}

@doc("The minimum TLS version for the cluster to support, e.g. '1.2'")
enum TlsVersion {
  `1.0`,
  `1.1`,
  `1.2`,
}

@doc("This determines if traffic is allowed over public network. By default it is enabled.")
enum PublicNetworkAccess {
  Enabled,
  Disabled,
  SecuredByPerimeter,
}

@doc("Status of the connection.")
enum EventHubsPrivateLinkConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

@doc("Provisioning state of the Private Endpoint Connection.")
enum EventHubsPrivateEndpointConnectionProvisioningState {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Canceled,
  Failed,
}

@doc("Provisioning state of NetworkSecurityPerimeter configuration propagation")
enum NetworkSecurityPerimeterConfigurationProvisioningState {
  Unknown,
  Creating,
  Updating,
  Accepted,
  InvalidResponse,
  Succeeded,
  SucceededWithIssues,
  Failed,
  Deleting,
  Deleted,
  Canceled,
}

@doc("Access Mode of the resource association")
enum ResourceAssociationAccessMode {
  NoAssociationMode,
  EnforcedMode,
  LearningMode,
  AuditMode,
  UnspecifiedMode,
}

@doc("Direction of Access Rule")
enum NspAccessRuleDirection {
  Inbound,
  Outbound,
}

@doc("Default Action for Network Rule Set")
enum EventHubsNetworkRuleSetDefaultAction {
  Allow,
  Deny,
}

@doc("The IP Filter Action")
enum EventHubsNetworkRuleIPAction {
  Allow,
}

@doc("This determines if traffic is allowed over public network. By default it is enabled. If value is SecuredByPerimeter then Inbound and Outbound communication is controlled by the network security perimeter and profile's access rules. ")
enum EventHubsPublicNetworkAccessFlag {
  Enabled,
  Disabled,
  SecuredByPerimeter,
}

enum EventHubsAccessRight {
  Manage,
  Send,
  Listen,
}

@doc("The access key to regenerate.")
enum EventHubsAccessKeyType {
  PrimaryKey,
  SecondaryKey,
}

@doc("Enumerates the possible values for cleanup policy")
enum CleanupPolicyRetentionDescription {
  Delete,
  Compaction,
}

enum SchemaCompatibility {
  None,
  Backward,
  Forward,
}

enum SchemaType {
  Unknown,
  Avro,
}

@doc("Application Group Policy types")
enum ApplicationGroupPolicyType {
  ThrottlingPolicy,
}

@doc("Metric Id on which the throttle limit should be set, MetricId can be discovered by hovering over Metric in the Metrics section of Event Hub Namespace inside Azure Portal")
enum MetricId {
  IncomingBytes,
  OutgoingBytes,
  IncomingMessages,
  OutgoingMessages,
}

@doc("Type of managed service identity.")
@fixed
enum ManagedServiceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

@doc("Specifies the reason for the unavailability of the service.")
@fixed
enum UnavailableReason {
  None,
  InvalidName,
  SubscriptionIsDisabled,
  NameInUse,
  NameInLockdown,
  TooManyNamespaceInCurrentSubscription,
}

@doc("Provisioning state of the Alias(Disaster Recovery configuration) - possible values 'Accepted' or 'Succeeded' or 'Failed'")
@fixed
enum EventHubsDisasterRecoveryProvisioningState {
  Accepted,
  Succeeded,
  Failed,
}

@doc("role of namespace in GEO DR - possible values 'Primary' or 'PrimaryNotReplicating' or 'Secondary'")
@fixed
enum EventHubsDisasterRecoveryRole {
  Primary,
  PrimaryNotReplicating,
  Secondary,
}

@doc("Enumerates the possible values for the status of the Event Hub.")
@fixed
enum EventHubEntityStatus {
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

@doc("Enumerates the possible values for the encoding format of capture description. Note: 'AvroDeflate' will be deprecated in New API Version")
@fixed
enum EncodingCaptureDescription {
  Avro,
  AvroDeflate,
}

@doc("Pre-provisioned and readily available Event Hubs Cluster count per region.")
model AvailableCluster {
  @doc("Location fo the Available Cluster")
  location?: string;
}

@doc("SKU parameters particular to a cluster instance.")
model EventHubsClusterSku {
  @doc("Name of this SKU.")
  name: EventHubsClusterSkuName;

  @doc("The quantity of Event Hubs Cluster Capacity Units contained in this cluster.")
  @minValue(1)
  capacity?: int32;
}

@doc("Event Hubs Cluster properties supplied in responses in List or Get operations.")
model ClusterProperties {
  @doc("The UTC time when the Event Hubs Cluster was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The UTC time when the Event Hubs Cluster was last updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  @doc("The metric ID of the cluster resource. Provided by the service and not modifiable by the user.")
  @visibility("read")
  metricId?: string;

  @doc("Status of the Cluster resource")
  @visibility("read")
  status?: string;

  @doc("A value that indicates whether Scaling is Supported.")
  supportsScaling?: boolean;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("The response of the List Namespace IDs operation")
model EHNamespaceIdListResult {
  @doc("Result of the List Namespace IDs operation")
  value?: EHNamespaceIdContainer[];
}

@doc("The full ARM ID of an Event Hubs Namespace")
model EHNamespaceIdContainer {
  @doc("id parameter")
  id?: string;
}

@doc("SKU parameters supplied to the create namespace operation")
model Sku {
  @doc("Name of this SKU.")
  name: SkuName;

  @doc("The billing tier of this particular SKU.")
  tier?: SkuTier;

  @doc("The Event Hubs throughput units for Basic or Standard tiers, where value should be 0 to 20 throughput units. The Event Hubs premium units for Premium tier, where value should be 0 to 10 premium units.")
  capacity?: int32;
}

@doc("Properties to configure Identity for Bring your Own Keys")
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

@doc("Namespace properties supplied for create namespace operation.")
model EHNamespaceProperties {
  @doc("The minimum TLS version for the cluster to support, e.g. '1.2'")
  minimumTlsVersion?: TlsVersion;

  @doc("Provisioning state of the Namespace.")
  @visibility("read")
  provisioningState?: string;

  @doc("Status of the Namespace.")
  @visibility("read")
  status?: string;

  @doc("The time the Namespace was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The time the Namespace was updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  @doc("Endpoint you can use to perform Service Bus operations.")
  @visibility("read")
  serviceBusEndpoint?: string;

  @doc("Cluster ARM ID of the Namespace.")
  clusterArmId?: string;

  @doc("Identifier for Azure Insights metrics.")
  @visibility("read")
  metricId?: string;

  @doc("Value that indicates whether AutoInflate is enabled for eventhub namespace.")
  isAutoInflateEnabled?: boolean;

  @doc("This determines if traffic is allowed over public network. By default it is enabled.")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("Upper limit of throughput units when AutoInflate is enabled, value should be within 0 to 20 throughput units. ( '0' if AutoInflateEnabled = true)")
  maximumThroughputUnits?: int32;

  @doc("Value that indicates whether Kafka is enabled for eventhub namespace.")
  kafkaEnabled?: boolean;

  @doc("Enabling this property creates a Standard Event Hubs Namespace in regions supported availability zones.")
  zoneRedundant?: boolean;

  @doc("Properties of BYOK Encryption description")
  encryption?: EventHubsEncryption;

  @doc("List of private endpoint connections.")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("This property disables SAS authentication for the Event Hubs namespace.")
  disableLocalAuth?: boolean;

  @doc("Alternate name specified when alias and namespace names are same.")
  alternateName?: string;
}

@doc("Properties to configure Encryption")
model EventHubsEncryption {
  @doc("Properties of KeyVault")
  keyVaultProperties?: EventHubsKeyVaultProperties[];

  @doc("Enumerates the possible value of keySource for Encryption")
  keySource?: "Microsoft.KeyVault";

  @doc("Enable Infrastructure Encryption (Double Encryption)")
  requireInfrastructureEncryption?: boolean;
}

@doc("Properties to configure keyVault Properties")
model EventHubsKeyVaultProperties {
  @doc("Name of the Key from KeyVault")
  keyName?: string;

  @doc("Uri of KeyVault")
  keyVaultUri?: string;

  @doc("Key Version")
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
  privateLinkServiceConnectionState?: EventHubsPrivateLinkServiceConnectionState;

  @doc("Provisioning state of the Private Endpoint Connection.")
  provisioningState?: EventHubsPrivateEndpointConnectionProvisioningState;
}

@doc("PrivateEndpoint information.")
model PrivateEndpoint {
  @doc("The ARM identifier for Private Endpoint.")
  id?: string;
}

@doc("ConnectionState information.")
model EventHubsPrivateLinkServiceConnectionState {
  @doc("Status of the connection.")
  status?: EventHubsPrivateLinkConnectionStatus;

  @doc("Description of the connection state.")
  description?: string;
}

@doc("Result of the List private link resources operation.")
model PrivateLinkResourcesListResult {
  @doc("A collection of private link resources")
  value?: EventHubsPrivateLinkResourceData[];

  @doc("A link for the next page of private link resources.")
  nextLink?: string;
}

@doc("Information of the private link resource.")
model EventHubsPrivateLinkResourceData {
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
  @doc("The private link resource group id.")
  groupId?: string;

  @doc("The private link resource required member names.")
  requiredMembers?: string[];

  @doc("The private link resource Private link DNS zone name.")
  requiredZoneNames?: string[];
}

@doc("Result of the List NetworkSecurityPerimeterConfiguration operation.")
model NetworkSecurityPerimeterConfigurationList {
  @doc("A collection of NetworkSecurityPerimeterConfigurations")
  @visibility("read")
  value?: NetworkSecurityPerimeterConfiguration[];
}

@doc("Network Security Perimeter related configurations of a given namespace")
model NetworkSecurityPerimeterConfiguration extends TrackedResource {
  @doc("Properties of the Network Security Perimeter Configuration")
  @visibility("read")
  properties?: NetworkSecurityPerimeterConfigurationProperties;
}

@doc("Properties of NetworkSecurityPerimeterConfiguration")
model NetworkSecurityPerimeterConfigurationProperties {
  @doc("Provisioning state of NetworkSecurityPerimeter configuration propagation")
  provisioningState?: NetworkSecurityPerimeterConfigurationProvisioningState;

  @doc("List of Provisioning Issues if any")
  provisioningIssues?: ProvisioningIssue[];

  @doc("NetworkSecurityPerimeter related information")
  @visibility("read")
  networkSecurityPerimeter?: NetworkSecurityPerimeter;

  @doc("Information about resource association")
  @visibility("read")
  resourceAssociation?: NetworkSecurityPerimeterConfigurationPropertiesResourceAssociation;

  @doc("Information about current network profile")
  @visibility("read")
  profile?: NetworkSecurityPerimeterConfigurationPropertiesProfile;
}

@doc("Describes Provisioning issue for given NetworkSecurityPerimeterConfiguration")
model ProvisioningIssue {
  @doc("Name of the issue")
  name?: string;

  @doc("Properties of Provisioning Issue")
  @visibility("read")
  properties?: ProvisioningIssueProperties;
}

@doc("Properties of Provisioning Issue")
model ProvisioningIssueProperties {
  @doc("Type of Issue")
  issueType?: string;

  @doc("Description of the issue")
  description?: string;
}

@doc("NetworkSecurityPerimeter related information")
model NetworkSecurityPerimeter {
  @doc("Fully qualified identifier of the resource")
  id?: string;

  @doc("Guid of the resource")
  perimeterGuid?: string;

  @doc("Location of the resource")
  location?: string;
}

@doc("Information about resource association")
model NetworkSecurityPerimeterConfigurationPropertiesResourceAssociation {
  @doc("Name of the resource association")
  name?: string;

  @doc("Access Mode of the resource association")
  accessMode?: ResourceAssociationAccessMode;
}

@doc("Information about current network profile")
model NetworkSecurityPerimeterConfigurationPropertiesProfile {
  @doc("Name of the resource")
  name?: string;

  @doc("Current access rules version")
  accessRulesVersion?: string;

  @doc("List of Access Rules")
  accessRules?: NspAccessRule[];
}

@doc("Information of Access Rule in Network Profile")
model NspAccessRule {
  @doc("Fully qualified identifier of the resource")
  id?: string;

  @doc("Name of the resource")
  name?: string;

  @doc("Type of the resource")
  type?: string;

  @doc("Properties of Access Rule")
  @visibility("read")
  properties?: NspAccessRuleProperties;
}

@doc("Properties of Access Rule")
model NspAccessRuleProperties {
  @doc("Direction of Access Rule")
  direction?: NspAccessRuleDirection;

  @doc("Address prefixes in the CIDR format for inbound rules")
  addressPrefixes?: string[];

  @doc("Subscriptions for inbound rules")
  subscriptions?: NspAccessRulePropertiesSubscriptionsItem[];

  @doc("NetworkSecurityPerimeters for inbound rules")
  @visibility("read")
  networkSecurityPerimeters?: NetworkSecurityPerimeter[];

  @doc("FQDN for outbound rules")
  @visibility("read")
  fullyQualifiedDomainNames?: string[];
}

@doc("Subscription for inbound rule")
model NspAccessRulePropertiesSubscriptionsItem {
  @doc("Fully qualified identifier of subscription")
  id?: string;
}

@doc("Contains all settings for the cluster.")
model ClusterQuotaConfigurationProperties {
  @doc("All possible Cluster settings - a collection of key/value paired settings which apply to quotas and configurations imposed on the cluster.")
  settings?: Record<string>;
}

@doc("NetworkRuleSet properties")
model NetworkRuleSetProperties {
  @doc("Value that indicates whether Trusted Service Access is Enabled or not.")
  trustedServiceAccessEnabled?: boolean;

  @doc("Default Action for Network Rule Set")
  defaultAction?: EventHubsNetworkRuleSetDefaultAction;

  @doc("List VirtualNetwork Rules")
  virtualNetworkRules?: EventHubsNetworkRuleSetVirtualNetworkRules[];

  @doc("List of IpRules")
  ipRules?: EventHubsNetworkRuleSetIPRules[];

  @doc("This determines if traffic is allowed over public network. By default it is enabled. If value is SecuredByPerimeter then Inbound and Outbound communication is controlled by the network security perimeter and profile's access rules. ")
  publicNetworkAccess?: EventHubsPublicNetworkAccessFlag;
}

@doc("The response from the List namespace operation.")
model EventHubsNetworkRuleSetVirtualNetworkRules {
  @doc("Subnet properties")
  subnet?: Subnet;

  @doc("Value that indicates whether to ignore missing Vnet Service Endpoint")
  ignoreMissingVnetServiceEndpoint?: boolean;
}

@doc("Properties supplied for Subnet")
model Subnet {
  @doc("Resource ID of Virtual Network Subnet")
  id?: string;
}

@doc("The response from the List namespace operation.")
model EventHubsNetworkRuleSetIPRules {
  @doc("IP Mask")
  ipMask?: string;

  @doc("The IP Filter Action")
  action?: EventHubsNetworkRuleIPAction;
}

@doc("Properties supplied to create or update AuthorizationRule")
model AuthorizationRuleProperties {
  @doc("The rights associated with the rule.")
  rights: EventHubsAccessRight[];
}

@doc("Namespace/EventHub Connection String")
model EventHubsAccessKeys {
  @doc("Primary connection string of the created namespace AuthorizationRule.")
  @visibility("read")
  primaryConnectionString?: string;

  @doc("Secondary connection string of the created namespace AuthorizationRule.")
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

  @doc("A string that describes the AuthorizationRule.")
  @visibility("read")
  keyName?: string;
}

@doc("Parameters supplied to the Regenerate Authorization Rule operation, specifies which key needs to be reset.")
model EventHubsRegenerateAccessKeyContent {
  @doc("The access key to regenerate.")
  keyType: EventHubsAccessKeyType;

  @doc("Optional, if the key value provided, is set for KeyType or autogenerated Key value set for keyType")
  key?: string;
}

@doc("Parameter supplied to check Namespace name availability operation ")
model EventHubsNameAvailabilityContent {
  @doc("Name to check the namespace name availability")
  name: string;
}

@doc("The Result of the CheckNameAvailability operation")
model EventHubsNameAvailabilityResult {
  @doc("The detailed info regarding the reason associated with the Namespace.")
  @visibility("read")
  message?: string;

  @doc("Value indicating Namespace is availability, true if the Namespace is available; otherwise, false.")
  nameAvailable?: boolean;

  @doc("The reason for unavailability of a Namespace.")
  reason?: UnavailableReason;
}

@doc("Single item in List or Get Consumer group operation")
model ConsumerGroupProperties {
  @doc("Exact time the message was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The exact time the message was updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  @doc("User Metadata is a placeholder to store user-defined string data with maximum length 1024. e.g. it can be used to store descriptive data, such as list of teams and their contact information also user-defined configuration settings can be stored.")
  userMetadata?: string;
}

@doc("Properties required to the Create Or Update Alias(Disaster Recovery configurations)")
model ArmDisasterRecoveryProperties {
  @doc("Provisioning state of the Alias(Disaster Recovery configuration) - possible values 'Accepted' or 'Succeeded' or 'Failed'")
  @visibility("read")
  provisioningState?: EventHubsDisasterRecoveryProvisioningState;

  @doc("ARM Id of the Primary/Secondary eventhub namespace name, which is part of GEO DR pairing")
  partnerNamespace?: string;

  @doc("Alternate name specified when alias and namespace names are same.")
  alternateName?: string;

  @doc("role of namespace in GEO DR - possible values 'Primary' or 'PrimaryNotReplicating' or 'Secondary'")
  @visibility("read")
  role?: EventHubsDisasterRecoveryRole;

  @doc("Number of entities pending to be replicated.")
  @visibility("read")
  pendingReplicationOperationsCount?: int32;
}

@doc("Properties supplied to the Create Or Update Event Hub operation.")
model EventhubProperties {
  @doc("Current number of shards on the Event Hub.")
  @visibility("read")
  partitionIds?: string[];

  @doc("Exact time the Event Hub was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The exact time the message was updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  @doc("Number of partitions created for the Event Hub, allowed values are from 1 to 32 partitions.")
  @minValue(1)
  partitionCount?: int32;

  @doc("Enumerates the possible values for the status of the Event Hub.")
  status?: EventHubEntityStatus;

  @doc("Properties of capture description")
  captureDescription?: CaptureDescription;

  @doc("Event Hub retention settings")
  retentionDescription?: RetentionDescription;
}

@doc("Properties to configure capture description for eventhub")
model CaptureDescription {
  @doc("A value that indicates whether capture description is enabled. ")
  enabled?: boolean;

  @doc("Enumerates the possible values for the encoding format of capture description. Note: 'AvroDeflate' will be deprecated in New API Version")
  encoding?: EncodingCaptureDescription;

  @doc("The time window allows you to set the frequency with which the capture to Azure Blobs will happen, value should between 60 to 900 seconds")
  intervalInSeconds?: int32;

  @doc("The size window defines the amount of data built up in your Event Hub before an capture operation, value should be between 10485760 to 524288000 bytes")
  sizeLimitInBytes?: int32;

  @doc("Properties of Destination where capture will be stored. (Storage Account, Blob Names)")
  destination?: EventHubDestination;

  @doc("A value that indicates whether to Skip Empty Archives")
  skipEmptyArchives?: boolean;
}

@doc("Capture storage details for capture description")
model EventHubDestination {
  @doc("Name for capture destination")
  name?: string;

  @doc("Properties describing the storage account, blob container and archive name format for capture destination")
  properties?: DestinationProperties;
}

@doc("Properties describing the storage account, blob container and archive name format for capture destination")
model DestinationProperties {
  @doc("Resource id of the storage account to be used to create the blobs")
  storageAccountResourceId?: string;

  @doc("Blob container Name")
  blobContainer?: string;

  @doc("Blob naming convention for archive, e.g. {Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}. Here all the parameters (Namespace,EventHub .. etc) are mandatory irrespective of order")
  archiveNameFormat?: string;

  @doc("Subscription Id of Azure Data Lake Store")
  dataLakeSubscriptionId?: string;

  @doc("The Azure Data Lake Store name for the captured events")
  dataLakeAccountName?: string;

  @doc("The destination folder path for the captured events")
  dataLakeFolderPath?: string;
}

@doc("Properties to configure retention settings for the  eventhub")
model RetentionDescription {
  @doc("Enumerates the possible values for cleanup policy")
  cleanupPolicy?: CleanupPolicyRetentionDescription;

  @doc("Number of hours to retain the events for this Event Hub. This value is only used when cleanupPolicy is Delete. If cleanupPolicy is Compaction the returned value of this property is Long.MaxValue ")
  retentionTimeInHours?: int32;

  @doc("Number of hours to retain the tombstone markers of a compacted Event Hub. This value is only used when cleanupPolicy is Compaction. Consumer must complete reading the tombstone marker within this specified amount of time if consumer begins from starting offset to ensure they get a valid snapshot for the specific key described by the tombstone marker within the compacted Event Hub")
  tombstoneRetentionTimeInHours?: int32;
}

model SchemaGroupProperties {
  @doc("Exact time the Schema Group was updated")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAtUtc?: utcDateTime;

  @doc("Exact time the Schema Group was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAtUtc?: utcDateTime;

  @doc("The ETag value.")
  @visibility("read")
  eTag?: string;

  @doc("dictionary object for SchemaGroup group properties")
  groupProperties?: Record<string>;

  schemaCompatibility?: SchemaCompatibility;
  schemaType?: SchemaType;
}

model ApplicationGroupProperties {
  @doc("Determines if Application Group is allowed to create connection with namespace or not. Once the isEnabled is set to false, all the existing connections of application group gets dropped and no new connections will be allowed")
  isEnabled?: boolean;

  @doc("The Unique identifier for application group.Supports SAS(SASKeyName=KeyName) or AAD(AADAppID=Guid)")
  clientAppGroupIdentifier: string;

  @doc("List of group policies that define the behavior of application group. The policies can support resource governance scenarios such as limiting ingress or egress traffic.")
  policies?: EventHubsApplicationGroupPolicy[];
}

@doc("Properties of the Application Group policy")
@discriminator("type")
model EventHubsApplicationGroupPolicy {
  @doc("The Name of this policy")
  name: string;
}

@doc("Properties of the throttling policy")
model EventHubsThrottlingPolicy extends EventHubsApplicationGroupPolicy {
  @doc("The Threshold limit above which the application group will be throttled.Rate limit is always per second.")
  rateLimitThreshold: int32;

  @doc("Metric Id on which the throttle limit should be set, MetricId can be discovered by hovering over Metric in the Metrics section of Event Hub Namespace inside Azure Portal")
  metricId: MetricId;

  @doc("Application Group Policy types")
  type: "ThrottlingPolicy";
}
