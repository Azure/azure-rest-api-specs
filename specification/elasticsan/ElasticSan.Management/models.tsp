import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.ElasticSan;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The sku name.")
enum SkuName {
  @doc("Premium locally redundant storage") Premium_LRS,
  @doc("Premium zone redundant storage") Premium_ZRS,
}

@doc("Provisioning state of the iSCSI Target.")
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

@doc("The private endpoint connection status.")
enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Failed,
  Rejected,
}

@doc("Allow or disallow public network access to ElasticSan. Value is optional but if passed in, must be 'Enabled' or 'Disabled'.")
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

@doc("The identity type.")
enum IdentityType {
  None,
  SystemAssigned,
  UserAssigned,
}

@doc("Storage Target type.")
enum StorageTargetType {
  Iscsi,
  None,
}

@doc("The type of key used to encrypt the data of the disk.")
enum EncryptionType {
  @doc("Volume is encrypted at rest with Platform managed key. It is the default encryption type.")
  EncryptionAtRestWithPlatformKey,

  @doc("Volume is encrypted at rest with Customer managed key that can be changed and revoked by a customer.")
  EncryptionAtRestWithCustomerManagedKey,
}

@doc("The action of virtual network rule.")
enum Action {
  Allow,
}

@doc("This enumerates the possible sources of a volume creation.")
enum VolumeCreateOption {
  None,
  VolumeSnapshot,
  DiskSnapshot,
  Disk,
  DiskRestorePoint,
}

@doc("Operational status of the resource.")
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

@doc("The sku tier.")
enum SkuTier {
  @doc("Premium Tier")
  Premium,
}

enum XMsDeleteSnapshots {
  `true`,
  `false`,
}

enum XMsForceDelete {
  `true`,
  `false`,
}

@doc("List of SKU Information objects")
@pagedResult
model SkuInformationList {
  @doc("List of ResourceType Sku")
  @items
  @visibility("read")
  value?: SkuInformation[];

  @doc("URI to fetch the next section of the paginated response.")
  @nextLink
  @visibility("read")
  nextLink?: string;
}

@doc("ElasticSAN SKU and its properties")
model SkuInformation {
  @doc("Sku Name")
  name: SkuName;

  @doc("Sku Tier")
  tier?: SkuTier;

  @doc("The type of the resource.")
  @visibility("read")
  resourceType?: string;

  @doc("The set of locations that the SKU is available. This will be supported and registered Azure Geo Regions (e.g. West US, East US, Southeast Asia, etc.).")
  @visibility("read")
  locations?: string[];

  @doc("Availability of the SKU for the location/zone")
  @visibility("read")
  locationInfo?: SkuLocationInfo[];

  @doc("The capability information in the specified SKU.")
  @visibility("read")
  capabilities?: SKUCapability[];
}

@doc("The location info.")
model SkuLocationInfo {
  @doc("The location.")
  @visibility("read")
  location?: string;

  @doc("The zones.")
  @visibility("read")
  zones?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
@doc("The capability information in the specified SKU.")
model SKUCapability {
  @doc("The name of capability.")
  @visibility("read")
  name?: string;

  @doc("A string value to indicate states of given capability.")
  @visibility("read")
  value?: string;
}

@doc("Elastic San response properties.")
model ElasticSanProperties {
  @doc("resource sku")
  sku: Sku;

  @doc("Logical zone for Elastic San resource; example: [\"1\"].")
  availabilityZones?: string[];

  @doc("State of the operation on the resource.")
  @visibility("read")
  provisioningState?: ProvisioningStates;

  @doc("Base size of the Elastic San appliance in TiB.")
  @visibility("read", "create")
  baseSizeTiB: int64;

  @doc("Extended size of the Elastic San appliance in TiB.")
  @visibility("read", "create")
  extendedCapacitySizeTiB: int64;

  @doc("Total size of the provisioned Volumes in GiB.")
  @visibility("read")
  totalVolumeSizeGiB?: int64;

  @doc("Total number of volume groups in this Elastic San appliance.")
  @visibility("read")
  volumeGroupCount?: int64;

  @doc("Total Provisioned IOPS of the Elastic San appliance.")
  @visibility("read")
  totalIops?: int64;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @doc("Total Provisioned MBps Elastic San appliance.")
  @visibility("read")
  totalMBps?: int64;

  @doc("Total size of the Elastic San appliance in TB.")
  @visibility("read")
  totalSizeTiB?: int64;

  @doc("The list of Private Endpoint Connections.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("Allow or disallow public network access to ElasticSan. Value is optional but if passed in, must be 'Enabled' or 'Disabled'.")
  publicNetworkAccess?: PublicNetworkAccess;
}

@doc("The SKU name. Required for account creation; optional for update.")
model Sku {
  @doc("The sku name.")
  name: SkuName;

  @doc("The sku tier.")
  tier?: SkuTier;
}

@doc(" Response for PrivateEndpoint connection properties")
model PrivateEndpointConnectionProperties {
  @doc("Provisioning State of Private Endpoint connection resource")
  @visibility("read")
  provisioningState?: ProvisioningStates;

  @doc("Private Endpoint resource")
  privateEndpoint?: PrivateEndpoint;

  @doc("Private Link Service Connection State.")
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  @doc(" List of resources private endpoint is mapped")
  groupIds?: string[];
}

@doc("Response for PrivateEndpoint")
model PrivateEndpoint {
  @doc("The ARM identifier for Private Endpoint")
  @visibility("read")
  id?: string;
}

@doc("Response for Private Link Service Connection state")
model PrivateLinkServiceConnectionState {
  @doc("Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.")
  status?: PrivateEndpointServiceConnectionStatus;

  @doc("The reason for approval/rejection of the connection.")
  description?: string;

  @doc("A message indicating if changes on the service provider require any updates on the consumer.")
  actionsRequired?: string;
}

@doc("Response for ElasticSan update request.")
model ElasticSanUpdate {
  @doc("Properties of ElasticSan.")
  @extension("x-ms-client-flatten", true)
  properties?: ElasticSanUpdateProperties;

  @doc("Update tags")
  tags?: Record<string>;
}

@doc("Elastic San update properties.")
model ElasticSanUpdateProperties {
  @doc("Base size of the Elastic San appliance in TiB.")
  @visibility("update")
  baseSizeTiB?: int64;

  @doc("Extended size of the Elastic San appliance in TiB.")
  @visibility("update")
  extendedCapacitySizeTiB?: int64;

  @doc("Allow or disallow public network access to ElasticSan Account. Value is optional but if passed in, must be 'Enabled' or 'Disabled'.")
  publicNetworkAccess?: PublicNetworkAccess;
}

@doc("Identity for the resource.")
model Identity {
  @doc("The principal ID of resource identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of resource.")
  @visibility("read")
  tenantId?: string;

  @doc("The identity type.")
  type: IdentityType;

  @doc("Gets or sets a list of key value pairs that describe the set of User Assigned identities that will be used with this volume group. The key is the ARM resource identifier of the identity.")
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

@doc("UserAssignedIdentity for the resource.")
model UserAssignedIdentity {
  @doc("The principal ID of the identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client ID of the identity.")
  @visibility("read")
  clientId?: string;
}

@doc("VolumeGroup response properties.")
model VolumeGroupProperties {
  @doc("State of the operation on the resource.")
  @visibility("read")
  provisioningState?: ProvisioningStates;

  @doc("Type of storage target")
  protocolType?: StorageTargetType;

  @doc("Type of encryption")
  encryption?: EncryptionType;

  @doc("Encryption Properties describing Key Vault and Identity information")
  encryptionProperties?: EncryptionProperties;

  @doc("A collection of rules governing the accessibility from specific network locations.")
  @visibility("read", "create")
  networkAcls?: NetworkRuleSet;

  @doc("The list of Private Endpoint Connections.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];
}

@doc("The encryption settings on the volume group.")
model EncryptionProperties {
  @doc("Properties provided by key vault.")
  keyVaultProperties?: KeyVaultProperties;

  @doc("The identity to be used with service-side encryption at rest.")
  @projectedName("json", "identity")
  encryptionIdentity?: EncryptionIdentity;
}

@doc("Properties of key vault.")
model KeyVaultProperties {
  @doc("The name of KeyVault key.")
  keyName?: string;

  @doc("The version of KeyVault key.")
  keyVersion?: string;

  @doc("The Uri of KeyVault.")
  keyVaultUri?: url;

  @doc("The object identifier of the current versioned Key Vault Key in use.")
  @visibility("read")
  currentVersionedKeyIdentifier?: string;

  @doc("Timestamp of last rotation of the Key Vault Key.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastKeyRotationTimestamp?: utcDateTime;

  @doc("This is a read only property that represents the expiration time of the current version of the customer managed key used for encryption.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  currentVersionedKeyExpirationTimestamp?: utcDateTime;
}

@doc("Encryption identity for the volume group.")
model EncryptionIdentity {
  @doc("Resource identifier of the UserAssigned identity to be associated with server-side encryption on the volume group.")
  @projectedName("json", "userAssignedIdentity")
  encryptionUserAssignedIdentity?: string;
}

@doc("A set of rules governing the network accessibility.")
model NetworkRuleSet {
  @doc("The list of virtual network rules.")
  virtualNetworkRules?: VirtualNetworkRule[];
}

@doc("Virtual Network rule.")
model VirtualNetworkRule {
  @doc("Resource ID of a subnet, for example: /subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/Microsoft.Network/virtualNetworks/{vnetName}/subnets/{subnetName}.")
  @projectedName("json", "id")
  virtualNetworkResourceId: string;

  @doc("The action of virtual network rule.")
  action?: Action = Action.Allow;
}

@doc("Volume Group request.")
model VolumeGroupUpdate {
  @doc("The identity of the resource.")
  identity?: Identity;

  @doc("Properties of VolumeGroup.")
  @extension("x-ms-client-flatten", true)
  properties?: VolumeGroupUpdateProperties;
}

@doc("VolumeGroup response properties.")
model VolumeGroupUpdateProperties {
  @doc("Type of storage target")
  protocolType?: StorageTargetType;

  @doc("Type of encryption")
  encryption?: EncryptionType;

  @doc("Encryption Properties describing Key Vault and Identity information")
  encryptionProperties?: EncryptionProperties;

  @doc("A collection of rules governing the accessibility from specific network locations.")
  @visibility("update")
  networkAcls?: NetworkRuleSet;
}

@doc("Volume response properties.")
model VolumeProperties {
  @doc("Unique Id of the volume in GUID format")
  @visibility("read")
  volumeId?: string;

  @doc("State of the operation on the resource.")
  creationData?: SourceCreationData;

  @doc("Volume size.")
  sizeGiB: int64;

  @doc("Storage target information")
  @visibility("read")
  storageTarget?: IscsiTargetInfo;

  @doc("Parent resource information.")
  managedBy?: ManagedByInfo;

  @doc("State of the operation on the resource.")
  @visibility("read")
  provisioningState?: ProvisioningStates;
}

@doc("Data source used when creating the volume.")
model SourceCreationData {
  @doc("This enumerates the possible sources of a volume creation.")
  createSource?: VolumeCreateOption;

  @doc("Fully qualified resource ID for the resource. E.g. \"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}\"")
  sourceId?: string;
}

@doc("Iscsi target information")
model IscsiTargetInfo {
  @doc("iSCSI Target IQN (iSCSI Qualified Name); example: \"iqn.2005-03.org.iscsi:server\".")
  @visibility("read")
  targetIqn?: string;

  @doc("iSCSI Target Portal Host Name")
  @visibility("read")
  targetPortalHostname?: string;

  @doc("iSCSI Target Portal Port")
  @visibility("read")
  targetPortalPort?: int32;

  @doc("State of the operation on the resource.")
  @visibility("read")
  provisioningState?: ProvisioningStates;

  @doc("Operational status of the iSCSI Target.")
  status?: OperationalStatus;
}

@doc("Parent resource information.")
model ManagedByInfo {
  @doc("Resource ID of the resource managing the volume, this is a restricted field and can only be set for internal use.")
  resourceId?: string;
}

@doc("Response for Volume request.")
model VolumeUpdate {
  @doc("Properties of Volume.")
  @extension("x-ms-client-flatten", true)
  properties?: VolumeUpdateProperties;
}

@doc("Volume response properties.")
model VolumeUpdateProperties {
  @doc("Volume size.")
  sizeGiB?: int64;

  @doc("Parent resource information.")
  managedBy?: ManagedByInfo;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "No common resource"
@doc("Properties of a private link resource.")
model PrivateLinkResourceProperties {
  @doc("The private link resource group id.")
  @visibility("read")
  groupId?: string;

  @doc("The private link resource required member names.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("The private link resource Private link DNS zone name.")
  requiredZoneNames?: string[];
}

@doc("Properties for Snapshot.")
model SnapshotProperties {
  @doc("Data used when creating a volume snapshot.")
  creationData: SnapshotCreationData;

  @doc("State of the operation on the resource.")
  @visibility("read")
  provisioningState?: ProvisioningStates;

  @doc("Size of Source Volume")
  @visibility("read")
  sourceVolumeSizeGiB?: int64;

  @doc("Source Volume Name of a snapshot")
  @visibility("read")
  volumeName?: string;
}

@doc("Data used when creating a volume snapshot.")
model SnapshotCreationData {
  @doc("Fully qualified resource ID of the volume. E.g. \"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/volumegroups/{volumeGroupName}/volumes/{volumeName}\"")
  sourceId: string;
}
