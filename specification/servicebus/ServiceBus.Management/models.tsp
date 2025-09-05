import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.ServiceBus;

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * The minimum TLS version for the cluster to support, e.g. '1.2'
 */
union TlsVersion {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `1.0`: "1.0",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `1.1`: "1.1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `1.2`: "1.2",
}

/**
 * Status of the connection.
 */
union PrivateLinkConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disconnected: "Disconnected",
}

/**
 * Provisioning state of the Private Endpoint Connection.
 */
union EndPointProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

/**
 * This determines if traffic is allowed over public network. By default it is enabled.
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SecuredByPerimeter: "SecuredByPerimeter",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union MigrationConfigurationName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  $default: "$default",
}

/**
 * Default Action for Network Rule Set
 */
union DefaultAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Allow: "Allow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deny: "Deny",
}

/**
 * The IP Filter Action
 */
union NetworkRuleIPAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Allow: "Allow",
}

/**
 * This determines if traffic is allowed over public network. By default it is enabled.
 */
union PublicNetworkAccessFlag {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Name of this SKU.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SkuName {
  Basic,
  Standard,
  Premium,
}

/**
 * The billing tier of this particular SKU.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SkuTier {
  Basic,
  Standard,
  Premium,
}

/**
 * Type of managed service identity.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ManagedServiceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

/**
 * Provisioning state of the Alias(Disaster Recovery configuration) - possible values 'Accepted' or 'Succeeded' or 'Failed'
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ProvisioningStateDR {
  Accepted,
  Succeeded,
  Failed,
}

/**
 * role of namespace in GEO DR - possible values 'Primary' or 'PrimaryNotReplicating' or 'Secondary'
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum RoleDisasterRecovery {
  Primary,
  PrimaryNotReplicating,
  Secondary,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AccessRights {
  Manage,
  Send,
  Listen,
}

/**
 * The access key to regenerate.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum KeyType {
  PrimaryKey,
  SecondaryKey,
}

/**
 * Entity status.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum FilterType {
  SqlFilter,
  CorrelationFilter,
}

/**
 * Specifies the reason for the unavailability of the service.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SBSku {
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
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * TenantId from the KeyVault
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * Type of managed service identity.
   */
  type?: ManagedServiceIdentityType;

  /**
   * Properties for User Assigned Identities
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Recognized Dictionary value.
 */
model UserAssignedIdentity {
  /**
   * Principal Id of user assigned identity
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * Client Id of user assigned identity
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
model SystemData {
  /**
   * The identity that created the resource.
   */
  createdBy?: string;

  /**
   * The type of identity that created the resource.
   */
  createdByType?: CreatedByType;

  /**
   * The timestamp of resource creation (UTC).
   */
  createdAt?: utcDateTime;

  /**
   * The identity that last modified the resource.
   */
  lastModifiedBy?: string;

  /**
   * The type of identity that last modified the resource.
   */
  lastModifiedByType?: CreatedByType;

  /**
   * The type of identity that last modified the resource.
   */
  lastModifiedAt?: utcDateTime;
}

/**
 * Properties of the namespace.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SBNamespaceProperties {
  /**
   * The minimum TLS version for the cluster to support, e.g. '1.2'
   */
  minimumTlsVersion?: TlsVersion;

  /**
   * Provisioning state of the namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Status of the namespace.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The time the namespace was created
   */
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  /**
   * The time the namespace was updated.
   */
  @visibility(Lifecycle.Read)
  updatedAt?: utcDateTime;

  /**
   * Endpoint you can use to perform Service Bus operations.
   */
  @visibility(Lifecycle.Read)
  serviceBusEndpoint?: string;

  /**
   * Identifier for Azure Insights metrics
   */
  @visibility(Lifecycle.Read)
  metricId?: string;

  /**
   * This property reflects if zone redundancy has been enabled for namespaces in regions that support availability zones.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  zoneRedundant?: boolean;

  /**
   * Properties of BYOK Encryption description
   */
  encryption?: Encryption;

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
model Encryption {
  /**
   * Properties of KeyVault
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keyVaultProperties?: KeyVaultProperties[];

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
model KeyVaultProperties {
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: UserAssignedIdentityProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  privateLinkServiceConnectionState?: ConnectionState;

  /**
   * Provisioning state of the Private Endpoint Connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: EndPointProvisioningState;
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
  status?: PrivateLinkConnectionStatus;

  /**
   * Description of the connection state.
   */
  description?: string;
}

/**
 * Description of a namespace resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SBNamespaceUpdateParameters extends ResourceNamespacePatch {
  /**
   * Properties of SKU
   */
  sku?: SBSku;

  /**
   * Properties of the namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: SBNamespaceUpdateProperties;

  /**
   * Properties of BYOK Identity description
   */
  identity?: Identity;
}

/**
 * Properties of the namespace.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SBNamespaceUpdateProperties {
  /**
   * Provisioning state of the namespace.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Status of the namespace.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The time the namespace was created
   */
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  /**
   * The time the namespace was updated.
   */
  @visibility(Lifecycle.Read)
  updatedAt?: utcDateTime;

  /**
   * Endpoint you can use to perform Service Bus operations.
   */
  @visibility(Lifecycle.Read)
  serviceBusEndpoint?: string;

  /**
   * Identifier for Azure Insights metrics
   */
  @visibility(Lifecycle.Read)
  metricId?: string;

  /**
   * Properties of BYOK Encryption description
   */
  encryption?: Encryption;

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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceNamespacePatch
  extends Azure.ResourceManager.Foundations.Resource {
  /**
   * Resource location
   */
  location?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Information of the private link resource.
 */
model PrivateLinkResource {
  /**
   * Properties of the private link resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
 * Properties of PrivateLinkResource
 */
model PrivateLinkResourceProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * A Service Bus REST API operation
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * Display of the operation
   */
  display?: OperationDisplay;

  /**
   * Origin of the operation
   */
  origin?: string;

  /**
   * Properties of the operation
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: Record<unknown>;
}

/**
 * Operation display payload
 */
model OperationDisplay {
  /**
   * Resource provider of the operation
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * Resource of the operation
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * Localized friendly name for the operation
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * Localized friendly description for the operation
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Properties required to the Create Or Update Alias(Disaster Recovery configurations)
 */
model ArmDisasterRecoveryProperties {
  /**
   * Provisioning state of the Alias(Disaster Recovery configuration) - possible values 'Accepted' or 'Succeeded' or 'Failed'
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningStateDR;

  /**
   * Number of entities pending to be replicated.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  role?: RoleDisasterRecovery;
}

/**
 * Safe failover is to indicate the service should wait for pending replication to finish before switching to the secondary.
 */
model FailoverProperties {
  /**
   * Safe failover is to indicate the service should wait for pending replication to finish before switching to the secondary.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: FailoverPropertiesProperties;
}

/**
 * Safe failover is to indicate the service should wait for pending replication to finish before switching to the secondary.
 */
model FailoverPropertiesProperties {
  /**
   * Safe failover is to indicate the service should wait for pending replication to finish before switching to the secondary.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IsSafeFailover?: boolean;
}

/**
 * Properties required to the Create Migration Configuration
 */
model MigrationConfigPropertiesProperties {
  /**
   * Provisioning state of Migration Configuration
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Number of entities pending to be replicated.
   */
  @visibility(Lifecycle.Read)
  pendingReplicationOperationsCount?: int64;

  /**
   * Existing premium Namespace ARM Id name which has no entities, will be used for migration
   */
  targetNamespace: string;

  /**
   * Name to access Standard Namespace after migration
   */
  postMigrationName: string;

  /**
   * State in which Standard to Premium Migration is, possible values : Unknown, Reverting, Completing, Initiating, Syncing, Active
   */
  @visibility(Lifecycle.Read)
  migrationState?: string;
}

/**
 * NetworkRuleSet properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NetworkRuleSetProperties {
  /**
   * Value that indicates whether Trusted Service Access is Enabled or not.
   */
  trustedServiceAccessEnabled?: boolean;

  /**
   * Default Action for Network Rule Set
   */
  defaultAction?: DefaultAction;

  /**
   * List VirtualNetwork Rules
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  virtualNetworkRules?: NWRuleSetVirtualNetworkRules[];

  /**
   * List of IpRules
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ipRules?: NWRuleSetIpRules[];

  /**
   * This determines if traffic is allowed over public network. By default it is enabled.
   */
  publicNetworkAccess?: PublicNetworkAccessFlag = PublicNetworkAccessFlag.Enabled;
}

/**
 * Description of VirtualNetworkRules - NetworkRules resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NWRuleSetVirtualNetworkRules {
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NWRuleSetIpRules {
  /**
   * IP Mask
   */
  ipMask?: string;

  /**
   * The IP Filter Action
   */
  action?: NetworkRuleIPAction = NetworkRuleIPAction.Allow;
}

/**
 * AuthorizationRule properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SBAuthorizationRuleProperties {
  /**
   * The rights associated with the rule.
   */
  rights: AccessRights[];
}

/**
 * Namespace/ServiceBus Connection String
 */
model AccessKeys {
  /**
   * Primary connection string of the created namespace authorization rule.
   */
  @visibility(Lifecycle.Read)
  primaryConnectionString?: string;

  /**
   * Secondary connection string of the created namespace authorization rule.
   */
  @visibility(Lifecycle.Read)
  secondaryConnectionString?: string;

  /**
   * Primary connection string of the alias if GEO DR is enabled
   */
  @visibility(Lifecycle.Read)
  aliasPrimaryConnectionString?: string;

  /**
   * Secondary  connection string of the alias if GEO DR is enabled
   */
  @visibility(Lifecycle.Read)
  aliasSecondaryConnectionString?: string;

  /**
   * A base64-encoded 256-bit primary key for signing and validating the SAS token.
   */
  @visibility(Lifecycle.Read)
  primaryKey?: string;

  /**
   * A base64-encoded 256-bit primary key for signing and validating the SAS token.
   */
  @visibility(Lifecycle.Read)
  secondaryKey?: string;

  /**
   * A string that describes the authorization rule.
   */
  @visibility(Lifecycle.Read)
  keyName?: string;
}

/**
 * Parameters supplied to the Regenerate Authorization Rule operation, specifies which key needs to be reset.
 */
model RegenerateAccessKeyParameters {
  /**
   * The access key to regenerate.
   */
  keyType: KeyType;

  /**
   * Optional, if the key value provided, is reset for KeyType value or autogenerate Key value set for keyType
   */
  key?: string;
}

/**
 * The Queue Properties definition.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SBQueueProperties {
  /**
   * Message Count Details.
   */
  @visibility(Lifecycle.Read)
  countDetails?: MessageCountDetails;

  /**
   * The exact time the message was created.
   */
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  /**
   * The exact time the message was updated.
   */
  @visibility(Lifecycle.Read)
  updatedAt?: utcDateTime;

  /**
   * Last time a message was sent, or the last time there was a receive request to this queue.
   */
  @visibility(Lifecycle.Read)
  accessedAt?: utcDateTime;

  /**
   * The size of the queue, in bytes.
   */
  @visibility(Lifecycle.Read)
  sizeInBytes?: int64;

  /**
   * The number of messages in the queue.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  activeMessageCount?: int64;

  /**
   * Number of messages that are dead lettered.
   */
  @visibility(Lifecycle.Read)
  deadLetterMessageCount?: int64;

  /**
   * Number of scheduled messages.
   */
  @visibility(Lifecycle.Read)
  scheduledMessageCount?: int64;

  /**
   * Number of messages transferred to another queue, topic, or subscription.
   */
  @visibility(Lifecycle.Read)
  transferMessageCount?: int64;

  /**
   * Number of messages transferred into dead letters.
   */
  @visibility(Lifecycle.Read)
  transferDeadLetterMessageCount?: int64;
}

/**
 * The Topic Properties definition.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SBTopicProperties {
  /**
   * Size of the topic, in bytes.
   */
  @visibility(Lifecycle.Read)
  sizeInBytes?: int64;

  /**
   * Exact time the message was created.
   */
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  /**
   * The exact time the message was updated.
   */
  @visibility(Lifecycle.Read)
  updatedAt?: utcDateTime;

  /**
   * Last time the message was sent, or a request was received, for this topic.
   */
  @visibility(Lifecycle.Read)
  accessedAt?: utcDateTime;

  /**
   * Number of subscriptions.
   */
  @visibility(Lifecycle.Read)
  subscriptionCount?: int32;

  /**
   * Message count details
   */
  @visibility(Lifecycle.Read)
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Ruleproperties {
  /**
   * Represents the filter actions which are allowed for the transformation of a message that have been matched by a filter expression.
   */
  action?: Action;

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
model Action {
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  to?: string;

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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SBSubscriptionProperties {
  /**
   * Number of messages.
   */
  @visibility(Lifecycle.Read)
  messageCount?: int64;

  /**
   * Exact time the message was created.
   */
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  /**
   * Last time there was a receive request to this subscription.
   */
  @visibility(Lifecycle.Read)
  accessedAt?: utcDateTime;

  /**
   * The exact time the message was updated.
   */
  @visibility(Lifecycle.Read)
  updatedAt?: utcDateTime;

  /**
   * Message count details
   */
  @visibility(Lifecycle.Read)
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
  clientAffineProperties?: SBClientAffineProperties;
}

/**
 * Properties specific to client affine subscriptions.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SBClientAffineProperties {
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
model CheckNameAvailability {
  /**
   * The Name to check the namespace name availability and The namespace name can contain only letters, numbers, and hyphens. The namespace must start with a letter, and it must end with a letter or number.
   */
  name: string;
}

/**
 * Description of a Check Name availability request properties.
 */
model CheckNameAvailabilityResult {
  /**
   * The detailed info regarding the reason associated with the namespace.
   */
  @visibility(Lifecycle.Read)
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
