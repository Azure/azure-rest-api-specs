import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DataBoxEdge;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Metric units.
 */
enum MetricUnit {
  NotSpecified,
  Percent,
  Count,
  Seconds,
  Milliseconds,
  Bytes,
  BytesPerSecond,
  CountPerSecond,
}

/**
 * Metric aggregation type.
 */
enum MetricAggregationType {
  NotSpecified,
  None,
  Average,
  Minimum,
  Maximum,
  Total,
  Count,
}

/**
 * Metric category.
 */
enum MetricCategory {
  Capacity,
  Transaction,
}

enum TimeGrain {
  PT1M,
  PT5M,
  PT15M,
  PT30M,
  PT1H,
  PT6H,
  PT12H,
  PT1D,
}

/**
 * The Sku name.
 */
enum SkuName {
  Gateway,
  Edge,
  TEA_1Node,
  TEA_1Node_UPS,
  TEA_1Node_Heater,
  TEA_1Node_UPS_Heater,
  TEA_4Node_Heater,
  TEA_4Node_UPS_Heater,
  TMA,
  TDC,
  TCA_Small,
  GPU,
  TCA_Large,
  EdgeP_Base,
  EdgeP_High,
  EdgePR_Base,
  EdgePR_Base_UPS,
  EP2_64_1VPU_W,
  EP2_128_1T4_Mx1_W,
  EP2_256_2T4_W,
  EdgeMR_Mini,
  RCA_Small,
  RCA_Large,
  RDC,
  Management,
  EP2_64_Mx1_W,
  EP2_128_GPU1_Mx1_W,
  EP2_256_GPU2_Mx1,
  EdgeMR_TCP,
}

/**
 * Sku can be signed up by customer or not.
 */
enum SkuSignupOption {
  None,
  Available,
}

/**
 * Availability of the Sku as preview/stable.
 */
enum SkuVersion {
  Stable,
  Preview,
}

/**
 * Links to the next set of results
 */
enum SkuAvailability {
  Available,
  Unavailable,
}

enum ShipmentType {
  NotApplicable,
  ShippedToCustomer,
  SelfPickup,
}

/**
 * Identity type
 */
enum MsiIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
}

/**
 * The kind of the device.
 */
enum DataBoxEdgeDeviceKind {
  AzureDataBoxGateway,
  AzureStackEdge,
  AzureStackHub,
  AzureModularDataCentre,
}

/**
 * The status of the Data Box Edge/Gateway device.
 */
enum DataBoxEdgeDeviceStatus {
  ReadyToSetup,
  Online,
  Offline,
  NeedsAttention,
  Disconnected,
  PartiallyDisconnected,
  Maintenance,
}

/**
 * The type of the Data Box Edge/Gateway device.
 */
enum DeviceType {
  DataBoxEdgeDevice,
}

enum RoleTypes {
  IOT,
  ASA,
  Functions,
  Cognitive,
  MEC,
  CloudEdgeManagement,
  Kubernetes,
}

/**
 * Denotes whether move operation is in progress
 */
enum ResourceMoveStatus {
  None,
  ResourceMoveInProgress,
  ResourceMoveFailed,
}

enum SubscriptionState {
  Registered,
  Warned,
  Suspended,
  Deleted,
  Unregistered,
}

/**
 * DataResidencyType enum
 */
enum DataResidencyType {
  GeoZoneReplication,
  ZoneReplication,
}

/**
 * Severity of the alert.
 */
enum AlertSeverity {
  Informational,
  Warning,
  Critical,
}

enum DayOfWeek {
  Sunday,
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
}

/**
 * Proactive diagnostic collection consent flag
 */
enum ProactiveDiagnosticsConsent {
  Enabled,
  Disabled,
}

/**
 * Remote application type
 */
enum RemoteApplicationType {
  Powershell,
  WAC,
  LocalUI,
  AllApplications,
}

/**
 * Access level allowed for this remote application type
 */
enum AccessLevel {
  None,
  ReadOnly,
  ReadWrite,
  FullAccess,
}

/**
 * For changing or to initiate the resync to key-vault set the status to KeyVaultSyncPending, rest of the status will not be applicable.
 */
enum KeyVaultSyncStatus {
  KeyVaultSynced,
  KeyVaultSyncFailed,
  KeyVaultNotConfigured,
  KeyVaultSyncPending,
  KeyVaultSyncing,
  KeyVaultNotSynced,
}

/**
 * The algorithm used to encrypt "Value".
 */
enum EncryptionAlgorithm {
  None,
  AES256,
  RSAES_PKCS1_v_1_5,
}

/**
 * Cluster Witness Type
 */
enum ClusterWitnessType {
  None,
  Cloud,
  FileShare,
}

/**
 * The current status of the job.
 */
enum JobStatus {
  Invalid,
  Running,
  Succeeded,
  Failed,
  Canceled,
  Paused,
  Scheduled,
}

/**
 * The type of the job.
 */
enum JobType {
  Invalid,
  ScanForUpdates,
  DownloadUpdates,
  InstallUpdates,
  RefreshShare,
  RefreshContainer,
  Backup,
  Restore,
  TriggerSupportPackage,
}

/**
 * Current stage of the update operation.
 */
enum UpdateOperationStage {
  Unknown,
  Initial,
  ScanStarted,
  ScanComplete,
  ScanFailed,
  DownloadStarted,
  DownloadComplete,
  DownloadFailed,
  InstallStarted,
  InstallComplete,
  InstallFailed,
  RebootInitiated,
  Success,
  Failure,
  RescanStarted,
  RescanComplete,
  RescanFailed,
}

/**
 * The download phase.
 */
enum DownloadPhase {
  Unknown,
  Initializing,
  Downloading,
  Verifying,
}

/**
 * The network group.
 */
enum NetworkGroup {
  None,
  NonRDMA,
  RDMA,
}

/**
 * Value indicating whether this adapter is valid.
 */
enum NetworkAdapterStatus {
  Inactive,
  Active,
}

/**
 * Value indicating whether this adapter is RDMA capable.
 */
enum NetworkAdapterRdmaStatus {
  Incapable,
  Capable,
}

/**
 * Value indicating whether this adapter has DHCP enabled.
 */
enum NetworkAdapterDhcpStatus {
  Disabled,
  Enabled,
}

/**
 * The current status of the individual node
 */
enum NodeStatus {
  Unknown,
  Up,
  Down,
  Rebooting,
  ShuttingDown,
}

/**
 * Status of the order as per the allowed status types.
 */
enum OrderState {
  Untracked,
  AwaitingFulfillment,
  AwaitingPreparation,
  AwaitingShipment,
  Shipped,
  Arriving,
  Delivered,
  ReplacementRequested,
  LostDevice,
  Declined,
  ReturnInitiated,
  AwaitingReturnShipment,
  ShippedBack,
  CollectedAtMicrosoft,
  AwaitingPickup,
  PickupCompleted,
  AwaitingDrop,
}

/**
 * Addon type.
 */
enum AddonType {
  IotEdge,
  ArcForKubernetes,
}

/**
 * Current status of the share.
 */
enum ShareStatus {
  Offline,
  Unknown,
  OK,
  Updating,
  NeedsAttention,
}

/**
 * Current monitoring status of the share.
 */
enum MonitoringStatus {
  Enabled,
  Disabled,
}

/**
 * Storage format used for the file represented by the share.
 */
enum AzureContainerDataFormat {
  BlockBlob,
  PageBlob,
  AzureFile,
}

/**
 * Access protocol to be used by the share.
 */
enum ShareAccessProtocol {
  SMB,
  NFS,
}

/**
 * Type of access to be allowed on the share for this user.
 */
enum ShareAccessType {
  Change,
  Read,
  Custom,
}

/**
 * Type of access to be allowed for the client.
 */
enum ClientPermissionType {
  NoAccess,
  ReadOnly,
  ReadWrite,
}

/**
 * Mounting type.
 */
enum MountType {
  Volume,
  HostPath,
}

/**
 * Data policy of the share.
 */
enum DataPolicy {
  Cloud,
  Local,
}

/**
 * Signifies whether SSL needs to be enabled or not.
 */
enum SSLStatus {
  Enabled,
  Disabled,
}

/**
 * Type of storage accessed on the storage account.
 */
enum AccountType {
  GeneralPurposeStorage,
  BlobStorage,
}

/**
 * Current status of the storage account
 */
enum StorageAccountStatus {
  OK,
  Offline,
  Unknown,
  Updating,
  NeedsAttention,
}

/**
 * Current status of the container.
 */
enum ContainerStatus {
  OK,
  Offline,
  Unknown,
  Updating,
  NeedsAttention,
}

/**
 * Trigger Kind.
 */
enum TriggerEventType {
  FileEvent,
  PeriodicTimerEvent,
}

/**
 * Indicates if updates are available and at least one of the updates needs a reboot.
 */
enum InstallRebootBehavior {
  NeverReboots,
  RequiresReboot,
  RequestReboot,
}

/**
 * The current update operation.
 */
enum UpdateOperation {
  None,
  Scan,
  Download,
  Install,
}

/**
 * Type of the Update
 */
enum UpdateType {
  Software,
  Kubernetes,
  Firmware,
}

/**
 * Impact of Installing an updateType
 */
enum InstallationImpact {
  None,
  DeviceRebooted,
  KubernetesWorkloadsDown,
}

/**
 * Status of the update.
 */
enum UpdateStatus {
  DownloadPending,
  DownloadStarted,
  DownloadCompleted,
  InstallStarted,
  InstallCompleted,
}

/**
 * The authentication type.
 */
enum AuthenticationType {
  Invalid,
  AzureActiveDirectory,
}

/**
 * Type of the user.
 */
enum UserType {
  Share,
  LocalManagement,
  ARM,
}

/**
 * Host OS supported by the Arc addon.
 */
enum PlatformType {
  Windows,
  Linux,
}

/**
 * Platform where the runtime is hosted.
 */
enum HostPlatformType {
  KubernetesCluster,
  LinuxVM,
}

/**
 * Addon Provisioning State
 */
enum AddonState {
  Invalid,
  Creating,
  Created,
  Updating,
  Reconfiguring,
  Failed,
  Deleting,
}

/**
 * Local Edge Management Status
 */
enum RoleStatus {
  Enabled,
  Disabled,
}

/**
 * Node type - Master/Worker
 */
enum KubernetesNodeType {
  Invalid,
  Master,
  Worker,
}

/**
 * State of Kubernetes deployment
 */
enum KubernetesState {
  Invalid,
  Creating,
  Created,
  Updating,
  Reconfiguring,
  Failed,
  Deleting,
}

/**
 * If provisioned storage is posix compliant.
 */
enum PosixComplianceStatus {
  Invalid,
  Enabled,
  Disabled,
}

/**
 * Operation properties.
 */
model OperationProperties {
  /**
   * Service specification.
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * Service specification.
 */
model ServiceSpecification {
  /**
   * Metric specification as defined by shoebox.
   */
  metricSpecifications?: MetricSpecificationV1[];
}

/**
 * Metric specification version 1.
 */
model MetricSpecificationV1 {
  /**
   * Name of the metric.
   */
  name?: string;

  /**
   * Display name of the metric.
   */
  displayName?: string;

  /**
   * Description of the metric to be displayed.
   */
  displayDescription?: string;

  /**
   * Metric units.
   */
  unit?: MetricUnit;

  /**
   * Metric aggregation type.
   */
  aggregationType?: MetricAggregationType;

  /**
   * Metric dimensions, other than default dimension which is resource.
   */
  dimensions?: MetricDimensionV1[];

  /**
   * Set true to fill the gaps with zero.
   */
  fillGapWithZero?: boolean;

  /**
   * Metric category.
   */
  category?: MetricCategory;

  /**
   * Resource name override.
   */
  resourceIdDimensionNameOverride?: string;

  /**
   * Support granularity of metrics.
   */
  supportedTimeGrainTypes?: TimeGrain[];

  /**
   * Support metric aggregation type.
   */
  supportedAggregationTypes?: MetricAggregationType[];
}

/**
 * Metric Dimension v1.
 */
model MetricDimensionV1 {
  /**
   * Name of the metrics dimension.
   */
  name?: string;

  /**
   * Display name of the metrics dimension.
   */
  displayName?: string;

  /**
   * To be exported to shoe box.
   */
  toBeExportedForShoebox?: boolean;
}

/**
 * An error response from the service.
 */
@error
model CloudError {
  /**
   * The error details.
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

  /**
   * A list of additional details about the error.
   */
  details?: CloudErrorBody[];
}

/**
 * List of SKU Information objects.
 */
model DataBoxEdgeSkuList is Azure.Core.Page<DataBoxEdgeSku>;

/**
 * The Sku information.
 */
model DataBoxEdgeSku {
  /**
   * The type of the resource.
   */
  @visibility("read")
  resourceType?: string;

  /**
   * The Sku name.
   */
  @visibility("read")
  name?: SkuName;

  /**
   * The Sku kind.
   */
  @visibility("read")
  kind?: string;

  /**
   * The Sku tier.
   */
  @visibility("read")
  tier?: SkuTier;

  /**
   * The Sku kind.
   */
  @visibility("read")
  size?: string;

  /**
   * The Sku family.
   */
  @visibility("read")
  family?: string;

  /**
   * Availability of the Sku for the region.
   */
  @visibility("read")
  locations?: string[];

  /**
   * The API versions in which Sku is available.
   */
  @visibility("read")
  apiVersions?: string[];

  /**
   * Availability of the Sku for the location/zone/site.
   */
  @visibility("read")
  locationInfo?: SkuLocationInfo[];

  /**
   * The pricing info of the Sku.
   */
  @visibility("read")
  costs?: SkuCost[];

  /**
   * Sku can be signed up by customer or not.
   */
  @visibility("read")
  signupOption?: SkuSignupOption;

  /**
   * Availability of the Sku as preview/stable.
   */
  @visibility("read")
  version?: SkuVersion;

  /**
   * Links to the next set of results
   */
  @visibility("read")
  availability?: SkuAvailability;

  /**
   * List of Shipment Types supported by this SKU
   */
  @visibility("read")
  shipmentTypes?: ShipmentType[];

  /**
   * The capability info of the SKU.
   */
  @visibility("read")
  capabilities?: SkuCapability[];
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

  /**
   * The sites.
   */
  @visibility("read")
  sites?: string[];
}

/**
 * The metadata for retrieving price info.
 */
model SkuCost {
  /**
   * Used for querying price from commerce.
   */
  @visibility("read")
  meterId?: string;

  /**
   * The cost quantity.
   */
  @visibility("read")
  quantity?: int64;

  /**
   * The extended unit.
   */
  @visibility("read")
  extendedUnit?: string;
}

/**
 * The metadata to describe the capability.
 */
model SkuCapability {
  /**
   * An invariant to describe the feature.
   */
  @visibility("read")
  name?: string;

  /**
   * An invariant if the feature is measured by quantity.
   */
  @visibility("read")
  value?: string;
}

/**
 * The SKU type.
 */
model Sku {
  /**
   * SKU name.
   */
  name?: SkuName;

  /**
   * The SKU tier. This is based on the SKU name.
   */
  tier?: SkuTier;
}

/**
 * Msi identity details of the resource
 */
model ResourceIdentity {
  /**
   * Identity type
   */
  type?: MsiIdentityType;

  /**
   * Service Principal Id backing the Msi
   */
  @visibility("read")
  principalId?: string;

  /**
   * Home Tenant Id
   */
  @visibility("read")
  tenantId?: string;
}

/**
 * The properties of the Data Box Edge/Gateway device.
 */
model DataBoxEdgeDeviceProperties {
  /**
   * DataBoxEdge Device Properties
   */
  @visibility("read")
  systemData?: SystemData;

  /**
   * The status of the Data Box Edge/Gateway device.
   */
  @visibility("read")
  dataBoxEdgeDeviceStatus?: DataBoxEdgeDeviceStatus;

  /**
   * The Serial Number of Data Box Edge/Gateway device.
   */
  @visibility("read")
  serialNumber?: string;

  /**
   * The Description of the Data Box Edge/Gateway device.
   */
  @visibility("read")
  description?: string;

  /**
   * The description of the Data Box Edge/Gateway device model.
   */
  @visibility("read")
  modelDescription?: string;

  /**
   * The type of the Data Box Edge/Gateway device.
   */
  @visibility("read")
  deviceType?: DeviceType;

  /**
   * The Data Box Edge/Gateway device name.
   */
  @visibility("read")
  friendlyName?: string;

  /**
   * The Data Box Edge/Gateway device culture.
   */
  @visibility("read")
  culture?: string;

  /**
   * The Data Box Edge/Gateway device model.
   */
  @visibility("read")
  deviceModel?: string;

  /**
   * The Data Box Edge/Gateway device software version.
   */
  @visibility("read")
  deviceSoftwareVersion?: string;

  /**
   * The Data Box Edge/Gateway device local capacity in MB.
   */
  @visibility("read")
  deviceLocalCapacity?: int64;

  /**
   * The Data Box Edge/Gateway device timezone.
   */
  @visibility("read")
  timeZone?: string;

  /**
   * The device software version number of the device (eg: 1.2.18105.6).
   */
  @visibility("read")
  deviceHcsVersion?: string;

  /**
   * Type of compute roles configured.
   */
  @visibility("read")
  configuredRoleTypes?: RoleTypes[];

  /**
   * The number of nodes in the cluster.
   */
  @visibility("read")
  nodeCount?: int32;

  /**
   * The details of the move operation on this resource.
   */
  @visibility("read")
  resourceMoveDetails?: ResourceMoveDetails;

  /**
   * The details of Edge Profile for this resource
   */
  @visibility("read")
  edgeProfile?: EdgeProfile;

  /**
   * The details of data-residency related properties for this resource
   */
  dataResidency?: DataResidency;
}

/**
 * Fields for tracking resource move
 */
model ResourceMoveDetails {
  /**
   * Denotes whether move operation is in progress
   */
  operationInProgress?: ResourceMoveStatus;

  /**
   * Denotes the timeout of the operation to finish
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  operationInProgressLockTimeoutInUTC?: utcDateTime;
}

/**
 * Details about Edge Profile for the resource
 */
model EdgeProfile {
  /**
   * Edge Profile Subscription
   */
  subscription?: EdgeProfileSubscription;
}

/**
 * Subscription details for the Edge Profile
 */
model EdgeProfileSubscription {
  /**
   * Edge Subscription Registration ID
   */
  registrationId?: string;

  /**
   * ARM ID of the subscription
   */
  id?: string;

  state?: SubscriptionState;
  registrationDate?: string;
  subscriptionId?: string;

  @extension("x-ms-client-flatten", true)
  properties?: SubscriptionProperties;
}

model SubscriptionProperties {
  tenantId?: string;
  locationPlacementId?: string;
  quotaId?: string;
  serializedDetails?: string;
  registeredFeatures?: SubscriptionRegisteredFeatures[];
}

model SubscriptionRegisteredFeatures {
  name?: string;
  state?: string;
}

/**
 * Wraps data-residency related information for edge-resource and this should be used with ARM layer.
 */
model DataResidency {
  /**
   * DataResidencyType enum
   */
  type?: DataResidencyType;
}

/**
 * Represents the base class for all object models.
 */
model ARMBaseModel {
  /**
   * The path ID that uniquely identifies the object.
   */
  @visibility("read")
  id?: string;

  /**
   * The object name.
   */
  @visibility("read")
  name?: string;

  /**
   * The hierarchical type of the object.
   */
  @visibility("read")
  type?: string;
}

/**
 * The Data Box Edge/Gateway device patch.
 */
model DataBoxEdgeDevicePatch {
  /**
   * The tags attached to the Data Box Edge/Gateway resource.
   */
  tags?: Record<string>;

  /**
   * Msi identity of the resource
   */
  identity?: ResourceIdentity;

  /**
   * The properties associated with the Data Box Edge/Gateway resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: DataBoxEdgeDevicePropertiesPatch;
}

/**
 * The Data Box Edge/Gateway device properties patch.
 */
model DataBoxEdgeDevicePropertiesPatch {
  /**
   * Edge Profile property of the Data Box Edge/Gateway device
   */
  edgeProfile?: EdgeProfilePatch;
}

/**
 * The Data Box Edge/Gateway Edge Profile patch.
 */
model EdgeProfilePatch {
  /**
   * The Data Box Edge/Gateway Edge Profile Subscription patch
   */
  subscription?: EdgeProfileSubscriptionPatch;
}

/**
 * The Data Box Edge/Gateway Edge Profile Subscription patch.
 */
model EdgeProfileSubscriptionPatch {
  /**
   * The path ID that uniquely identifies the subscription of the edge profile.
   */
  id?: string;
}

/**
 * Properties of alert.
 */
model AlertProperties {
  /**
   * Alert title.
   */
  @visibility("read")
  title?: string;

  /**
   * Alert type.
   */
  @visibility("read")
  alertType?: string;

  /**
   * UTC time when the alert appeared.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  appearedAtDateTime?: utcDateTime;

  /**
   * Alert recommendation.
   */
  @visibility("read")
  recommendation?: string;

  /**
   * Severity of the alert.
   */
  @visibility("read")
  severity?: AlertSeverity;

  /**
   * Error details of the alert.
   */
  @visibility("read")
  errorDetails?: AlertErrorDetails;

  /**
   * Alert details.
   */
  @visibility("read")
  detailedInformation?: Record<string>;
}

/**
 * Error details for the alert.
 */
model AlertErrorDetails {
  /**
   * Error code.
   */
  @visibility("read")
  errorCode?: string;

  /**
   * Error Message.
   */
  @visibility("read")
  errorMessage?: string;

  /**
   * Number of occurrences.
   */
  @visibility("read")
  occurrences?: int32;
}

/**
 * The properties of the bandwidth schedule.
 */
model BandwidthScheduleProperties {
  /**
   * The start time of the schedule in UTC.
   */
  start: plainTime;

  /**
   * The stop time of the schedule in UTC.
   */
  stop: plainTime;

  /**
   * The bandwidth rate in Mbps.
   */
  rateInMbps: int32;

  /**
   * The days of the week when this schedule is applicable.
   */
  days: DayOfWeek[];
}

/**
 * Object for Capturing DeviceCapacityRequestInfo
 */
model DeviceCapacityRequestInfo {
  /**
   * The properties of the Device Capacity Request.
   */
  @extension("x-ms-client-flatten", true)
  properties: DeviceCapacityRequestInfoProperties;
}

/**
 * Properties of Device Capacity Request Info containing VM's to be checked and their corresponding results.
 */
model DeviceCapacityRequestInfoProperties {
  /**
   * Array containing the sizes of the VMs for checking if its feasible to create them on the appliance.
   */
  vmPlacementQuery: string[][];

  /**
   * Array of the VMs of the sizes in VmSizes can be provisioned on the appliance.
   */
  vmPlacementResults?: VmPlacementRequestResult[];
}

/**
 * List of VM sizes being checked for creation on appliance along with corresponding result.
 */
model VmPlacementRequestResult {
  /**
   * List of VM sizes being checked.
   */
  vmSize?: string[];

  /**
   * Boolean value indicating if the VM(s) in VmSize can be created.
   */
  isFeasible?: boolean;

  /**
   * MessageCode indicating reason for success or failure.
   */
  messageCode?: string;

  /**
   * Localized message to be displayed to the user to explain the check result.
   */
  message?: string;
}

/**
 * Object for Capturing DeviceCapacityInfo
 */
model DeviceCapacityInfo extends ARMBaseModel {
  /**
   * The device capacity properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DeviceCapacityInfoProperties;

  /**
   * Metadata pertaining to device capacity info.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The properties of Device Capacity Info
 */
model DeviceCapacityInfoProperties {
  /**
   * Timestamp of request in UTC
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStamp?: utcDateTime;

  /**
   * Cluster capacity data for storage resources (CSV).
   */
  clusterStorageCapacityInfo?: ClusterStorageViewData;

  /**
   * Cluster capacity data for compute resources (Memory and GPU).
   */
  clusterComputeCapacityInfo?: ClusterCapacityViewData;

  /**
   * The dictionary of individual node names and node capacities in the cluster.
   */
  nodeCapacityInfos?: Record<HostCapacity>;
}

/**
 * Cluster Storage Data.
 */
model ClusterStorageViewData {
  /**
   * Total storage on the cluster in MB.
   */
  clusterTotalStorageMb?: float64;

  /**
   * The available or free storage on the cluster in MB.
   */
  clusterFreeStorageMb?: float64;
}

/**
 * Cluster Compute Data.
 */
model ClusterCapacityViewData {
  /**
   * The FQDN of the cluster.
   */
  fqdn?: string;

  /**
   * The cluster's GPU capacity.
   */
  gpuCapacity?: ClusterGpuCapacity;

  /**
   * The cluster's memory capacity.
   */
  memoryCapacity?: ClusterMemoryCapacity;

  /**
   * The last time at which the ClusterCapacityViewData was set.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRefreshedTime?: utcDateTime;

  /**
   * The total # of vCPUs provisioned by non-HPN VM per appliance.
   */
  totalProvisionedNonHpnCores?: int64;
}

/**
 * Cluster GPU Data.
 */
model ClusterGpuCapacity {
  /**
   * The cluster GPU Type.
   */
  gpuType?: string;

  /**
   * The used GPU units count in the cluster.
   */
  gpuUsedUnitsCount?: int32;

  /**
   * The free GPU units count in the cluster.
   */
  gpuFreeUnitsCount?: int32;

  /**
   * The GPU units count reserved for failover in the cluster.
   */
  gpuReservedForFailoverUnitsCount?: int32;

  /**
   * The total GPU units count in the cluster.
   */
  gpuTotalUnitsCount?: int32;
}

/**
 * NodeCapacityInfo defines the required information to determine the placement of a VM.
 */
model ClusterMemoryCapacity {
  /**
   * The free memory in the cluster in MB.
   */
  clusterFreeMemoryMb?: float64;

  /**
   * The used memory in the cluster in MB.
   */
  clusterUsedMemoryMb?: float64;

  /**
   * The failover memory in the cluster in MB.
   */
  clusterFailoverMemoryMb?: float64;

  /**
   * The fragmentation memory in the cluster in MB.
   */
  clusterFragmentationMemoryMb?: float64;

  /**
   * The memory reserved for Hyper-V in the cluster in MB.
   */
  clusterHypervReserveMemoryMb?: float64;

  /**
   * The memory of the Infra VM in the cluster in MB.
   */
  clusterInfraVmMemoryMb?: float64;

  /**
   * The total memory in the cluster in MB.
   */
  clusterTotalMemoryMb?: float64;

  /**
   * The non-failover memory in the cluster in MB.
   */
  clusterNonFailoverVmMb?: float64;

  /**
   * The memory used by VMs in the cluster in MB.
   */
  clusterMemoryUsedByVmsMb?: float64;
}

/**
 * Host Capacity Data.
 */
model HostCapacity {
  /**
   * The name of the host.
   */
  hostName?: string;

  /**
   * The available memory on the host accounting for VM placement size and any host VM reservations.
   */
  effectiveAvailableMemoryMbOnHost?: int64;

  /**
   * The available amount of GPUs on the host to use after accounting for GPUS used by reservations on the host.
   */
  availableGpuCount?: int32;

  /**
   * The VM used memory per VmId.
   */
  vmUsedMemory?: Record<VmMemory>;

  /**
   * The GPU type of the VM.
   */
  gpuType?: string;

  /**
   * The numa nodes information for Hpn VMs.
   */
  numaNodesData?: NumaNodeData[];
}

/**
 * VmMemory Data.
 */
model VmMemory {
  /**
   * The total amount of RAM in the virtual machine, as seen by the guest  operating system. For a virtual machine with dynamic memory enabled, this represents the initial memory available at startup.
   */
  startupMemoryMB?: int64;

  /**
   * The current memory used by the virtual machine.
   */
  currentMemoryUsageMB?: int64;
}

/**
 * NUMA node data.
 */
model NumaNodeData {
  /**
   * The NUMA node index.
   */
  numaNodeIndex?: int32;

  /**
   * The total memory on the NUMA node.
   */
  totalMemoryInMb?: int64;

  /**
   * The logical cores per core count.
   */
  logicalCoreCountPerCore?: int32;

  /**
   * The effective available memory on the NUMA node in MB.
   */
  effectiveAvailableMemoryInMb?: int64;

  /**
   * The free VCPU indices for the Hpn VMs.
   */
  freeVCpuIndexesForHpn?: int32[];

  /**
   * The VCPU indices for Hpn VMs
   */
  vCpuIndexesForHpn?: int32[];

  /**
   * The VCPU indices for the root.
   */
  vCpuIndexesForRoot?: int32[];
}

/**
 * The properties of proactive log collection settings.
 */
model ProactiveLogCollectionSettingsProperties {
  /**
   * Proactive diagnostic collection consent flag
   */
  userConsent: ProactiveDiagnosticsConsent;
}

/**
 * The properties of remote support settings.
 */
model DiagnosticRemoteSupportSettingsProperties {
  /**
   * Remote support settings list according to the RemoteApplicationType
   */
  remoteSupportSettingsList?: RemoteSupportSettings[];
}

/**
 * RemoteApplicationType for which remote support settings is being modified
 */
model RemoteSupportSettings {
  /**
   * Remote application type
   */
  remoteApplicationType?: RemoteApplicationType;

  /**
   * Access level allowed for this remote application type
   */
  accessLevel?: AccessLevel;

  /**
   * Expiration time stamp
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeStampInUTC?: utcDateTime;
}

/**
 * Used in activation key generation flow.
 */
model GenerateCertResponse {
  /**
   * Gets or sets base64 encoded certificate raw data,
   * this is the public part needed to be uploaded to cert vault
   */
  publicKey?: string;

  /**
   * Gets or sets base64 encoded private part of the certificate,
   * needed to form the activation key
   */
  privateKey?: string;

  /**
   * Gets or sets expiry time in UTC
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTimeInUTC?: utcDateTime;
}

/**
 * The extended Info of the Data Box Edge/Gateway device.
 */
model DataBoxEdgeDeviceExtendedInfo extends ARMBaseModel {
  /**
   * The extended info properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DataBoxEdgeDeviceExtendedInfoProperties;

  /**
   * Metadata pertaining to creation and last modification of DataBoxEdgeDevice
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The properties of the Data Box Edge/Gateway device extended info.
 */
model DataBoxEdgeDeviceExtendedInfoProperties {
  /**
   * The digital signature of encrypted certificate.
   */
  encryptionKeyThumbprint?: string;

  /**
   * The public part of the encryption certificate. Client uses this to encrypt any secret.
   */
  encryptionKey?: string;

  /**
   * The Resource ID of the Resource.
   */
  @visibility("read")
  resourceKey?: string;

  /**
   * The Key Vault ARM Id for client secrets
   */
  clientSecretStoreId?: string;

  /**
   * The url to access the Client Key Vault
   */
  clientSecretStoreUrl?: string;

  /**
   * The name of Channel Integrity Key stored in the Client Key Vault
   */
  channelIntegrityKeyName?: string;

  /**
   * The version of Channel Integrity Key stored in the Client Key Vault
   */
  channelIntegrityKeyVersion?: string;

  /**
   * Key vault sync status
   */
  keyVaultSyncStatus?: KeyVaultSyncStatus;

  /**
   * Device secrets, will be returned only with ODataFilter $expand=deviceSecrets
   */
  @visibility("read")
  deviceSecrets?: Record<Secret>;

  /**
   * Cluster Witness Type
   */
  @visibility("read")
  clusterWitnessType?: ClusterWitnessType;

  /**
   * The witness location of file share.
   */
  @visibility("read")
  fileShareWitnessLocation?: string;

  /**
   * The username of file share.
   */
  @visibility("read")
  fileShareWitnessUsername?: string;

  /**
   * The Cloud Witness Storage account name.
   */
  @visibility("read")
  cloudWitnessStorageAccountName?: string;

  /**
   * The Container for cloud witness in the storage account.
   */
  @visibility("read")
  cloudWitnessContainerName?: string;

  /**
   * The Azure service endpoint of the cloud witness storage account.
   */
  @visibility("read")
  cloudWitnessStorageEndpoint?: string;
}

/**
 * Holds device secret either as a KeyVault reference or as an encrypted value.
 */
model Secret {
  /**
   * Encrypted (using device public key) secret value.
   */
  encryptedSecret?: AsymmetricEncryptedSecret;

  /**
   * Id of the Key-Vault where secret is stored (ex: secrets/AuthClientSecret/82ef4346187a4033a10d629cde07d740).
   */
  keyVaultId?: string;
}

/**
 * Represent the secrets intended for encryption with asymmetric key pair.
 */
model AsymmetricEncryptedSecret {
  /**
   * The value of the secret.
   */
  value: string;

  /**
   * Thumbprint certificate used to encrypt \"Value\". If the value is unencrypted, it will be null.
   */
  encryptionCertThumbprint?: string;

  /**
   * The algorithm used to encrypt "Value".
   */
  encryptionAlgorithm: EncryptionAlgorithm;
}

/**
 * The job error information containing the list of job errors.
 */
model JobErrorDetails {
  /**
   * The error details.
   */
  @visibility("read")
  errorDetails?: JobErrorItem[];

  /**
   * The code intended for programmatic access.
   */
  @visibility("read")
  code?: string;

  /**
   * The message that describes the error in detail.
   */
  @visibility("read")
  message?: string;
}

/**
 * The job error items.
 */
model JobErrorItem {
  /**
   * The recommended actions.
   */
  @visibility("read")
  recommendations?: string[];

  /**
   * The code intended for programmatic access.
   */
  @visibility("read")
  code?: string;

  /**
   * The message that describes the error in detail.
   */
  @visibility("read")
  message?: string;
}

/**
 * The properties for the job.
 */
model JobProperties {
  /**
   * The type of the job.
   */
  @visibility("read")
  jobType?: JobType;

  /**
   * Current stage of the update operation.
   */
  @visibility("read")
  currentStage?: UpdateOperationStage;

  /**
   * The download progress.
   */
  @visibility("read")
  downloadProgress?: UpdateDownloadProgress;

  /**
   * The install progress.
   */
  @visibility("read")
  installProgress?: UpdateInstallProgress;

  /**
   * Total number of errors encountered during the refresh process.
   */
  @visibility("read")
  totalRefreshErrors?: int32;

  /**
   * Local share/remote container relative path to the error manifest file of the refresh.
   */
  @visibility("read")
  errorManifestFile?: string;

  /**
   * ARM ID of the entity that was refreshed.
   */
  @visibility("read")
  refreshedEntityId?: string;

  /**
   * If only subfolders need to be refreshed, then the subfolder path inside the share or container. (The path is empty if there are no subfolders.)
   */
  folder?: string;
}

/**
 * Details about the download progress of update.
 */
model UpdateDownloadProgress {
  /**
   * The download phase.
   */
  @visibility("read")
  downloadPhase?: DownloadPhase;

  /**
   * Percentage of completion.
   */
  @visibility("read")
  percentComplete?: int32;

  /**
   * Total bytes to download.
   */
  @visibility("read")
  totalBytesToDownload?: float64;

  /**
   * Total bytes downloaded.
   */
  @visibility("read")
  totalBytesDownloaded?: float64;

  /**
   * Number of updates to download.
   */
  @visibility("read")
  numberOfUpdatesToDownload?: int32;

  /**
   * Number of updates downloaded.
   */
  @visibility("read")
  numberOfUpdatesDownloaded?: int32;
}

/**
 * Progress details during installation of updates.
 */
model UpdateInstallProgress {
  /**
   * Percentage completed.
   */
  @visibility("read")
  percentComplete?: int32;

  /**
   * Number of updates to install.
   */
  @visibility("read")
  numberOfUpdatesToInstall?: int32;

  /**
   * Number of updates installed.
   */
  @visibility("read")
  numberOfUpdatesInstalled?: int32;
}

/**
 * The network settings of a device.
 */
model NetworkSettings extends ARMBaseModel {
  /**
   * The properties of network settings of a device.
   */
  @visibility("read")
  @extension("x-ms-client-flatten", true)
  properties?: NetworkSettingsProperties;

  /**
   * Metadata pertaining to creation and last modification of NetworkSettings
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The properties of network settings.
 */
model NetworkSettingsProperties {
  /**
   * The network adapter list on the device.
   */
  @visibility("read")
  networkAdapters?: NetworkAdapter[];
}

/**
 * Represents the networkAdapter on a device.
 */
model NetworkAdapter {
  /**
   * Instance ID of network adapter.
   */
  @visibility("read")
  adapterId?: string;

  /**
   * Hardware position of network adapter.
   */
  @visibility("read")
  adapterPosition?: NetworkAdapterPosition;

  /**
   * Logical index of the adapter.
   */
  @visibility("read")
  index?: int32;

  /**
   * Node ID of the network adapter.
   */
  @visibility("read")
  nodeId?: string;

  /**
   * Network adapter name.
   */
  @visibility("read")
  networkAdapterName?: string;

  /**
   * Hardware label for the adapter.
   */
  @visibility("read")
  label?: string;

  /**
   * MAC address.
   */
  @visibility("read")
  macAddress?: string;

  /**
   * Link speed.
   */
  @visibility("read")
  linkSpeed?: int64;

  /**
   * Value indicating whether this adapter is valid.
   */
  @visibility("read")
  status?: NetworkAdapterStatus;

  /**
   * Value indicating whether this adapter is RDMA capable.
   */
  rdmaStatus?: NetworkAdapterRdmaStatus;

  /**
   * Value indicating whether this adapter has DHCP enabled.
   */
  dhcpStatus?: NetworkAdapterDhcpStatus;

  /**
   * The IPv4 configuration of the network adapter.
   */
  @visibility("read")
  ipv4Configuration?: Ipv4Config;

  /**
   * The IPv6 configuration of the network adapter.
   */
  @visibility("read")
  ipv6Configuration?: Ipv6Config;

  /**
   * The IPv6 local address.
   */
  @visibility("read")
  ipv6LinkLocalAddress?: string;

  /**
   * The list of DNS Servers of the device.
   */
  @visibility("read")
  dnsServers?: string[];
}

/**
 * The network adapter position.
 */
model NetworkAdapterPosition {
  /**
   * The network group.
   */
  @visibility("read")
  networkGroup?: NetworkGroup;

  /**
   * The port.
   */
  @visibility("read")
  port?: int32;
}

/**
 * Details related to the IPv4 address configuration.
 */
model Ipv4Config {
  /**
   * The IPv4 address of the network adapter.
   */
  @visibility("read")
  ipAddress?: string;

  /**
   * The IPv4 subnet of the network adapter.
   */
  @visibility("read")
  subnet?: string;

  /**
   * The IPv4 gateway of the network adapter.
   */
  @visibility("read")
  gateway?: string;
}

/**
 * Details related to the IPv6 address configuration.
 */
model Ipv6Config {
  /**
   * The IPv6 address of the network adapter.
   */
  @visibility("read")
  ipAddress?: string;

  /**
   * The IPv6 prefix of the network adapter.
   */
  @visibility("read")
  prefixLength?: int32;

  /**
   * The IPv6 gateway of the network adapter.
   */
  @visibility("read")
  gateway?: string;
}

/**
 * Collection of Nodes.
 */
model NodeList is Azure.Core.Page<Node>;

/**
 * Represents a single node in a Data box Edge/Gateway device
 * Gateway devices, standalone Edge devices and a single node cluster Edge device will all have 1 node
 * Multi-node Edge devices will have more than 1 nodes
 */
model Node extends ARMBaseModel {
  /**
   * The properties of the node
   */
  @visibility("read")
  @extension("x-ms-client-flatten", true)
  properties?: NodeProperties;
}

/**
 * This class represents the nodes in a highly available cluster
 */
model NodeProperties {
  /**
   * The current status of the individual node
   */
  @visibility("read")
  nodeStatus?: NodeStatus;

  /**
   * Serial number of the Chassis
   */
  @visibility("read")
  nodeChassisSerialNumber?: string;

  /**
   * Serial number of the individual node
   */
  @visibility("read")
  nodeSerialNumber?: string;

  /**
   * Display Name of the individual node
   */
  @visibility("read")
  nodeDisplayName?: string;

  /**
   * Friendly software version name that is currently installed on the node
   */
  @visibility("read")
  nodeFriendlySoftwareVersion?: string;

  /**
   * HCS version that is currently installed on the node
   */
  @visibility("read")
  nodeHcsVersion?: string;

  /**
   * Guid instance id of the node
   */
  @visibility("read")
  nodeInstanceId?: string;
}

/**
 * Order properties.
 */
model OrderProperties {
  /**
   * It specify the order resource id.
   */
  @visibility("read")
  orderId?: string;

  /**
   * The contact details.
   */
  contactInformation: ContactDetails;

  /**
   * The shipping address.
   */
  shippingAddress?: Address;

  /**
   * Current status of the order.
   */
  @visibility("read")
  currentStatus?: OrderStatus;

  /**
   * List of status changes in the order.
   */
  @visibility("read")
  orderHistory?: OrderStatus[];

  /**
   * Serial number of the device.
   */
  @visibility("read")
  serialNumber?: string;

  /**
   * Tracking information for the package delivered to the customer whether it has an original or a replacement device.
   */
  @visibility("read")
  deliveryTrackingInfo?: TrackingInfo[];

  /**
   * Tracking information for the package returned from the customer whether it has an original or a replacement device.
   */
  @visibility("read")
  returnTrackingInfo?: TrackingInfo[];

  /**
   * ShipmentType of the order
   */
  shipmentType?: ShipmentType;
}

/**
 * Contains all the contact details of the customer.
 */
model ContactDetails {
  /**
   * The contact person name.
   */
  contactPerson: string;

  /**
   * The name of the company.
   */
  companyName: string;

  /**
   * The phone number.
   */
  phone: string;

  /**
   * The email list.
   */
  emailList: string[];
}

/**
 * The shipping address of the customer.
 */
model Address {
  /**
   * The address line1.
   */
  addressLine1?: string;

  /**
   * The address line2.
   */
  addressLine2?: string;

  /**
   * The address line3.
   */
  addressLine3?: string;

  /**
   * The postal code.
   */
  postalCode?: string;

  /**
   * The city name.
   */
  city?: string;

  /**
   * The state name.
   */
  state?: string;

  /**
   * The country name.
   */
  country: string;
}

/**
 * Represents a single status change.
 */
model OrderStatus {
  /**
   * Status of the order as per the allowed status types.
   */
  status: OrderState;

  /**
   * Time of status update.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updateDateTime?: utcDateTime;

  /**
   * Comments related to this status change.
   */
  comments?: string;

  /**
   * Tracking information related to the state in the ordering flow
   */
  @visibility("read")
  trackingInformation?: TrackingInfo;

  /**
   * Dictionary to hold generic information which is not stored
   * by the already existing properties
   */
  @visibility("read")
  additionalOrderDetails?: Record<string>;
}

/**
 * Tracking courier information.
 */
model TrackingInfo {
  /**
   * Serial number of the device being tracked.
   */
  serialNumber?: string;

  /**
   * Name of the carrier used in the delivery.
   */
  carrierName?: string;

  /**
   * Tracking ID of the shipment.
   */
  trackingId?: string;

  /**
   * Tracking URL of the shipment.
   */
  trackingUrl?: string;
}

/**
 * DC Access code in the case of Self Managed Shipping.
 */
model DCAccessCode {
  /**
   * DCAccessCode properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DCAccessCodeProperties;
}

/**
 * DCAccessCode Properties.
 */
model DCAccessCodeProperties {
  /**
   * DCAccess Code for the Self Managed shipment.
   */
  authCode?: string;
}

/**
 * Metrics properties
 */
model MonitoringMetricConfigurationProperties {
  /**
   * The metrics configuration details
   */
  metricConfigurations: MetricConfiguration[];
}

/**
 * Metric configuration.
 */
model MetricConfiguration {
  /**
   * The Resource ID on which the metrics should be pushed.
   */
  resourceId: string;

  /**
   * The MDM account to which the counters should be pushed.
   */
  mdmAccount?: string;

  /**
   * The MDM namespace to which the counters should be pushed. This is required if MDMAccount is specified
   */
  metricNameSpace?: string;

  /**
   * Host name for the IoT hub associated to the device.
   */
  counterSets: MetricCounterSet[];
}

/**
 * The metric counter set
 */
model MetricCounterSet {
  /**
   * The counters that should be collected in this set.
   */
  counters: MetricCounter[];
}

/**
 * The metric counter
 */
model MetricCounter {
  /**
   * The counter name.
   */
  name: string;

  /**
   * The instance from which counter should be collected.
   */
  instance?: string;

  /**
   * The dimension filter.
   */
  dimensionFilter?: MetricDimension[];

  /**
   * The additional dimensions to be added to metric.
   */
  additionalDimensions?: MetricDimension[];
}

/**
 * The metric dimension
 */
model MetricDimension {
  /**
   * The dimension type.
   */
  sourceType: string;

  /**
   * The dimension value.
   */
  sourceName: string;
}

/**
 * The security settings of a device.
 */
model SecuritySettings extends ARMBaseModel {
  /**
   * Properties of the security settings.
   */
  @extension("x-ms-client-flatten", true)
  properties: SecuritySettingsProperties;
}

/**
 * The properties of security settings.
 */
model SecuritySettingsProperties {
  /**
   * Device administrator password as an encrypted string (encrypted using RSA PKCS #1) is used to sign into the  local web UI of the device. The Actual password should have at least 8 characters that are a combination of  uppercase, lowercase, numeric, and special characters.
   */
  deviceAdminPassword: AsymmetricEncryptedSecret;
}

/**
 * The share properties.
 */
model ShareProperties {
  /**
   * Description for the share.
   */
  description?: string;

  /**
   * Current status of the share.
   */
  shareStatus: ShareStatus;

  /**
   * Current monitoring status of the share.
   */
  monitoringStatus: MonitoringStatus;

  /**
   * Azure container mapping for the share.
   */
  azureContainerInfo?: AzureContainerInfo;

  /**
   * Access protocol to be used by the share.
   */
  accessProtocol: ShareAccessProtocol;

  /**
   * Mapping of users and corresponding access rights on the share (required for SMB protocol).
   */
  userAccessRights?: UserAccessRight[];

  /**
   * List of IP addresses and corresponding access rights on the share(required for NFS protocol).
   */
  clientAccessRights?: ClientAccessRight[];

  /**
   * Details of the refresh job on this share.
   */
  refreshDetails?: RefreshDetails;

  /**
   * Share mount point to the role.
   */
  @visibility("read")
  shareMappings?: MountPointMap[];

  /**
   * Data policy of the share.
   */
  dataPolicy?: DataPolicy;
}

/**
 * Azure container mapping of the endpoint.
 */
model AzureContainerInfo {
  /**
   * ID of the storage account credential used to access storage.
   */
  storageAccountCredentialId: string;

  /**
   * Container name (Based on the data format specified, this represents the name of Azure Files/Page blob/Block blob).
   */
  containerName: string;

  /**
   * Storage format used for the file represented by the share.
   */
  dataFormat: AzureContainerDataFormat;
}

/**
 * The mapping between a particular user and the access type on the SMB share.
 */
model UserAccessRight {
  /**
   * User ID (already existing in the device).
   */
  userId: string;

  /**
   * Type of access to be allowed for the user.
   */
  accessType: ShareAccessType;
}

/**
 * The mapping between a particular client IP and the type of access client has on the NFS share.
 */
model ClientAccessRight {
  /**
   * IP of the client.
   */
  client: string;

  /**
   * Type of access to be allowed for the client.
   */
  accessPermission: ClientPermissionType;
}

/**
 * Fields for tracking refresh job on the share or container.
 */
model RefreshDetails {
  /**
   * If a refresh job is currently in progress on this share or container, this field indicates the ARM resource ID of that job. The field is empty if no job is in progress.
   */
  inProgressRefreshJobId?: string;

  /**
   * Indicates the completed time for the last refresh job on this particular share or container, if any.This could be a failed job or a successful job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCompletedRefreshJobTimeInUTC?: utcDateTime;

  /**
   * Indicates the relative path of the error xml for the last refresh job on this particular share or container, if any. This could be a failed job or a successful job.
   */
  errorManifestFile?: string;

  /**
   * Indicates the id of the last refresh job on this particular share or container,if any. This could be a failed job or a successful job.
   */
  lastJob?: string;
}

/**
 * The share mount point.
 */
model MountPointMap {
  /**
   * ID of the share mounted to the role VM.
   */
  shareId: string;

  /**
   * ID of the role to which share is mounted.
   */
  @visibility("read")
  roleId?: string;

  /**
   * Mount point for the share.
   */
  @visibility("read")
  mountPoint?: string;

  /**
   * Mounting type.
   */
  @visibility("read")
  mountType?: MountType;

  /**
   * Role type.
   */
  @visibility("read")
  roleType?: RoleTypes;
}

/**
 * The storage account credential properties.
 */
model StorageAccountCredentialProperties {
  /**
   * Alias for the storage account.
   */
  `alias`: string;

  /**
   * Username for the storage account.
   */
  userName?: string;

  /**
   * Encrypted storage key.
   */
  accountKey?: AsymmetricEncryptedSecret;

  /**
   * Connection string for the storage account. Use this string if username and account key are not specified.
   */
  connectionString?: string;

  /**
   * Signifies whether SSL needs to be enabled or not.
   */
  sslStatus: SSLStatus;

  /**
   * Blob end point for private clouds.
   */
  blobDomainName?: string;

  /**
   * Type of storage accessed on the storage account.
   */
  accountType: AccountType;

  /**
   * Id of the storage account.
   */
  storageAccountId?: string;
}

/**
 * The storage account properties.
 */
model StorageAccountProperties {
  /**
   * Description for the storage Account.
   */
  description?: string;

  /**
   * Current status of the storage account
   */
  storageAccountStatus?: StorageAccountStatus;

  /**
   * Data policy of the storage Account.
   */
  dataPolicy: DataPolicy;

  /**
   * Storage Account Credential Id
   */
  storageAccountCredentialId?: string;

  /**
   * BlobEndpoint of Storage Account
   */
  @visibility("read")
  blobEndpoint?: string;

  /**
   * The Container Count. Present only for Storage Accounts with DataPolicy set to Cloud.
   */
  @visibility("read")
  containerCount?: int32;
}

/**
 * The container properties.
 */
model ContainerProperties {
  /**
   * Current status of the container.
   */
  @visibility("read")
  containerStatus?: ContainerStatus;

  /**
   * DataFormat for Container
   */
  dataFormat: AzureContainerDataFormat;

  /**
   * Details of the refresh job on this container.
   */
  @visibility("read")
  refreshDetails?: RefreshDetails;

  /**
   * The UTC time when container got created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime?: utcDateTime;
}

/**
 * The request object for trigger support package.
 */
model TriggerSupportPackageRequest extends ARMBaseModel {
  /**
   * The TriggerSupportPackageRequest properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: SupportPackageRequestProperties;
}

/**
 * The share properties.
 */
model SupportPackageRequestProperties {
  /**
   * MinimumTimeStamp from where logs need to be collected
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  minimumTimeStamp?: utcDateTime;

  /**
   * Start of the timespan of the log collection
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  maximumTimeStamp?: utcDateTime;

  /**
   * Type of files, which need to be included in the logs
   * This will contain the type of logs (Default/DefaultWithDumps/None/All/DefaultWithArchived)
   * or a comma separated list of log types that are required
   */
  include?: string;
}

/**
 * The Data Box Edge/Gateway device extended info patch.
 */
model DataBoxEdgeDeviceExtendedInfoPatch {
  /**
   * The Key Vault ARM Id for client secrets
   */
  clientSecretStoreId?: string;

  /**
   * The url to access the Client Key Vault
   */
  clientSecretStoreUrl?: string;

  /**
   * The name for Channel Integrity Key stored in the Client Key Vault
   */
  channelIntegrityKeyName?: string;

  /**
   * The version of Channel Integrity Key stored in the Client Key Vault
   */
  channelIntegrityKeyVersion?: string;

  /**
   * For changing or to initiate the resync to key-vault set the status to KeyVaultSyncPending, rest of the status will not be applicable.
   */
  syncStatus?: KeyVaultSyncStatus;
}

/**
 * Details about ongoing updates and availability of updates on the device.
 */
model UpdateSummary extends ARMBaseModel {
  /**
   * The device update information summary.
   */
  @extension("x-ms-client-flatten", true)
  properties?: UpdateSummaryProperties;

  /**
   * Metadata pertaining to creation and last modification of UpdateSummary
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The device update information summary.
 */
model UpdateSummaryProperties {
  /**
   * The current version of the device in format: 1.2.17312.13.",
   */
  deviceVersionNumber?: string;

  /**
   * The current version of the device in text format.
   */
  friendlyDeviceVersionName?: string;

  /**
   * The last time when a scan was done on the device.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deviceLastScannedDateTime?: utcDateTime;

  /**
   * The time when the last scan job was completed (success/cancelled/failed) on the appliance.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCompletedScanJobDateTime?: utcDateTime;

  /**
   * Time when the last scan job is successfully completed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulScanJobTime?: utcDateTime;

  /**
   * The time when the last Download job was completed (success/cancelled/failed) on the appliance.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCompletedDownloadJobDateTime?: utcDateTime;

  /**
   * JobId of the last ran download job.(Can be success/cancelled/failed)
   */
  @visibility("read")
  lastCompletedDownloadJobId?: string;

  /**
   * JobStatus of the last ran download job.
   */
  @visibility("read")
  lastDownloadJobStatus?: JobStatus;

  /**
   * The time when the Last Install job was completed successfully on the appliance
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulInstallJobDateTime?: utcDateTime;

  /**
   * The time when the last Install job was completed (success/cancelled/failed) on the appliance.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCompletedInstallJobDateTime?: utcDateTime;

  /**
   * JobId of the last ran install job.(Can be success/cancelled/failed)
   */
  @visibility("read")
  lastCompletedInstallJobId?: string;

  /**
   * JobStatus of the last ran install job.
   */
  @visibility("read")
  lastInstallJobStatus?: JobStatus;

  /**
   * The number of updates available for the current device version as per the last device scan.
   */
  @visibility("read")
  totalNumberOfUpdatesAvailable?: int32;

  /**
   * The total number of items pending download.
   */
  @visibility("read")
  totalNumberOfUpdatesPendingDownload?: int32;

  /**
   * The total number of items pending install.
   */
  @visibility("read")
  totalNumberOfUpdatesPendingInstall?: int32;

  /**
   * Indicates if updates are available and at least one of the updates needs a reboot.
   */
  @visibility("read")
  rebootBehavior?: InstallRebootBehavior;

  /**
   * The current update operation.
   */
  @visibility("read")
  ongoingUpdateOperation?: UpdateOperation;

  /**
   * The job ID of the download job in progress.
   */
  @visibility("read")
  inProgressDownloadJobId?: string;

  /**
   * The job ID of the install job in progress.
   */
  @visibility("read")
  inProgressInstallJobId?: string;

  /**
   * The time when the currently running download (if any) started.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  inProgressDownloadJobStartedDateTime?: utcDateTime;

  /**
   * The time when the currently running install (if any) started.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  inProgressInstallJobStartedDateTime?: utcDateTime;

  /**
   * The list of updates available for install.
   */
  @visibility("read")
  updateTitles?: string[];

  /**
   * The list of updates available for install.
   */
  @visibility("read")
  updates?: UpdateDetails[];

  /**
   * The total size of updates available for download in bytes.
   */
  @visibility("read")
  totalUpdateSizeInBytes?: float64;

  /**
   * The total time in Minutes
   */
  @visibility("read")
  totalTimeInMinutes?: int32;
}

/**
 * Update Specific attributes
 */
model UpdateDetails {
  /**
   * Title of the Update
   */
  updateTitle?: string;

  /**
   * Size of the update(In Bytes)
   */
  updateSize?: float64;

  /**
   * Type of the Update
   */
  updateType?: UpdateType;

  /**
   * Target Version number
   */
  targetVersion?: string;

  /**
   * Friendly Version Number
   */
  friendlyVersionNumber?: string;

  /**
   * Estimated Install Time for the update
   */
  estimatedInstallTimeInMins?: int32;

  /**
   * Indicates if updates are available and at least one of the updates needs a reboot.
   */
  rebootBehavior?: InstallRebootBehavior;

  /**
   * Impact of Installing an updateType
   */
  installationImpact?: InstallationImpact;

  /**
   * Status of the update.
   */
  status?: UpdateStatus;
}

/**
 * The upload certificate request.
 */
model UploadCertificateRequest {
  /**
   * The Base 64 encoded certificate raw data.
   */
  @extension("x-ms-client-flatten", true)
  properties: RawCertificateData;
}

/**
 * Raw Certificate Data.
 */
model RawCertificateData {
  /**
   * The authentication type.
   */
  authenticationType?: AuthenticationType;

  /**
   * The base64 encoded certificate raw data.
   */
  certificate: string;
}

/**
 * The upload registration certificate response.
 */
model UploadCertificateResponse {
  /**
   * Specifies authentication type.
   */
  authType?: AuthenticationType;

  /**
   * The resource ID of the Data Box Edge/Gateway device.
   */
  @visibility("read")
  resourceId?: string;

  /**
   * Azure Active Directory tenant authority.
   */
  @visibility("read")
  aadAuthority?: string;

  /**
   * Azure Active Directory tenant ID.
   */
  @visibility("read")
  aadTenantId?: string;

  /**
   * Azure Active Directory service principal client ID.
   */
  @visibility("read")
  servicePrincipalClientId?: string;

  /**
   * Azure Active Directory service principal object ID.
   */
  @visibility("read")
  servicePrincipalObjectId?: string;

  /**
   * The azure management endpoint audience.
   */
  @visibility("read")
  azureManagementEndpointAudience?: string;

  /**
   * Identifier of the target resource that is the recipient of the requested token.
   */
  @visibility("read")
  aadAudience?: string;
}

/**
 * The user properties.
 */
model UserProperties {
  /**
   * The password details.
   */
  encryptedPassword?: AsymmetricEncryptedSecret;

  /**
   * List of shares that the user has rights on. This field should not be specified during user creation.
   */
  @visibility("read")
  shareAccessRights?: ShareAccessRight[];

  /**
   * Type of the user.
   */
  userType: UserType;
}

/**
 * Specifies the mapping between this particular user and the type of access he has on shares on this device.
 */
model ShareAccessRight {
  /**
   * The share ID.
   */
  shareId: string;

  /**
   * Type of access to be allowed on the share for this user.
   */
  accessType: ShareAccessType;
}

/**
 * Arc Addon.
 */
model ArcAddon extends Addon {
  /**
   * Properties specific to Arc addon.
   */
  @extension("x-ms-client-flatten", true)
  properties: ArcAddonProperties;

  /**
   * Addon type.
   */
  kind: "ArcForKubernetes";
}

/**
 * Arc addon properties.
 */
model ArcAddonProperties {
  /**
   * Arc resource subscription Id
   */
  subscriptionId: string;

  /**
   * Arc resource group name
   */
  resourceGroupName: string;

  /**
   * Arc resource Name
   */
  resourceName: string;

  /**
   * Arc resource location
   */
  resourceLocation: string;

  /**
   * Arc resource version
   */
  @visibility("read")
  version?: string;

  /**
   * Host OS supported by the Arc addon.
   */
  @visibility("read")
  hostPlatform?: PlatformType;

  /**
   * Platform where the runtime is hosted.
   */
  @visibility("read")
  hostPlatformType?: HostPlatformType;

  /**
   * Addon Provisioning State
   */
  @visibility("read")
  provisioningState?: AddonState;
}

/**
 * Authentication mechanism for IoT devices.
 */
model Authentication {
  /**
   * Symmetric key for authentication.
   */
  symmetricKey?: SymmetricKey;
}

/**
 * Symmetric key for authentication.
 */
model SymmetricKey {
  /**
   * Connection string based on the symmetric key.
   */
  connectionString?: AsymmetricEncryptedSecret;
}

/**
 * The preview of Virtual Machine Cloud Management from the Azure supports deploying and managing VMs on your Azure Stack Edge device from Azure Portal.
 * For more information, refer to: https://docs.microsoft.com/en-us/azure/databox-online/azure-stack-edge-gpu-virtual-machine-overview
 * By using this feature, you agree to the preview legal terms. See the https://azure.microsoft.com/en-us/support/legal/preview-supplemental-terms/ for additional details.
 */
model CloudEdgeManagementRole extends Role {
  /**
   * Properties specific to CloudEdgeManagementRole role.
   */
  @extension("x-ms-client-flatten", true)
  properties?: CloudEdgeManagementRoleProperties;

  /**
   * Role type.
   */
  kind: "CloudEdgeManagement";
}

/**
 * CloudEdgeManagement Role properties.
 */
model CloudEdgeManagementRoleProperties {
  /**
   * Local Edge Management Status
   */
  @visibility("read")
  localManagementStatus?: RoleStatus;

  /**
   * Edge Profile of the resource
   */
  @visibility("read")
  edgeProfile?: EdgeProfile;

  /**
   * Role status.
   */
  roleStatus: RoleStatus;
}

/**
 * Cni configuration
 */
model CniConfig {
  /**
   * Cni type
   */
  @visibility("read")
  type?: string;

  /**
   * Cni version
   */
  @visibility("read")
  version?: string;

  /**
   * Pod Subnet
   */
  @visibility("read")
  podSubnet?: string;

  /**
   * Service subnet
   */
  @visibility("read")
  serviceSubnet?: string;
}

/**
 * Compute infrastructure Resource
 */
model ComputeResource {
  /**
   * Processor count
   */
  processorCount: int32;

  /**
   * Memory in GB
   */
  memoryInGB: int64;
}

/**
 * Resource Move details
 */
model DataBoxEdgeMoveRequest {
  /**
   * Target resource group ARMId
   */
  targetResourceGroup: string;

  /**
   * List of resources to be moved
   */
  resources: string[];
}

/**
 * Etcd configuration
 */
model EtcdInfo {
  /**
   * Etcd type
   */
  @visibility("read")
  type?: string;

  /**
   * Etcd version
   */
  @visibility("read")
  version?: string;
}

/**
 * Trigger details.
 */
model FileEventTrigger extends Trigger {
  /**
   * File trigger properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: FileTriggerProperties;

  /**
   * Trigger Kind.
   */
  kind: "FileEvent";
}

/**
 * File trigger properties.
 */
model FileTriggerProperties {
  /**
   * File event source details.
   */
  sourceInfo: FileSourceInfo;

  /**
   * Role sink info.
   */
  sinkInfo: RoleSinkInfo;

  /**
   * A custom context tag typically used to correlate the trigger against its usage. For example, if a periodic timer trigger is intended for certain specific IoT modules in the device, the tag can be the name or the image URL of the module.
   */
  @maxLength(192)
  customContextTag?: string;
}

/**
 * File source details.
 */
model FileSourceInfo {
  /**
   * File share ID.
   */
  shareId: string;
}

/**
 * Compute role against which events will be raised.
 */
model RoleSinkInfo {
  /**
   * Compute role ID.
   */
  roleId: string;
}

/**
 * Image repository credential.
 */
model ImageRepositoryCredential {
  /**
   * Image repository url (e.g.: mcr.microsoft.com).
   */
  imageRepositoryUrl: string;

  /**
   * Repository user name.
   */
  userName: string;

  /**
   * Repository user password.
   */
  password?: AsymmetricEncryptedSecret;
}

/**
 * IoT Addon.
 */
model IoTAddon extends Addon {
  /**
   * Properties specific to IOT addon.
   */
  @extension("x-ms-client-flatten", true)
  properties: IoTAddonProperties;

  /**
   * Addon type.
   */
  kind: "IotEdge";
}

/**
 * IoT addon properties.
 */
model IoTAddonProperties {
  /**
   * IoT device metadata to which appliance needs to be connected.
   */
  ioTDeviceDetails: IoTDeviceInfo;

  /**
   * IoT edge device to which the IoT Addon needs to be configured.
   */
  ioTEdgeDeviceDetails: IoTDeviceInfo;

  /**
   * Version of IoT running on the appliance.
   */
  @visibility("read")
  version?: string;

  /**
   * Host OS supported by the IoT addon.
   */
  @visibility("read")
  hostPlatform?: PlatformType;

  /**
   * Platform where the runtime is hosted.
   */
  @visibility("read")
  hostPlatformType?: HostPlatformType;

  /**
   * Addon Provisioning State
   */
  @visibility("read")
  provisioningState?: AddonState;
}

/**
 * Metadata of IoT device/IoT Edge device to be configured.
 */
model IoTDeviceInfo {
  /**
   * ID of the IoT device/edge device.
   */
  deviceId: string;

  /**
   * Host name for the IoT hub associated to the device.
   */
  ioTHostHub: string;

  /**
   * Id for the IoT hub associated to the device.
   */
  ioTHostHubId?: string;

  /**
   * Encrypted IoT device/IoT edge device connection string.
   */
  authentication?: Authentication;
}

/**
 * IoT edge agent details is optional, this will be used for download system Agent module while bootstrapping IoT Role if specified.
 */
model IoTEdgeAgentInfo {
  /**
   * Name of the IoT edge agent image.
   */
  imageName: string;

  /**
   * Image Tag.
   */
  tag: string;

  /**
   * Image repository details.
   */
  imageRepository?: ImageRepositoryCredential;
}

/**
 * Compute role.
 */
model IoTRole extends Role {
  /**
   * Properties specific to IoT role.
   */
  @extension("x-ms-client-flatten", true)
  properties?: IoTRoleProperties;

  /**
   * Role type.
   */
  kind: "IOT";
}

/**
 * IoT role properties.
 */
model IoTRoleProperties {
  /**
   * Host OS supported by the IoT role.
   */
  hostPlatform: PlatformType;

  /**
   * IoT device metadata to which data box edge device needs to be connected.
   */
  ioTDeviceDetails: IoTDeviceInfo;

  /**
   * IoT edge device to which the IoT role needs to be configured.
   */
  ioTEdgeDeviceDetails: IoTDeviceInfo;

  /**
   * Mount points of shares in role(s).
   */
  shareMappings?: MountPointMap[];

  /**
   * Iot edge agent details to download the agent and bootstrap iot runtime.
   */
  ioTEdgeAgentInfo?: IoTEdgeAgentInfo;

  /**
   * Platform where the Iot runtime is hosted.
   */
  @visibility("read")
  hostPlatformType?: HostPlatformType;

  /**
   * Resource allocation
   */
  computeResource?: ComputeResource;

  /**
   * Role status.
   */
  roleStatus: RoleStatus;
}

/**
 * Kubernetes cluster configuration
 */
model KubernetesClusterInfo {
  /**
   * Etcd configuration
   */
  @visibility("read")
  etcdInfo?: EtcdInfo;

  /**
   * Kubernetes cluster nodes
   */
  @visibility("read")
  nodes?: NodeInfo[];

  /**
   * Kubernetes cluster version
   */
  version: string;
}

/**
 * Kubernetes node info
 */
model NodeInfo {
  /**
   * Node name.
   */
  @visibility("read")
  name?: string;

  /**
   * Node type - Master/Worker
   */
  @visibility("read")
  type?: KubernetesNodeType;

  /**
   * IP Configuration of the Kubernetes node.
   */
  ipConfiguration?: KubernetesIPConfiguration[];
}

/**
 * Kubernetes node IP configuration
 */
model KubernetesIPConfiguration {
  /**
   * Port of the Kubernetes node.
   */
  @visibility("read")
  port?: string;

  /**
   * IP address of the Kubernetes node.
   */
  ipAddress?: string;
}

/**
 * The limited preview of Kubernetes Cluster Management from the Azure supports:
 * 1. Using a simple turn-key option in Azure Portal, deploy a Kubernetes cluster on your Azure Stack Edge device.
 * 2. Configure Kubernetes cluster running on your device with Arc enabled Kubernetes with a click of a button in the Azure Portal.
 *  Azure Arc enables organizations to view, manage, and govern their on-premises Kubernetes clusters using the Azure Portal, command line tools, and APIs.
 * 3. Easily configure Persistent Volumes using SMB and NFS shares for storing container data.
 *  For more information, refer to the document here: https://databoxupdatepackages.blob.core.windows.net/documentation/Microsoft-Azure-Stack-Edge-K8-Cloud-Management-20210323.pdf
 *  Or Demo: https://databoxupdatepackages.blob.core.windows.net/documentation/Microsoft-Azure-Stack-Edge-K8S-Cloud-Management-20210323.mp4
 *  By using this feature, you agree to the preview legal terms. See the https://azure.microsoft.com/en-us/support/legal/preview-supplemental-terms/
 */
model KubernetesRole extends Role {
  /**
   * Properties specific to Kubernetes role.
   */
  @extension("x-ms-client-flatten", true)
  properties?: KubernetesRoleProperties;

  /**
   * Role type.
   */
  kind: "Kubernetes";
}

/**
 * Kubernetes role properties.
 */
model KubernetesRoleProperties {
  /**
   * Host OS supported by the Kubernetes role.
   */
  hostPlatform: PlatformType;

  /**
   * State of Kubernetes deployment
   */
  @visibility("read")
  provisioningState?: KubernetesState;

  /**
   * Platform where the runtime is hosted.
   */
  @visibility("read")
  hostPlatformType?: HostPlatformType;

  /**
   * Kubernetes cluster configuration
   */
  kubernetesClusterInfo: KubernetesClusterInfo;

  /**
   * Kubernetes role resources
   */
  kubernetesRoleResources: KubernetesRoleResources;

  /**
   * Role status.
   */
  roleStatus: RoleStatus;
}

/**
 * Kubernetes role resources
 */
model KubernetesRoleResources {
  /**
   * Kubernetes role storage resource
   */
  storage?: KubernetesRoleStorage;

  /**
   * Kubernetes role compute resource
   */
  compute: KubernetesRoleCompute;

  /**
   * Kubernetes role network resource
   */
  @visibility("read")
  network?: KubernetesRoleNetwork;
}

/**
 * Kubernetes role storage resource
 */
model KubernetesRoleStorage {
  /**
   * Kubernetes storage class info.
   */
  @visibility("read")
  storageClasses?: KubernetesRoleStorageClassInfo[];

  /**
   * Mount points of shares in role(s).
   */
  endpoints?: MountPointMap[];
}

/**
 * Kubernetes storage class info.
 */
model KubernetesRoleStorageClassInfo {
  /**
   * Storage class name.
   */
  @visibility("read")
  name?: string;

  /**
   * Storage class type.
   */
  @visibility("read")
  type?: string;

  /**
   * If provisioned storage is posix compliant.
   */
  @visibility("read")
  posixCompliant?: PosixComplianceStatus;
}

/**
 * Kubernetes role compute resource
 */
model KubernetesRoleCompute {
  /**
   * VM profile
   */
  vmProfile: string;

  /**
   * Memory in bytes
   */
  @visibility("read")
  memoryInBytes?: int64;

  /**
   * Processor count
   */
  @visibility("read")
  processorCount?: int32;
}

/**
 * Kubernetes role network resource
 */
model KubernetesRoleNetwork {
  /**
   * Cni configuration
   */
  @visibility("read")
  cniConfig?: CniConfig;

  /**
   * Load balancer configuration
   */
  @visibility("read")
  loadBalancerConfig?: LoadBalancerConfig;
}

/**
 * Load balancer configuration
 */
model LoadBalancerConfig {
  /**
   * Load balancer type
   */
  @visibility("read")
  type?: string;

  /**
   * Load balancer version
   */
  @visibility("read")
  version?: string;
}

/**
 * MEC role.
 */
model MECRole extends Role {
  /**
   * Properties specific to MEC role.
   */
  @extension("x-ms-client-flatten", true)
  properties?: MECRoleProperties;

  /**
   * Role type.
   */
  kind: "MEC";
}

/**
 * MEC role properties.
 */
model MECRoleProperties {
  /**
   * Activation key of the MEC.
   */
  connectionString?: AsymmetricEncryptedSecret;

  /**
   * Controller Endpoint.
   */
  controllerEndpoint?: string;

  /**
   * Unique Id of the Resource.
   */
  resourceUniqueId?: string;

  /**
   * Role status.
   */
  roleStatus: RoleStatus;
}

/**
 * Trigger details.
 */
model PeriodicTimerEventTrigger extends Trigger {
  /**
   * Periodic timer trigger properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: PeriodicTimerProperties;

  /**
   * Trigger Kind.
   */
  kind: "PeriodicTimerEvent";
}

/**
 * Periodic timer trigger properties.
 */
model PeriodicTimerProperties {
  /**
   * Periodic timer details.
   */
  sourceInfo: PeriodicTimerSourceInfo;

  /**
   * Role Sink information.
   */
  sinkInfo: RoleSinkInfo;

  /**
   * A custom context tag typically used to correlate the trigger against its usage. For example, if a periodic timer trigger is intended for certain specific IoT modules in the device, the tag can be the name or the image URL of the module.
   */
  @maxLength(192)
  customContextTag?: string;
}

/**
 * Periodic timer event source.
 */
model PeriodicTimerSourceInfo {
  /**
   * The time of the day that results in a valid trigger. Schedule is computed with reference to the time specified upto seconds. If timezone is not specified the time will considered to be in device timezone. The value will always be returned as UTC time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime: utcDateTime;

  /**
   * Periodic frequency at which timer event needs to be raised. Supports daily, hourly, minutes, and seconds.
   */
  schedule: string;

  /**
   * Topic where periodic events are published to IoT device.
   */
  topic?: string;
}
