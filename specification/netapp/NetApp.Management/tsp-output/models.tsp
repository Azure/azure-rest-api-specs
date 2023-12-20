import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Azure.ResourceManager.NetApp;

interface Operations extends Azure.ResourceManager.Operations {}

enum MetricAggregationType {
  Average,
}

enum CheckNameResourceTypes {
  `Microsoft.NetApp/netAppAccounts`,
  `Microsoft.NetApp/netAppAccounts/capacityPools`,
  `Microsoft.NetApp/netAppAccounts/capacityPools/volumes`,
  `Microsoft.NetApp/netAppAccounts/capacityPools/volumes/snapshots`,
}

enum InAvailabilityReasonType {
  Invalid,
  AlreadyExists,
}

enum CheckQuotaNameResourceTypes {
  `Microsoft.NetApp/netAppAccounts`,
  `Microsoft.NetApp/netAppAccounts/capacityPools`,
  `Microsoft.NetApp/netAppAccounts/capacityPools/volumes`,
  `Microsoft.NetApp/netAppAccounts/capacityPools/volumes/snapshots`,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum RegionStorageToNetworkProximity {
  @doc("Basic network connectivity.") Default,
  @doc("Standard T1 network connectivity.") T1,
  @doc("Standard T2 network connectivity.") T2,
  @doc("Standard AcrossT2 network connectivity.") AcrossT2,
  @doc("Standard T1 and T2 network connectivity.") T1AndT2,
  @doc("Standard T1 and AcrossT2 network connectivity.") T1AndAcrossT2,
  @doc("Standard T2 and AcrossT2 network connectivity.") T2AndAcrossT2,
  @doc("Standard T1, T2 and AcrossT2 network connectivity.") T1AndT2AndAcrossT2,
}

enum NetworkFeatures {
  @doc("Basic network features.") Basic,
  @doc("Standard network features.") Standard,
  @doc("Updating from Basic to Standard network features.") Basic_Standard,
  @doc("Updating from Standard to Basic network features.") Standard_Basic,
}

enum NetworkSiblingSetProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Updating,
}

enum ActiveDirectoryStatus {
  @doc("Active Directory created but not in use") Created,
  @doc("Active Directory in use by SMB Volume") InUse,
  @doc("Active Directory Deleted") Deleted,
  @doc("Error with the Active Directory") Error,
  @doc("Active Directory Updating") Updating,
}

enum KeySource {
  @doc("Microsoft-managed key encryption") `Microsoft.NetApp`,
  @doc("Customer-managed key encryption") `Microsoft.KeyVault`,
}

enum KeyVaultStatus {
  @doc("KeyVault connection created but not in use") Created,
  @doc("KeyVault connection in use by SMB Volume") InUse,
  @doc("KeyVault connection Deleted") Deleted,
  @doc("Error with the KeyVault connection") Error,
  @doc("KeyVault connection Updating") Updating,
}

enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

enum ServiceLevel {
  @doc("Standard service level") Standard,
  @doc("Premium service level") Premium,
  @doc("Ultra service level") Ultra,
  @doc("Zone redundant storage service level") StandardZRS,
}

enum QosType {
  @doc("qos type Auto") Auto,
  @doc("qos type Manual") Manual,
}

enum EncryptionType {
  @doc("EncryptionType Single, volumes will use single encryption at rest")
  Single,
  @doc("EncryptionType Double, volumes will use double encryption at rest")
  Double,
}

enum ChownMode {
  Restricted,
  Unrestricted,
}

enum VolumeStorageToNetworkProximity {
  @doc("Basic storage to network connectivity.") Default,
  @doc("Standard T1 storage to network connectivity.") T1,
  @doc("Standard T2 storage to network connectivity.") T2,
  @doc("Standard AcrossT2 storage to network connectivity.") AcrossT2,
}

enum EndpointType {
  src,
  dst,
}

enum ReplicationSchedule {
  _10minutely,
  hourly,
  daily,
}

enum SecurityStyle {
  ntfs,
  unix,
}

enum SmbAccessBasedEnumeration {
  @doc("smbAccessBasedEnumeration share setting is disabled") Disabled,
  @doc("smbAccessBasedEnumeration share setting is enabled") Enabled,
}

enum SmbNonBrowsable {
  @doc("smbNonBrowsable share setting is disabled") Disabled,
  @doc("smbNonBrowsable share setting is enabled") Enabled,
}

enum EncryptionKeySource {
  @doc("Microsoft-managed key encryption") `Microsoft.NetApp`,
  @doc("Customer-managed key encryption") `Microsoft.KeyVault`,
}

enum CoolAccessRetrievalPolicy {
  Default,
  OnRead,
  Never,
}

enum FileAccessLogs {
  @doc("fileAccessLogs are enabled") Enabled,
  @doc("fileAccessLogs are not enabled") Disabled,
}

enum AvsDataStore {
  @doc("avsDataStore is enabled") Enabled,
  @doc("avsDataStore is disabled") Disabled,
}

enum EnableSubvolumes {
  @doc("subvolumes are enabled") Enabled,
  @doc("subvolumes are not enabled") Disabled,
}

enum RelationshipStatus {
  Idle,
  Transferring,
}

enum MirrorState {
  Uninitialized,
  Mirrored,
  Broken,
}

enum Type {
  @doc("Default user quota") DefaultUserQuota,
  @doc("Default group quota") DefaultGroupQuota,
  @doc("Individual user quota") IndividualUserQuota,
  @doc("Individual group quota") IndividualGroupQuota,
}

enum ApplicationType {
  `SAP-HANA`,
  ORACLE,
}
@Azure.Core.fixed
enum ProvisioningState {
  Accepted,
  Creating,
  Patching,
  Deleting,
  Moving,
  Failed,
  Succeeded,
}

@doc("Properties of operation, include metric specifications.")
model OperationProperties {
  @doc("One property of operation, include metric specifications.")
  serviceSpecification?: ServiceSpecification;
}

@doc("One property of operation, include metric specifications.")
model ServiceSpecification {
  @doc("Metric specifications of operation.")
  metricSpecifications?: MetricSpecification[];

  @doc("Log specification of operation.")
  logSpecifications?: LogSpecification[];
}

@doc("Metric specification of operation.")
model MetricSpecification {
  @doc("Name of metric specification.")
  name?: string;

  @doc("Display name of metric specification.")
  displayName?: string;

  @doc("Display description of metric specification.")
  displayDescription?: string;

  @doc("Unit could be Bytes or Count.")
  unit?: string;

  @doc("Support metric aggregation type.")
  supportedAggregationTypes?: MetricAggregationType[];

  @doc("The supported time grain types for the metrics.")
  supportedTimeGrainTypes?: string[];

  @doc("The internal metric name.")
  internalMetricName?: string;

  @doc("Whether or not the service is using regional MDM accounts.")
  enableRegionalMdmAccount?: boolean;

  @doc("The source MDM account.")
  sourceMdmAccount?: string;

  @doc("The source MDM namespace.")
  sourceMdmNamespace?: string;

  @doc("Dimensions of blobs, including blob type and access tier.")
  dimensions?: Dimension[];

  @doc("Aggregation type could be Average.")
  aggregationType?: string;

  @doc("The property to decide fill gap with zero or not.")
  fillGapWithZero?: boolean;

  @doc("The category this metric specification belong to, could be Capacity.")
  category?: string;

  @doc("Account Resource Id.")
  resourceIdDimensionNameOverride?: string;

  @doc("Whether the metric is internal.")
  isInternal?: boolean;
}

@doc("Dimension of blobs, possibly be blob type or access tier.")
model Dimension {
  @doc("Display name of dimension.")
  name?: string;

  @doc("Display name of dimension.")
  displayName?: string;
}

@doc("Log Definition of a single resource metric.")
model LogSpecification {
  @doc("Name of log specification.")
  name?: string;

  @doc("Display name of log specification.")
  displayName?: string;
}

@doc("Resource name availability request content.")
model ResourceNameAvailabilityRequest {
  @doc("Resource name to verify.")
  name: string;

  @doc("Resource type used for verification.")
  type: CheckNameResourceTypes;

  @doc("Resource group name.")
  resourceGroup: string;
}

@doc("Information regarding availability of a resource.")
model CheckAvailabilityResponse {
  @doc("<code>true</code> indicates name is valid and available. <code>false</code> indicates the name is invalid, unavailable, or both.")
  isAvailable?: boolean;

  @doc("<code>Invalid</code> indicates the name provided does not match Azure App Service naming requirements. <code>AlreadyExists</code> indicates that the name is already in use and is therefore unavailable.")
  reason?: InAvailabilityReasonType;

  @doc("If reason == invalid, provide the user with the reason why the given name is invalid, and provide the resource naming requirements so that the user can select a valid name. If reason == AlreadyExists, explain that resource name is already in use, and direct them to select a different name.")
  message?: string;
}

@doc("File path availability request content - availability is based on the name and the subnetId.")
model FilePathAvailabilityRequest {
  @doc("File path to verify.")
  name: string;

  @doc("The Azure Resource URI for a delegated subnet. Must have the delegation Microsoft.NetApp/volumes")
  subnetId: string;
}

@doc("Quota availability request content.")
model QuotaAvailabilityRequest {
  @doc("Name of the resource to verify.")
  name: string;

  @doc("Resource type used for verification.")
  type: CheckQuotaNameResourceTypes;

  @doc("Resource group name.")
  resourceGroup: string;
}

@doc("List of Subscription Quota Items")
@pagedResult
model SubscriptionQuotaItemList {
  @doc("A list of SubscriptionQuotaItems")
  @items
  value?: SubscriptionQuotaItem[];
}

@doc("Information regarding Subscription Quota Item.")
model SubscriptionQuotaItem {
  ...ProxyResource;

  @doc("SubscriptionQuotaItem properties")
  properties?: SubscriptionQuotaItemProperties;
}

@doc("SubscriptionQuotaItem Properties")
model SubscriptionQuotaItemProperties {
  @doc("The current quota value.")
  @visibility("read")
  current?: int32;

  @doc("The default quota value.")
  @visibility("read")
  default?: int32;
}

@doc("Provides region specific information.")
model RegionInfo {
  @doc("Provides storage to network proximity information in the region.")
  storageToNetworkProximity?: RegionStorageToNetworkProximity;

  @doc("Provides logical availability zone mappings for the subscription for a region.")
  availabilityZoneMappings?: RegionInfoAvailabilityZoneMappingsItem[];
}

model RegionInfoAvailabilityZoneMappingsItem {
  @doc("Logical availability zone.")
  availabilityZone?: string;

  @doc("Available availability zone")
  isAvailable?: boolean;
}

@doc("Network sibling set query.")
model QueryNetworkSiblingSetRequest {
  @doc("Network Sibling Set ID for a group of volumes sharing networking resources in a subnet.")
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  networkSiblingSetId: string;

  @doc("The Azure Resource URI for a delegated subnet. Must have the delegation Microsoft.NetApp/volumes. Example /subscriptions/subscriptionId/resourceGroups/resourceGroup/providers/Microsoft.Network/virtualNetworks/testVnet/subnets/{mySubnet}")
  subnetId: ResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;
}

@doc("Describes the contents of a network sibling set.")
model NetworkSiblingSet {
  @doc("Network Sibling Set ID for a group of volumes sharing networking resources in a subnet.")
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  networkSiblingSetId?: string;

  @doc("The Azure Resource URI for a delegated subnet. Must have the delegation Microsoft.NetApp/volumes. Example /subscriptions/subscriptionId/resourceGroups/resourceGroup/providers/Microsoft.Network/virtualNetworks/testVnet/subnets/{mySubnet}")
  subnetId?: ResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  @doc("Network sibling set state Id identifying the current state of the sibling set.")
  networkSiblingSetStateId?: string;

  @doc("Network features available to the volume, or current state of update.")
  networkFeatures?: NetworkFeatures;

  @doc("Gets the status of the NetworkSiblingSet at the time the operation was called.")
  @visibility("read")
  provisioningState?: NetworkSiblingSetProvisioningState;

  @doc("List of NIC information")
  nicInfoList?: NicInfo[];
}

@doc("NIC information and list of volumes for which the NIC has the primary mount ip address.")
model NicInfo {
  @doc("ipAddress")
  @visibility("read")
  ipAddress?: string;

  @doc("Volume resource Ids")
  volumeResourceIds?: ResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes";
    }
  ]>[];
}

@doc("Network sibling set update.")
model UpdateNetworkSiblingSetRequest {
  @doc("Network Sibling Set ID for a group of volumes sharing networking resources in a subnet.")
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  networkSiblingSetId: string;

  @doc("The Azure Resource URI for a delegated subnet. Must have the delegation Microsoft.NetApp/volumes. Example /subscriptions/subscriptionId/resourceGroups/resourceGroup/providers/Microsoft.Network/virtualNetworks/testVnet/subnets/{mySubnet}")
  subnetId: ResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  @doc("Network sibling set state Id identifying the current state of the sibling set.")
  networkSiblingSetStateId: string;

  @doc("Network features available to the volume, some such")
  networkFeatures: NetworkFeatures;
}

@doc("NetApp account properties")
model AccountProperties {
  @doc("Azure lifecycle management")
  @visibility("read")
  provisioningState?: string;

  @doc("Active Directories")
  activeDirectories?: ActiveDirectory[];

  @doc("Encryption settings")
  encryption?: AccountEncryption;

  @doc("Shows the status of disableShowmount for all volumes under the subscription, null equals false")
  @visibility("read")
  disableShowmount?: boolean;
}

@doc("Active Directory")
model ActiveDirectory {
  @doc("Id of the Active Directory")
  activeDirectoryId?: string;

  @doc("A domain user account with permission to create machine accounts")
  username?: string;

  @doc("Plain text password of Active Directory domain administrator, value is masked in the response")
  @maxLength(64)
  password?: string;

  @doc("Name of the Active Directory domain")
  domain?: string;

  @doc("Comma separated list of DNS server IP addresses (IPv4 only) for the Active Directory domain")
  @pattern("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)((, ?)(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))*$")
  dns?: string;

  @doc("Status of the Active Directory")
  @visibility("read")
  status?: ActiveDirectoryStatus;

  @doc("Any details in regards to the Status of the Active Directory")
  @visibility("read")
  statusDetails?: string;

  @doc("NetBIOS name of the SMB server. This name will be registered as a computer account in the AD and used to mount volumes")
  smbServerName?: string;

  @doc("The Organizational Unit (OU) within the Windows Active Directory")
  organizationalUnit?: string;

  @doc("The Active Directory site the service will limit Domain Controller discovery to")
  site?: string;

  @doc("Users to be added to the Built-in Backup Operator active directory group. A list of unique usernames without domain specifier")
  backupOperators?: string[];

  @doc("Users to be added to the Built-in Administrators active directory group. A list of unique usernames without domain specifier")
  administrators?: string[];

  @doc("kdc server IP addresses for the active directory machine. This optional parameter is used only while creating kerberos volume.")
  @pattern("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)((, ?)(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))*$")
  kdcIP?: string;

  @doc("Name of the active directory machine. This optional parameter is used only while creating kerberos volume")
  @maxLength(64)
  @minLength(1)
  adName?: string;

  @doc("When LDAP over SSL/TLS is enabled, the LDAP client is required to have base64 encoded Active Directory Certificate Service's self-signed root CA certificate, this optional parameter is used only for dual protocol with LDAP user-mapping volumes.")
  @maxLength(10240)
  @minLength(1)
  serverRootCACertificate?: string;

  @doc("If enabled, AES encryption will be enabled for SMB communication.")
  aesEncryption?: boolean;

  @doc("Specifies whether or not the LDAP traffic needs to be signed.")
  ldapSigning?: boolean;

  @doc("Domain Users in the Active directory to be given SeSecurityPrivilege privilege (Needed for SMB Continuously available shares for SQL). A list of unique usernames without domain specifier")
  securityOperators?: string[];

  @doc("Specifies whether or not the LDAP traffic needs to be secured via TLS.")
  ldapOverTLS?: boolean;

  @doc(" If enabled, NFS client local users can also (in addition to LDAP users) access the NFS volumes.")
  allowLocalNfsUsersWithLdap?: boolean;

  @doc("If enabled, Traffic between the SMB server to Domain Controller (DC) will be encrypted.")
  encryptDCConnections?: boolean;

  @doc("LDAP Search scope options")
  ldapSearchScope?: LdapSearchScopeOpt;

  @doc("Comma separated list of IPv4 addresses of preferred servers for LDAP client. At most two comma separated IPv4 addresses can be passed.")
  @maxLength(32)
  @pattern("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)((, ?)(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))?)?$")
  preferredServersForLdapClient?: string;
}

@doc("LDAP search scope ")
model LdapSearchScopeOpt {
  @doc("This specifies the user DN, which overrides the base DN for user lookups.")
  @maxLength(255)
  userDN?: string;

  @doc("This specifies the group DN, which overrides the base DN for group lookups.")
  @maxLength(255)
  groupDN?: string;

  @doc("This specifies the custom LDAP search filter to be used when looking up group membership from LDAP server.")
  @maxLength(255)
  groupMembershipFilter?: string;
}

@doc("Encryption settings")
model AccountEncryption {
  @doc("The encryption keySource (provider). Possible values (case-insensitive):  Microsoft.NetApp, Microsoft.KeyVault")
  keySource?: KeySource;

  @doc("Properties provided by KeVault. Applicable if keySource is 'Microsoft.KeyVault'.")
  keyVaultProperties?: KeyVaultProperties;

  @doc("Identity used to authenticate to KeyVault. Applicable if keySource is 'Microsoft.KeyVault'.")
  identity?: EncryptionIdentity;
}

@doc("Properties of key vault.")
model KeyVaultProperties {
  @doc("UUID v4 used to identify the Azure Key Vault configuration")
  @visibility("read")
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  keyVaultId?: string;

  @doc("The Uri of KeyVault.")
  keyVaultUri: string;

  @doc("The name of KeyVault key.")
  keyName: string;

  @doc("The resource ID of KeyVault.")
  keyVaultResourceId: string;

  @doc("Status of the KeyVault connection.")
  @visibility("read")
  status?: KeyVaultStatus;
}

@doc("Identity used to authenticate with key vault.")
model EncryptionIdentity {
  @doc("The principal ID (object ID) of the identity used to authenticate with key vault. Read-only.")
  @visibility("read")
  principalId?: string;

  @doc("The ARM resource identifier of the user assigned identity used to authenticate with key vault. Applicable if identity.type has 'UserAssigned'. It should match key of identity.userAssignedIdentities.")
  userAssignedIdentity?: string;
}

@doc("User assigned identity properties")
model UserAssignedIdentity {
  @doc("The principal ID of the assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client ID of the assigned identity.")
  @visibility("read")
  clientId?: string;
}

@doc("An error response from the service.")
@error
model CloudError {
  @doc("Cloud error body.")
  error?: CloudErrorBody;
}

@doc("An error response from the service.")
model CloudErrorBody {
  @doc("An identifier for the error. Codes are invariant and are intended to be consumed programmatically.")
  code?: string;

  @doc("A message describing the error, intended to be suitable for display in a user interface.")
  message?: string;
}

@doc("Pool properties")
model PoolProperties {
  @doc("UUID v4 used to identify the Pool")
  @visibility("read")
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  poolId?: string;

  @doc("Provisioned size of the pool (in bytes). Allowed values are in 1TiB chunks (value must be multiply of 4398046511104).")
  size: int32;

  @doc("The service level of the file system")
  serviceLevel: ServiceLevel;

  @doc("Azure lifecycle management")
  @visibility("read")
  provisioningState?: string;

  @doc("Total throughput of pool in MiB/s")
  @visibility("read")
  totalThroughputMibps?: float32;

  @doc("Utilized throughput of pool in MiB/s")
  @visibility("read")
  utilizedThroughputMibps?: float32;

  @doc("The qos type of the pool")
  qosType?: QosType;

  @doc("If enabled (true) the pool can contain cool Access enabled volumes.")
  coolAccess?: boolean;

  @doc("Encryption type of the capacity pool, set encryption type for data at rest for this pool and all volumes in it. This value can only be set when creating new pool.")
  @visibility("read", "create")
  encryptionType?: EncryptionType;
}

@doc("Volume properties")
model VolumeProperties {
  @doc("Unique FileSystem Identifier.")
  @visibility("read")
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  fileSystemId?: string;

  @doc("A unique file path for the volume. Used when creating mount targets")
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-]{0,79}$")
  creationToken: string;

  @doc("The service level of the file system")
  serviceLevel?: ServiceLevel;

  @doc("Maximum storage quota allowed for a file system in bytes. This is a soft quota used for alerting only. Minimum size is 100 GiB. Upper limit is 100TiB, 500Tib for LargeVolume or 2400Tib for LargeVolume on exceptional basis. Specified in bytes.")
  @maxValue(2638827906662400)
  @minValue(107374182400)
  usageThreshold: int32;

  @doc("Set of export policy rules")
  exportPolicy?: VolumePropertiesExportPolicy;

  @doc("Set of protocol types, default NFSv3, CIFS for SMB protocol")
  protocolTypes?: string[];

  @doc("Azure lifecycle management")
  @visibility("read")
  provisioningState?: string;

  @doc("UUID v4 or resource identifier used to identify the Snapshot.")
  @visibility("read", "create")
  snapshotId?: string;

  @doc("If enabled (true) the snapshot the volume was created from will be automatically deleted after the volume create operation has finished.  Defaults to false")
  deleteBaseSnapshot?: boolean;

  @doc("UUID v4 or resource identifier used to identify the Backup.")
  @visibility("read", "create")
  backupId?: string;

  @doc("Unique Baremetal Tenant Identifier.")
  @visibility("read")
  baremetalTenantId?: string;

  @doc("The Azure Resource URI for a delegated subnet. Must have the delegation Microsoft.NetApp/volumes")
  subnetId: string;

  @doc("Network features available to the volume, or current state of update.")
  networkFeatures?: NetworkFeatures;

  @doc("Network Sibling Set ID for the the group of volumes sharing networking resources.")
  @visibility("read")
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  networkSiblingSetId?: string;

  @doc("Provides storage to network proximity information for the volume.")
  @visibility("read")
  storageToNetworkProximity?: VolumeStorageToNetworkProximity;

  @doc("List of mount targets")
  @visibility("read")
  mountTargets?: MountTargetProperties[];

  @doc("What type of volume is this. For destination volumes in Cross Region Replication, set type to DataProtection")
  volumeType?: string;

  @doc("DataProtection type volumes include an object containing details of the replication")
  dataProtection?: VolumePropertiesDataProtection;

  @doc("Restoring")
  isRestoring?: boolean;

  @doc("If enabled (true) the volume will contain a read-only snapshot directory which provides access to each of the volume's snapshots (defaults to true).")
  snapshotDirectoryVisible?: boolean;

  @doc("Describe if a volume is KerberosEnabled. To be use with swagger version 2020-05-01 or later")
  @visibility("read", "create")
  kerberosEnabled?: boolean;

  @doc("The security style of volume, default unix, defaults to ntfs for dual protocol or CIFS protocol")
  securityStyle?: SecurityStyle;

  @doc("Enables encryption for in-flight smb3 data. Only applicable for SMB/DualProtocol volume. To be used with swagger version 2020-08-01 or later")
  smbEncryption?: boolean;

  @doc("Enables access-based enumeration share property for SMB Shares. Only applicable for SMB/DualProtocol volume")
  smbAccessBasedEnumeration?: SmbAccessBasedEnumeration;

  @doc("Enables non-browsable property for SMB Shares. Only applicable for SMB/DualProtocol volume")
  smbNonBrowsable?: SmbNonBrowsable;

  @doc("Enables continuously available share property for smb volume. Only applicable for SMB volume")
  smbContinuouslyAvailable?: boolean;

  @doc("Maximum throughput in MiB/s that can be achieved by this volume and this will be accepted as input only for manual qosType volume")
  throughputMibps?: float32;

  @doc("Actual throughput in MiB/s for auto qosType volumes calculated based on size and serviceLevel")
  @visibility("read")
  actualThroughputMibps?: float32;

  @doc("Source of key used to encrypt data in volume. Applicable if NetApp account has encryption.keySource = 'Microsoft.KeyVault'. Possible values (case-insensitive) are: 'Microsoft.NetApp, Microsoft.KeyVault'")
  encryptionKeySource?: EncryptionKeySource;

  @doc("The resource ID of private endpoint for KeyVault. It must reside in the same VNET as the volume. Only applicable if encryptionKeySource = 'Microsoft.KeyVault'.")
  keyVaultPrivateEndpointResourceId?: string;

  @doc("Specifies whether LDAP is enabled or not for a given NFS volume.")
  ldapEnabled?: boolean;

  @doc("Specifies whether Cool Access(tiering) is enabled for the volume.")
  coolAccess?: boolean;

  @doc("Specifies the number of days after which data that is not accessed by clients will be tiered.")
  @maxValue(63)
  @minValue(7)
  coolnessPeriod?: int32;

  @doc("""
coolAccessRetrievalPolicy determines the data retrieval behavior from the cool tier to standard storage based on the read pattern for cool access enabled volumes. The possible values for this field are: 
 Default - Data will be pulled from cool tier to standard storage on random reads. This policy is the default.
 OnRead - All client-driven data read is pulled from cool tier to standard storage on both sequential and random reads.
 Never - No client-driven data is pulled from cool tier to standard storage.
""")
  coolAccessRetrievalPolicy?: CoolAccessRetrievalPolicy;

  @doc("UNIX permissions for NFS volume accepted in octal 4 digit format. First digit selects the set user ID(4), set group ID (2) and sticky (1) attributes. Second digit selects permission for the owner of the file: read (4), write (2) and execute (1). Third selects permissions for other users in the same group. the fourth for other users not in the group. 0755 - gives read/write/execute permissions to owner and read/execute to group and other users.")
  @maxLength(4)
  @minLength(4)
  unixPermissions?: string;

  @doc("When a volume is being restored from another volume's snapshot, will show the percentage completion of this cloning process. When this value is empty/null there is no cloning process currently happening on this volume. This value will update every 5 minutes during cloning.")
  @visibility("read")
  cloneProgress?: int32;

  @doc("Flag indicating whether file access logs are enabled for the volume, based on active diagnostic settings present on the volume.")
  @visibility("read")
  fileAccessLogs?: FileAccessLogs;

  @doc("Specifies whether the volume is enabled for Azure VMware Solution (AVS) datastore purpose")
  avsDataStore?: AvsDataStore;

  @doc("Data store resource unique identifier")
  @visibility("read")
  dataStoreResourceId?: string[];

  @doc("Specifies if default quota is enabled for the volume.")
  isDefaultQuotaEnabled?: boolean;

  @doc("Default user quota for volume in KiBs. If isDefaultQuotaEnabled is set, the minimum value of 4 KiBs applies .")
  defaultUserQuotaInKiBs?: int32;

  @doc("Default group quota for volume in KiBs. If isDefaultQuotaEnabled is set, the minimum value of 4 KiBs applies.")
  defaultGroupQuotaInKiBs?: int32;

  @doc("Maximum number of files allowed. Needs a service request in order to be changed. Only allowed to be changed if volume quota is more than 4TiB.")
  @visibility("read")
  maximumNumberOfFiles?: int32;

  @doc("Volume Group Name")
  @visibility("read")
  volumeGroupName?: string;

  @doc("Pool Resource Id used in case of creating a volume through volume group")
  capacityPoolResourceId?: string;

  @doc("Proximity placement group associated with the volume")
  proximityPlacementGroup?: string;

  @doc("T2 network information")
  @visibility("read")
  t2Network?: string;

  @doc("Volume spec name is the application specific designation or identifier for the particular volume in a volume group for e.g. data, log")
  volumeSpecName?: string;

  @doc("Specifies if the volume is encrypted or not. Only available on volumes created or updated after 2022-01-01.")
  @visibility("read")
  encrypted?: boolean;

  @doc("Application specific placement rules for the particular volume")
  placementRules?: PlacementKeyValuePairs[];

  @doc("Flag indicating whether subvolume operations are enabled on the volume")
  enableSubvolumes?: EnableSubvolumes;

  @doc("The availability zone where the volume is provisioned. This refers to the logical availability zone where the volume resides.")
  @visibility("read")
  provisionedAvailabilityZone?: string;

  @doc("Specifies whether volume is a Large Volume or Regular Volume.")
  isLargeVolume?: boolean;

  @doc("Id of the snapshot or backup that the volume is restored from.")
  @visibility("read")
  originatingResourceId?: string;
}

@doc("Set of export policy rules")
model VolumePropertiesExportPolicy {
  @doc("Export policy rule")
  rules?: ExportPolicyRule[];
}

@doc("Volume Export Policy Rule")
model ExportPolicyRule {
  @doc("Order index")
  ruleIndex?: int32;

  @doc("Read only access")
  unixReadOnly?: boolean;

  @doc("Read and write access")
  unixReadWrite?: boolean;

  @doc("Kerberos5 Read only access. To be use with swagger version 2020-05-01 or later")
  kerberos5ReadOnly?: boolean;

  @doc("Kerberos5 Read and write access. To be use with swagger version 2020-05-01 or later")
  kerberos5ReadWrite?: boolean;

  @doc("Kerberos5i Read only access. To be use with swagger version 2020-05-01 or later")
  @projectedName("json", "kerberos5iReadOnly")
  kerberos5IReadOnly?: boolean;

  @doc("Kerberos5i Read and write access. To be use with swagger version 2020-05-01 or later")
  @projectedName("json", "kerberos5iReadWrite")
  kerberos5IReadWrite?: boolean;

  @doc("Kerberos5p Read only access. To be use with swagger version 2020-05-01 or later")
  @projectedName("json", "kerberos5pReadOnly")
  kerberos5PReadOnly?: boolean;

  @doc("Kerberos5p Read and write access. To be use with swagger version 2020-05-01 or later")
  @projectedName("json", "kerberos5pReadWrite")
  kerberos5PReadWrite?: boolean;

  @doc("Allows CIFS protocol")
  cifs?: boolean;

  @doc("Allows NFSv3 protocol. Enable only for NFSv3 type volumes")
  nfsv3?: boolean;

  @doc("Allows NFSv4.1 protocol. Enable only for NFSv4.1 type volumes")
  nfsv41?: boolean;

  @doc("Client ingress specification as comma separated string with IPv4 CIDRs, IPv4 host addresses and host names")
  allowedClients?: string;

  @doc("Has root access to volume")
  hasRootAccess?: boolean;

  @doc("This parameter specifies who is authorized to change the ownership of a file. restricted - Only root user can change the ownership of the file. unrestricted - Non-root users can change ownership of files that they own.")
  chownMode?: ChownMode;
}

@doc("Mount target properties")
model MountTargetProperties {
  @doc("UUID v4 used to identify the MountTarget")
  @visibility("read")
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  mountTargetId?: string;

  @doc("UUID v4 used to identify the MountTarget")
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  fileSystemId: string;

  @doc("The mount target's IPv4 address")
  @visibility("read")
  ipAddress?: string;

  @doc("The SMB server's Fully Qualified Domain Name, FQDN")
  smbServerFqdn?: string;
}

@doc("DataProtection type volumes include an object containing details of the replication")
model VolumePropertiesDataProtection {
  @doc("Replication properties")
  replication?: ReplicationObject;

  @doc("Snapshot properties.")
  snapshot?: VolumeSnapshotProperties;

  @doc("VolumeRelocation properties")
  volumeRelocation?: VolumeRelocationProperties;
}

@doc("Replication properties")
model ReplicationObject {
  @doc("Id")
  @visibility("read")
  replicationId?: string;

  @doc("Indicates whether the local volume is the source or destination for the Volume Replication")
  endpointType?: EndpointType;

  @doc("Schedule")
  replicationSchedule?: ReplicationSchedule;

  @doc("The resource ID of the remote volume.")
  remoteVolumeResourceId: string;

  @doc("The remote region for the other end of the Volume Replication.")
  remoteVolumeRegion?: string;
}

@doc("Volume Snapshot Properties")
model VolumeSnapshotProperties {
  @doc("Snapshot Policy ResourceId")
  snapshotPolicyId?: string;
}

@doc("Volume relocation properties")
model VolumeRelocationProperties {
  @doc("Has relocation been requested for this volume")
  relocationRequested?: boolean;

  @doc("Has relocation finished and is ready to be cleaned up")
  @visibility("read")
  readyToBeFinalized?: boolean;
}

@doc("Application specific parameters for the placement of volumes in the volume group")
model PlacementKeyValuePairs {
  @doc("Key for an application specific parameter for the placement of volumes in the volume group")
  key: string;

  @doc("Value for an application specific parameter for the placement of volumes in the volume group")
  value: string;
}

@doc("Set of export policy rules")
model VolumePatchPropertiesExportPolicy {
  @doc("Export policy rule")
  rules?: ExportPolicyRule[];
}

@doc("DataProtection type volumes include an object containing details of the replication")
model VolumePatchPropertiesDataProtection {
  @doc("Snapshot properties.")
  snapshot?: VolumeSnapshotProperties;
}

@doc("revert a volume to the snapshot")
model VolumeRevert {
  @doc("Resource id of the snapshot")
  snapshotId?: string;
}

@doc("Break file locks request")
model BreakFileLocksRequest {
  @doc("To clear file locks on a volume for a particular client")
  @pattern("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
  clientIp?: string;

  @doc("Break File locks could be a disruptive operation for application as locks on the volume will be broken, if want to process, set to true.")
  confirmRunningDisruptiveOperation?: boolean;
}

@doc("Get group Id list for LDAP User request")
model GetGroupIdListForLdapUserRequest {
  @doc("username is required to fetch the group to which user is part of")
  @maxLength(255)
  @minLength(1)
  username: string;
}

@doc("Group Id list for Ldap user")
model GetGroupIdListForLdapUserResponse {
  @doc("Group Id list")
  groupIdsForLdapUser?: string[];
}

@doc("Break replication request")
model BreakReplicationRequest {
  @doc("If replication is in status transferring and you want to force break the replication, set to true")
  forceBreakReplication?: boolean;
}

@doc("Re-establish request object supplied in the body of the operation.")
model ReestablishReplicationRequest {
  @doc("Resource id of the source volume for the replication")
  sourceVolumeId?: string;
}

@doc("Replication status")
model ReplicationStatus {
  @doc("Replication health check")
  healthy?: boolean;

  @doc("Status of the mirror relationship")
  relationshipStatus?: RelationshipStatus;

  @doc("The status of the replication")
  mirrorState?: MirrorState;

  @doc("The progress of the replication")
  totalProgress?: string;

  @doc("Displays error message if the replication is in an error state")
  errorMessage?: string;
}

@doc("List Replications")
@pagedResult
model ListReplications {
  @doc("A list of replications")
  @items
  value?: Replication[];
}

@doc("Replication properties")
model Replication {
  @doc("Indicates whether the local volume is the source or destination for the Volume Replication")
  endpointType?: EndpointType;

  @doc("Schedule")
  replicationSchedule?: ReplicationSchedule;

  @doc("The resource ID of the remote volume.")
  remoteVolumeResourceId: string;

  @doc("The remote region for the other end of the Volume Replication.")
  remoteVolumeRegion?: string;
}

@doc("Authorize request")
model AuthorizeRequest {
  @doc("Resource id of the remote volume")
  remoteVolumeResourceId?: string;
}

@doc("Pool change request")
model PoolChangeRequest {
  @doc("Resource id of the pool to move volume to")
  newPoolResourceId: string;
}

@doc("Relocate volume request")
model RelocateVolumeRequest {
  @doc("New creation token for the volume that controls the mount point name")
  creationToken?: string;
}

@doc("Snapshot properties")
model SnapshotProperties {
  @doc("UUID v4 used to identify the Snapshot")
  @visibility("read")
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  snapshotId?: string;

  @doc("The creation date of the snapshot")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  @doc("Azure lifecycle management")
  @visibility("read")
  provisioningState?: string;
}

@doc("Restore payload for Single File Snapshot Restore")
model SnapshotRestoreFiles {
  @doc("List of files to be restored")
  filePaths: string[];

  @doc("Destination folder where the files will be restored")
  destinationPath?: string;
}

@doc("Snapshot policy properties")
model SnapshotPolicyProperties {
  @doc("Schedule for hourly snapshots")
  hourlySchedule?: HourlySchedule;

  @doc("Schedule for daily snapshots")
  dailySchedule?: DailySchedule;

  @doc("Schedule for weekly snapshots")
  weeklySchedule?: WeeklySchedule;

  @doc("Schedule for monthly snapshots")
  monthlySchedule?: MonthlySchedule;

  @doc("The property to decide policy is enabled or not")
  enabled?: boolean;

  @doc("Azure lifecycle management")
  @visibility("read")
  provisioningState?: string;
}

@doc("Hourly Schedule properties")
model HourlySchedule {
  @doc("Hourly snapshot count to keep")
  snapshotsToKeep?: int32;

  @doc("Indicates which minute snapshot should be taken")
  minute?: int32;

  @doc("Resource size in bytes, current storage usage for the volume in bytes")
  usedBytes?: int32;
}

@doc("Daily Schedule properties")
model DailySchedule {
  @doc("Daily snapshot count to keep")
  snapshotsToKeep?: int32;

  @doc("Indicates which hour in UTC timezone a snapshot should be taken")
  hour?: int32;

  @doc("Indicates which minute snapshot should be taken")
  minute?: int32;

  @doc("Resource size in bytes, current storage usage for the volume in bytes")
  usedBytes?: int32;
}

@doc("Weekly Schedule properties, make a snapshot every week at a specific day or days")
model WeeklySchedule {
  @doc("Weekly snapshot count to keep")
  snapshotsToKeep?: int32;

  @doc("Indicates which weekdays snapshot should be taken, accepts a comma separated list of week day names in english")
  day?: string;

  @doc("Indicates which hour in UTC timezone a snapshot should be taken")
  hour?: int32;

  @doc("Indicates which minute snapshot should be taken")
  minute?: int32;

  @doc("Resource size in bytes, current storage usage for the volume in bytes")
  usedBytes?: int32;
}

@doc("Monthly Schedule properties")
model MonthlySchedule {
  @doc("Monthly snapshot count to keep")
  snapshotsToKeep?: int32;

  @doc("Indicates which days of the month snapshot should be taken. A comma delimited string.")
  daysOfMonth?: string;

  @doc("Indicates which hour in UTC timezone a snapshot should be taken")
  hour?: int32;

  @doc("Indicates which minute snapshot should be taken")
  minute?: int32;

  @doc("Resource size in bytes, current storage usage for the volume in bytes")
  usedBytes?: int32;
}

@doc("Volumes associated with snapshot policy")
model SnapshotPolicyVolumeList {
  @doc("List of volumes")
  value?: Volume[];
}

@doc("Restore status")
model RestoreStatus {
  @doc("Restore health status")
  @visibility("read")
  healthy?: boolean;

  @doc("Status of the restore SnapMirror relationship")
  @visibility("read")
  relationshipStatus?: RelationshipStatus;

  @doc("The status of the restore")
  @visibility("read")
  mirrorState?: MirrorState;

  @doc("Reason for the unhealthy restore relationship")
  @visibility("read")
  unhealthyReason?: string;

  @doc("Displays error message if the restore is in an error state")
  @visibility("read")
  errorMessage?: string;

  @doc("Displays the total bytes transferred")
  @visibility("read")
  totalTransferBytes?: int32;
}

@doc("Backup policy properties")
model BackupPolicyProperties {
  @doc("Backup Policy Resource ID")
  @visibility("read")
  backupPolicyId?: string;

  @doc("Azure lifecycle management")
  @visibility("read")
  provisioningState?: string;

  @doc("Daily backups count to keep")
  dailyBackupsToKeep?: int32;

  @doc("Weekly backups count to keep")
  weeklyBackupsToKeep?: int32;

  @doc("Monthly backups count to keep")
  monthlyBackupsToKeep?: int32;

  @doc("Volumes using current backup policy")
  @visibility("read")
  volumesAssigned?: int32;

  @doc("The property to decide policy is enabled or not")
  enabled?: boolean;

  @doc("A list of volumes assigned to this policy")
  @visibility("read")
  volumeBackups?: VolumeBackups[];
}

@doc("Volume details using the backup policy")
model VolumeBackups {
  @doc("Volume name")
  volumeName?: string;

  @doc("Total count of backups for volume")
  backupsCount?: int32;

  @doc("Policy enabled")
  policyEnabled?: boolean;
}

@doc("Volume Quota Rule properties")
model VolumeQuotaRulesProperties {
  @doc("Gets the status of the VolumeQuotaRule at the time the operation was called.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Size of quota")
  quotaSizeInKiBs?: int32;

  @doc("Type of quota")
  @visibility("read", "create")
  quotaType?: Type;

  @doc("UserID/GroupID/SID based on the quota target type. UserID and groupID can be found by running ‘id’ or ‘getent’ command for the user or group and SID can be found by running <wmic useraccount where name='user-name' get sid>")
  @visibility("read", "create")
  quotaTarget?: string;
}

@doc("List of volume group resources")
@pagedResult
model VolumeGroupList {
  @doc("List of volume Groups")
  @items
  value?: VolumeGroup[];
}

@doc("Volume group resource")
model VolumeGroup {
  @doc("Resource location")
  @visibility("read", "create")
  location?: string;

  @doc("Resource Id")
  @visibility("read")
  id?: string;

  @doc("Resource name")
  @visibility("read")
  name?: string;

  @doc("Resource type")
  @visibility("read")
  type?: string;

  @doc("Volume group properties")
  properties?: VolumeGroupListProperties;
}

@doc("Volume group properties")
model VolumeGroupListProperties {
  @doc("Azure lifecycle management")
  @visibility("read")
  provisioningState?: string;

  @doc("Volume group details")
  groupMetaData?: VolumeGroupMetaData;
}

@doc("Volume group properties")
model VolumeGroupMetaData {
  @doc("Group Description")
  groupDescription?: string;

  @doc("Application Type")
  applicationType?: ApplicationType;

  @doc("Application specific identifier")
  applicationIdentifier?: string;

  @doc("Application specific placement rules for the volume group")
  globalPlacementRules?: PlacementKeyValuePairs[];

  @doc("Application specific identifier of deployment rules for the volume group")
  deploymentSpecId?: string;

  @doc("Number of volumes in volume group")
  @visibility("read")
  volumesCount?: int32;
}

@doc("Volume group properties")
model VolumeGroupProperties {
  @doc("Azure lifecycle management")
  @visibility("read")
  provisioningState?: string;

  @doc("Volume group details")
  groupMetaData?: VolumeGroupMetaData;

  @doc("List of volumes from group")
  volumes?: VolumeGroupVolumeProperties[];
}

@doc("Volume resource")
model VolumeGroupVolumeProperties {
  @doc("Resource Id")
  @visibility("read")
  id?: string;

  @doc("Resource name")
  name?: string;

  @doc("Resource type")
  @visibility("read")
  type?: string;

  @doc("Resource tags")
  tags?: Record<string>;

  @doc("Availability Zone")
  @visibility("read", "create")
  zones?: string[];

  @doc("Volume properties")
  properties: VolumeProperties;
}

@doc("This represents path associated with the subvolume")
model SubvolumeProperties {
  @doc("Path to the subvolume")
  path?: string;

  @doc("Truncate subvolume to the provided size in bytes")
  @visibility("create", "update")
  size?: int32;

  @doc("parent path to the subvolume")
  parentPath?: string;

  @doc("Azure lifecycle management")
  @visibility("read")
  provisioningState?: string;
}

@doc("Result of the post subvolume and action is to get metadata of the subvolume.")
model SubvolumeModel {
  @doc("Resource Id")
  @visibility("read")
  id?: string;

  @doc("Resource name")
  @visibility("read")
  name?: string;

  @doc("Resource type")
  @visibility("read")
  type?: string;

  @doc("It represents the minimal properties of the subvolume.")
  properties?: SubvolumeModelProperties;
}

@doc("Properties which represents actual subvolume model which is stored as a file in the system.")
model SubvolumeModelProperties {
  @doc("Path to the subvolume")
  path?: string;

  @doc("Path to the parent subvolume")
  parentPath?: string;

  @doc("Size of subvolume")
  size?: int32;

  @doc("Bytes used")
  bytesUsed?: int32;

  @doc("Permissions of the subvolume")
  permissions?: string;

  @doc("Creation time and date")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTimeStamp?: utcDateTime;

  @doc("Most recent access time and date")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  accessedTimeStamp?: utcDateTime;

  @doc("Most recent modification time and date")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedTimeStamp?: utcDateTime;

  @doc("Most recent change time and date")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTimeStamp?: utcDateTime;

  @doc("Azure lifecycle management")
  provisioningState?: string;
}

@doc("Identity for the resource.")
model ResourceIdentity {
  @doc("Object id of the identity resource")
  @visibility("read")
  principalId?: string;

  @doc("The tenant id of the resource")
  @visibility("read")
  tenantId?: string;

  @doc("Type of Identity. Supported values are: 'None', 'SystemAssigned'")
  type?: string;
}

@doc("Mount Target")
model MountTarget {
  @doc("Resource location")
  location: string;

  @doc("Resource Id")
  @visibility("read")
  id?: string;

  @doc("Resource name")
  @visibility("read")
  name?: string;

  @doc("Resource type")
  @visibility("read")
  type?: string;

  @doc("Resource tags")
  tags?: Record<string>;

  @doc("Mount Target Properties")
  properties: MountTargetProperties;
}

@doc("Snapshot policy properties")
model SnapshotPolicyDetails {
  @doc("Resource location")
  @visibility("read", "create")
  location?: string;

  @doc("Resource Id")
  @visibility("read")
  id?: string;

  @doc("Resource name")
  @visibility("read")
  name?: string;

  @doc("Resource type")
  @visibility("read")
  type?: string;

  @doc("Resource tags")
  tags?: Record<string>;

  @doc("Snapshot policy Properties")
  properties?: SnapshotPolicyProperties;
}
