import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ElasticSanManagement;

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

enum SkuName {
  @doc("Premium locally redundant storage") Premium_LRS,
  @doc("Premium zone redundant storage") Premium_ZRS,
}

enum SkuTier {
  @doc("Premium Tier") Premium,
}

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

enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Failed,
  Rejected,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

enum IdentityType {
  None,
  SystemAssigned,
  UserAssigned,
}

enum StorageTargetType {
  Iscsi,
  None,
}

enum EncryptionType {
  @doc("""
Volume is encrypted at rest with Platform managed key. It is the default
encryption type.
""")
  EncryptionAtRestWithPlatformKey,
  @doc("""
Volume is encrypted at rest with Customer managed key that can be changed and
revoked by a customer.
""")
  EncryptionAtRestWithCustomerManagedKey,
}

enum Action {
  Allow,
}

enum VolumeCreateOption {
  None,
  VolumeSnapshot,
  DiskSnapshot,
  Disk,
  DiskRestorePoint,
}

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

@doc("""
A list of REST API operations supported by an Azure Resource Provider. It
contains an URL link to get the next set of results.
""")
model OperationListResult is Azure.Core.Page<Operation>;

@doc("""
Details of a REST API operation, returned from the Resource Provider Operations
API
""")
model Operation {
  @doc("""
The name of the operation, as per Resource-Based Access Control (RBAC).
Examples: \"Microsoft.Compute/virtualMachines/write\",
\"Microsoft.Compute/virtualMachines/capture/action\"
""")
  @visibility("read")
  name?: string;

  @doc("""
Whether the operation applies to data-plane. This is \"true\" for data-plane
operations and \"false\" for ARM/control-plane operations.
""")
  @visibility("read")
  isDataAction?: boolean;

  @doc("Localized display information for this particular operation.")
  display?: OperationDisplay;

  @doc("""
The intended executor of the operation; as in Resource Based Access Control
(RBAC) and audit logs UX. Default value is \"user,system\"
""")
  @visibility("read")
  origin?: Origin;

  @doc("""
Enum. Indicates the action type. \"Internal\" refers to actions that are for
internal only APIs.
""")
  @visibility("read")
  actionType?: ActionType;
}

@doc("Localized display information for this particular operation.")
model OperationDisplay {
  @doc("""
The localized friendly form of the resource provider name, e.g. \"Microsoft
Monitoring Insights\" or \"Microsoft Compute\".
""")
  @visibility("read")
  provider?: string;

  @doc("""
The localized friendly name of the resource type related to this operation.
E.g. \"Virtual Machines\" or \"Job Schedule Collections\".
""")
  @visibility("read")
  resource?: string;

  @doc("""
The concise, localized friendly name for the operation; suitable for dropdowns.
E.g. \"Create or Update Virtual Machine\", \"Restart Virtual Machine\".
""")
  @visibility("read")
  operation?: string;

  @doc("""
The short, localized friendly description of the operation; suitable for tool
tips and detailed views.
""")
  @visibility("read")
  description?: string;
}

@doc("""
Common error response for all Azure Resource Manager APIs to return error
details for failed operations. (This also follows the OData error response
format.).
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

@doc("List of SKU Information objects")
model SkuInformationList is Azure.Core.Page<SkuInformation>;

@doc("ElasticSAN SKU and its properties")
model SkuInformation {
  @doc("Sku Name")
  name: SkuName;

  @doc("Sku Tier")
  tier?: SkuTier;

  @doc("The type of the resource.")
  @visibility("read")
  resourceType?: string;

  @doc("""
The set of locations that the SKU is available. This will be supported and
registered Azure Geo Regions (e.g. West US, East US, Southeast Asia, etc.).
""")
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

@doc("The capability information in the specified SKU.")
model SKUCapability {
  @doc("The name of capability.")
  @visibility("read")
  name?: string;

  @doc("A string value to indicate states of given capability.")
  @visibility("read")
  value?: string;
}

@doc("List of Elastic Sans")
model ElasticSanList is Azure.Core.Page<ElasticSan>;

@doc("Response for ElasticSan request.")
model ElasticSan {
  ...TrackedResource;

  @doc("Properties of ElasticSan.")
  properties: ElasticSanProperties;
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
  baseSizeTiB: int32;

  @doc("Extended size of the Elastic San appliance in TiB.")
  extendedCapacitySizeTiB: int32;

  @doc("Total size of the provisioned Volumes in GiB.")
  @visibility("read")
  totalVolumeSizeGiB?: int32;

  @doc("Total number of volume groups in this Elastic San appliance.")
  @visibility("read")
  volumeGroupCount?: int32;

  @doc("Total Provisioned IOPS of the Elastic San appliance.")
  @visibility("read")
  totalIops?: int32;

  @doc("Total Provisioned MBps Elastic San appliance.")
  @visibility("read")
  totalMBps?: int32;

  @doc("Total size of the Elastic San appliance in TB.")
  @visibility("read")
  totalSizeTiB?: int32;

  @doc("The list of Private Endpoint Connections.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("""
Allow or disallow public network access to ElasticSan. Value is optional but if
passed in, must be 'Enabled' or 'Disabled'.
""")
  publicNetworkAccess?: PublicNetworkAccess;
}

@doc("The SKU name. Required for account creation; optional for update.")
model Sku {
  @doc("The sku name.")
  name: SkuName;

  @doc("The sku tier.")
  tier?: SkuTier;
}

@doc(" Response for PrivateEndpoint Connection object")
model PrivateEndpointConnection {
  ...Resource;

  @doc("Private Endpoint Connection Properties.")
  properties: PrivateEndpointConnectionProperties;
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
  @doc("""
Indicates whether the connection has been Approved/Rejected/Removed by the
owner of the service.
""")
  status?: PrivateEndpointServiceConnectionStatus;

  @doc("The reason for approval/rejection of the connection.")
  description?: string;

  @doc("""
A message indicating if changes on the service provider require any updates on
the consumer.
""")
  actionsRequired?: string;
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

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
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

  @doc("The timestamp of resource last modification (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

@doc("""
The resource model definition for an Azure Resource Manager tracked top level
resource which has 'tags' and a 'location'
""")
model TrackedResource {
  ...Resource;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The geo-location where the resource lives")
  location: string;
}

@doc("Response for ElasticSan update request.")
model ElasticSanUpdate {
  @doc("Properties of ElasticSan.")
  properties?: ElasticSanUpdateProperties;

  @doc("Update tags")
  tags?: Record<string>;
}

@doc("Elastic San update properties.")
model ElasticSanUpdateProperties {
  @doc("Base size of the Elastic San appliance in TiB.")
  baseSizeTiB?: int32;

  @doc("Extended size of the Elastic San appliance in TiB.")
  extendedCapacitySizeTiB?: int32;

  @doc("""
Allow or disallow public network access to ElasticSan Account. Value is
optional but if passed in, must be 'Enabled' or 'Disabled'.
""")
  publicNetworkAccess?: PublicNetworkAccess;
}

@doc("List of Volume Groups")
model VolumeGroupList is Azure.Core.Page<VolumeGroup>;

@doc("Response for Volume Group request.")
model VolumeGroup {
  ...ProxyResource;

  @doc("The identity of the resource.")
  identity?: Identity;

  @doc("Properties of VolumeGroup.")
  properties?: VolumeGroupProperties;
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

  @doc("""
Gets or sets a list of key value pairs that describe the set of User Assigned
identities that will be used with this volume group. The key is the ARM
resource identifier of the identity.
""")
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

  @doc("""
A collection of rules governing the accessibility from specific network
locations.
""")
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
  keyVaultUri?: string;

  @doc("The object identifier of the current versioned Key Vault Key in use.")
  @visibility("read")
  currentVersionedKeyIdentifier?: string;

  @doc("Timestamp of last rotation of the Key Vault Key.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastKeyRotationTimestamp?: utcDateTime;

  @doc("""
This is a read only property that represents the expiration time of the current
version of the customer managed key used for encryption.
""")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  currentVersionedKeyExpirationTimestamp?: utcDateTime;
}

@doc("Encryption identity for the volume group.")
model EncryptionIdentity {
  @doc("""
Resource identifier of the UserAssigned identity to be associated with
server-side encryption on the volume group.
""")
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
  @doc("""
Resource ID of a subnet, for example:
/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/Microsoft.Network/virtualNetworks/{vnetName}/subnets/{subnetName}.
""")
  @projectedName("json", "id")
  virtualNetworkResourceId: string;

  @doc("The action of virtual network rule.")
  action?: Action;
}

@doc("""
The resource model definition for a Azure Resource Manager proxy resource. It
will not have tags and a location
""")
model ProxyResource {
  ...Resource;
}

@doc("Volume Group request.")
model VolumeGroupUpdate {
  @doc("The identity of the resource.")
  identity?: Identity;

  @doc("Properties of VolumeGroup.")
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

  @doc("""
A collection of rules governing the accessibility from specific network
locations.
""")
  networkAcls?: NetworkRuleSet;
}

@doc("Response for Volume request.")
model Volume {
  ...ProxyResource;

  @doc("Properties of Volume.")
  properties: VolumeProperties;
}

@doc("Volume response properties.")
model VolumeProperties {
  @doc("Unique Id of the volume in GUID format")
  @visibility("read")
  volumeId?: string;

  @doc("State of the operation on the resource.")
  creationData?: SourceCreationData;

  @doc("Volume size.")
  sizeGiB: int32;

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

  @doc("""
Fully qualified resource ID for the resource. E.g.
\"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}\"
""")
  sourceId?: string;
}

@doc("Iscsi target information")
model IscsiTargetInfo {
  @doc("""
iSCSI Target IQN (iSCSI Qualified Name); example:
\"iqn.2005-03.org.iscsi:server\".
""")
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
  @doc("""
Resource ID of the resource managing the volume, this is a restricted field and
can only be set for internal use.
""")
  resourceId?: string;
}

@doc("Response for Volume request.")
model VolumeUpdate {
  @doc("Properties of Volume.")
  properties?: VolumeUpdateProperties;
}

@doc("Volume response properties.")
model VolumeUpdateProperties {
  @doc("Volume size.")
  sizeGiB?: int32;

  @doc("Parent resource information.")
  managedBy?: ManagedByInfo;
}

@doc("List of Volumes")
model VolumeList is Azure.Core.Page<Volume>;

@doc("List of private endpoint connections associated with SAN")
model PrivateEndpointConnectionListResult
  is Azure.Core.Page<PrivateEndpointConnection>;

@doc("A list of private link resources")
model PrivateLinkResourceListResult {
  @doc("Array of private link resources")
  value?: PrivateLinkResource[];

  @doc("URI to fetch the next section of the paginated response.")
  @visibility("read")
  nextLink?: string;
}

@doc("A private link resource")
model PrivateLinkResource {
  ...Resource;

  @doc("Resource properties.")
  properties?: PrivateLinkResourceProperties;
}

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

@doc("List of Snapshots")
model SnapshotList is Azure.Core.Page<Snapshot>;

@doc("Response for Volume Snapshot request.")
model Snapshot {
  ...ProxyResource;

  @doc("Properties of Volume Snapshot.")
  properties: SnapshotProperties;
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
  sourceVolumeSizeGiB?: int32;

  @doc("Source Volume Name of a snapshot")
  @visibility("read")
  volumeName?: string;
}

@doc("Data used when creating a volume snapshot.")
model SnapshotCreationData {
  @doc("""
Fully qualified resource ID of the volume. E.g.
\"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/volumegroups/{volumeGroupName}/volumes/{volumeName}\"
""")
  sourceId: string;
}
