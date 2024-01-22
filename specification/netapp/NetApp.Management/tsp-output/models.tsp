import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.NetApp;

interface Operations extends Azure.ResourceManager.Operations {}

enum MetricAggregationType {
  Average,
}

/**
 * Resource type used for verification.
 */
enum CheckNameResourceTypes {
  `Microsoft.NetApp/netAppAccounts`,
  `Microsoft.NetApp/netAppAccounts/capacityPools`,
  `Microsoft.NetApp/netAppAccounts/capacityPools/volumes`,
  `Microsoft.NetApp/netAppAccounts/capacityPools/volumes/snapshots`,
}

/**
 * <code>Invalid</code> indicates the name provided does not match Azure App Service naming requirements. <code>AlreadyExists</code> indicates that the name is already in use and is therefore unavailable.
 */
enum InAvailabilityReasonType {
  Invalid,
  AlreadyExists,
}

/**
 * Resource type used for verification.
 */
enum CheckQuotaNameResourceTypes {
  `Microsoft.NetApp/netAppAccounts`,
  `Microsoft.NetApp/netAppAccounts/capacityPools`,
  `Microsoft.NetApp/netAppAccounts/capacityPools/volumes`,
  `Microsoft.NetApp/netAppAccounts/capacityPools/volumes/snapshots`,
}

/**
 * Provides storage to network proximity information in the region.
 */
enum RegionStorageToNetworkProximity {
  /**
   * Basic network connectivity.
   */
  Default,

  /**
   * Standard T1 network connectivity.
   */
  T1,

  /**
   * Standard T2 network connectivity.
   */
  T2,

  /**
   * Standard AcrossT2 network connectivity.
   */
  AcrossT2,

  /**
   * Standard T1 and T2 network connectivity.
   */
  T1AndT2,

  /**
   * Standard T1 and AcrossT2 network connectivity.
   */
  T1AndAcrossT2,

  /**
   * Standard T2 and AcrossT2 network connectivity.
   */
  T2AndAcrossT2,

  /**
   * Standard T1, T2 and AcrossT2 network connectivity.
   */
  T1AndT2AndAcrossT2,
}

/**
 * Network features available to the volume, or current state of update.
 */
enum NetworkFeatures {
  /**
   * Basic network features.
   */
  Basic,

  /**
   * Standard network features.
   */
  Standard,

  /**
   * Updating from Basic to Standard network features.
   */
  Basic_Standard,

  /**
   * Updating from Standard to Basic network features.
   */
  Standard_Basic,
}

/**
 * Gets the status of the NetworkSiblingSet at the time the operation was called.
 */
enum NetworkSiblingSetProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Updating,
}

/**
 * Status of the Active Directory
 */
enum ActiveDirectoryStatus {
  /**
   * Active Directory created but not in use
   */
  Created,

  /**
   * Active Directory in use by SMB Volume
   */
  InUse,

  /**
   * Active Directory Deleted
   */
  Deleted,

  /**
   * Error with the Active Directory
   */
  Error,

  /**
   * Active Directory Updating
   */
  Updating,
}

/**
 * The encryption keySource (provider). Possible values (case-insensitive):  Microsoft.NetApp, Microsoft.KeyVault
 */
enum KeySource {
  /**
   * Microsoft-managed key encryption
   */
  `Microsoft.NetApp`,

  /**
   * Customer-managed key encryption
   */
  `Microsoft.KeyVault`,
}

/**
 * Status of the KeyVault connection.
 */
enum KeyVaultStatus {
  /**
   * KeyVault connection created but not in use
   */
  Created,

  /**
   * KeyVault connection in use by SMB Volume
   */
  InUse,

  /**
   * KeyVault connection Deleted
   */
  Deleted,

  /**
   * Error with the KeyVault connection
   */
  Error,

  /**
   * KeyVault connection Updating
   */
  Updating,
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

/**
 * The service level of the file system
 */
enum ServiceLevel {
  /**
   * Standard service level
   */
  Standard,

  /**
   * Premium service level
   */
  Premium,

  /**
   * Ultra service level
   */
  Ultra,

  /**
   * Zone redundant storage service level
   */
  StandardZRS,
}

/**
 * The qos type of the pool
 */
enum QosType {
  /**
   * qos type Auto
   */
  Auto,

  /**
   * qos type Manual
   */
  Manual,
}

/**
 * Encryption type of the capacity pool, set encryption type for data at rest for this pool and all volumes in it. This value can only be set when creating new pool.
 */
enum EncryptionType {
  /**
   * EncryptionType Single, volumes will use single encryption at rest
   */
  Single,

  /**
   * EncryptionType Double, volumes will use double encryption at rest
   */
  Double,
}

/**
 * This parameter specifies who is authorized to change the ownership of a file. restricted - Only root user can change the ownership of the file. unrestricted - Non-root users can change ownership of files that they own.
 */
enum ChownMode {
  Restricted,
  Unrestricted,
}

/**
 * Provides storage to network proximity information for the volume.
 */
enum VolumeStorageToNetworkProximity {
  /**
   * Basic storage to network connectivity.
   */
  Default,

  /**
   * Standard T1 storage to network connectivity.
   */
  T1,

  /**
   * Standard T2 storage to network connectivity.
   */
  T2,

  /**
   * Standard AcrossT2 storage to network connectivity.
   */
  AcrossT2,
}

/**
 * Indicates whether the local volume is the source or destination for the Volume Replication
 */
enum EndpointType {
  src,
  dst,
}

/**
 * Schedule
 */
enum ReplicationSchedule {
  _10minutely,
  hourly,
  daily,
}

/**
 * The security style of volume, default unix, defaults to ntfs for dual protocol or CIFS protocol
 */
enum SecurityStyle {
  ntfs,
  unix,
}

/**
 * Enables access-based enumeration share property for SMB Shares. Only applicable for SMB/DualProtocol volume
 */
enum SmbAccessBasedEnumeration {
  /**
   * smbAccessBasedEnumeration share setting is disabled
   */
  Disabled,

  /**
   * smbAccessBasedEnumeration share setting is enabled
   */
  Enabled,
}

/**
 * Enables non-browsable property for SMB Shares. Only applicable for SMB/DualProtocol volume
 */
enum SmbNonBrowsable {
  /**
   * smbNonBrowsable share setting is disabled
   */
  Disabled,

  /**
   * smbNonBrowsable share setting is enabled
   */
  Enabled,
}

/**
 * Source of key used to encrypt data in volume. Applicable if NetApp account has encryption.keySource = 'Microsoft.KeyVault'. Possible values (case-insensitive) are: 'Microsoft.NetApp, Microsoft.KeyVault'
 */
enum EncryptionKeySource {
  /**
   * Microsoft-managed key encryption
   */
  `Microsoft.NetApp`,

  /**
   * Customer-managed key encryption
   */
  `Microsoft.KeyVault`,
}

/**
* coolAccessRetrievalPolicy determines the data retrieval behavior from the cool tier to standard storage based on the read pattern for cool access enabled volumes. The possible values for this field are:
* Default - Data will be pulled from cool tier to standard storage on random reads. This policy is the default.
 OnRead - All client-driven data read is pulled from cool tier to standard storage on both sequential and random reads.
 Never - No client-driven data is pulled from cool tier to standard storage.
*/
enum CoolAccessRetrievalPolicy {
  Default,
  OnRead,
  Never,
}

/**
 * Flag indicating whether file access logs are enabled for the volume, based on active diagnostic settings present on the volume.
 */
enum FileAccessLogs {
  /**
   * fileAccessLogs are enabled
   */
  Enabled,

  /**
   * fileAccessLogs are not enabled
   */
  Disabled,
}

/**
 * Specifies whether the volume is enabled for Azure VMware Solution (AVS) datastore purpose
 */
enum AvsDataStore {
  /**
   * avsDataStore is enabled
   */
  Enabled,

  /**
   * avsDataStore is disabled
   */
  Disabled,
}

/**
 * Flag indicating whether subvolume operations are enabled on the volume
 */
enum EnableSubvolumes {
  /**
   * subvolumes are enabled
   */
  Enabled,

  /**
   * subvolumes are not enabled
   */
  Disabled,
}

/**
 * Status of the mirror relationship
 */
enum RelationshipStatus {
  Idle,
  Transferring,
}

/**
 * The status of the replication
 */
enum MirrorState {
  Uninitialized,
  Mirrored,
  Broken,
}

/**
 * Type of quota
 */
enum Type {
  /**
   * Default user quota
   */
  DefaultUserQuota,

  /**
   * Default group quota
   */
  DefaultGroupQuota,

  /**
   * Individual user quota
   */
  IndividualUserQuota,

  /**
   * Individual group quota
   */
  IndividualGroupQuota,
}

/**
 * Application Type
 */
enum ApplicationType {
  `SAP-HANA`,
  ORACLE,
}

/**
 * Gets the status of the VolumeQuotaRule at the time the operation was called.
 */
@fixed
enum ProvisioningState {
  Accepted,
  Creating,
  Patching,
  Deleting,
  Moving,
  Failed,
  Succeeded,
}

/**
 * Properties of operation, include metric specifications.
 */
model OperationProperties {
  /**
   * One property of operation, include metric specifications.
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * One property of operation, include metric specifications.
 */
model ServiceSpecification {
  /**
   * Metric specifications of operation.
   */
  metricSpecifications?: MetricSpecification[];

  /**
   * Log specification of operation.
   */
  logSpecifications?: LogSpecification[];
}

/**
 * Metric specification of operation.
 */
model MetricSpecification {
  /**
   * Name of metric specification.
   */
  name?: string;

  /**
   * Display name of metric specification.
   */
  displayName?: string;

  /**
   * Display description of metric specification.
   */
  displayDescription?: string;

  /**
   * Unit could be Bytes or Count.
   */
  unit?: string;

  /**
   * Support metric aggregation type.
   */
  supportedAggregationTypes?: MetricAggregationType[];

  /**
   * The supported time grain types for the metrics.
   */
  supportedTimeGrainTypes?: string[];

  /**
   * The internal metric name.
   */
  internalMetricName?: string;

  /**
   * Whether or not the service is using regional MDM accounts.
   */
  enableRegionalMdmAccount?: boolean;

  /**
   * The source MDM account.
   */
  sourceMdmAccount?: string;

  /**
   * The source MDM namespace.
   */
  sourceMdmNamespace?: string;

  /**
   * Dimensions of blobs, including blob type and access tier.
   */
  dimensions?: Dimension[];

  /**
   * Aggregation type could be Average.
   */
  aggregationType?: string;

  /**
   * The property to decide fill gap with zero or not.
   */
  fillGapWithZero?: boolean;

  /**
   * The category this metric specification belong to, could be Capacity.
   */
  category?: string;

  /**
   * Account Resource Id.
   */
  resourceIdDimensionNameOverride?: string;

  /**
   * Whether the metric is internal.
   */
  isInternal?: boolean;
}

/**
 * Dimension of blobs, possibly be blob type or access tier.
 */
model Dimension {
  /**
   * Display name of dimension.
   */
  name?: string;

  /**
   * Display name of dimension.
   */
  displayName?: string;
}

/**
 * Log Definition of a single resource metric.
 */
model LogSpecification {
  /**
   * Name of log specification.
   */
  name?: string;

  /**
   * Display name of log specification.
   */
  displayName?: string;
}

/**
 * Resource name availability request content.
 */
model ResourceNameAvailabilityRequest {
  /**
   * Resource name to verify.
   */
  name: string;

  /**
   * Resource type used for verification.
   */
  type: CheckNameResourceTypes;

  /**
   * Resource group name.
   */
  resourceGroup: string;
}

/**
 * Information regarding availability of a resource.
 */
model CheckAvailabilityResponse {
  /**
   * <code>true</code> indicates name is valid and available. <code>false</code> indicates the name is invalid, unavailable, or both.
   */
  isAvailable?: boolean;

  /**
   * <code>Invalid</code> indicates the name provided does not match Azure App Service naming requirements. <code>AlreadyExists</code> indicates that the name is already in use and is therefore unavailable.
   */
  reason?: InAvailabilityReasonType;

  /**
   * If reason == invalid, provide the user with the reason why the given name is invalid, and provide the resource naming requirements so that the user can select a valid name. If reason == AlreadyExists, explain that resource name is already in use, and direct them to select a different name.
   */
  message?: string;
}

/**
 * File path availability request content - availability is based on the name and the subnetId.
 */
model FilePathAvailabilityRequest {
  /**
   * File path to verify.
   */
  name: string;

  /**
   * The Azure Resource URI for a delegated subnet. Must have the delegation Microsoft.NetApp/volumes
   */
  subnetId: string;
}

/**
 * Quota availability request content.
 */
model QuotaAvailabilityRequest {
  /**
   * Name of the resource to verify.
   */
  name: string;

  /**
   * Resource type used for verification.
   */
  type: CheckQuotaNameResourceTypes;

  /**
   * Resource group name.
   */
  resourceGroup: string;
}

/**
 * List of Subscription Quota Items
 */
@pagedResult
model SubscriptionQuotaItemList {
  /**
   * A list of SubscriptionQuotaItems
   */
  @items
  value?: SubscriptionQuotaItem[];
}

/**
 * Information regarding Subscription Quota Item.
 */
model SubscriptionQuotaItem extends ProxyResource {
  /**
   * SubscriptionQuotaItem properties
   */
  properties?: SubscriptionQuotaItemProperties;
}

/**
 * SubscriptionQuotaItem Properties
 */
model SubscriptionQuotaItemProperties {
  /**
   * The current quota value.
   */
  @visibility("read")
  current?: int32;

  /**
   * The default quota value.
   */
  @visibility("read")
  default?: int32;
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
 * Provides region specific information.
 */
model RegionInfo {
  /**
   * Provides storage to network proximity information in the region.
   */
  storageToNetworkProximity?: RegionStorageToNetworkProximity;

  /**
   * Provides logical availability zone mappings for the subscription for a region.
   */
  availabilityZoneMappings?: RegionInfoAvailabilityZoneMappingsItem[];
}

model RegionInfoAvailabilityZoneMappingsItem {
  /**
   * Logical availability zone.
   */
  availabilityZone?: string;

  /**
   * Available availability zone
   */
  isAvailable?: boolean;
}

/**
 * Network sibling set query.
 */
model QueryNetworkSiblingSetRequest {
  /**
   * Network Sibling Set ID for a group of volumes sharing networking resources in a subnet.
   */
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  networkSiblingSetId: string;

  /**
   * The Azure Resource URI for a delegated subnet. Must have the delegation Microsoft.NetApp/volumes. Example /subscriptions/subscriptionId/resourceGroups/resourceGroup/providers/Microsoft.Network/virtualNetworks/testVnet/subnets/{mySubnet}
   */
  subnetId: ResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;
}

/**
 * Describes the contents of a network sibling set.
 */
model NetworkSiblingSet {
  /**
   * Network Sibling Set ID for a group of volumes sharing networking resources in a subnet.
   */
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  networkSiblingSetId?: string;

  /**
   * The Azure Resource URI for a delegated subnet. Must have the delegation Microsoft.NetApp/volumes. Example /subscriptions/subscriptionId/resourceGroups/resourceGroup/providers/Microsoft.Network/virtualNetworks/testVnet/subnets/{mySubnet}
   */
  subnetId?: ResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Network sibling set state Id identifying the current state of the sibling set.
   */
  networkSiblingSetStateId?: string;

  /**
   * Network features available to the volume, or current state of update.
   */
  networkFeatures?: NetworkFeatures = NetworkFeatures.Basic;

  /**
   * Gets the status of the NetworkSiblingSet at the time the operation was called.
   */
  @visibility("read")
  provisioningState?: NetworkSiblingSetProvisioningState;

  /**
   * List of NIC information
   */
  nicInfoList?: NicInfo[];
}

/**
 * NIC information and list of volumes for which the NIC has the primary mount ip address.
 */
model NicInfo {
  /**
   * ipAddress
   */
  @visibility("read")
  ipAddress?: string;

  /**
   * Volume resource Ids
   */
  volumeResourceIds?: ResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes";
    }
  ]>[];
}

/**
 * Network sibling set update.
 */
model UpdateNetworkSiblingSetRequest {
  /**
   * Network Sibling Set ID for a group of volumes sharing networking resources in a subnet.
   */
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  networkSiblingSetId: string;

  /**
   * The Azure Resource URI for a delegated subnet. Must have the delegation Microsoft.NetApp/volumes. Example /subscriptions/subscriptionId/resourceGroups/resourceGroup/providers/Microsoft.Network/virtualNetworks/testVnet/subnets/{mySubnet}
   */
  subnetId: ResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Network sibling set state Id identifying the current state of the sibling set.
   */
  networkSiblingSetStateId: string;

  /**
   * Network features available to the volume, some such
   */
  networkFeatures: NetworkFeatures = NetworkFeatures.Basic;
}

/**
 * NetApp account properties
 */
model AccountProperties {
  /**
   * Azure lifecycle management
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Active Directories
   */
  activeDirectories?: ActiveDirectory[];

  /**
   * Encryption settings
   */
  encryption?: AccountEncryption;

  /**
   * Shows the status of disableShowmount for all volumes under the subscription, null equals false
   */
  @visibility("read")
  disableShowmount?: boolean;
}

/**
 * Active Directory
 */
model ActiveDirectory {
  /**
   * Id of the Active Directory
   */
  activeDirectoryId?: string;

  /**
   * A domain user account with permission to create machine accounts
   */
  username?: string;

  /**
   * Plain text password of Active Directory domain administrator, value is masked in the response
   */
  @maxLength(64)
  password?: string;

  /**
   * Name of the Active Directory domain
   */
  domain?: string;

  /**
   * Comma separated list of DNS server IP addresses (IPv4 only) for the Active Directory domain
   */
  @pattern("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)((, ?)(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))*$")
  dns?: string;

  /**
   * Status of the Active Directory
   */
  @visibility("read")
  status?: ActiveDirectoryStatus;

  /**
   * Any details in regards to the Status of the Active Directory
   */
  @visibility("read")
  statusDetails?: string;

  /**
   * NetBIOS name of the SMB server. This name will be registered as a computer account in the AD and used to mount volumes
   */
  smbServerName?: string;

  /**
   * The Organizational Unit (OU) within the Windows Active Directory
   */
  organizationalUnit?: string = "CN=Computers";

  /**
   * The Active Directory site the service will limit Domain Controller discovery to
   */
  site?: string;

  /**
   * Users to be added to the Built-in Backup Operator active directory group. A list of unique usernames without domain specifier
   */
  backupOperators?: string[];

  /**
   * Users to be added to the Built-in Administrators active directory group. A list of unique usernames without domain specifier
   */
  administrators?: string[];

  /**
   * kdc server IP addresses for the active directory machine. This optional parameter is used only while creating kerberos volume.
   */
  @pattern("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)((, ?)(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))*$")
  kdcIP?: string;

  /**
   * Name of the active directory machine. This optional parameter is used only while creating kerberos volume
   */
  @maxLength(64)
  @minLength(1)
  adName?: string;

  /**
   * When LDAP over SSL/TLS is enabled, the LDAP client is required to have base64 encoded Active Directory Certificate Service's self-signed root CA certificate, this optional parameter is used only for dual protocol with LDAP user-mapping volumes.
   */
  @maxLength(10240)
  @minLength(1)
  serverRootCACertificate?: string;

  /**
   * If enabled, AES encryption will be enabled for SMB communication.
   */
  aesEncryption?: boolean;

  /**
   * Specifies whether or not the LDAP traffic needs to be signed.
   */
  ldapSigning?: boolean;

  /**
   * Domain Users in the Active directory to be given SeSecurityPrivilege privilege (Needed for SMB Continuously available shares for SQL). A list of unique usernames without domain specifier
   */
  securityOperators?: string[];

  /**
   * Specifies whether or not the LDAP traffic needs to be secured via TLS.
   */
  ldapOverTLS?: boolean;

  /**
   *  If enabled, NFS client local users can also (in addition to LDAP users) access the NFS volumes.
   */
  allowLocalNfsUsersWithLdap?: boolean;

  /**
   * If enabled, Traffic between the SMB server to Domain Controller (DC) will be encrypted.
   */
  encryptDCConnections?: boolean;

  /**
   * LDAP Search scope options
   */
  ldapSearchScope?: LdapSearchScopeOpt;

  /**
   * Comma separated list of IPv4 addresses of preferred servers for LDAP client. At most two comma separated IPv4 addresses can be passed.
   */
  @maxLength(32)
  @pattern("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)((, ?)(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))?)?$")
  preferredServersForLdapClient?: string;
}

/**
 * LDAP search scope
 */
model LdapSearchScopeOpt {
  /**
   * This specifies the user DN, which overrides the base DN for user lookups.
   */
  @maxLength(255)
  userDN?: string;

  /**
   * This specifies the group DN, which overrides the base DN for group lookups.
   */
  @maxLength(255)
  groupDN?: string;

  /**
   * This specifies the custom LDAP search filter to be used when looking up group membership from LDAP server.
   */
  @maxLength(255)
  groupMembershipFilter?: string;
}

/**
 * Encryption settings
 */
model AccountEncryption {
  /**
   * The encryption keySource (provider). Possible values (case-insensitive):  Microsoft.NetApp, Microsoft.KeyVault
   */
  keySource?: KeySource = KeySource.Microsoft.NetApp;

  /**
   * Properties provided by KeVault. Applicable if keySource is 'Microsoft.KeyVault'.
   */
  keyVaultProperties?: KeyVaultProperties;

  /**
   * Identity used to authenticate to KeyVault. Applicable if keySource is 'Microsoft.KeyVault'.
   */
  identity?: EncryptionIdentity;
}

/**
 * Properties of key vault.
 */
model KeyVaultProperties {
  /**
   * UUID v4 used to identify the Azure Key Vault configuration
   */
  @visibility("read")
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  keyVaultId?: string;

  /**
   * The Uri of KeyVault.
   */
  keyVaultUri: string;

  /**
   * The name of KeyVault key.
   */
  keyName: string;

  /**
   * The resource ID of KeyVault.
   */
  keyVaultResourceId: string;

  /**
   * Status of the KeyVault connection.
   */
  @visibility("read")
  status?: KeyVaultStatus;
}

/**
 * Identity used to authenticate with key vault.
 */
model EncryptionIdentity {
  /**
   * The principal ID (object ID) of the identity used to authenticate with key vault. Read-only.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The ARM resource identifier of the user assigned identity used to authenticate with key vault. Applicable if identity.type has 'UserAssigned'. It should match key of identity.userAssignedIdentities.
   */
  userAssignedIdentity?: string;
}

/**
 * NetApp account patch resource
 */
model NetAppAccountPatch {
  /**
   * Resource location
   */
  location?: string;

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

  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * NetApp Account properties
   */
  properties?: AccountProperties;

  /**
   * The identity used for the resource.
   */
  identity?: ManagedServiceIdentity;
}

/**
 * An error response from the service.
 */
@error
model CloudError {
  /**
   * Cloud error body.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from the service.
 */
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code?: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message?: string;
}

/**
 * Pool properties
 */
model PoolProperties {
  /**
   * UUID v4 used to identify the Pool
   */
  @visibility("read")
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  poolId?: string;

  /**
   * Provisioned size of the pool (in bytes). Allowed values are in 1TiB chunks (value must be multiply of 4398046511104).
   */
  size: int64 = 4398046511104;

  /**
   * The service level of the file system
   */
  serviceLevel: ServiceLevel = ServiceLevel.Premium;

  /**
   * Azure lifecycle management
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Total throughput of pool in MiB/s
   */
  @visibility("read")
  totalThroughputMibps?: float32;

  /**
   * Utilized throughput of pool in MiB/s
   */
  @visibility("read")
  utilizedThroughputMibps?: float32;

  /**
   * The qos type of the pool
   */
  qosType?: QosType;

  /**
   * If enabled (true) the pool can contain cool Access enabled volumes.
   */
  coolAccess?: boolean;

  /**
   * Encryption type of the capacity pool, set encryption type for data at rest for this pool and all volumes in it. This value can only be set when creating new pool.
   */
  @visibility("read", "create")
  encryptionType?: EncryptionType = EncryptionType.Single;
}

/**
 * Capacity pool patch resource
 */
model CapacityPoolPatch {
  /**
   * Resource location
   */
  location?: string;

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

  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * Capacity pool properties
   */
  properties?: PoolPatchProperties;
}

/**
 * Patchable pool properties
 */
model PoolPatchProperties {
  /**
   * Provisioned size of the pool (in bytes). Allowed values are in 1TiB chunks (value must be multiply of 4398046511104).
   */
  size?: int64 = 4398046511104;

  /**
   * The qos type of the pool
   */
  qosType?: QosType;

  /**
   * If enabled (true) the pool can contain cool Access enabled volumes.
   */
  coolAccess?: boolean;
}

/**
 * Volume properties
 */
model VolumeProperties {
  /**
   * Unique FileSystem Identifier.
   */
  @visibility("read")
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  fileSystemId?: string;

  /**
   * A unique file path for the volume. Used when creating mount targets
   */
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-]{0,79}$")
  creationToken: string;

  /**
   * The service level of the file system
   */
  serviceLevel?: ServiceLevel = ServiceLevel.Premium;

  /**
   * Maximum storage quota allowed for a file system in bytes. This is a soft quota used for alerting only. Minimum size is 100 GiB. Upper limit is 100TiB, 500Tib for LargeVolume or 2400Tib for LargeVolume on exceptional basis. Specified in bytes.
   */
  @maxValue(2638827906662400)
  @minValue(107374182400)
  usageThreshold: int64 = 107374182400;

  /**
   * Set of export policy rules
   */
  exportPolicy?: VolumePropertiesExportPolicy;

  /**
   * Set of protocol types, default NFSv3, CIFS for SMB protocol
   */
  protocolTypes?: string[];

  /**
   * Azure lifecycle management
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * UUID v4 or resource identifier used to identify the Snapshot.
   */
  @visibility("read", "create")
  snapshotId?: string;

  /**
   * If enabled (true) the snapshot the volume was created from will be automatically deleted after the volume create operation has finished.  Defaults to false
   */
  deleteBaseSnapshot?: boolean;

  /**
   * UUID v4 or resource identifier used to identify the Backup.
   */
  @visibility("read", "create")
  backupId?: string;

  /**
   * Unique Baremetal Tenant Identifier.
   */
  @visibility("read")
  baremetalTenantId?: string;

  /**
   * The Azure Resource URI for a delegated subnet. Must have the delegation Microsoft.NetApp/volumes
   */
  subnetId: string;

  /**
   * Network features available to the volume, or current state of update.
   */
  networkFeatures?: NetworkFeatures = NetworkFeatures.Basic;

  /**
   * Network Sibling Set ID for the the group of volumes sharing networking resources.
   */
  @visibility("read")
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  networkSiblingSetId?: string;

  /**
   * Provides storage to network proximity information for the volume.
   */
  @visibility("read")
  storageToNetworkProximity?: VolumeStorageToNetworkProximity;

  /**
   * List of mount targets
   */
  @visibility("read")
  mountTargets?: MountTargetProperties[];

  /**
   * What type of volume is this. For destination volumes in Cross Region Replication, set type to DataProtection
   */
  volumeType?: string;

  /**
   * DataProtection type volumes include an object containing details of the replication
   */
  dataProtection?: VolumePropertiesDataProtection;

  /**
   * Restoring
   */
  isRestoring?: boolean;

  /**
   * If enabled (true) the volume will contain a read-only snapshot directory which provides access to each of the volume's snapshots (defaults to true).
   */
  snapshotDirectoryVisible?: boolean = true;

  /**
   * Describe if a volume is KerberosEnabled. To be use with swagger version 2020-05-01 or later
   */
  @visibility("read", "create")
  kerberosEnabled?: boolean;

  /**
   * The security style of volume, default unix, defaults to ntfs for dual protocol or CIFS protocol
   */
  securityStyle?: SecurityStyle = SecurityStyle.unix;

  /**
   * Enables encryption for in-flight smb3 data. Only applicable for SMB/DualProtocol volume. To be used with swagger version 2020-08-01 or later
   */
  smbEncryption?: boolean;

  /**
   * Enables access-based enumeration share property for SMB Shares. Only applicable for SMB/DualProtocol volume
   */
  smbAccessBasedEnumeration?: SmbAccessBasedEnumeration;

  /**
   * Enables non-browsable property for SMB Shares. Only applicable for SMB/DualProtocol volume
   */
  smbNonBrowsable?: SmbNonBrowsable;

  /**
   * Enables continuously available share property for smb volume. Only applicable for SMB volume
   */
  smbContinuouslyAvailable?: boolean;

  /**
   * Maximum throughput in MiB/s that can be achieved by this volume and this will be accepted as input only for manual qosType volume
   */
  throughputMibps?: float32;

  /**
   * Actual throughput in MiB/s for auto qosType volumes calculated based on size and serviceLevel
   */
  @visibility("read")
  actualThroughputMibps?: float32;

  /**
   * Source of key used to encrypt data in volume. Applicable if NetApp account has encryption.keySource = 'Microsoft.KeyVault'. Possible values (case-insensitive) are: 'Microsoft.NetApp, Microsoft.KeyVault'
   */
  encryptionKeySource?: EncryptionKeySource = EncryptionKeySource.Microsoft.NetApp;

  /**
   * The resource ID of private endpoint for KeyVault. It must reside in the same VNET as the volume. Only applicable if encryptionKeySource = 'Microsoft.KeyVault'.
   */
  keyVaultPrivateEndpointResourceId?: string;

  /**
   * Specifies whether LDAP is enabled or not for a given NFS volume.
   */
  ldapEnabled?: boolean;

  /**
   * Specifies whether Cool Access(tiering) is enabled for the volume.
   */
  coolAccess?: boolean;

  /**
   * Specifies the number of days after which data that is not accessed by clients will be tiered.
   */
  @maxValue(63)
  @minValue(7)
  coolnessPeriod?: int32;

  /**
* coolAccessRetrievalPolicy determines the data retrieval behavior from the cool tier to standard storage based on the read pattern for cool access enabled volumes. The possible values for this field are:
* Default - Data will be pulled from cool tier to standard storage on random reads. This policy is the default.
 OnRead - All client-driven data read is pulled from cool tier to standard storage on both sequential and random reads.
 Never - No client-driven data is pulled from cool tier to standard storage.
*/
  coolAccessRetrievalPolicy?: CoolAccessRetrievalPolicy;

  /**
   * UNIX permissions for NFS volume accepted in octal 4 digit format. First digit selects the set user ID(4), set group ID (2) and sticky (1) attributes. Second digit selects permission for the owner of the file: read (4), write (2) and execute (1). Third selects permissions for other users in the same group. the fourth for other users not in the group. 0755 - gives read/write/execute permissions to owner and read/execute to group and other users.
   */
  @maxLength(4)
  @minLength(4)
  unixPermissions?: string;

  /**
   * When a volume is being restored from another volume's snapshot, will show the percentage completion of this cloning process. When this value is empty/null there is no cloning process currently happening on this volume. This value will update every 5 minutes during cloning.
   */
  @visibility("read")
  cloneProgress?: int32;

  /**
   * Flag indicating whether file access logs are enabled for the volume, based on active diagnostic settings present on the volume.
   */
  @visibility("read")
  fileAccessLogs?: FileAccessLogs = FileAccessLogs.Disabled;

  /**
   * Specifies whether the volume is enabled for Azure VMware Solution (AVS) datastore purpose
   */
  avsDataStore?: AvsDataStore = AvsDataStore.Disabled;

  /**
   * Data store resource unique identifier
   */
  @visibility("read")
  dataStoreResourceId?: string[];

  /**
   * Specifies if default quota is enabled for the volume.
   */
  isDefaultQuotaEnabled?: boolean;

  /**
   * Default user quota for volume in KiBs. If isDefaultQuotaEnabled is set, the minimum value of 4 KiBs applies .
   */
  defaultUserQuotaInKiBs?: int64;

  /**
   * Default group quota for volume in KiBs. If isDefaultQuotaEnabled is set, the minimum value of 4 KiBs applies.
   */
  defaultGroupQuotaInKiBs?: int64;

  /**
   * Maximum number of files allowed. Needs a service request in order to be changed. Only allowed to be changed if volume quota is more than 4TiB.
   */
  @visibility("read")
  maximumNumberOfFiles?: int64;

  /**
   * Volume Group Name
   */
  @visibility("read")
  volumeGroupName?: string;

  /**
   * Pool Resource Id used in case of creating a volume through volume group
   */
  capacityPoolResourceId?: string;

  /**
   * Proximity placement group associated with the volume
   */
  proximityPlacementGroup?: string;

  /**
   * T2 network information
   */
  @visibility("read")
  t2Network?: string;

  /**
   * Volume spec name is the application specific designation or identifier for the particular volume in a volume group for e.g. data, log
   */
  volumeSpecName?: string;

  /**
   * Specifies if the volume is encrypted or not. Only available on volumes created or updated after 2022-01-01.
   */
  @visibility("read")
  encrypted?: boolean;

  /**
   * Application specific placement rules for the particular volume
   */
  placementRules?: PlacementKeyValuePairs[];

  /**
   * Flag indicating whether subvolume operations are enabled on the volume
   */
  enableSubvolumes?: EnableSubvolumes = EnableSubvolumes.Disabled;

  /**
   * The availability zone where the volume is provisioned. This refers to the logical availability zone where the volume resides.
   */
  @visibility("read")
  provisionedAvailabilityZone?: string;

  /**
   * Specifies whether volume is a Large Volume or Regular Volume.
   */
  isLargeVolume?: boolean;

  /**
   * Id of the snapshot or backup that the volume is restored from.
   */
  @visibility("read")
  originatingResourceId?: string;
}

/**
 * Set of export policy rules
 */
model VolumePropertiesExportPolicy {
  /**
   * Export policy rule
   */
  rules?: ExportPolicyRule[];
}

/**
 * Volume Export Policy Rule
 */
model ExportPolicyRule {
  /**
   * Order index
   */
  ruleIndex?: int32;

  /**
   * Read only access
   */
  unixReadOnly?: boolean;

  /**
   * Read and write access
   */
  unixReadWrite?: boolean;

  /**
   * Kerberos5 Read only access. To be use with swagger version 2020-05-01 or later
   */
  kerberos5ReadOnly?: boolean;

  /**
   * Kerberos5 Read and write access. To be use with swagger version 2020-05-01 or later
   */
  kerberos5ReadWrite?: boolean;

  /**
   * Kerberos5i Read only access. To be use with swagger version 2020-05-01 or later
   */
  @projectedName("json", "kerberos5iReadOnly")
  kerberos5IReadOnly?: boolean;

  /**
   * Kerberos5i Read and write access. To be use with swagger version 2020-05-01 or later
   */
  @projectedName("json", "kerberos5iReadWrite")
  kerberos5IReadWrite?: boolean;

  /**
   * Kerberos5p Read only access. To be use with swagger version 2020-05-01 or later
   */
  @projectedName("json", "kerberos5pReadOnly")
  kerberos5PReadOnly?: boolean;

  /**
   * Kerberos5p Read and write access. To be use with swagger version 2020-05-01 or later
   */
  @projectedName("json", "kerberos5pReadWrite")
  kerberos5PReadWrite?: boolean;

  /**
   * Allows CIFS protocol
   */
  cifs?: boolean;

  /**
   * Allows NFSv3 protocol. Enable only for NFSv3 type volumes
   */
  nfsv3?: boolean;

  /**
   * Allows NFSv4.1 protocol. Enable only for NFSv4.1 type volumes
   */
  nfsv41?: boolean;

  /**
   * Client ingress specification as comma separated string with IPv4 CIDRs, IPv4 host addresses and host names
   */
  allowedClients?: string;

  /**
   * Has root access to volume
   */
  hasRootAccess?: boolean = true;

  /**
   * This parameter specifies who is authorized to change the ownership of a file. restricted - Only root user can change the ownership of the file. unrestricted - Non-root users can change ownership of files that they own.
   */
  chownMode?: ChownMode = ChownMode.Restricted;
}

/**
 * Mount target properties
 */
model MountTargetProperties {
  /**
   * UUID v4 used to identify the MountTarget
   */
  @visibility("read")
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  mountTargetId?: string;

  /**
   * UUID v4 used to identify the MountTarget
   */
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  fileSystemId: string;

  /**
   * The mount target's IPv4 address
   */
  @visibility("read")
  ipAddress?: string;

  /**
   * The SMB server's Fully Qualified Domain Name, FQDN
   */
  smbServerFqdn?: string;
}

/**
 * DataProtection type volumes include an object containing details of the replication
 */
model VolumePropertiesDataProtection {
  /**
   * Replication properties
   */
  replication?: ReplicationObject;

  /**
   * Snapshot properties.
   */
  snapshot?: VolumeSnapshotProperties;

  /**
   * VolumeRelocation properties
   */
  volumeRelocation?: VolumeRelocationProperties;
}

/**
 * Replication properties
 */
model ReplicationObject {
  /**
   * Id
   */
  @visibility("read")
  replicationId?: string;

  /**
   * Indicates whether the local volume is the source or destination for the Volume Replication
   */
  endpointType?: EndpointType;

  /**
   * Schedule
   */
  replicationSchedule?: ReplicationSchedule;

  /**
   * The resource ID of the remote volume.
   */
  remoteVolumeResourceId: string;

  /**
   * The remote region for the other end of the Volume Replication.
   */
  remoteVolumeRegion?: string;
}

/**
 * Volume Snapshot Properties
 */
model VolumeSnapshotProperties {
  /**
   * Snapshot Policy ResourceId
   */
  snapshotPolicyId?: string;
}

/**
 * Volume relocation properties
 */
model VolumeRelocationProperties {
  /**
   * Has relocation been requested for this volume
   */
  relocationRequested?: boolean;

  /**
   * Has relocation finished and is ready to be cleaned up
   */
  @visibility("read")
  readyToBeFinalized?: boolean;
}

/**
 * Application specific parameters for the placement of volumes in the volume group
 */
model PlacementKeyValuePairs {
  /**
   * Key for an application specific parameter for the placement of volumes in the volume group
   */
  key: string;

  /**
   * Value for an application specific parameter for the placement of volumes in the volume group
   */
  value: string;
}

/**
 * Volume patch resource
 */
model VolumePatch {
  /**
   * Resource location
   */
  location?: string;

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

  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * Patchable volume properties
   */
  properties?: VolumePatchProperties;
}

/**
 * Patchable volume properties
 */
model VolumePatchProperties {
  /**
   * The service level of the file system
   */
  serviceLevel?: ServiceLevel = ServiceLevel.Premium;

  /**
   * Maximum storage quota allowed for a file system in bytes. This is a soft quota used for alerting only. Minimum size is 100 GiB. Upper limit is 100TiB, 500Tib for LargeVolume or 2400Tib for LargeVolume on exceptional basis. Specified in bytes.
   */
  @maxValue(2638827906662400)
  @minValue(107374182400)
  usageThreshold?: int64 = 107374182400;

  /**
   * Set of export policy rules
   */
  exportPolicy?: VolumePatchPropertiesExportPolicy;

  /**
   * Maximum throughput in MiB/s that can be achieved by this volume and this will be accepted as input only for manual qosType volume
   */
  throughputMibps?: float32;

  /**
   * DataProtection type volumes include an object containing details of the replication
   */
  dataProtection?: VolumePatchPropertiesDataProtection;

  /**
   * Specifies if default quota is enabled for the volume.
   */
  isDefaultQuotaEnabled?: boolean;

  /**
   * Default user quota for volume in KiBs. If isDefaultQuotaEnabled is set, the minimum value of 4 KiBs applies .
   */
  defaultUserQuotaInKiBs?: int64;

  /**
   * Default group quota for volume in KiBs. If isDefaultQuotaEnabled is set, the minimum value of 4 KiBs applies.
   */
  defaultGroupQuotaInKiBs?: int64;

  /**
   * UNIX permissions for NFS volume accepted in octal 4 digit format. First digit selects the set user ID(4), set group ID (2) and sticky (1) attributes. Second digit selects permission for the owner of the file: read (4), write (2) and execute (1). Third selects permissions for other users in the same group. the fourth for other users not in the group. 0755 - gives read/write/execute permissions to owner and read/execute to group and other users.
   */
  @maxLength(4)
  @minLength(4)
  unixPermissions?: string;

  /**
   * Specifies whether Cool Access(tiering) is enabled for the volume.
   */
  coolAccess?: boolean;

  /**
   * Specifies the number of days after which data that is not accessed by clients will be tiered.
   */
  @maxValue(63)
  @minValue(7)
  coolnessPeriod?: int32;

  /**
* coolAccessRetrievalPolicy determines the data retrieval behavior from the cool tier to standard storage based on the read pattern for cool access enabled volumes. The possible values for this field are:
* Default - Data will be pulled from cool tier to standard storage on random reads. This policy is the default.
 OnRead - All client-driven data read is pulled from cool tier to standard storage on both sequential and random reads.
 Never - No client-driven data is pulled from cool tier to standard storage.
*/
  coolAccessRetrievalPolicy?: CoolAccessRetrievalPolicy;

  /**
   * If enabled (true) the volume will contain a read-only snapshot directory which provides access to each of the volume's snapshots.
   */
  snapshotDirectoryVisible?: boolean;

  /**
   * Enables access-based enumeration share property for SMB Shares. Only applicable for SMB/DualProtocol volume
   */
  smbAccessBasedEnumeration?: SmbAccessBasedEnumeration;

  /**
   * Enables non-browsable property for SMB Shares. Only applicable for SMB/DualProtocol volume
   */
  smbNonBrowsable?: SmbNonBrowsable;
}

/**
 * Set of export policy rules
 */
model VolumePatchPropertiesExportPolicy {
  /**
   * Export policy rule
   */
  rules?: ExportPolicyRule[];
}

/**
 * DataProtection type volumes include an object containing details of the replication
 */
model VolumePatchPropertiesDataProtection {
  /**
   * Snapshot properties.
   */
  snapshot?: VolumeSnapshotProperties;
}

/**
 * revert a volume to the snapshot
 */
model VolumeRevert {
  /**
   * Resource id of the snapshot
   */
  snapshotId?: string;
}

/**
 * Break file locks request
 */
model BreakFileLocksRequest {
  /**
   * To clear file locks on a volume for a particular client
   */
  @pattern("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
  clientIp?: string;

  /**
   * Break File locks could be a disruptive operation for application as locks on the volume will be broken, if want to process, set to true.
   */
  confirmRunningDisruptiveOperation?: boolean;
}

/**
 * Get group Id list for LDAP User request
 */
model GetGroupIdListForLdapUserRequest {
  /**
   * username is required to fetch the group to which user is part of
   */
  @maxLength(255)
  @minLength(1)
  username: string;
}

/**
 * Group Id list for Ldap user
 */
model GetGroupIdListForLdapUserResponse {
  /**
   * Group Id list
   */
  groupIdsForLdapUser?: string[];
}

/**
 * Break replication request
 */
model BreakReplicationRequest {
  /**
   * If replication is in status transferring and you want to force break the replication, set to true
   */
  forceBreakReplication?: boolean;
}

/**
 * Re-establish request object supplied in the body of the operation.
 */
model ReestablishReplicationRequest {
  /**
   * Resource id of the source volume for the replication
   */
  sourceVolumeId?: string;
}

/**
 * Replication status
 */
model ReplicationStatus {
  /**
   * Replication health check
   */
  healthy?: boolean;

  /**
   * Status of the mirror relationship
   */
  relationshipStatus?: RelationshipStatus;

  /**
   * The status of the replication
   */
  mirrorState?: MirrorState;

  /**
   * The progress of the replication
   */
  totalProgress?: string;

  /**
   * Displays error message if the replication is in an error state
   */
  errorMessage?: string;
}

/**
 * List Replications
 */
@pagedResult
model ListReplications {
  /**
   * A list of replications
   */
  @items
  value?: Replication[];
}

/**
 * Replication properties
 */
model Replication {
  /**
   * Indicates whether the local volume is the source or destination for the Volume Replication
   */
  endpointType?: EndpointType;

  /**
   * Schedule
   */
  replicationSchedule?: ReplicationSchedule;

  /**
   * The resource ID of the remote volume.
   */
  remoteVolumeResourceId: string;

  /**
   * The remote region for the other end of the Volume Replication.
   */
  remoteVolumeRegion?: string;
}

/**
 * Authorize request
 */
model AuthorizeRequest {
  /**
   * Resource id of the remote volume
   */
  remoteVolumeResourceId?: string;
}

/**
 * Pool change request
 */
model PoolChangeRequest {
  /**
   * Resource id of the pool to move volume to
   */
  newPoolResourceId: string;
}

/**
 * Relocate volume request
 */
model RelocateVolumeRequest {
  /**
   * New creation token for the volume that controls the mount point name
   */
  creationToken?: string;
}

/**
 * Snapshot properties
 */
model SnapshotProperties {
  /**
   * UUID v4 used to identify the Snapshot
   */
  @visibility("read")
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  snapshotId?: string;

  /**
   * The creation date of the snapshot
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * Azure lifecycle management
   */
  @visibility("read")
  provisioningState?: string;
}

/**
 * Restore payload for Single File Snapshot Restore
 */
model SnapshotRestoreFiles {
  /**
   * List of files to be restored
   */
  filePaths: string[];

  /**
   * Destination folder where the files will be restored
   */
  destinationPath?: string;
}

/**
 * Snapshot policy properties
 */
model SnapshotPolicyProperties {
  /**
   * Schedule for hourly snapshots
   */
  hourlySchedule?: HourlySchedule;

  /**
   * Schedule for daily snapshots
   */
  dailySchedule?: DailySchedule;

  /**
   * Schedule for weekly snapshots
   */
  weeklySchedule?: WeeklySchedule;

  /**
   * Schedule for monthly snapshots
   */
  monthlySchedule?: MonthlySchedule;

  /**
   * The property to decide policy is enabled or not
   */
  enabled?: boolean;

  /**
   * Azure lifecycle management
   */
  @visibility("read")
  provisioningState?: string;
}

/**
 * Hourly Schedule properties
 */
model HourlySchedule {
  /**
   * Hourly snapshot count to keep
   */
  snapshotsToKeep?: int32;

  /**
   * Indicates which minute snapshot should be taken
   */
  minute?: int32;

  /**
   * Resource size in bytes, current storage usage for the volume in bytes
   */
  usedBytes?: int64;
}

/**
 * Daily Schedule properties
 */
model DailySchedule {
  /**
   * Daily snapshot count to keep
   */
  snapshotsToKeep?: int32;

  /**
   * Indicates which hour in UTC timezone a snapshot should be taken
   */
  hour?: int32;

  /**
   * Indicates which minute snapshot should be taken
   */
  minute?: int32;

  /**
   * Resource size in bytes, current storage usage for the volume in bytes
   */
  usedBytes?: int64;
}

/**
 * Weekly Schedule properties, make a snapshot every week at a specific day or days
 */
model WeeklySchedule {
  /**
   * Weekly snapshot count to keep
   */
  snapshotsToKeep?: int32;

  /**
   * Indicates which weekdays snapshot should be taken, accepts a comma separated list of week day names in english
   */
  day?: string;

  /**
   * Indicates which hour in UTC timezone a snapshot should be taken
   */
  hour?: int32;

  /**
   * Indicates which minute snapshot should be taken
   */
  minute?: int32;

  /**
   * Resource size in bytes, current storage usage for the volume in bytes
   */
  usedBytes?: int64;
}

/**
 * Monthly Schedule properties
 */
model MonthlySchedule {
  /**
   * Monthly snapshot count to keep
   */
  snapshotsToKeep?: int32;

  /**
   * Indicates which days of the month snapshot should be taken. A comma delimited string.
   */
  daysOfMonth?: string;

  /**
   * Indicates which hour in UTC timezone a snapshot should be taken
   */
  hour?: int32;

  /**
   * Indicates which minute snapshot should be taken
   */
  minute?: int32;

  /**
   * Resource size in bytes, current storage usage for the volume in bytes
   */
  usedBytes?: int64;
}

/**
 * Snapshot policy Details for create and update
 */
model SnapshotPolicyPatch {
  /**
   * Resource location
   */
  location?: string;

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

  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * Snapshot Policy properties
   */
  properties?: SnapshotPolicyProperties;
}

/**
 * Volumes associated with snapshot policy
 */
model SnapshotPolicyVolumeList {
  /**
   * List of volumes
   */
  value?: Volume[];
}

/**
 * Restore status
 */
model RestoreStatus {
  /**
   * Restore health status
   */
  @visibility("read")
  healthy?: boolean;

  /**
   * Status of the restore SnapMirror relationship
   */
  @visibility("read")
  relationshipStatus?: RelationshipStatus;

  /**
   * The status of the restore
   */
  @visibility("read")
  mirrorState?: MirrorState;

  /**
   * Reason for the unhealthy restore relationship
   */
  @visibility("read")
  unhealthyReason?: string;

  /**
   * Displays error message if the restore is in an error state
   */
  @visibility("read")
  errorMessage?: string;

  /**
   * Displays the total bytes transferred
   */
  @visibility("read")
  totalTransferBytes?: int64;
}

/**
 * Backup policy properties
 */
model BackupPolicyProperties {
  /**
   * Backup Policy Resource ID
   */
  @visibility("read")
  backupPolicyId?: string;

  /**
   * Azure lifecycle management
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Daily backups count to keep
   */
  dailyBackupsToKeep?: int32;

  /**
   * Weekly backups count to keep
   */
  weeklyBackupsToKeep?: int32;

  /**
   * Monthly backups count to keep
   */
  monthlyBackupsToKeep?: int32;

  /**
   * Volumes using current backup policy
   */
  @visibility("read")
  volumesAssigned?: int32;

  /**
   * The property to decide policy is enabled or not
   */
  enabled?: boolean;

  /**
   * A list of volumes assigned to this policy
   */
  @visibility("read")
  volumeBackups?: VolumeBackups[];
}

/**
 * Volume details using the backup policy
 */
model VolumeBackups {
  /**
   * Volume name
   */
  volumeName?: string;

  /**
   * Total count of backups for volume
   */
  backupsCount?: int32;

  /**
   * Policy enabled
   */
  policyEnabled?: boolean;
}

/**
 * Backup policy Details for create and update
 */
model BackupPolicyPatch {
  /**
   * Resource location
   */
  @visibility("read", "create")
  location?: string;

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

  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * Backup policy Properties
   */
  properties?: BackupPolicyProperties;
}

/**
 * Volume Quota Rule properties
 */
model VolumeQuotaRulesProperties {
  /**
   * Gets the status of the VolumeQuotaRule at the time the operation was called.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Size of quota
   */
  quotaSizeInKiBs?: int64;

  /**
   * Type of quota
   */
  @visibility("read", "create")
  quotaType?: Type;

  /**
   * UserID/GroupID/SID based on the quota target type. UserID and groupID can be found by running ‘id’ or ‘getent’ command for the user or group and SID can be found by running <wmic useraccount where name='user-name' get sid>
   */
  @visibility("read", "create")
  quotaTarget?: string;
}

/**
 * Patchable Quota Rule of a Volume
 */
model VolumeQuotaRulePatch {
  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * Volume Quota Rule Properties
   */
  properties?: VolumeQuotaRulesProperties;
}

/**
 * List of volume group resources
 */
@pagedResult
model VolumeGroupList {
  /**
   * List of volume Groups
   */
  @items
  value?: VolumeGroup[];
}

/**
 * Volume group resource
 */
model VolumeGroup {
  /**
   * Resource location
   */
  @visibility("read", "create")
  location?: string;

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

  /**
   * Volume group properties
   */
  properties?: VolumeGroupListProperties;
}

/**
 * Volume group properties
 */
model VolumeGroupListProperties {
  /**
   * Azure lifecycle management
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Volume group details
   */
  groupMetaData?: VolumeGroupMetaData;
}

/**
 * Volume group properties
 */
model VolumeGroupMetaData {
  /**
   * Group Description
   */
  groupDescription?: string;

  /**
   * Application Type
   */
  applicationType?: ApplicationType;

  /**
   * Application specific identifier
   */
  applicationIdentifier?: string;

  /**
   * Application specific placement rules for the volume group
   */
  globalPlacementRules?: PlacementKeyValuePairs[];

  /**
   * Application specific identifier of deployment rules for the volume group
   */
  deploymentSpecId?: string;

  /**
   * Number of volumes in volume group
   */
  @visibility("read")
  volumesCount?: int64;
}

/**
 * Volume group properties
 */
model VolumeGroupProperties {
  /**
   * Azure lifecycle management
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Volume group details
   */
  groupMetaData?: VolumeGroupMetaData;

  /**
   * List of volumes from group
   */
  volumes?: VolumeGroupVolumeProperties[];
}

/**
 * Volume resource
 */
model VolumeGroupVolumeProperties {
  /**
   * Resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name
   */
  name?: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * Availability Zone
   */
  @visibility("read", "create")
  zones?: string[];

  /**
   * Volume properties
   */
  properties: VolumeProperties;
}

/**
 * This represents path associated with the subvolume
 */
model SubvolumeProperties {
  /**
   * Path to the subvolume
   */
  path?: string;

  /**
   * Truncate subvolume to the provided size in bytes
   */
  @visibility("create", "update")
  size?: int64;

  /**
   * parent path to the subvolume
   */
  parentPath?: string;

  /**
   * Azure lifecycle management
   */
  @visibility("read")
  provisioningState?: string;
}

/**
 * Subvolume Patch Request properties
 */
model SubvolumePatchRequest {
  /**
   * Subvolume Properties
   */
  properties?: SubvolumePatchParams;
}

/**
 * Parameters with which a subvolume can be updated
 */
model SubvolumePatchParams {
  /**
   * Truncate subvolume to the provided size in bytes
   */
  size?: int64;

  /**
   * path to the subvolume
   */
  path?: string;
}

/**
 * Result of the post subvolume and action is to get metadata of the subvolume.
 */
model SubvolumeModel {
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

  /**
   * It represents the minimal properties of the subvolume.
   */
  properties?: SubvolumeModelProperties;
}

/**
 * Properties which represents actual subvolume model which is stored as a file in the system.
 */
model SubvolumeModelProperties {
  /**
   * Path to the subvolume
   */
  path?: string;

  /**
   * Path to the parent subvolume
   */
  parentPath?: string;

  /**
   * Size of subvolume
   */
  size?: int64;

  /**
   * Bytes used
   */
  bytesUsed?: int64;

  /**
   * Permissions of the subvolume
   */
  permissions?: string;

  /**
   * Creation time and date
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTimeStamp?: utcDateTime;

  /**
   * Most recent access time and date
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  accessedTimeStamp?: utcDateTime;

  /**
   * Most recent modification time and date
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedTimeStamp?: utcDateTime;

  /**
   * Most recent change time and date
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTimeStamp?: utcDateTime;

  /**
   * Azure lifecycle management
   */
  provisioningState?: string;
}

/**
 * Identity for the resource.
 */
model ResourceIdentity {
  /**
   * Object id of the identity resource
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant id of the resource
   */
  @visibility("read")
  tenantId?: string;

  /**
   * Type of Identity. Supported values are: 'None', 'SystemAssigned'
   */
  type?: string;
}

/**
 * Mount Target
 */
model MountTarget {
  /**
   * Resource location
   */
  location: string;

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

  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * Mount Target Properties
   */
  properties: MountTargetProperties;
}

/**
 * Snapshot policy properties
 */
model SnapshotPolicyDetails {
  /**
   * Resource location
   */
  @visibility("read", "create")
  location?: string;

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

  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * Snapshot policy Properties
   */
  properties?: SnapshotPolicyProperties;
}
