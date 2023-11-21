import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace EventHubManagementClient;

enum ClusterSkuName {
  Dedicated,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum SkuName {
  Basic,
  Standard,
  Premium,
}

enum SkuTier {
  Basic,
  Standard,
  Premium,
}

enum TlsVersion {
  `1.0`,
  `1.1`,
  `1.2`,
}

enum PublicNetworkAccess {
  Enabled,
  Disabled,
  SecuredByPerimeter,
}

enum PrivateLinkConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

enum EndPointProvisioningState {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Canceled,
  Failed,
}

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

enum ResourceAssociationAccessMode {
  NoAssociationMode,
  EnforcedMode,
  LearningMode,
  AuditMode,
  UnspecifiedMode,
}

enum NspAccessRuleDirection {
  Inbound,
  Outbound,
}

enum DefaultAction {
  Allow,
  Deny,
}

enum NetworkRuleIPAction {
  Allow,
}

enum PublicNetworkAccessFlag {
  Enabled,
  Disabled,
  SecuredByPerimeter,
}

enum AccessRights {
  Manage,
  Send,
  Listen,
}

enum KeyType {
  PrimaryKey,
  SecondaryKey,
}

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

enum ApplicationGroupPolicyType {
  ThrottlingPolicy,
}

enum MetricId {
  IncomingBytes,
  OutgoingBytes,
  IncomingMessages,
  OutgoingMessages,
}
@Azure.Core.fixed
enum ManagedServiceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
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
@Azure.Core.fixed
enum ProvisioningStateDR {
  Accepted,
  Succeeded,
  Failed,
}
@Azure.Core.fixed
enum RoleDisasterRecovery {
  Primary,
  PrimaryNotReplicating,
  Secondary,
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
enum EncodingCaptureDescription {
  Avro,
  AvroDeflate,
}

@doc("The response of the List Available Clusters operation.")
model AvailableClustersList {
  @doc("""
The count of readily available and pre-provisioned Event Hubs Clusters per
region.
""")
  value?: AvailableCluster[];
}

@doc("Pre-provisioned and readily available Event Hubs Cluster count per region.")
model AvailableCluster {
  @doc("Location fo the Available Cluster")
  location?: string;
}

@doc("""
Error response indicates Event Hub service is not able to process the incoming
request. The reason is provided in the error message.
""")
@error
model ErrorResponse {
  @doc("The error object.")
  error?: ErrorDetail;
}

@doc("The error detail.")
model ErrorDetail {
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
  details?: ErrorDetail[];

  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("The resource management error additional info.")
model ErrorAdditionalInfo {
  @doc("The additional info type.")
  @visibility("read")
  type?: string;

  @doc("The additional info.")
  @visibility("read")
  info?: unknown;
}

@doc("The response of the List Event Hubs Clusters operation.")
model ClusterListResult is Azure.Core.Page<Cluster>;

@doc("Single Event Hubs Cluster resource in List or Get operations.")
model Cluster {
  ...TrackedResource;

  @doc("Properties of the cluster SKU.")
  sku?: ClusterSku;

  @doc("The system meta data relating to this resource.")
  @visibility("read")
  systemData?: SystemData;

  @doc("Event Hubs Cluster properties supplied in responses in List or Get operations.")
  properties?: ClusterProperties;
}

@doc("SKU parameters particular to a cluster instance.")
model ClusterSku {
  @doc("Name of this SKU.")
  name: ClusterSkuName;

  @doc("The quantity of Event Hubs Cluster Capacity Units contained in this cluster.")
  capacity?: int32;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @doc("The identity that created the resource.")
  createdBy?: string;

  @doc("The type of identity that created the resource.")
  createdByType?: CreatedByType;

  @doc("The timestamp of resource creation (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The identity that last modified the resource.")
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource.")
  lastModifiedByType?: CreatedByType;

  @doc("The type of identity that last modified the resource.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

@doc("Event Hubs Cluster properties supplied in responses in List or Get operations.")
model ClusterProperties {
  @doc("The UTC time when the Event Hubs Cluster was created.")
  @visibility("read")
  createdAt?: string;

  @doc("The UTC time when the Event Hubs Cluster was last updated.")
  @visibility("read")
  updatedAt?: string;

  @doc("""
The metric ID of the cluster resource. Provided by the service and not
modifiable by the user.
""")
  @visibility("read")
  metricId?: string;

  @doc("Status of the Cluster resource")
  @visibility("read")
  status?: string;

  @doc("A value that indicates whether Scaling is Supported.")
  supportsScaling?: boolean;
}

@doc("Definition of resource.")
model TrackedResource {
  ...Resource;

  @doc("Resource location.")
  location?: string;

  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("""
Common fields that are returned in the response for all Azure Resource Manager
resources
""")
model Resource {
  @doc("""
Fully qualified resource ID for the resource. Ex -
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
""")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("""
The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or
\"Microsoft.Storage/storageAccounts\"
""")
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

@doc("The response of the List Namespace operation")
model EHNamespaceListResult is Azure.Core.Page<EHNamespace>;

@doc("Single Namespace item in List or Get Operation")
model EHNamespace {
  ...TrackedResource;

  @doc("Properties of sku resource")
  sku?: Sku;

  @doc("Properties of BYOK Identity description")
  identity?: Identity;

  @doc("The system meta data relating to this resource.")
  @visibility("read")
  systemData?: SystemData;

  @doc("Namespace properties supplied for create namespace operation.")
  properties?: EHNamespaceProperties;
}

@doc("SKU parameters supplied to the create namespace operation")
model Sku {
  @doc("Name of this SKU.")
  name: SkuName;

  @doc("The billing tier of this particular SKU.")
  tier?: SkuTier;

  @doc("""
The Event Hubs throughput units for Basic or Standard tiers, where value should
be 0 to 20 throughput units. The Event Hubs premium units for Premium tier,
where value should be 0 to 10 premium units.
""")
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

@doc("Recognized Dictionary value.")
model UserAssignedIdentity {
  @doc("Principal Id of user assigned identity")
  @visibility("read")
  principalId?: string;

  @doc("Client Id of user assigned identity")
  @visibility("read")
  clientId?: string;
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

  @doc("""
This determines if traffic is allowed over public network. By default it is
enabled.
""")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("""
Upper limit of throughput units when AutoInflate is enabled, value should be
within 0 to 20 throughput units. ( '0' if AutoInflateEnabled = true)
""")
  maximumThroughputUnits?: int32;

  @doc("Value that indicates whether Kafka is enabled for eventhub namespace.")
  kafkaEnabled?: boolean;

  @doc("""
Enabling this property creates a Standard Event Hubs Namespace in regions
supported availability zones.
""")
  zoneRedundant?: boolean;

  @doc("Properties of BYOK Encryption description")
  encryption?: Encryption;

  @doc("List of private endpoint connections.")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("This property disables SAS authentication for the Event Hubs namespace.")
  disableLocalAuth?: boolean;

  @doc("Alternate name specified when alias and namespace names are same.")
  alternateName?: string;
}

@doc("Properties to configure Encryption")
model Encryption {
  @doc("Properties of KeyVault")
  keyVaultProperties?: KeyVaultProperties[];

  @doc("Enumerates the possible value of keySource for Encryption")
  keySource?: "Microsoft.KeyVault";

  @doc("Enable Infrastructure Encryption (Double Encryption)")
  requireInfrastructureEncryption?: boolean;
}

@doc("Properties to configure keyVault Properties")
model KeyVaultProperties {
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

@doc("Properties of the PrivateEndpointConnection.")
model PrivateEndpointConnection {
  ...ProxyResource;

  @doc("Properties of the PrivateEndpointConnection.")
  properties?: PrivateEndpointConnectionProperties;

  @doc("The system meta data relating to this resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Properties of the private endpoint connection resource.")
model PrivateEndpointConnectionProperties {
  @doc("The Private Endpoint resource for this Connection.")
  privateEndpoint?: PrivateEndpoint;

  @doc("Details about the state of the connection.")
  privateLinkServiceConnectionState?: ConnectionState;

  @doc("Provisioning state of the Private Endpoint Connection.")
  provisioningState?: EndPointProvisioningState;
}

@doc("PrivateEndpoint information.")
model PrivateEndpoint {
  @doc("The ARM identifier for Private Endpoint.")
  id?: string;
}

@doc("ConnectionState information.")
model ConnectionState {
  @doc("Status of the connection.")
  status?: PrivateLinkConnectionStatus;

  @doc("Description of the connection state.")
  description?: string;
}

@doc("""
Common fields that are returned in the response for all Azure Resource Manager
resources
""")
model ProxyResource {
  @doc("""
Fully qualified resource ID for the resource. Ex -
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
""")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("""
The type of the resource. E.g. \"Microsoft.EventHub/Namespaces\" or
\"Microsoft.EventHub/Namespaces/EventHubs\"
""")
  @visibility("read")
  type?: string;

  @doc("The geo-location where the resource lives")
  @visibility("read")
  location?: string;
}

@doc("Result of the list of all private endpoint connections operation.")
model PrivateEndpointConnectionListResult
  is Azure.Core.Page<PrivateEndpointConnection>;

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
model NetworkSecurityPerimeterConfiguration {
  ...ProxyResource;

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
  @doc("""
All possible Cluster settings - a collection of key/value paired settings which
apply to quotas and configurations imposed on the cluster.
""")
  settings?: Record<string>;
}

@doc("Description of topic resource.")
model NetworkRuleSet {
  ...ProxyResource;

  @doc("NetworkRuleSet properties")
  properties?: NetworkRuleSetProperties;

  @doc("The system meta data relating to this resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("NetworkRuleSet properties")
model NetworkRuleSetProperties {
  @doc("Value that indicates whether Trusted Service Access is Enabled or not.")
  trustedServiceAccessEnabled?: boolean;

  @doc("Default Action for Network Rule Set")
  defaultAction?: DefaultAction;

  @doc("List VirtualNetwork Rules")
  virtualNetworkRules?: NWRuleSetVirtualNetworkRules[];

  @doc("List of IpRules")
  ipRules?: NWRuleSetIpRules[];

  @doc("""
This determines if traffic is allowed over public network. By default it is
enabled. If value is SecuredByPerimeter then Inbound and Outbound communication
is controlled by the network security perimeter and profile's access rules. 
""")
  publicNetworkAccess?: PublicNetworkAccessFlag;
}

@doc("The response from the List namespace operation.")
model NWRuleSetVirtualNetworkRules {
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
model NWRuleSetIpRules {
  @doc("IP Mask")
  ipMask?: string;

  @doc("The IP Filter Action")
  action?: NetworkRuleIPAction;
}

@doc("The response of the List NetworkRuleSet operation")
model NetworkRuleSetListResult {
  @doc("Result of the List NetworkRuleSet operation")
  value?: NetworkRuleSet[];

  @doc("""
Link to the next set of results. Not empty if Value contains incomplete list of
NetworkRuleSet.
""")
  nextLink?: string;
}

@doc("The response from the List namespace operation.")
model AuthorizationRuleListResult is Azure.Core.Page<AuthorizationRule>;

@doc("Single item in a List or Get AuthorizationRule operation")
model AuthorizationRule {
  ...ProxyResource;

  @doc("Properties supplied to create or update AuthorizationRule")
  properties?: AuthorizationRuleProperties;

  @doc("The system meta data relating to this resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Properties supplied to create or update AuthorizationRule")
model AuthorizationRuleProperties {
  @doc("The rights associated with the rule.")
  rights: AccessRights[];
}

@doc("Namespace/EventHub Connection String")
model AccessKeys {
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

@doc("""
Parameters supplied to the Regenerate Authorization Rule operation, specifies
which key needs to be reset.
""")
model RegenerateAccessKeyParameters {
  @doc("The access key to regenerate.")
  keyType: KeyType;

  @doc("""
Optional, if the key value provided, is set for KeyType or autogenerated Key
value set for keyType
""")
  key?: string;
}

@doc("Parameter supplied to check Namespace name availability operation ")
model CheckNameAvailabilityParameter {
  @doc("Name to check the namespace name availability")
  name: string;
}

@doc("The Result of the CheckNameAvailability operation")
model CheckNameAvailabilityResult {
  @doc("The detailed info regarding the reason associated with the Namespace.")
  @visibility("read")
  message?: string;

  @doc("""
Value indicating Namespace is availability, true if the Namespace is available;
otherwise, false.
""")
  nameAvailable?: boolean;

  @doc("The reason for unavailability of a Namespace.")
  reason?: UnavailableReason;
}

@doc("Single item in List or Get Consumer group operation")
model ConsumerGroup {
  ...ProxyResource;

  @doc("Single item in List or Get Consumer group operation")
  properties?: ConsumerGroupProperties;

  @doc("The system meta data relating to this resource.")
  @visibility("read")
  systemData?: SystemData;
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

  @doc("""
User Metadata is a placeholder to store user-defined string data with maximum
length 1024. e.g. it can be used to store descriptive data, such as list of
teams and their contact information also user-defined configuration settings
can be stored.
""")
  userMetadata?: string;
}

@doc("The result to the List Consumer Group operation.")
model ConsumerGroupListResult is Azure.Core.Page<ConsumerGroup>;

@doc("The result of the List Alias(Disaster Recovery configuration) operation.")
model ArmDisasterRecoveryListResult is Azure.Core.Page<ArmDisasterRecovery>;

@doc("Single item in List or Get Alias(Disaster Recovery configuration) operation")
model ArmDisasterRecovery {
  ...ProxyResource;

  @doc("""
Properties required to the Create Or Update Alias(Disaster Recovery
configurations)
""")
  properties?: ArmDisasterRecoveryProperties;

  @doc("The system meta data relating to this resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("""
Properties required to the Create Or Update Alias(Disaster Recovery
configurations)
""")
model ArmDisasterRecoveryProperties {
  @doc("""
Provisioning state of the Alias(Disaster Recovery configuration) - possible
values 'Accepted' or 'Succeeded' or 'Failed'
""")
  @visibility("read")
  provisioningState?: ProvisioningStateDR;

  @doc("""
ARM Id of the Primary/Secondary eventhub namespace name, which is part of GEO
DR pairing
""")
  partnerNamespace?: string;

  @doc("Alternate name specified when alias and namespace names are same.")
  alternateName?: string;

  @doc("""
role of namespace in GEO DR - possible values 'Primary' or
'PrimaryNotReplicating' or 'Secondary'
""")
  @visibility("read")
  role?: RoleDisasterRecovery;

  @doc("Number of entities pending to be replicated.")
  @visibility("read")
  pendingReplicationOperationsCount?: int32;
}

@doc("""
Result of the request to list Event Hub operations. It contains a list of
operations and a URL link to get the next set of results.
""")
model OperationListResult is Azure.Core.Page<Operation>;

@doc("A Event Hub REST API operation")
model Operation {
  @doc("Operation name: {provider}/{resource}/{operation}")
  @visibility("read")
  name?: string;

  @doc("Indicates whether the operation is a data action")
  isDataAction?: boolean;

  @doc("Display of the operation")
  display?: OperationDisplay;

  @doc("Origin of the operation")
  origin?: string;

  @doc("Properties of the operation")
  properties?: unknown;
}

@doc("Operation display payload")
model OperationDisplay {
  @doc("Resource provider of the operation")
  @visibility("read")
  provider?: string;

  @doc("Resource of the operation")
  @visibility("read")
  resource?: string;

  @doc("Localized friendly name for the operation")
  @visibility("read")
  operation?: string;

  @doc("Localized friendly description for the operation")
  @visibility("read")
  description?: string;
}

@doc("The result of the List EventHubs operation.")
model EventHubListResult is Azure.Core.Page<Eventhub>;

@doc("Single item in List or Get Event Hub operation")
model Eventhub {
  ...ProxyResource;

  @doc("Properties supplied to the Create Or Update Event Hub operation.")
  properties?: EventhubProperties;

  @doc("The system meta data relating to this resource.")
  @visibility("read")
  systemData?: SystemData;
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

  @doc("""
Number of days to retain the events for this Event Hub, value should be 1 to 7
days
""")
  messageRetentionInDays?: int32;

  @doc("""
Number of partitions created for the Event Hub, allowed values are from 1 to 32
partitions.
""")
  partitionCount?: int32;

  @doc("Enumerates the possible values for the status of the Event Hub.")
  status?: EntityStatus;

  @doc("Properties of capture description")
  captureDescription?: CaptureDescription;

  @doc("Event Hub retention settings")
  retentionDescription?: RetentionDescription;
}

@doc("Properties to configure capture description for eventhub")
model CaptureDescription {
  @doc("A value that indicates whether capture description is enabled. ")
  enabled?: boolean;

  @doc("""
Enumerates the possible values for the encoding format of capture description.
Note: 'AvroDeflate' will be deprecated in New API Version
""")
  encoding?: EncodingCaptureDescription;

  @doc("""
The time window allows you to set the frequency with which the capture to Azure
Blobs will happen, value should between 60 to 900 seconds
""")
  intervalInSeconds?: int32;

  @doc("""
The size window defines the amount of data built up in your Event Hub before an
capture operation, value should be between 10485760 to 524288000 bytes
""")
  sizeLimitInBytes?: int32;

  @doc("""
Properties of Destination where capture will be stored. (Storage Account, Blob
Names)
""")
  destination?: Destination;

  @doc("A value that indicates whether to Skip Empty Archives")
  skipEmptyArchives?: boolean;
}

@doc("Capture storage details for capture description")
model Destination {
  @doc("Name for capture destination")
  name?: string;

  @doc("""
Properties describing the storage account, blob container and archive name
format for capture destination
""")
  properties?: DestinationProperties;
}

@doc("""
Properties describing the storage account, blob container and archive name
format for capture destination
""")
model DestinationProperties {
  @doc("Resource id of the storage account to be used to create the blobs")
  storageAccountResourceId?: string;

  @doc("Blob container Name")
  blobContainer?: string;

  @doc("""
Blob naming convention for archive, e.g.
{Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}.
Here all the parameters (Namespace,EventHub .. etc) are mandatory irrespective
of order
""")
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

  @doc("""
Number of hours to retain the events for this Event Hub. This value is only
used when cleanupPolicy is Delete. If cleanupPolicy is Compaction the returned
value of this property is Long.MaxValue 
""")
  retentionTimeInHours?: int32;

  @doc("""
Number of hours to retain the tombstone markers of a compacted Event Hub. This
value is only used when cleanupPolicy is Compaction. Consumer must complete
reading the tombstone marker within this specified amount of time if consumer
begins from starting offset to ensure they get a valid snapshot for the
specific key described by the tombstone marker within the compacted Event Hub
""")
  tombstoneRetentionTimeInHours?: int32;
}

@doc("The result of the List SchemaGroup operation.")
model SchemaGroupListResult is Azure.Core.Page<SchemaGroup>;

@doc("Single item in List or Get Schema Group operation")
model SchemaGroup {
  ...ProxyResource;
  properties?: SchemaGroupProperties;

  @doc("The system meta data relating to this resource.")
  @visibility("read")
  systemData?: SystemData;
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

@doc("The response from the List Application Groups operation.")
model ApplicationGroupListResult is Azure.Core.Page<ApplicationGroup>;

@doc("The Application Group object")
model ApplicationGroup {
  ...ProxyResource;
  properties?: ApplicationGroupProperties;

  @doc("The system meta data relating to this resource.")
  @visibility("read")
  systemData?: SystemData;
}

model ApplicationGroupProperties {
  @doc("""
Determines if Application Group is allowed to create connection with namespace
or not. Once the isEnabled is set to false, all the existing connections of
application group gets dropped and no new connections will be allowed
""")
  isEnabled?: boolean;

  @doc("""
The Unique identifier for application group.Supports SAS(SASKeyName=KeyName) or
AAD(AADAppID=Guid)
""")
  clientAppGroupIdentifier: string;

  @doc("""
List of group policies that define the behavior of application group. The
policies can support resource governance scenarios such as limiting ingress or
egress traffic.
""")
  policies?: ApplicationGroupPolicy[];
}

@doc("Properties of the Application Group policy")
@discriminator("type")
model ApplicationGroupPolicy {
  @doc("The Name of this policy")
  name: string;
}

@doc("Properties of the throttling policy")
model ThrottlingPolicy extends ApplicationGroupPolicy {
  @doc("""
The Threshold limit above which the application group will be throttled.Rate
limit is always per second.
""")
  rateLimitThreshold: int32;

  @doc("""
Metric Id on which the throttle limit should be set, MetricId can be discovered
by hovering over Metric in the Metrics section of Event Hub Namespace inside
Azure Portal
""")
  metricId: MetricId;

  @doc("Application Group Policy types")
  type: "ThrottlingPolicy";
}
