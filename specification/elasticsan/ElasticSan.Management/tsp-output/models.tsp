import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ElasticSan;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The sku name.
 */
enum SkuName {
  /**
   * Premium locally redundant storage
   */
  Premium_LRS,

  /**
   * Premium zone redundant storage
   */
  Premium_ZRS,
}

/**
 * Provisioning state of the iSCSI Target.
 */
enum ProvisioningStates {
  Invalid,
  Succeeded,
  Failed,
  Canceled,
  Pending,
  Creating,
  Updating,
  Deleting,
}

/**
 * The private endpoint connection status.
 */
enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Failed,
  Rejected,
}

/**
 * Allow or disallow public network access to ElasticSan. Value is optional but if passed in, must be 'Enabled' or 'Disabled'.
 */
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

/**
 * The identity type.
 */
enum IdentityType {
  None,
  SystemAssigned,
  UserAssigned,
}

/**
 * Storage Target type.
 */
enum StorageTargetType {
  Iscsi,
  None,
}

/**
 * The type of key used to encrypt the data of the disk.
 */
enum EncryptionType {
  /**
   * Volume is encrypted at rest with Platform managed key. It is the default encryption type.
   */
  EncryptionAtRestWithPlatformKey,

  /**
   * Volume is encrypted at rest with Customer managed key that can be changed and revoked by a customer.
   */
  EncryptionAtRestWithCustomerManagedKey,
}

/**
 * The action of virtual network rule.
 */
enum Action {
  Allow,
}

/**
 * This enumerates the possible sources of a volume creation.
 */
enum VolumeCreateOption {
  None,
  VolumeSnapshot,
  DiskSnapshot,
  Disk,
  DiskRestorePoint,
}

/**
 * Operational status of the resource.
 */
enum OperationalStatus {
  Invalid,
  Unknown,
  Healthy,
  Unhealthy,
  Updating,
  Running,
  Stopped,
  `Stopped (deallocated)`,
}

enum XMsDeleteSnapshots {
  `true`,
  `false`,
}

enum XMsForceDelete {
  `true`,
  `false`,
}

/**
 * List of SKU Information objects
 */
model SkuInformationList is Azure.Core.Page<SkuInformation>;

/**
 * ElasticSAN SKU and its properties
 */
model SkuInformation {
  /**
   * Sku Name
   */
  name: SkuName;

  /**
   * Sku Tier
   */
  tier?: SkuTier;

  /**
   * The type of the resource.
   */
  @visibility("read")
  resourceType?: string;

  /**
   * The set of locations that the SKU is available. This will be supported and registered Azure Geo Regions (e.g. West US, East US, Southeast Asia, etc.).
   */
  @visibility("read")
  locations?: string[];

  /**
   * Availability of the SKU for the location/zone
   */
  @visibility("read")
  locationInfo?: SkuLocationInfo[];

  /**
   * The capability information in the specified SKU.
   */
  @visibility("read")
  capabilities?: SKUCapability[];
}

/**
 * The location info.
 */
model SkuLocationInfo {
  /**
   * The location.
   */
  @visibility("read")
  location?: string;

  /**
   * The zones.
   */
  @visibility("read")
  zones?: string[];
}

/**
 * The capability information in the specified SKU.
 */
model SKUCapability {
  /**
   * The name of capability.
   */
  @visibility("read")
  name?: string;

  /**
   * A string value to indicate states of given capability.
   */
  @visibility("read")
  value?: string;
}

/**
 * Elastic San response properties.
 */
model ElasticSanProperties {
  /**
   * resource sku
   */
  sku: Sku;

  /**
   * Logical zone for Elastic San resource; example: ["1"].
   */
  availabilityZones?: string[];

  /**
   * State of the operation on the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningStates;

  /**
   * Base size of the Elastic San appliance in TiB.
   */
  @visibility("read", "create")
  baseSizeTiB: int64;

  /**
   * Extended size of the Elastic San appliance in TiB.
   */
  @visibility("read", "create")
  extendedCapacitySizeTiB: int64;

  /**
   * Total size of the provisioned Volumes in GiB.
   */
  @visibility("read")
  totalVolumeSizeGiB?: int64;

  /**
   * Total number of volume groups in this Elastic San appliance.
   */
  @visibility("read")
  volumeGroupCount?: int64;

  /**
   * Total Provisioned IOPS of the Elastic San appliance.
   */
  @visibility("read")
  totalIops?: int64;

  /**
   * Total Provisioned MBps Elastic San appliance.
   */
  @visibility("read")
  totalMBps?: int64;

  /**
   * Total size of the Elastic San appliance in TB.
   */
  @visibility("read")
  totalSizeTiB?: int64;

  /**
   * The list of Private Endpoint Connections.
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Allow or disallow public network access to ElasticSan. Value is optional but if passed in, must be 'Enabled' or 'Disabled'.
   */
  publicNetworkAccess?: PublicNetworkAccess;
}

/**
 * The SKU name. Required for account creation; optional for update.
 */
model Sku {
  /**
   * The sku name.
   */
  name: SkuName;

  /**
   * The sku tier.
   */
  tier?: SkuTier;
}

/**
 *  Response for PrivateEndpoint connection properties
 */
model PrivateEndpointConnectionProperties {
  /**
   * Provisioning State of Private Endpoint connection resource
   */
  @visibility("read")
  provisioningState?: ProvisioningStates;

  /**
   * Private Endpoint resource
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * Private Link Service Connection State.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   *  List of resources private endpoint is mapped
   */
  groupIds?: string[];
}

/**
 * Response for PrivateEndpoint
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for Private Endpoint
   */
  @visibility("read")
  id?: string;
}

/**
 * Response for Private Link Service Connection state
 */
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: PrivateEndpointServiceConnectionStatus;

  /**
   * The reason for approval/rejection of the connection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
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
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Response for ElasticSan update request.
 */
model ElasticSanUpdate {
  /**
   * Properties of ElasticSan.
   */
  properties?: ElasticSanUpdateProperties;

  /**
   * Update tags
   */
  tags?: Record<string>;
}

/**
 * Elastic San update properties.
 */
model ElasticSanUpdateProperties {
  /**
   * Base size of the Elastic San appliance in TiB.
   */
  @visibility("update")
  baseSizeTiB?: int64;

  /**
   * Extended size of the Elastic San appliance in TiB.
   */
  @visibility("update")
  extendedCapacitySizeTiB?: int64;

  /**
   * Allow or disallow public network access to ElasticSan Account. Value is optional but if passed in, must be 'Enabled' or 'Disabled'.
   */
  publicNetworkAccess?: PublicNetworkAccess;
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The identity type.
   */
  type: IdentityType;

  /**
   * Gets or sets a list of key value pairs that describe the set of User Assigned identities that will be used with this volume group. The key is the ARM resource identifier of the identity.
   */
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * VolumeGroup response properties.
 */
model VolumeGroupProperties {
  /**
   * State of the operation on the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningStates;

  /**
   * Type of storage target
   */
  protocolType?: StorageTargetType;

  /**
   * Type of encryption
   */
  encryption?: EncryptionType;

  /**
   * Encryption Properties describing Key Vault and Identity information
   */
  encryptionProperties?: EncryptionProperties;

  /**
   * A collection of rules governing the accessibility from specific network locations.
   */
  @visibility("read", "create")
  networkAcls?: NetworkRuleSet;

  /**
   * The list of Private Endpoint Connections.
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];
}

/**
 * The encryption settings on the volume group.
 */
model EncryptionProperties {
  /**
   * Properties provided by key vault.
   */
  keyVaultProperties?: KeyVaultProperties;

  /**
   * The identity to be used with service-side encryption at rest.
   */
  @projectedName("json", "identity")
  encryptionIdentity?: EncryptionIdentity;
}

/**
 * Properties of key vault.
 */
model KeyVaultProperties {
  /**
   * The name of KeyVault key.
   */
  keyName?: string;

  /**
   * The version of KeyVault key.
   */
  keyVersion?: string;

  /**
   * The Uri of KeyVault.
   */
  keyVaultUri?: url;

  /**
   * The object identifier of the current versioned Key Vault Key in use.
   */
  @visibility("read")
  currentVersionedKeyIdentifier?: string;

  /**
   * Timestamp of last rotation of the Key Vault Key.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastKeyRotationTimestamp?: utcDateTime;

  /**
   * This is a read only property that represents the expiration time of the current version of the customer managed key used for encryption.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  currentVersionedKeyExpirationTimestamp?: utcDateTime;
}

/**
 * Encryption identity for the volume group.
 */
model EncryptionIdentity {
  /**
   * Resource identifier of the UserAssigned identity to be associated with server-side encryption on the volume group.
   */
  @projectedName("json", "userAssignedIdentity")
  encryptionUserAssignedIdentity?: string;
}

/**
 * A set of rules governing the network accessibility.
 */
model NetworkRuleSet {
  /**
   * The list of virtual network rules.
   */
  virtualNetworkRules?: VirtualNetworkRule[];
}

/**
 * Virtual Network rule.
 */
model VirtualNetworkRule {
  /**
   * Resource ID of a subnet, for example: /subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/Microsoft.Network/virtualNetworks/{vnetName}/subnets/{subnetName}.
   */
  @projectedName("json", "id")
  virtualNetworkResourceId: string;

  /**
   * The action of virtual network rule.
   */
  action?: Action = Action.Allow;
}

/**
 * Volume Group request.
 */
model VolumeGroupUpdate {
  /**
   * The identity of the resource.
   */
  identity?: Identity;

  /**
   * Properties of VolumeGroup.
   */
  properties?: VolumeGroupUpdateProperties;
}

/**
 * VolumeGroup response properties.
 */
model VolumeGroupUpdateProperties {
  /**
   * Type of storage target
   */
  protocolType?: StorageTargetType;

  /**
   * Type of encryption
   */
  encryption?: EncryptionType;

  /**
   * Encryption Properties describing Key Vault and Identity information
   */
  encryptionProperties?: EncryptionProperties;

  /**
   * A collection of rules governing the accessibility from specific network locations.
   */
  @visibility("update")
  networkAcls?: NetworkRuleSet;
}

/**
 * Volume response properties.
 */
model VolumeProperties {
  /**
   * Unique Id of the volume in GUID format
   */
  @visibility("read")
  volumeId?: string;

  /**
   * State of the operation on the resource.
   */
  creationData?: SourceCreationData;

  /**
   * Volume size.
   */
  sizeGiB: int64;

  /**
   * Storage target information
   */
  @visibility("read")
  storageTarget?: IscsiTargetInfo;

  /**
   * Parent resource information.
   */
  managedBy?: ManagedByInfo;

  /**
   * State of the operation on the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningStates;
}

/**
 * Data source used when creating the volume.
 */
model SourceCreationData {
  /**
   * This enumerates the possible sources of a volume creation.
   */
  createSource?: VolumeCreateOption;

  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  sourceId?: string;
}

/**
 * Iscsi target information
 */
model IscsiTargetInfo {
  /**
   * iSCSI Target IQN (iSCSI Qualified Name); example: "iqn.2005-03.org.iscsi:server".
   */
  @visibility("read")
  targetIqn?: string;

  /**
   * iSCSI Target Portal Host Name
   */
  @visibility("read")
  targetPortalHostname?: string;

  /**
   * iSCSI Target Portal Port
   */
  @visibility("read")
  targetPortalPort?: int32;

  /**
   * State of the operation on the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningStates;

  /**
   * Operational status of the iSCSI Target.
   */
  status?: OperationalStatus;
}

/**
 * Parent resource information.
 */
model ManagedByInfo {
  /**
   * Resource ID of the resource managing the volume, this is a restricted field and can only be set for internal use.
   */
  resourceId?: string;
}

/**
 * Response for Volume request.
 */
model VolumeUpdate {
  /**
   * Properties of Volume.
   */
  properties?: VolumeUpdateProperties;
}

/**
 * Volume response properties.
 */
model VolumeUpdateProperties {
  /**
   * Volume size.
   */
  sizeGiB?: int64;

  /**
   * Parent resource information.
   */
  managedBy?: ManagedByInfo;
}

/**
 * A list of private link resources
 */
model PrivateLinkResourceListResult {
  /**
   * Array of private link resources
   */
  value?: PrivateLinkResource[];

  /**
   * URI to fetch the next section of the paginated response.
   */
  @visibility("read")
  nextLink?: string;
}

/**
 * A private link resource
 */
model PrivateLinkResource extends Resource {
  /**
   * Resource properties.
   */
  properties?: PrivateLinkResourceProperties;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility("read")
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * Properties for Snapshot.
 */
model SnapshotProperties {
  /**
   * Data used when creating a volume snapshot.
   */
  creationData: SnapshotCreationData;

  /**
   * State of the operation on the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningStates;

  /**
   * Size of Source Volume
   */
  @visibility("read")
  sourceVolumeSizeGiB?: int64;

  /**
   * Source Volume Name of a snapshot
   */
  @visibility("read")
  volumeName?: string;
}

/**
 * Data used when creating a volume snapshot.
 */
model SnapshotCreationData {
  /**
   * Fully qualified resource ID of the volume. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/volumegroups/{volumeGroupName}/volumes/{volumeName}"
   */
  sourceId: string;
}
