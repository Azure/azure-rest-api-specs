import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ElasticSan;

/**
 * The sku name.
 */
union SkuName {
  string,

  /**
   * Premium locally redundant storage
   */
  Premium_LRS: "Premium_LRS",

  /**
   * Premium zone redundant storage
   */
  Premium_ZRS: "Premium_ZRS",
}

/**
 * Provisioning state of the iSCSI Target.
 */
union ProvisioningStates {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Restoring: "Restoring",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SoftDeleting: "SoftDeleting",
}

/**
 * The private endpoint connection status.
 */
union PrivateEndpointServiceConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Rejected: "Rejected",
}

/**
 * Allow or disallow public network access to ElasticSan. Value is optional but if passed in, must be 'Enabled' or 'Disabled'.
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Enable or Disable scale up setting on Elastic San Appliance.
 */
union AutoScalePolicyEnforcement {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union `x-ms-access-soft-deleted-resources` {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `true`: "true",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `false`: "false",
}

/**
 * The identity type.
 */
union IdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UserAssigned: "UserAssigned",
}

/**
 * Storage Target type.
 */
union StorageTargetType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Iscsi: "Iscsi",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
}

/**
 * The type of key used to encrypt the data of the disk.
 */
union EncryptionType {
  string,

  /**
   * Volume is encrypted at rest with Platform managed key. It is the default encryption type.
   */
  EncryptionAtRestWithPlatformKey: "EncryptionAtRestWithPlatformKey",

  /**
   * Volume is encrypted at rest with Customer managed key that can be changed and revoked by a customer.
   */
  EncryptionAtRestWithCustomerManagedKey: "EncryptionAtRestWithCustomerManagedKey",
}

/**
 * The action of virtual network rule.
 */
union Action {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Allow: "Allow",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union PolicyState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * This enumerates the possible sources of a volume creation.
 */
union VolumeCreateOption {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VolumeSnapshot: "VolumeSnapshot",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DiskSnapshot: "DiskSnapshot",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disk: "Disk",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DiskRestorePoint: "DiskRestorePoint",
}

/**
 * Operational status of the resource.
 */
union OperationalStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Healthy: "Healthy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unhealthy: "Unhealthy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Stopped: "Stopped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `Stopped (deallocated)`: "Stopped (deallocated)",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union `x-ms-delete-snapshots` {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `true`: "true",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `false`: "false",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union `x-ms-force-delete` {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `true`: "true",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `false`: "false",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union DeleteType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  permanent: "permanent",
}

/**
 * List of SKU Information objects
 */
model SkuInformationList is Azure.Core.Page<SkuInformation>;
@@visibility(SkuInformationList.value, Lifecycle.Read);

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
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The set of locations that the SKU is available. This will be supported and registered Azure Geo Regions (e.g. West US, East US, Southeast Asia, etc.).
   */
  @visibility(Lifecycle.Read)
  locations?: string[];

  /**
   * Availability of the SKU for the location/zone
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  locationInfo?: SkuLocationInfo[];

  /**
   * The capability information in the specified SKU.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  capabilities?: SKUCapability[];
}

/**
 * The location info.
 */
model SkuLocationInfo {
  /**
   * The location.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * The zones.
   */
  @visibility(Lifecycle.Read)
  zones?: string[];
}

/**
 * The capability information in the specified SKU.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SKUCapability {
  /**
   * The name of capability.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * A string value to indicate states of given capability.
   */
  @visibility(Lifecycle.Read)
  value?: string;
}

/**
 * List of Elastic Sans
 */
model ElasticSanList is Azure.Core.Page<ElasticSan>;

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
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningStates;

  /**
   * Base size of the Elastic San appliance in TiB.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  baseSizeTiB: int64;

  /**
   * Extended size of the Elastic San appliance in TiB.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedCapacitySizeTiB: int64;

  /**
   * Total size of the provisioned Volumes in GiB.
   */
  @visibility(Lifecycle.Read)
  totalVolumeSizeGiB?: int64;

  /**
   * Total number of volume groups in this Elastic San appliance.
   */
  @visibility(Lifecycle.Read)
  volumeGroupCount?: int64;

  /**
   * Total Provisioned IOPS of the Elastic San appliance.
   */
  @visibility(Lifecycle.Read)
  totalIops?: int64;

  /**
   * Total Provisioned MBps Elastic San appliance.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  totalMBps?: int64;

  /**
   * Total size of the Elastic San appliance in TB.
   */
  @visibility(Lifecycle.Read)
  totalSizeTiB?: int64;

  /**
   * The list of Private Endpoint Connections.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Allow or disallow public network access to ElasticSan. Value is optional but if passed in, must be 'Enabled' or 'Disabled'.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Auto Scale Properties for Elastic San Appliance.
   */
  autoScaleProperties?: AutoScaleProperties;
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
 * The auto scale settings on Elastic San Appliance.
 */
model AutoScaleProperties {
  /**
   * Scale up settings on Elastic San Appliance.
   */
  scaleUpProperties?: ScaleUpProperties;
}

/**
 * Scale up properties on Elastic San Appliance.
 */
model ScaleUpProperties {
  /**
   * Unused size on Elastic San appliance in TiB.
   */
  unusedSizeTiB?: int64;

  /**
   * Unit to increase Capacity Unit on Elastic San appliance in TiB.
   */
  increaseCapacityUnitByTiB?: int64;

  /**
   * Maximum scale up size on Elastic San appliance in TiB.
   */
  capacityUnitScaleUpLimitTiB?: int64;

  /**
   * Enable or Disable scale up setting on Elastic San Appliance.
   */
  autoScalePolicyEnforcement?: AutoScalePolicyEnforcement;
}

/**
 * Response for ElasticSan update request.
 */
model ElasticSanUpdate {
  /**
   * Properties of ElasticSan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: ElasticSanUpdateProperties;

  /**
   * Update tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Elastic San update properties.
 */
model ElasticSanUpdateProperties {
  /**
   * Base size of the Elastic San appliance in TiB.
   */
  @visibility(Lifecycle.Update)
  baseSizeTiB?: int64;

  /**
   * Extended size of the Elastic San appliance in TiB.
   */
  @visibility(Lifecycle.Update)
  extendedCapacitySizeTiB?: int64;

  /**
   * Allow or disallow public network access to ElasticSan Account. Value is optional but if passed in, must be 'Enabled' or 'Disabled'.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Auto Scale Properties for Elastic San Appliance.
   */
  autoScaleProperties?: AutoScaleProperties;
}

/**
 * List of Volume Groups
 */
model VolumeGroupList is Azure.Core.Page<VolumeGroup>;

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The identity type.
   */
  type: IdentityType;

  /**
   * Gets or sets a list of key value pairs that describe the set of User Assigned identities that will be used with this volume group. The key is the ARM resource identifier of the identity.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * UserAssignedIdentity for the resource.
 */
model UserAssignedIdentity {
  /**
   * The principal ID of the identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client ID of the identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * The sku tier.
 */
union SkuTier {
  string,

  /**
   * Premium Tier
   */
  Premium: "Premium",
}

/**
 * VolumeGroup response properties.
 */
model VolumeGroupProperties {
  /**
   * State of the operation on the resource.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkAcls?: NetworkRuleSet;

  /**
   * The list of Private Endpoint Connections.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * A boolean indicating whether or not Data Integrity Check is enabled
   */
  enforceDataIntegrityCheckForIscsi?: boolean;

  /**
   * The retention policy for the soft deleted volume group and its associated resources.
   */
  deleteRetentionPolicy?: DeleteRetentionPolicy;
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
  identity?: EncryptionIdentity;
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
  @visibility(Lifecycle.Read)
  currentVersionedKeyIdentifier?: string;

  /**
   * Timestamp of last rotation of the Key Vault Key.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastKeyRotationTimestamp?: utcDateTime;

  /**
   * This is a read only property that represents the expiration time of the current version of the customer managed key used for encryption.
   */
  @visibility(Lifecycle.Read)
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
  userAssignedIdentity?: string;
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
  id: string;

  /**
   * The action of virtual network rule.
   */
  action?: Action = Action.Allow;
}

/**
 * Response for Delete Retention Policy object
 */
model DeleteRetentionPolicy {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  policyState?: PolicyState;

  /**
   * The number of days to retain the resources after deletion.
   */
  @minValue(0)
  retentionPeriodDays?: int32;
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Update)
  networkAcls?: NetworkRuleSet;

  /**
   * A boolean indicating whether or not Data Integrity Check is enabled
   */
  enforceDataIntegrityCheckForIscsi?: boolean;

  /**
   * The retention policy for the soft deleted volume group and its associated resources
   */
  deleteRetentionPolicy?: DeleteRetentionPolicy;
}

/**
 * Volume response properties.
 */
model VolumeProperties {
  /**
   * Unique Id of the volume in GUID format
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  storageTarget?: IscsiTargetInfo;

  /**
   * Parent resource information.
   */
  managedBy?: ManagedByInfo;

  /**
   * State of the operation on the resource.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  targetIqn?: string;

  /**
   * iSCSI Target Portal Host Name
   */
  @visibility(Lifecycle.Read)
  targetPortalHostname?: string;

  /**
   * iSCSI Target Portal Port
   */
  @visibility(Lifecycle.Read)
  targetPortalPort?: int32;

  /**
   * State of the operation on the resource.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * List of Volumes
 */
model VolumeList is Azure.Core.Page<Volume>;

/**
 * A list of private link resources
 */
model PrivateLinkResourceListResult {
  /**
   * Array of private link resources
   */
  @items
  value: PrivateLinkResource[];

  /**
   * URI to fetch the next section of the paginated response.
   */
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A private link resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateLinkResource extends Azure.ResourceManager.Foundations.Resource {
  /**
   * Resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: PrivateLinkResourceProperties;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * List of Snapshots
 */
model SnapshotList is Azure.Core.Page<Snapshot>;

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
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningStates;

  /**
   * Size of Source Volume
   */
  @visibility(Lifecycle.Read)
  sourceVolumeSizeGiB?: int64;

  /**
   * Source Volume Name of a snapshot
   */
  @visibility(Lifecycle.Read)
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

/**
 * object to hold array of volume names
 */
model VolumeNameList {
  /**
   * array of volume names
   */
  volumeNames: string[];
}

/**
 * response object for pre validation api
 */
model PreValidationResponse {
  /**
   * a status value indicating success or failure of validation
   */
  validationStatus?: string;
}

/**
 * object to hold array of Disk Snapshot ARM IDs
 */
model DiskSnapshotList {
  /**
   * array of DiskSnapshot ARM IDs
   */
  diskSnapshotIds: Azure.Core.armResourceIdentifier[];
}
