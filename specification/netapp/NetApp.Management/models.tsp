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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union MetricAggregationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Average: "Average",
}

/**
 * Resource type used for verification.
 */
union CheckNameResourceTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.NetApp/netAppAccounts`: "Microsoft.NetApp/netAppAccounts",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.NetApp/netAppAccounts/capacityPools`: "Microsoft.NetApp/netAppAccounts/capacityPools",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.NetApp/netAppAccounts/capacityPools/volumes`: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.NetApp/netAppAccounts/capacityPools/volumes/snapshots`: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/snapshots",
}

/**
 * <code>Invalid</code> indicates the name provided does not match Azure App Service naming requirements. <code>AlreadyExists</code> indicates that the name is already in use and is therefore unavailable.
 */
union InAvailabilityReasonType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AlreadyExists: "AlreadyExists",
}

/**
 * Resource type used for verification.
 */
union CheckQuotaNameResourceTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.NetApp/netAppAccounts`: "Microsoft.NetApp/netAppAccounts",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.NetApp/netAppAccounts/capacityPools`: "Microsoft.NetApp/netAppAccounts/capacityPools",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.NetApp/netAppAccounts/capacityPools/volumes`: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.NetApp/netAppAccounts/capacityPools/volumes/snapshots`: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/snapshots",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
}

/**
 * Provides storage to network proximity information in the region.
 */
union RegionStorageToNetworkProximity {
  string,

  /**
   * Basic network connectivity.
   */
  Default: "Default",

  /**
   * Standard T1 network connectivity.
   */
  T1: "T1",

  /**
   * Standard T2 network connectivity.
   */
  T2: "T2",

  /**
   * Standard AcrossT2 network connectivity.
   */
  AcrossT2: "AcrossT2",

  /**
   * Standard T1 and T2 network connectivity.
   */
  T1AndT2: "T1AndT2",

  /**
   * Standard T1 and AcrossT2 network connectivity.
   */
  T1AndAcrossT2: "T1AndAcrossT2",

  /**
   * Standard T2 and AcrossT2 network connectivity.
   */
  T2AndAcrossT2: "T2AndAcrossT2",

  /**
   * Standard T1, T2 and AcrossT2 network connectivity.
   */
  T1AndT2AndAcrossT2: "T1AndT2AndAcrossT2",
}

/**
 * Network features available to the volume, or current state of update.
 */
union NetworkFeatures {
  string,

  /**
   * Basic network features.
   */
  Basic: "Basic",

  /**
   * Standard network features.
   */
  Standard: "Standard",

  /**
   * Updating from Basic to Standard network features.
   */
  Basic_Standard: "Basic_Standard",

  /**
   * Updating from Standard to Basic network features.
   */
  Standard_Basic: "Standard_Basic",
}

/**
 * Gets the status of the NetworkSiblingSet at the time the operation was called.
 */
union NetworkSiblingSetProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
}

/**
 * Status of the Active Directory
 */
union ActiveDirectoryStatus {
  string,

  /**
   * Active Directory created but not in use
   */
  Created: "Created",

  /**
   * Active Directory in use by SMB Volume
   */
  InUse: "InUse",

  /**
   * Active Directory Deleted
   */
  Deleted: "Deleted",

  /**
   * Error with the Active Directory
   */
  Error: "Error",

  /**
   * Active Directory Updating
   */
  Updating: "Updating",
}

/**
 * The encryption keySource (provider). Possible values (case-insensitive):  Microsoft.NetApp, Microsoft.KeyVault
 */
union KeySource {
  string,

  /**
   * Microsoft-managed key encryption
   */
  `Microsoft.NetApp`: "Microsoft.NetApp",

  /**
   * Customer-managed key encryption
   */
  `Microsoft.KeyVault`: "Microsoft.KeyVault",
}

/**
 * Status of the KeyVault connection.
 */
union KeyVaultStatus {
  string,

  /**
   * KeyVault connection created but not in use
   */
  Created: "Created",

  /**
   * KeyVault connection in use by SMB Volume
   */
  InUse: "InUse",

  /**
   * KeyVault connection Deleted
   */
  Deleted: "Deleted",

  /**
   * Error with the KeyVault connection
   */
  Error: "Error",

  /**
   * KeyVault connection Updating
   */
  Updating: "Updating",
}

/**
 * MultiAD Status for the account
 */
union MultiAdStatus {
  string,

  /**
   * Account is MultiAD disabled, Means its a SharedAD or SingleAD account.
   */
  Disabled: "Disabled",

  /**
   * Account is MultiAD enabled
   */
  Enabled: "Enabled",
}

/**
 * The service level of the file system
 */
union ServiceLevel {
  string,

  /**
   * Standard service level
   */
  Standard: "Standard",

  /**
   * Premium service level
   */
  Premium: "Premium",

  /**
   * Ultra service level
   */
  Ultra: "Ultra",

  /**
   * Zone redundant storage service level. This will be deprecated soon.
   */
  StandardZRS: "StandardZRS",

  /**
   * Flexible service level
   */
  Flexible: "Flexible",
}

/**
 * The qos type of the pool
 */
union QosType {
  string,

  /**
   * qos type Auto
   */
  Auto: "Auto",

  /**
   * qos type Manual
   */
  Manual: "Manual",
}

/**
 * Encryption type of the capacity pool, set encryption type for data at rest for this pool and all volumes in it. This value can only be set when creating new pool.
 */
union EncryptionType {
  string,

  /**
   * EncryptionType Single, volumes will use single encryption at rest
   */
  Single: "Single",

  /**
   * EncryptionType Double, volumes will use double encryption at rest
   */
  Double: "Double",
}

/**
 * This parameter specifies who is authorized to change the ownership of a file. restricted - Only root user can change the ownership of the file. unrestricted - Non-root users can change ownership of files that they own.
 */
union ChownMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Restricted: "Restricted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unrestricted: "Unrestricted",
}

/**
 * Provides storage to network proximity information for the volume.
 */
union VolumeStorageToNetworkProximity {
  string,

  /**
   * Basic storage to network connectivity.
   */
  Default: "Default",

  /**
   * Standard T1 storage to network connectivity.
   */
  T1: "T1",

  /**
   * Standard T2 storage to network connectivity.
   */
  T2: "T2",

  /**
   * Standard AcrossT2 storage to network connectivity.
   */
  AcrossT2: "AcrossT2",
}

/**
 * Indicates whether the local volume is the source or destination for the Volume Replication
 */
union EndpointType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  src: "src",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  dst: "dst",
}

/**
 * Schedule
 */
union ReplicationSchedule {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  _10minutely: "_10minutely",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  hourly: "hourly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  daily: "daily",
}

/**
 * Indicates whether the replication is cross zone or cross region.
 */
union ReplicationType {
  string,

  /**
   * Cross region replication
   */
  CrossRegionReplication: "CrossRegionReplication",

  /**
   * Cross zone replication
   */
  CrossZoneReplication: "CrossZoneReplication",
}

/**
 * While auto splitting the short term clone volume, if the parent pool does not have enough space to accommodate the volume after split, it will be automatically resized, which will lead to increased billing. To accept capacity pool size auto grow and create a short term clone volume, set the property as accepted.
 */
union AcceptGrowCapacityPoolForShortTermCloneSplit {
  string,

  /**
   * Auto grow capacity pool for short term clone split is accepted.
   */
  Accepted: "Accepted",

  /**
   * Auto grow capacity pool for short term clone split is declined. Short term clone volume creation will not be allowed, to create short term clone volume accept auto grow capacity pool.
   */
  Declined: "Declined",
}

/**
 * The security style of volume, default unix, defaults to ntfs for dual protocol or CIFS protocol
 */
union SecurityStyle {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ntfs: "ntfs",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  unix: "unix",
}

/**
 * Enables access-based enumeration share property for SMB Shares. Only applicable for SMB/DualProtocol volume
 */
union SmbAccessBasedEnumeration {
  string,

  /**
   * smbAccessBasedEnumeration share setting is disabled
   */
  Disabled: "Disabled",

  /**
   * smbAccessBasedEnumeration share setting is enabled
   */
  Enabled: "Enabled",
}

/**
 * Enables non-browsable property for SMB Shares. Only applicable for SMB/DualProtocol volume
 */
union SmbNonBrowsable {
  string,

  /**
   * smbNonBrowsable share setting is disabled
   */
  Disabled: "Disabled",

  /**
   * smbNonBrowsable share setting is enabled
   */
  Enabled: "Enabled",
}

/**
 * Source of key used to encrypt data in volume. Applicable if NetApp account has encryption.keySource = 'Microsoft.KeyVault'. Possible values (case-insensitive) are: 'Microsoft.NetApp, Microsoft.KeyVault'
 */
union EncryptionKeySource {
  string,

  /**
   * Microsoft-managed key encryption
   */
  `Microsoft.NetApp`: "Microsoft.NetApp",

  /**
   * Customer-managed key encryption
   */
  `Microsoft.KeyVault`: "Microsoft.KeyVault",
}

/**
 * coolAccessRetrievalPolicy determines the data retrieval behavior from the cool tier to standard storage based on the read pattern for cool access enabled volumes. The possible values for this field are:
 *  Default - Data will be pulled from cool tier to standard storage on random reads. This policy is the default.
 *  OnRead - All client-driven data read is pulled from cool tier to standard storage on both sequential and random reads.
 *  Never - No client-driven data is pulled from cool tier to standard storage.
 */
union CoolAccessRetrievalPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OnRead: "OnRead",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Never: "Never",
}

/**
 * coolAccessTieringPolicy determines which cold data blocks are moved to cool tier. The possible values for this field are: Auto - Moves cold user data blocks in both the Snapshot copies and the active file system to the cool tier tier. This policy is the default. SnapshotOnly - Moves user data blocks of the Volume Snapshot copies that are not associated with the active file system to the cool tier.
 */
union CoolAccessTieringPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Auto: "Auto",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SnapshotOnly: "SnapshotOnly",
}

/**
 * Flag indicating whether file access logs are enabled for the volume, based on active diagnostic settings present on the volume.
 */
union FileAccessLogs {
  string,

  /**
   * fileAccessLogs are enabled
   */
  Enabled: "Enabled",

  /**
   * fileAccessLogs are not enabled
   */
  Disabled: "Disabled",
}

/**
 * Specifies whether the volume is enabled for Azure VMware Solution (AVS) datastore purpose
 */
union AvsDataStore {
  string,

  /**
   * avsDataStore is enabled
   */
  Enabled: "Enabled",

  /**
   * avsDataStore is disabled
   */
  Disabled: "Disabled",
}

/**
 * Flag indicating whether subvolume operations are enabled on the volume
 */
union EnableSubvolumes {
  string,

  /**
   * subvolumes are enabled
   */
  Enabled: "Enabled",

  /**
   * subvolumes are not enabled
   */
  Disabled: "Disabled",
}

/**
 * Status of the mirror relationship
 */
union RelationshipStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Idle: "Idle",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Transferring: "Transferring",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
}

/**
 * The status of the replication
 */
union MirrorState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Uninitialized: "Uninitialized",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Mirrored: "Mirrored",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Broken: "Broken",
}

/**
 * Type of quota
 */
union Type {
  string,

  /**
   * Default user quota
   */
  DefaultUserQuota: "DefaultUserQuota",

  /**
   * Default group quota
   */
  DefaultGroupQuota: "DefaultGroupQuota",

  /**
   * Individual user quota
   */
  IndividualUserQuota: "IndividualUserQuota",

  /**
   * Individual group quota
   */
  IndividualGroupQuota: "IndividualGroupQuota",
}

/**
 * Application Type
 */
union ApplicationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `SAP-HANA`: "SAP-HANA",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ORACLE: "ORACLE",
}

/**
 * Type of backup Manual or Scheduled
 */
union BackupType {
  string,

  /**
   * Manual backup
   */
  Manual: "Manual",

  /**
   * Scheduled backup
   */
  Scheduled: "Scheduled",
}

/**
 * Gets the status of the VolumeQuotaRule at the time the operation was called.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
 * Microsoft.NetApp REST API operation definition.
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * Display metadata associated with the operation.
   */
  display?: OperationDisplay;

  /**
   * The origin of operations.
   */
  origin?: string;

  /**
   * Properties of operation, include metric specifications.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: OperationProperties;
}

/**
 * Display metadata associated with the operation.
 */
model OperationDisplay {
  /**
   * Service provider: Microsoft NetApp.
   */
  provider?: string;

  /**
   * Resource on which the operation is performed etc.
   */
  resource?: string;

  /**
   * Type of operation: get, read, delete, etc.
   */
  operation?: string;

  /**
   * Operation description.
   */
  description?: string;
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
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  metricSpecifications?: MetricSpecification[];

  /**
   * Log specification of operation.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
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
  @OpenAPI.extension("x-ms-identifiers", #["name"])
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

  /**
   * The Azure Resource logical availability zone which is used within zone mapping lookup for the subscription and region. The lookup will retrieve the physical zone where volume is placed.
   */
  availabilityZone?: string;
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
 * Usages result
 */
model UsagesListResult is Azure.Core.Page<UsageResult>;

/**
 * Usages entity model
 */
model UsageResult {
  /**
   * The id of the usage.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the usage.
   */
  @visibility(Lifecycle.Read)
  name?: UsageName;

  /**
   * Usage properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: UsageProperties;
}

/**
 * The name of the usage.
 */
model UsageName {
  /**
   * The name of the usage.
   */
  value?: string;

  /**
   * The localized name of the usage.
   */
  localizedValue?: string;
}

/**
 * Usage properties
 */
model UsageProperties {
  /**
   * The current usage value for the subscription.
   */
  @visibility(Lifecycle.Read)
  currentValue?: int32;

  /**
   * The limit of the usage.
   */
  @visibility(Lifecycle.Read)
  limit?: int32;

  /**
   * The unit of the usage.
   */
  @visibility(Lifecycle.Read)
  unit?: string;
}

/**
 * List of Subscription Quota Items
 */
model SubscriptionQuotaItemList is Azure.Core.Page<SubscriptionQuotaItem>;

/**
 * SubscriptionQuotaItem Properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SubscriptionQuotaItemProperties {
  /**
   * The current quota value.
   */
  @visibility(Lifecycle.Read)
  current?: int32;

  /**
   * The default quota value.
   */
  @visibility(Lifecycle.Read)
  default?: int32;
}

/**
 * Provides region specific information.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model RegionInfo {
  /**
   * Provides storage to network proximity information in the region.
   */
  storageToNetworkProximity?: RegionStorageToNetworkProximity;

  /**
   * Provides logical availability zone mappings for the subscription for a region.
   */
  @OpenAPI.extension("x-ms-identifiers", #["availabilityZone"])
  availabilityZoneMappings?: RegionInfoAvailabilityZoneMappingsItem[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
 * List of regionInfo resources
 */
model RegionInfosList is Azure.Core.Page<RegionInfoResource>;

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
  subnetId: Azure.Core.armResourceIdentifier<[
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
  subnetId?: Azure.Core.armResourceIdentifier<[
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
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkSiblingSetProvisioningState;

  /**
   * List of NIC information
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  nicInfoList?: NicInfo[];
}

/**
 * NIC information and list of volumes for which the NIC has the primary mount ip address.
 */
model NicInfo {
  /**
   * ipAddress
   */
  @visibility(Lifecycle.Read)
  ipAddress?: string;

  /**
   * Volume resource Ids
   */
  volumeResourceIds?: Azure.Core.armResourceIdentifier<[
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
  subnetId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Network sibling set state Id identifying the current state of the sibling set.
   */
  networkSiblingSetStateId: string;

  /**
   * Network features available to the volume.
   */
  networkFeatures: NetworkFeatures = NetworkFeatures.Basic;
}

/**
 * List of NetApp account resources
 */
model NetAppAccountList is Azure.Core.Page<NetAppAccount>;

/**
 * NetApp account properties
 */
model AccountProperties {
  /**
   * Azure lifecycle management
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Active Directories
   */
  @OpenAPI.extension("x-ms-identifiers", #["activeDirectoryId"])
  activeDirectories?: ActiveDirectory[];

  /**
   * Encryption settings
   */
  encryption?: AccountEncryption;

  /**
   * Shows the status of disableShowmount for all volumes under the subscription, null equals false
   */
  @visibility(Lifecycle.Read)
  disableShowmount?: boolean;

  /**
   * Domain for NFSv4 user ID mapping. This property will be set for all NetApp accounts in the subscription and region and only affect non ldap NFSv4 volumes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @maxLength(255)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9.-]{0,253}[a-zA-Z0-9]$")
  nfsV4IDDomain?: string | null;

  /**
   * MultiAD Status for the account
   */
  @visibility(Lifecycle.Read)
  multiAdStatus?: MultiAdStatus;
}

/**
 * Active Directory
 */
model ActiveDirectory {
  /**
   * Id of the Active Directory
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  activeDirectoryId?: string | null;

  /**
   * A domain user account with permission to create machine accounts
   */
  username?: string;

  /**
   * Plain text password of Active Directory domain administrator, value is masked in the response
   */
  @secret
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
  @visibility(Lifecycle.Read)
  status?: ActiveDirectoryStatus;

  /**
   * Any details in regards to the Status of the Active Directory
   */
  @visibility(Lifecycle.Read)
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
  @maxItems(255)
  @minItems(1)
  backupOperators?: string[];

  /**
   * Users to be added to the Built-in Administrators active directory group. A list of unique usernames without domain specifier
   */
  @maxItems(255)
  @minItems(1)
  administrators?: string[];

  /**
   * kdc server IP address for the active directory machine. This optional parameter is used only while creating kerberos volume.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @pattern("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @maxLength(10240)
  @minLength(1)
  @secret
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
  @maxItems(255)
  @minItems(1)
  securityOperators?: string[];

  /**
   * Specifies whether or not the LDAP traffic needs to be secured via TLS.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  ldapOverTLS?: boolean;

  /**
   *  If enabled, NFS client local users can also (in addition to LDAP users) access the NFS volumes.
   */
  allowLocalNfsUsersWithLdap?: boolean;

  /**
   * If enabled, Traffic between the SMB server to Domain Controller (DC) will be encrypted.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @maxLength(255)
  userDN?: string;

  /**
   * This specifies the group DN, which overrides the base DN for group lookups.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
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
  keySource?: KeySource = KeySource.`Microsoft.NetApp`;

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
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  keyVaultId?: string;

  /**
   * The Uri of KeyVault.
   */
  keyVaultUri: url;

  /**
   * The name of KeyVault key.
   */
  keyName: string;

  /**
   * The resource ID of KeyVault.
   */
  keyVaultResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  /**
   * Status of the KeyVault connection.
   */
  @visibility(Lifecycle.Read)
  status?: KeyVaultStatus;
}

/**
 * Identity used to authenticate with key vault.
 */
model EncryptionIdentity {
  /**
   * The principal ID (object ID) of the identity used to authenticate with key vault. Read-only.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The ARM resource identifier of the user assigned identity used to authenticate with key vault. Applicable if identity.type has 'UserAssigned'. It should match key of identity.userAssignedIdentities.
   */
  userAssignedIdentity?: string;

  /**
   * ClientId of the multi-tenant AAD Application. Used to access cross-tenant keyvaults.
   */
  federatedClientId?: string;
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * NetApp Account properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: AccountProperties;

  /**
   * The identity used for the resource.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

/**
 * Encryption transition request
 */
model EncryptionTransitionRequest {
  /**
   * Identifier for the virtual network
   */
  virtualNetworkId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks";
    }
  ]>;

  /**
   * Identifier of the private endpoint to reach the Azure Key Vault
   */
  privateEndpointId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/privateEndpoints";
    }
  ]>;
}

/**
 * Result of getKeyVaultStatus with information about how volumes under NetApp account are encrypted.
 */
model GetKeyVaultStatusResponse {
  /**
   * Represents the properties of the getKeyVaultStatus.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: GetKeyVaultStatusResponseProperties;
}

/**
 * Properties which represents Change key vault status.
 */
model GetKeyVaultStatusResponseProperties {
  /**
   * The URI of the key vault/managed HSM that should be used for encryption.
   */
  keyVaultUri?: url;

  /**
   * The name of the key that should be used for encryption.
   */
  keyName?: string;

  /**
   * Azure resource ID of the key vault/managed HSM that should be used for encryption.
   */
  keyVaultResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  /**
   * Pairs of virtual network ID and private endpoint ID. Every virtual network that has volumes encrypted with customer-managed keys needs its own key vault private endpoint.
   */
  @OpenAPI.extension("x-ms-identifiers", #["virtualNetworkId"])
  keyVaultPrivateEndpoints?: KeyVaultPrivateEndpoint[];
}

/**
 * Pairs of virtual network ID and private endpoint ID. Every virtual network that has volumes encrypted with customer-managed keys needs its own key vault private endpoint.
 */
model KeyVaultPrivateEndpoint {
  /**
   * Identifier for the virtual network id
   */
  virtualNetworkId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks";
    }
  ]>;

  /**
   * Identifier of the private endpoint to reach the Azure Key Vault
   */
  privateEndpointId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/privateEndpoints";
    }
  ]>;
}

/**
 * Change key vault request
 */
model ChangeKeyVault {
  /**
   * The URI of the key vault/managed HSM that should be used for encryption.
   */
  keyVaultUri: url;

  /**
   * The name of the key that should be used for encryption.
   */
  keyName: string;

  /**
   * Azure resource ID of the key vault/managed HSM that should be used for encryption.
   */
  keyVaultResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  /**
   * Pairs of virtual network ID and private endpoint ID. Every virtual network that has volumes encrypted with customer-managed keys needs its own key vault private endpoint.
   */
  @OpenAPI.extension("x-ms-identifiers", #["virtualNetworkId"])
  keyVaultPrivateEndpoints: KeyVaultPrivateEndpoint[];
}

/**
 * List of capacity pool resources
 */
model CapacityPoolList is Azure.Core.Page<CapacityPool>;

/**
 * Pool properties
 */
model PoolProperties {
  /**
   * UUID v4 used to identify the Pool
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  poolId?: string;

  /**
   * Provisioned size of the pool (in bytes). Allowed values are in 1TiB chunks (value must be multiple of 1099511627776).
   */
  size: int64 = 4398046511104;

  /**
   * The service level of the file system
   */
  serviceLevel: ServiceLevel = ServiceLevel.Premium;

  /**
   * Azure lifecycle management
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Total throughput of pool in MiB/s
   */
  @visibility(Lifecycle.Read)
  totalThroughputMibps?: float32;

  /**
   * Utilized throughput of pool in MiB/s
   */
  @visibility(Lifecycle.Read)
  utilizedThroughputMibps?: float32;

  /**
   * Maximum throughput in MiB/s that can be achieved by this pool and this will be accepted as input only for manual qosType pool with Flexible service level
   */
  customThroughputMibps?: float32;

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
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Capacity pool properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: PoolPatchProperties;
}

/**
 * Patchable pool properties
 */
model PoolPatchProperties {
  /**
   * Provisioned size of the pool (in bytes). Allowed values are in 1TiB chunks (value must be multiple of 1099511627776).
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

  /**
   * Maximum throughput in MiB/s that can be achieved by this pool and this will be accepted as input only for manual qosType pool with Flexible service level
   */
  customThroughputMibps?: float32;
}

/**
 * List of volume resources
 */
model VolumeList is Azure.Core.Page<Volume>;

/**
 * Volume properties
 */
model VolumeProperties {
  /**
   * Unique FileSystem Identifier.
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  fileSystemId?: string;

  /**
   * A unique file path for the volume. Used when creating mount targets
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-]{0,79}$")
  creationToken: string;

  /**
   * The service level of the file system
   */
  serviceLevel?: ServiceLevel = ServiceLevel.Premium;

  /**
   * Maximum storage quota allowed for a file system in bytes. This is a soft quota used for alerting only. For regular volumes, valid values are in the range 50GiB to 100TiB. For large volumes, valid values are in the range 100TiB to 500TiB, and on an exceptional basis, from to 2400GiB to 2400TiB. Values expressed in bytes as multiples of 1 GiB.
   */
  @maxValue(2638827906662400)
  @minValue(53687091200)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Resource identifier used to identify the Snapshot.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  snapshotId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/snapshots";
    }
  ]>;

  /**
   * If enabled (true) the snapshot the volume was created from will be automatically deleted after the volume create operation has finished.  Defaults to false
   */
  deleteBaseSnapshot?: boolean;

  /**
   * Resource identifier used to identify the Backup.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  backupId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/backupVaults/backups";
    }
  ]>;

  /**
   * Unique Baremetal Tenant Identifier.
   */
  @visibility(Lifecycle.Read)
  baremetalTenantId?: string;

  /**
   * The Azure Resource URI for a delegated subnet. Must have the delegation Microsoft.NetApp/volumes
   */
  subnetId: string;

  /**
   * The original value of the network features type available to the volume at the time it was created.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkFeatures?: NetworkFeatures = NetworkFeatures.Basic;

  /**
   * The effective value of the network features type available to the volume, or current effective state of update.
   */
  @visibility(Lifecycle.Read)
  effectiveNetworkFeatures?: NetworkFeatures = NetworkFeatures.Basic;

  /**
   * Network Sibling Set ID for the the group of volumes sharing networking resources.
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  networkSiblingSetId?: string;

  /**
   * Provides storage to network proximity information for the volume.
   */
  @visibility(Lifecycle.Read)
  storageToNetworkProximity?: VolumeStorageToNetworkProximity;

  /**
   * List of mount targets
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["fileSystemId"])
  mountTargets?: MountTargetProperties[];

  /**
   * What type of volume is this. For destination volumes in Cross Region Replication, set type to DataProtection. For creating clone volume, set type to ShortTermClone
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  volumeType?: string;

  /**
   * DataProtection type volumes include an object containing details of the replication
   */
  dataProtection?: VolumePropertiesDataProtection;

  /**
   * While auto splitting the short term clone volume, if the parent pool does not have enough space to accommodate the volume after split, it will be automatically resized, which will lead to increased billing. To accept capacity pool size auto grow and create a short term clone volume, set the property as accepted.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  acceptGrowCapacityPoolForShortTermCloneSplit?: AcceptGrowCapacityPoolForShortTermCloneSplit;

  /**
   * Restoring
   */
  @visibility(Lifecycle.Read)
  isRestoring?: boolean;

  /**
   * If enabled (true) the volume will contain a read-only snapshot directory which provides access to each of the volume's snapshots (defaults to true).
   */
  snapshotDirectoryVisible?: boolean = true;

  /**
   * Describe if a volume is KerberosEnabled. To be use with swagger version 2020-05-01 or later
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kerberosEnabled?: boolean;

  /**
   * The security style of volume, default unix, defaults to ntfs for dual protocol or CIFS protocol
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
  @visibility(Lifecycle.Read)
  actualThroughputMibps?: float32;

  /**
   * Source of key used to encrypt data in volume. Applicable if NetApp account has encryption.keySource = 'Microsoft.KeyVault'. Possible values (case-insensitive) are: 'Microsoft.NetApp, Microsoft.KeyVault'
   */
  encryptionKeySource?: EncryptionKeySource = EncryptionKeySource.`Microsoft.NetApp`;

  /**
   * The resource ID of private endpoint for KeyVault. It must reside in the same VNET as the volume. Only applicable if encryptionKeySource = 'Microsoft.KeyVault'.
   */
  keyVaultPrivateEndpointResourceId?: string;

  /**
   * Specifies whether LDAP is enabled or not for a given NFS volume.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ldapEnabled?: boolean;

  /**
   * Specifies whether Cool Access(tiering) is enabled for the volume.
   */
  coolAccess?: boolean;

  /**
   * Specifies the number of days after which data that is not accessed by clients will be tiered.
   */
  @maxValue(183)
  @minValue(2)
  coolnessPeriod?: int32;

  /**
   * coolAccessRetrievalPolicy determines the data retrieval behavior from the cool tier to standard storage based on the read pattern for cool access enabled volumes. The possible values for this field are:
   *  Default - Data will be pulled from cool tier to standard storage on random reads. This policy is the default.
   *  OnRead - All client-driven data read is pulled from cool tier to standard storage on both sequential and random reads.
   *  Never - No client-driven data is pulled from cool tier to standard storage.
   */
  coolAccessRetrievalPolicy?: CoolAccessRetrievalPolicy;

  /**
   * coolAccessTieringPolicy determines which cold data blocks are moved to cool tier. The possible values for this field are: Auto - Moves cold user data blocks in both the Snapshot copies and the active file system to the cool tier tier. This policy is the default. SnapshotOnly - Moves user data blocks of the Volume Snapshot copies that are not associated with the active file system to the cool tier.
   */
  coolAccessTieringPolicy?: CoolAccessTieringPolicy;

  /**
   * UNIX permissions for NFS volume accepted in octal 4 digit format. First digit selects the set user ID(4), set group ID (2) and sticky (1) attributes. Second digit selects permission for the owner of the file: read (4), write (2) and execute (1). Third selects permissions for other users in the same group. the fourth for other users not in the group. 0755 - gives read/write/execute permissions to owner and read/execute to group and other users.
   */
  @maxLength(4)
  @minLength(4)
  unixPermissions?: string;

  /**
   * When a volume is being restored from another volume's snapshot, will show the percentage completion of this cloning process. When this value is empty/null there is no cloning process currently happening on this volume. This value will update every 5 minutes during cloning.
   */
  @visibility(Lifecycle.Read)
  cloneProgress?: int32;

  /**
   * Flag indicating whether file access logs are enabled for the volume, based on active diagnostic settings present on the volume.
   */
  @visibility(Lifecycle.Read)
  fileAccessLogs?: FileAccessLogs = FileAccessLogs.Disabled;

  /**
   * Specifies whether the volume is enabled for Azure VMware Solution (AVS) datastore purpose
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  avsDataStore?: AvsDataStore = AvsDataStore.Disabled;

  /**
   * Data store resource unique identifier
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  maximumNumberOfFiles?: int64;

  /**
   * Volume Group Name
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  t2Network?: string;

  /**
   * Volume spec name is the application specific designation or identifier for the particular volume in a volume group for e.g. data, log
   */
  volumeSpecName?: string;

  /**
   * Specifies if the volume is encrypted or not. Only available on volumes created or updated after 2022-01-01.
   */
  @visibility(Lifecycle.Read)
  encrypted?: boolean;

  /**
   * Application specific placement rules for the particular volume
   */
  @OpenAPI.extension("x-ms-identifiers", #["key"])
  placementRules?: PlacementKeyValuePairs[];

  /**
   * Flag indicating whether subvolume operations are enabled on the volume
   */
  enableSubvolumes?: EnableSubvolumes = EnableSubvolumes.Disabled;

  /**
   * The availability zone where the volume is provisioned. This refers to the logical availability zone where the volume resides.
   */
  @visibility(Lifecycle.Read)
  provisionedAvailabilityZone?: string;

  /**
   * Specifies whether volume is a Large Volume or Regular Volume.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isLargeVolume?: boolean;

  /**
   * Id of the snapshot or backup that the volume is restored from.
   */
  @visibility(Lifecycle.Read)
  originatingResourceId?: string;

  /**
   * Space shared by short term clone volume with parent volume in bytes.
   */
  @visibility(Lifecycle.Read)
  inheritedSizeInBytes?: int64;
}

/**
 * Set of export policy rules
 */
model VolumePropertiesExportPolicy {
  /**
   * Export policy rule
   */
  @OpenAPI.extension("x-ms-identifiers", #["ruleIndex"])
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
  kerberos5iReadOnly?: boolean;

  /**
   * Kerberos5i Read and write access. To be use with swagger version 2020-05-01 or later
   */
  kerberos5iReadWrite?: boolean;

  /**
   * Kerberos5p Read only access. To be use with swagger version 2020-05-01 or later
   */
  kerberos5pReadOnly?: boolean;

  /**
   * Kerberos5p Read and write access. To be use with swagger version 2020-05-01 or later
   */
  kerberos5pReadWrite?: boolean;

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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
   * Backup Properties
   */
  backup?: VolumeBackupProperties;

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
 * Volume Backup Properties
 */
model VolumeBackupProperties {
  /**
   * Backup Policy Resource ID
   */
  backupPolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/backupPolicies";
    }
  ]>;

  /**
   * Policy Enforced
   */
  policyEnforced?: boolean;

  /**
   * Backup Vault Resource ID
   */
  backupVaultId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/backupVaults";
    }
  ]>;
}

/**
 * Replication properties
 */
model ReplicationObject {
  /**
   * Id
   */
  @visibility(Lifecycle.Read)
  replicationId?: string;

  /**
   * Indicates whether the local volume is the source or destination for the Volume Replication
   */
  @visibility(Lifecycle.Read)
  endpointType?: EndpointType;

  /**
   * Schedule
   */
  replicationSchedule?: ReplicationSchedule;

  /**
   * The resource ID of the remote volume. Required for cross region and cross zone replication
   */
  remoteVolumeResourceId?: string;

  /**
   * The full path to a volume that is to be migrated into ANF. Required for Migration volumes
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  remotePath?: RemotePath;

  /**
   * The remote region for the other end of the Volume Replication.
   */
  remoteVolumeRegion?: string;

  /**
   * A list of destination replications
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["resourceId"])
  destinationReplications?: DestinationReplication[];
}

/**
 * The full path to a volume that is to be migrated into ANF. Required for Migration volumes
 */
model RemotePath {
  /**
   * The Path to a ONTAP Host
   */
  externalHostName: string;

  /**
   * The name of a server on the ONTAP Host
   */
  serverName: string;

  /**
   * The name of a volume on the server
   */
  volumeName: string;
}

/**
 * Destination replication properties
 */
model DestinationReplication {
  /**
   * The resource ID of the remote volume
   */
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes";
    }
  ]>;

  /**
   * Indicates whether the replication is cross zone or cross region.
   */
  replicationType?: ReplicationType;

  /**
   * The remote region for the destination volume.
   */
  region?: string;

  /**
   * The remote zone for the destination volume.
   */
  zone?: string;
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Patchable volume properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
   * Maximum storage quota allowed for a file system in bytes. This is a soft quota used for alerting only. For regular volumes, valid values are in the range 50GiB to 100TiB. For large volumes, valid values are in the range 100TiB to 500TiB, and on an exceptional basis, from to 2400GiB to 2400TiB. Values expressed in bytes as multiples of 1 GiB.
   */
  @maxValue(2638827906662400)
  @minValue(53687091200)
  usageThreshold?: int64 = 107374182400;

  /**
   * Set of export policy rules
   */
  exportPolicy?: VolumePatchPropertiesExportPolicy;

  /**
   * Set of protocol types, default NFSv3, CIFS for SMB protocol
   */
  protocolTypes?: string[];

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
  @maxValue(183)
  @minValue(2)
  coolnessPeriod?: int32;

  /**
   * coolAccessRetrievalPolicy determines the data retrieval behavior from the cool tier to standard storage based on the read pattern for cool access enabled volumes. The possible values for this field are:
   *  Default - Data will be pulled from cool tier to standard storage on random reads. This policy is the default.
   *  OnRead - All client-driven data read is pulled from cool tier to standard storage on both sequential and random reads.
   *  Never - No client-driven data is pulled from cool tier to standard storage.
   */
  coolAccessRetrievalPolicy?: CoolAccessRetrievalPolicy;

  /**
   * coolAccessTieringPolicy determines which cold data blocks are moved to cool tier. The possible values for this field are: Auto - Moves cold user data blocks in both the Snapshot copies and the active file system to the cool tier tier. This policy is the default. SnapshotOnly - Moves user data blocks of the Volume Snapshot copies that are not associated with the active file system to the cool tier.
   */
  coolAccessTieringPolicy?: CoolAccessTieringPolicy;

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
  @OpenAPI.extension("x-ms-identifiers", #["ruleIndex"])
  rules?: ExportPolicyRule[];
}

/**
 * DataProtection type volumes include an object containing details of the replication
 */
model VolumePatchPropertiesDataProtection {
  /**
   * Backup Properties
   */
  backup?: VolumeBackupProperties;

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
  snapshotId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/snapshots";
    }
  ]>;
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
model ListReplications is Azure.Core.Page<Replication>;

/**
 * Replication properties
 */
model Replication {
  /**
   * UUID v4 used to identify the replication.
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
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
 * Authorize request
 */
model AuthorizeRequest {
  /**
   * Resource id of the remote volume
   */
  remoteVolumeResourceId?: string;
}

/**
 * Source Cluster properties for a cluster peer request
 */
model PeerClusterForVolumeMigrationRequest {
  /**
   * A list of IC-LIF IPs that can be used to connect to the On-prem cluster
   */
  peerIpAddresses: string[];
}

/**
 * Information about cluster peering process
 */
model ClusterPeerCommandResponse {
  /**
   * A command that needs to be run on the external ONTAP to accept cluster peering.  Will only be present if <code>clusterPeeringStatus</code> is <code>pending</code>
   */
  peerAcceptCommand?: string;
}

/**
 * Information about svm peering process
 */
model SvmPeerCommandResponse {
  /**
   * A command that needs to be run on the external ONTAP to accept svm peering.  Will only be present if <code>svmPeeringStatus</code> is <code>pending</code>
   */
  svmPeeringCommand?: string;
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
 * List of Snapshots
 */
model SnapshotsList is Azure.Core.Page<Snapshot>;

/**
 * Snapshot properties
 */
model SnapshotProperties {
  /**
   * UUID v4 used to identify the Snapshot
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  snapshotId?: string;

  /**
   * The creation date of the snapshot
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * Azure lifecycle management
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
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
 * List of Snapshot Policies
 */
model SnapshotPoliciesList is Azure.Core.Page<SnapshotPolicy>;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Snapshot Policy properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
 * List of Backup Policies
 */
model BackupPoliciesList is Azure.Core.Page<BackupPolicy>;

/**
 * Backup policy properties
 */
model BackupPolicyProperties {
  /**
   * Backup Policy GUID ID
   */
  @visibility(Lifecycle.Read)
  backupPolicyId?: string;

  /**
   * Azure lifecycle management
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  volumesAssigned?: int32;

  /**
   * The property to decide policy is enabled or not
   */
  enabled?: boolean;

  /**
   * A list of volumes assigned to this policy
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["volumeName"])
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
   * ResourceId used to identify the Volume
   */
  volumeResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes";
    }
  ]>;

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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Backup policy Properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: BackupPolicyProperties;
}

/**
 * List of Volume Quota Rules
 */
model VolumeQuotaRulesList is Azure.Core.Page<VolumeQuotaRule>;

/**
 * Volume Quota Rule properties
 */
model VolumeQuotaRulesProperties {
  /**
   * Gets the status of the VolumeQuotaRule at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Size of quota
   */
  quotaSizeInKiBs?: int64;

  /**
   * Type of quota
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  quotaType?: Type;

  /**
   * UserID/GroupID/SID based on the quota target type. UserID and groupID can be found by running ‘id’ or ‘getent’ command for the user or group and SID can be found by running <wmic useraccount where name='user-name' get sid>
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  quotaTarget?: string;
}

/**
 * Patchable Quota Rule of a Volume
 */
model VolumeQuotaRulePatch {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Volume Quota Rule Properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: VolumeQuotaRulesProperties;
}

/**
 * List of volume group resources
 */
model VolumeGroupList is Azure.Core.Page<VolumeGroup>;

/**
 * Volume group resource
 */
model VolumeGroup {
  /**
   * Resource location
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Volume group properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: VolumeGroupListProperties;
}

/**
 * Volume group properties
 */
model VolumeGroupListProperties {
  /**
   * Azure lifecycle management
   */
  @visibility(Lifecycle.Read)
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
  @OpenAPI.extension("x-ms-identifiers", #["key"])
  globalPlacementRules?: PlacementKeyValuePairs[];

  /**
   * Number of volumes in volume group
   */
  @visibility(Lifecycle.Read)
  volumesCount?: int64;
}

/**
 * Volume group properties
 */
model VolumeGroupProperties {
  /**
   * Azure lifecycle management
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Availability Zone
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  zones?: string[];

  /**
   * Volume properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: VolumeProperties;
}

/**
 * List of Subvolumes
 */
model SubvolumesList is Azure.Core.Page<SubvolumeInfo>;

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
  size?: int64;

  /**
   * parent path to the subvolume
   */
  parentPath?: string;

  /**
   * Azure lifecycle management
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Subvolume Patch Request properties
 */
model SubvolumePatchRequest {
  /**
   * Subvolume Properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * It represents the minimal properties of the subvolume.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
 * Backup status
 */
model BackupStatus {
  /**
   * Backup health status
   */
  @visibility(Lifecycle.Read)
  healthy?: boolean;

  /**
   * Status of the backup mirror relationship
   */
  @visibility(Lifecycle.Read)
  relationshipStatus?: RelationshipStatus;

  /**
   * The status of the backup
   */
  @visibility(Lifecycle.Read)
  mirrorState?: MirrorState;

  /**
   * Reason for the unhealthy backup relationship
   */
  @visibility(Lifecycle.Read)
  unhealthyReason?: string;

  /**
   * Displays error message if the backup is in an error state
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * Displays the last transfer size
   */
  @visibility(Lifecycle.Read)
  lastTransferSize?: int64;

  /**
   * Displays the last transfer type
   */
  @visibility(Lifecycle.Read)
  lastTransferType?: string;

  /**
   * Displays the total bytes transferred
   */
  @visibility(Lifecycle.Read)
  totalTransferBytes?: int64;

  /**
   * Displays the total number of bytes transferred for the ongoing operation
   */
  @visibility(Lifecycle.Read)
  transferProgressBytes?: int64;
}

/**
 * Restore status
 */
model RestoreStatus {
  /**
   * Restore health status
   */
  @visibility(Lifecycle.Read)
  healthy?: boolean;

  /**
   * Status of the restore SnapMirror relationship
   */
  @visibility(Lifecycle.Read)
  relationshipStatus?: RelationshipStatus;

  /**
   * The status of the restore
   */
  @visibility(Lifecycle.Read)
  mirrorState?: MirrorState;

  /**
   * Reason for the unhealthy restore relationship
   */
  @visibility(Lifecycle.Read)
  unhealthyReason?: string;

  /**
   * Displays error message if the restore is in an error state
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * Displays the total bytes transferred
   */
  @visibility(Lifecycle.Read)
  totalTransferBytes?: int64;
}

/**
 * List of Backups
 */
model BackupsList is Azure.Core.Page<Backup>;

/**
 * Backup properties
 */
model BackupProperties {
  /**
   * UUID v4 used to identify the Backup
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  backupId?: string;

  /**
   * The creation date of the backup
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * The snapshot creation date of the backup
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  snapshotCreationDate?: utcDateTime;

  /**
   * The completion date of the backup
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  completionDate?: utcDateTime;

  /**
   * Azure lifecycle management
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Size of backup in bytes
   */
  @visibility(Lifecycle.Read)
  size?: int64;

  /**
   * Label for backup
   */
  label?: string;

  /**
   * Type of backup Manual or Scheduled
   */
  @visibility(Lifecycle.Read)
  backupType?: BackupType;

  /**
   * Failure reason
   */
  @visibility(Lifecycle.Read)
  failureReason?: string;

  /**
   * ResourceId used to identify the Volume
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  volumeResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes";
    }
  ]>;

  /**
   * Manual backup an already existing snapshot. This will always be false for scheduled backups and true/false for manual backups
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  useExistingSnapshot?: boolean;

  /**
   * The name of the snapshot
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  snapshotName?: string;

  /**
   * ResourceId used to identify the backup policy
   */
  @visibility(Lifecycle.Read)
  backupPolicyResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/backupPolicies";
    }
  ]>;

  /**
   * Specifies if the backup is for a large volume.
   */
  @visibility(Lifecycle.Read)
  isLargeVolume?: boolean;
}

/**
 * Backup patch
 */
model BackupPatch {
  /**
   * Backup Patch Properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: BackupPatchProperties;
}

/**
 * Backup patch properties
 */
model BackupPatchProperties {
  /**
   * Label for backup
   */
  label?: string;
}

/**
 * List of Backup Vaults
 */
model BackupVaultsList is Azure.Core.Page<BackupVault>;

/**
 * Backup Vault properties
 */
model BackupVaultProperties {
  /**
   * Azure lifecycle management
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Backup Vault information
 */
model BackupVaultPatch {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Restore payload for Single File Backup Restore
 */
model BackupRestoreFiles {
  /**
   * List of files to be restored
   */
  fileList: string[];

  /**
   * Destination folder where the files will be restored. The path name should start with a forward slash. If it is omitted from request then restore is done at the root folder of the destination volume by default
   */
  @pattern("^\\/.*$")
  restoreFilePath?: string;

  /**
   * Resource Id of the destination volume on which the files need to be restored
   */
  destinationVolumeId: string;
}

/**
 * Migrate Backups Request
 */
model BackupsMigrationRequest {
  /**
   * The ResourceId of the Backup Vault
   */
  backupVaultId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/backupVaults";
    }
  ]>;
}

/**
 * Identity for the resource.
 */
model ResourceIdentity {
  /**
   * Object id of the identity resource
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant id of the resource
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  tags?: Record<string>;

  /**
   * Mount Target Properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: MountTargetProperties;
}

/**
 * Snapshot policy properties
 */
model SnapshotPolicyDetails {
  /**
   * Resource location
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Snapshot policy Properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: SnapshotPolicyProperties;
}

/**
 * An error response from the service.
 */
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
 * A list of REST API operations supported by an Azure Resource Provider. It contains an URL link to get the next set of results.
 */
model OperationListResult is Azure.Core.Page<Operation>;
