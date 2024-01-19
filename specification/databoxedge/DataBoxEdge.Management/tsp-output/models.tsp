import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DataBoxEdge;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Metric units.")
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

@doc("Metric aggregation type.")
enum MetricAggregationType {
  NotSpecified,
  None,
  Average,
  Minimum,
  Maximum,
  Total,
  Count,
}

@doc("Metric category.")
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

@doc("The Sku name.")
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

@doc("Sku can be signed up by customer or not.")
enum SkuSignupOption {
  None,
  Available,
}

@doc("Availability of the Sku as preview/stable.")
enum SkuVersion {
  Stable,
  Preview,
}

@doc("Links to the next set of results")
enum SkuAvailability {
  Available,
  Unavailable,
}

enum ShipmentType {
  NotApplicable,
  ShippedToCustomer,
  SelfPickup,
}

@doc("Identity type")
enum MsiIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
}

@doc("The kind of the device.")
enum DataBoxEdgeDeviceKind {
  AzureDataBoxGateway,
  AzureStackEdge,
  AzureStackHub,
  AzureModularDataCentre,
}

@doc("The status of the Data Box Edge/Gateway device.")
enum DataBoxEdgeDeviceStatus {
  ReadyToSetup,
  Online,
  Offline,
  NeedsAttention,
  Disconnected,
  PartiallyDisconnected,
  Maintenance,
}

@doc("The type of the Data Box Edge/Gateway device.")
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

@doc("Denotes whether move operation is in progress")
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

@doc("DataResidencyType enum")
enum DataResidencyType {
  GeoZoneReplication,
  ZoneReplication,
}

@doc("Severity of the alert.")
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

@doc("Proactive diagnostic collection consent flag")
enum ProactiveDiagnosticsConsent {
  Enabled,
  Disabled,
}

@doc("Remote application type")
enum RemoteApplicationType {
  Powershell,
  WAC,
  LocalUI,
  AllApplications,
}

@doc("Access level allowed for this remote application type")
enum AccessLevel {
  None,
  ReadOnly,
  ReadWrite,
  FullAccess,
}

@doc("For changing or to initiate the resync to key-vault set the status to KeyVaultSyncPending, rest of the status will not be applicable.")
enum KeyVaultSyncStatus {
  KeyVaultSynced,
  KeyVaultSyncFailed,
  KeyVaultNotConfigured,
  KeyVaultSyncPending,
  KeyVaultSyncing,
  KeyVaultNotSynced,
}

@doc("The algorithm used to encrypt \"Value\".")
enum EncryptionAlgorithm {
  None,
  AES256,
  RSAES_PKCS1_v_1_5,
}

@doc("Cluster Witness Type")
enum ClusterWitnessType {
  None,
  Cloud,
  FileShare,
}

@doc("The current status of the job.")
enum JobStatus {
  Invalid,
  Running,
  Succeeded,
  Failed,
  Canceled,
  Paused,
  Scheduled,
}

@doc("The type of the job.")
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

@doc("Current stage of the update operation.")
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

@doc("The download phase.")
enum DownloadPhase {
  Unknown,
  Initializing,
  Downloading,
  Verifying,
}

@doc("The network group.")
enum NetworkGroup {
  None,
  NonRDMA,
  RDMA,
}

@doc("Value indicating whether this adapter is valid.")
enum NetworkAdapterStatus {
  Inactive,
  Active,
}

@doc("Value indicating whether this adapter is RDMA capable.")
enum NetworkAdapterRdmaStatus {
  Incapable,
  Capable,
}

@doc("Value indicating whether this adapter has DHCP enabled.")
enum NetworkAdapterDhcpStatus {
  Disabled,
  Enabled,
}

@doc("The current status of the individual node")
enum NodeStatus {
  Unknown,
  Up,
  Down,
  Rebooting,
  ShuttingDown,
}

@doc("Status of the order as per the allowed status types.")
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

@doc("Addon type.")
enum AddonType {
  IotEdge,
  ArcForKubernetes,
}

@doc("Current status of the share.")
enum ShareStatus {
  Offline,
  Unknown,
  OK,
  Updating,
  NeedsAttention,
}

@doc("Current monitoring status of the share.")
enum MonitoringStatus {
  Enabled,
  Disabled,
}

@doc("Storage format used for the file represented by the share.")
enum AzureContainerDataFormat {
  BlockBlob,
  PageBlob,
  AzureFile,
}

@doc("Access protocol to be used by the share.")
enum ShareAccessProtocol {
  SMB,
  NFS,
}

@doc("Type of access to be allowed on the share for this user.")
enum ShareAccessType {
  Change,
  Read,
  Custom,
}

@doc("Type of access to be allowed for the client.")
enum ClientPermissionType {
  NoAccess,
  ReadOnly,
  ReadWrite,
}

@doc("Mounting type.")
enum MountType {
  Volume,
  HostPath,
}

@doc("Data policy of the share.")
enum DataPolicy {
  Cloud,
  Local,
}

@doc("Signifies whether SSL needs to be enabled or not.")
enum SSLStatus {
  Enabled,
  Disabled,
}

@doc("Type of storage accessed on the storage account.")
enum AccountType {
  GeneralPurposeStorage,
  BlobStorage,
}

@doc("Current status of the storage account")
enum StorageAccountStatus {
  OK,
  Offline,
  Unknown,
  Updating,
  NeedsAttention,
}

@doc("Current status of the container.")
enum ContainerStatus {
  OK,
  Offline,
  Unknown,
  Updating,
  NeedsAttention,
}

@doc("Trigger Kind.")
enum TriggerEventType {
  FileEvent,
  PeriodicTimerEvent,
}

@doc("Indicates if updates are available and at least one of the updates needs a reboot.")
enum InstallRebootBehavior {
  NeverReboots,
  RequiresReboot,
  RequestReboot,
}

@doc("The current update operation.")
enum UpdateOperation {
  None,
  Scan,
  Download,
  Install,
}

@doc("Type of the Update")
enum UpdateType {
  Software,
  Kubernetes,
  Firmware,
}

@doc("Impact of Installing an updateType")
enum InstallationImpact {
  None,
  DeviceRebooted,
  KubernetesWorkloadsDown,
}

@doc("Status of the update.")
enum UpdateStatus {
  DownloadPending,
  DownloadStarted,
  DownloadCompleted,
  InstallStarted,
  InstallCompleted,
}

@doc("The authentication type.")
enum AuthenticationType {
  Invalid,
  AzureActiveDirectory,
}

@doc("Type of the user.")
enum UserType {
  Share,
  LocalManagement,
  ARM,
}

@doc("Host OS supported by the Arc addon.")
enum PlatformType {
  Windows,
  Linux,
}

@doc("Platform where the runtime is hosted.")
enum HostPlatformType {
  KubernetesCluster,
  LinuxVM,
}

@doc("Addon Provisioning State")
enum AddonState {
  Invalid,
  Creating,
  Created,
  Updating,
  Reconfiguring,
  Failed,
  Deleting,
}

@doc("Local Edge Management Status")
enum RoleStatus {
  Enabled,
  Disabled,
}

@doc("Node type - Master/Worker")
enum KubernetesNodeType {
  Invalid,
  Master,
  Worker,
}

@doc("State of Kubernetes deployment")
enum KubernetesState {
  Invalid,
  Creating,
  Created,
  Updating,
  Reconfiguring,
  Failed,
  Deleting,
}

@doc("If provisioned storage is posix compliant.")
enum PosixComplianceStatus {
  Invalid,
  Enabled,
  Disabled,
}

@doc("Operation properties.")
model OperationProperties {
  @doc("Service specification.")
  serviceSpecification?: ServiceSpecification;
}

@doc("Service specification.")
model ServiceSpecification {
  @doc("Metric specification as defined by shoebox.")
  metricSpecifications?: MetricSpecificationV1[];
}

@doc("Metric specification version 1.")
model MetricSpecificationV1 {
  @doc("Name of the metric.")
  name?: string;

  @doc("Display name of the metric.")
  displayName?: string;

  @doc("Description of the metric to be displayed.")
  displayDescription?: string;

  @doc("Metric units.")
  unit?: MetricUnit;

  @doc("Metric aggregation type.")
  aggregationType?: MetricAggregationType;

  @doc("Metric dimensions, other than default dimension which is resource.")
  dimensions?: MetricDimensionV1[];

  @doc("Set true to fill the gaps with zero.")
  fillGapWithZero?: boolean;

  @doc("Metric category.")
  category?: MetricCategory;

  @doc("Resource name override.")
  resourceIdDimensionNameOverride?: string;

  @doc("Support granularity of metrics.")
  supportedTimeGrainTypes?: TimeGrain[];

  @doc("Support metric aggregation type.")
  supportedAggregationTypes?: MetricAggregationType[];
}

@doc("Metric Dimension v1.")
model MetricDimensionV1 {
  @doc("Name of the metrics dimension.")
  name?: string;

  @doc("Display name of the metrics dimension.")
  displayName?: string;

  @doc("To be exported to shoe box.")
  toBeExportedForShoebox?: boolean;
}

@doc("An error response from the service.")
@error
model CloudError {
  @doc("The error details.")
  error?: CloudErrorBody;
}

@doc("An error response from the service.")
model CloudErrorBody {
  @doc("An identifier for the error. Codes are invariant and are intended to be consumed programmatically.")
  code?: string;

  @doc("A message describing the error, intended to be suitable for display in a user interface.")
  message?: string;

  @doc("A list of additional details about the error.")
  details?: CloudErrorBody[];
}

@doc("List of SKU Information objects.")
model DataBoxEdgeSkuList is Azure.Core.Page<DataBoxEdgeSku>;

@doc("The Sku information.")
model DataBoxEdgeSku {
  @doc("The type of the resource.")
  @visibility("read")
  resourceType?: string;

  @doc("The Sku name.")
  @visibility("read")
  name?: SkuName;

  @doc("The Sku kind.")
  @visibility("read")
  kind?: string;

  @doc("The Sku tier.")
  @visibility("read")
  tier?: SkuTier;

  @doc("The Sku kind.")
  @visibility("read")
  size?: string;

  @doc("The Sku family.")
  @visibility("read")
  family?: string;

  @doc("Availability of the Sku for the region.")
  @visibility("read")
  locations?: string[];

  @doc("The API versions in which Sku is available.")
  @visibility("read")
  apiVersions?: string[];

  @doc("Availability of the Sku for the location/zone/site.")
  @visibility("read")
  locationInfo?: SkuLocationInfo[];

  @doc("The pricing info of the Sku.")
  @visibility("read")
  costs?: SkuCost[];

  @doc("Sku can be signed up by customer or not.")
  @visibility("read")
  signupOption?: SkuSignupOption;

  @doc("Availability of the Sku as preview/stable.")
  @visibility("read")
  version?: SkuVersion;

  @doc("Links to the next set of results")
  @visibility("read")
  availability?: SkuAvailability;

  @doc("List of Shipment Types supported by this SKU")
  @visibility("read")
  shipmentTypes?: ShipmentType[];

  @doc("The capability info of the SKU.")
  @visibility("read")
  capabilities?: SkuCapability[];
}

@doc("The location info.")
model SkuLocationInfo {
  @doc("The location.")
  @visibility("read")
  location?: string;

  @doc("The zones.")
  @visibility("read")
  zones?: string[];

  @doc("The sites.")
  @visibility("read")
  sites?: string[];
}

@doc("The metadata for retrieving price info.")
model SkuCost {
  @doc("Used for querying price from commerce.")
  @visibility("read")
  meterId?: string;

  @doc("The cost quantity.")
  @visibility("read")
  quantity?: int32;

  @doc("The extended unit.")
  @visibility("read")
  extendedUnit?: string;
}

@doc("The metadata to describe the capability.")
model SkuCapability {
  @doc("An invariant to describe the feature.")
  @visibility("read")
  name?: string;

  @doc("An invariant if the feature is measured by quantity.")
  @visibility("read")
  value?: string;
}

@doc("The SKU type.")
model Sku {
  @doc("SKU name.")
  name?: SkuName;

  @doc("The SKU tier. This is based on the SKU name.")
  tier?: SkuTier;
}

@doc("Msi identity details of the resource")
model ResourceIdentity {
  @doc("Identity type")
  type?: MsiIdentityType;

  @doc("Service Principal Id backing the Msi")
  @visibility("read")
  principalId?: string;

  @doc("Home Tenant Id")
  @visibility("read")
  tenantId?: string;
}

@doc("The properties of the Data Box Edge/Gateway device.")
model DataBoxEdgeDeviceProperties {
  @doc("DataBoxEdge Device Properties")
  @visibility("read")
  systemData?: SystemData;

  @doc("The status of the Data Box Edge/Gateway device.")
  @visibility("read")
  dataBoxEdgeDeviceStatus?: DataBoxEdgeDeviceStatus;

  @doc("The Serial Number of Data Box Edge/Gateway device.")
  @visibility("read")
  serialNumber?: string;

  @doc("The Description of the Data Box Edge/Gateway device.")
  @visibility("read")
  description?: string;

  @doc("The description of the Data Box Edge/Gateway device model.")
  @visibility("read")
  modelDescription?: string;

  @doc("The type of the Data Box Edge/Gateway device.")
  @visibility("read")
  deviceType?: DeviceType;

  @doc("The Data Box Edge/Gateway device name.")
  @visibility("read")
  friendlyName?: string;

  @doc("The Data Box Edge/Gateway device culture.")
  @visibility("read")
  culture?: string;

  @doc("The Data Box Edge/Gateway device model.")
  @visibility("read")
  deviceModel?: string;

  @doc("The Data Box Edge/Gateway device software version.")
  @visibility("read")
  deviceSoftwareVersion?: string;

  @doc("The Data Box Edge/Gateway device local capacity in MB.")
  @visibility("read")
  deviceLocalCapacity?: int32;

  @doc("The Data Box Edge/Gateway device timezone.")
  @visibility("read")
  timeZone?: string;

  @doc("The device software version number of the device (eg: 1.2.18105.6).")
  @visibility("read")
  deviceHcsVersion?: string;

  @doc("Type of compute roles configured.")
  @visibility("read")
  configuredRoleTypes?: RoleTypes[];

  @doc("The number of nodes in the cluster.")
  @visibility("read")
  nodeCount?: int32;

  @doc("The details of the move operation on this resource.")
  @visibility("read")
  resourceMoveDetails?: ResourceMoveDetails;

  @doc("The details of Edge Profile for this resource")
  @visibility("read")
  edgeProfile?: EdgeProfile;

  @doc("The details of data-residency related properties for this resource")
  dataResidency?: DataResidency;
}

@doc("Fields for tracking resource move")
model ResourceMoveDetails {
  @doc("Denotes whether move operation is in progress")
  operationInProgress?: ResourceMoveStatus;

  @doc("Denotes the timeout of the operation to finish")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  operationInProgressLockTimeoutInUTC?: utcDateTime;
}

@doc("Details about Edge Profile for the resource")
model EdgeProfile {
  @doc("Edge Profile Subscription")
  subscription?: EdgeProfileSubscription;
}

@doc("Subscription details for the Edge Profile")
model EdgeProfileSubscription {
  @doc("Edge Subscription Registration ID")
  registrationId?: string;

  @doc("ARM ID of the subscription")
  id?: string;

  state?: SubscriptionState;
  registrationDate?: string;
  subscriptionId?: string;
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

@doc("Wraps data-residency related information for edge-resource and this should be used with ARM layer.")
model DataResidency {
  @doc("DataResidencyType enum")
  type?: DataResidencyType;
}

@doc("Represents the base class for all object models.")
model ARMBaseModel {
  @doc("The path ID that uniquely identifies the object.")
  @visibility("read")
  id?: string;

  @doc("The object name.")
  @visibility("read")
  name?: string;

  @doc("The hierarchical type of the object.")
  @visibility("read")
  type?: string;
}

@doc("The Data Box Edge/Gateway device patch.")
model DataBoxEdgeDevicePatch {
  @doc("The tags attached to the Data Box Edge/Gateway resource.")
  tags?: Record<string>;

  @doc("Msi identity of the resource")
  identity?: ResourceIdentity;

  @doc("The properties associated with the Data Box Edge/Gateway resource")
  properties?: DataBoxEdgeDevicePropertiesPatch;
}

@doc("The Data Box Edge/Gateway device properties patch.")
model DataBoxEdgeDevicePropertiesPatch {
  @doc("Edge Profile property of the Data Box Edge/Gateway device")
  edgeProfile?: EdgeProfilePatch;
}

@doc("The Data Box Edge/Gateway Edge Profile patch.")
model EdgeProfilePatch {
  @doc("The Data Box Edge/Gateway Edge Profile Subscription patch")
  subscription?: EdgeProfileSubscriptionPatch;
}

@doc("The Data Box Edge/Gateway Edge Profile Subscription patch.")
model EdgeProfileSubscriptionPatch {
  @doc("The path ID that uniquely identifies the subscription of the edge profile.")
  id?: string;
}

@doc("Properties of alert.")
model AlertProperties {
  @doc("Alert title.")
  @visibility("read")
  title?: string;

  @doc("Alert type.")
  @visibility("read")
  alertType?: string;

  @doc("UTC time when the alert appeared.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  appearedAtDateTime?: utcDateTime;

  @doc("Alert recommendation.")
  @visibility("read")
  recommendation?: string;

  @doc("Severity of the alert.")
  @visibility("read")
  severity?: AlertSeverity;

  @doc("Error details of the alert.")
  @visibility("read")
  errorDetails?: AlertErrorDetails;

  @doc("Alert details.")
  @visibility("read")
  detailedInformation?: Record<string>;
}

@doc("Error details for the alert.")
model AlertErrorDetails {
  @doc("Error code.")
  @visibility("read")
  errorCode?: string;

  @doc("Error Message.")
  @visibility("read")
  errorMessage?: string;

  @doc("Number of occurrences.")
  @visibility("read")
  occurrences?: int32;
}

@doc("The properties of the bandwidth schedule.")
model BandwidthScheduleProperties {
  @doc("The start time of the schedule in UTC.")
  start: plainTime;

  @doc("The stop time of the schedule in UTC.")
  stop: plainTime;

  @doc("The bandwidth rate in Mbps.")
  rateInMbps: int32;

  @doc("The days of the week when this schedule is applicable.")
  days: DayOfWeek[];
}

@doc("Object for Capturing DeviceCapacityRequestInfo")
model DeviceCapacityRequestInfo {
  @doc("The properties of the Device Capacity Request.")
  properties: DeviceCapacityRequestInfoProperties;
}

@doc("Properties of Device Capacity Request Info containing VM's to be checked and their corresponding results.")
model DeviceCapacityRequestInfoProperties {
  @doc("Array containing the sizes of the VMs for checking if its feasible to create them on the appliance.")
  vmPlacementQuery: string[][];

  @doc("Array of the VMs of the sizes in VmSizes can be provisioned on the appliance.")
  vmPlacementResults?: VmPlacementRequestResult[];
}

@doc("List of VM sizes being checked for creation on appliance along with corresponding result.")
model VmPlacementRequestResult {
  @doc("List of VM sizes being checked.")
  vmSize?: string[];

  @doc("Boolean value indicating if the VM(s) in VmSize can be created.")
  isFeasible?: boolean;

  @doc("MessageCode indicating reason for success or failure.")
  messageCode?: string;

  @doc("Localized message to be displayed to the user to explain the check result.")
  message?: string;
}

@doc("Object for Capturing DeviceCapacityInfo")
model DeviceCapacityInfo extends ARMBaseModel {
  @doc("The device capacity properties.")
  properties?: DeviceCapacityInfoProperties;

  @doc("Metadata pertaining to device capacity info.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The properties of Device Capacity Info")
model DeviceCapacityInfoProperties {
  @doc("Timestamp of request in UTC")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStamp?: utcDateTime;

  @doc("Cluster capacity data for storage resources (CSV).")
  clusterStorageCapacityInfo?: ClusterStorageViewData;

  @doc("Cluster capacity data for compute resources (Memory and GPU).")
  clusterComputeCapacityInfo?: ClusterCapacityViewData;

  @doc("The dictionary of individual node names and node capacities in the cluster.")
  nodeCapacityInfos?: Record<HostCapacity>;
}

@doc("Cluster Storage Data.")
model ClusterStorageViewData {
  @doc("Total storage on the cluster in MB.")
  clusterTotalStorageMb?: float32;

  @doc("The available or free storage on the cluster in MB.")
  clusterFreeStorageMb?: float32;
}

@doc("Cluster Compute Data.")
model ClusterCapacityViewData {
  @doc("The FQDN of the cluster.")
  fqdn?: string;

  @doc("The cluster's GPU capacity.")
  gpuCapacity?: ClusterGpuCapacity;

  @doc("The cluster's memory capacity.")
  memoryCapacity?: ClusterMemoryCapacity;

  @doc("The last time at which the ClusterCapacityViewData was set.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRefreshedTime?: utcDateTime;

  @doc("The total # of vCPUs provisioned by non-HPN VM per appliance.")
  totalProvisionedNonHpnCores?: int32;
}

@doc("Cluster GPU Data.")
model ClusterGpuCapacity {
  @doc("The cluster GPU Type.")
  gpuType?: string;

  @doc("The used GPU units count in the cluster.")
  gpuUsedUnitsCount?: int32;

  @doc("The free GPU units count in the cluster.")
  gpuFreeUnitsCount?: int32;

  @doc("The GPU units count reserved for failover in the cluster.")
  gpuReservedForFailoverUnitsCount?: int32;

  @doc("The total GPU units count in the cluster.")
  gpuTotalUnitsCount?: int32;
}

@doc("NodeCapacityInfo defines the required information to determine the placement of a VM.")
model ClusterMemoryCapacity {
  @doc("The free memory in the cluster in MB.")
  clusterFreeMemoryMb?: float32;

  @doc("The used memory in the cluster in MB.")
  clusterUsedMemoryMb?: float32;

  @doc("The failover memory in the cluster in MB.")
  clusterFailoverMemoryMb?: float32;

  @doc("The fragmentation memory in the cluster in MB.")
  clusterFragmentationMemoryMb?: float32;

  @doc("The memory reserved for Hyper-V in the cluster in MB.")
  clusterHypervReserveMemoryMb?: float32;

  @doc("The memory of the Infra VM in the cluster in MB.")
  clusterInfraVmMemoryMb?: float32;

  @doc("The total memory in the cluster in MB.")
  clusterTotalMemoryMb?: float32;

  @doc("The non-failover memory in the cluster in MB.")
  clusterNonFailoverVmMb?: float32;

  @doc("The memory used by VMs in the cluster in MB.")
  clusterMemoryUsedByVmsMb?: float32;
}

@doc("Host Capacity Data.")
model HostCapacity {
  @doc("The name of the host.")
  hostName?: string;

  @doc("The available memory on the host accounting for VM placement size and any host VM reservations.")
  effectiveAvailableMemoryMbOnHost?: int32;

  @doc("The available amount of GPUs on the host to use after accounting for GPUS used by reservations on the host.")
  availableGpuCount?: int32;

  @doc("The VM used memory per VmId.")
  vmUsedMemory?: Record<VmMemory>;

  @doc("The GPU type of the VM.")
  gpuType?: string;

  @doc("The numa nodes information for Hpn VMs.")
  numaNodesData?: NumaNodeData[];
}

@doc("VmMemory Data.")
model VmMemory {
  @doc("The total amount of RAM in the virtual machine, as seen by the guest  operating system. For a virtual machine with dynamic memory enabled, this represents the initial memory available at startup.")
  startupMemoryMB?: int32;

  @doc("The current memory used by the virtual machine.")
  currentMemoryUsageMB?: int32;
}

@doc("NUMA node data.")
model NumaNodeData {
  @doc("The NUMA node index.")
  numaNodeIndex?: int32;

  @doc("The total memory on the NUMA node.")
  totalMemoryInMb?: int32;

  @doc("The logical cores per core count.")
  logicalCoreCountPerCore?: int32;

  @doc("The effective available memory on the NUMA node in MB.")
  effectiveAvailableMemoryInMb?: int32;

  @doc("The free VCPU indices for the Hpn VMs.")
  freeVCpuIndexesForHpn?: int32[];

  @doc("The VCPU indices for Hpn VMs")
  vCpuIndexesForHpn?: int32[];

  @doc("The VCPU indices for the root.")
  vCpuIndexesForRoot?: int32[];
}

@doc("The properties of proactive log collection settings.")
model ProactiveLogCollectionSettingsProperties {
  @doc("Proactive diagnostic collection consent flag")
  userConsent: ProactiveDiagnosticsConsent;
}

@doc("The properties of remote support settings.")
model DiagnosticRemoteSupportSettingsProperties {
  @doc("Remote support settings list according to the RemoteApplicationType")
  remoteSupportSettingsList?: RemoteSupportSettings[];
}

@doc("RemoteApplicationType for which remote support settings is being modified")
model RemoteSupportSettings {
  @doc("Remote application type")
  remoteApplicationType?: RemoteApplicationType;

  @doc("Access level allowed for this remote application type")
  accessLevel?: AccessLevel;

  @doc("Expiration time stamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeStampInUTC?: utcDateTime;
}

@doc("Used in activation key generation flow.")
model GenerateCertResponse {
  @doc("""
Gets or sets base64 encoded certificate raw data,
this is the public part needed to be uploaded to cert vault
""")
  publicKey?: string;

  @doc("""
Gets or sets base64 encoded private part of the certificate,
needed to form the activation key
""")
  privateKey?: string;

  @doc("Gets or sets expiry time in UTC")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTimeInUTC?: utcDateTime;
}

@doc("The extended Info of the Data Box Edge/Gateway device.")
model DataBoxEdgeDeviceExtendedInfo extends ARMBaseModel {
  @doc("The extended info properties.")
  properties?: DataBoxEdgeDeviceExtendedInfoProperties;

  @doc("Metadata pertaining to creation and last modification of DataBoxEdgeDevice")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The properties of the Data Box Edge/Gateway device extended info.")
model DataBoxEdgeDeviceExtendedInfoProperties {
  @doc("The digital signature of encrypted certificate.")
  encryptionKeyThumbprint?: string;

  @doc("The public part of the encryption certificate. Client uses this to encrypt any secret.")
  encryptionKey?: string;

  @doc("The Resource ID of the Resource.")
  @visibility("read")
  resourceKey?: string;

  @doc("The Key Vault ARM Id for client secrets")
  clientSecretStoreId?: string;

  @doc("The url to access the Client Key Vault")
  clientSecretStoreUrl?: string;

  @doc("The name of Channel Integrity Key stored in the Client Key Vault")
  channelIntegrityKeyName?: string;

  @doc("The version of Channel Integrity Key stored in the Client Key Vault")
  channelIntegrityKeyVersion?: string;

  @doc("Key vault sync status")
  keyVaultSyncStatus?: KeyVaultSyncStatus;

  @doc("Device secrets, will be returned only with ODataFilter $expand=deviceSecrets")
  @visibility("read")
  deviceSecrets?: Record<Secret>;

  @doc("Cluster Witness Type")
  @visibility("read")
  clusterWitnessType?: ClusterWitnessType;

  @doc("The witness location of file share.")
  @visibility("read")
  fileShareWitnessLocation?: string;

  @doc("The username of file share.")
  @visibility("read")
  fileShareWitnessUsername?: string;

  @doc("The Cloud Witness Storage account name.")
  @visibility("read")
  cloudWitnessStorageAccountName?: string;

  @doc("The Container for cloud witness in the storage account.")
  @visibility("read")
  cloudWitnessContainerName?: string;

  @doc("The Azure service endpoint of the cloud witness storage account.")
  @visibility("read")
  cloudWitnessStorageEndpoint?: string;
}

@doc("Holds device secret either as a KeyVault reference or as an encrypted value.")
model Secret {
  @doc("Encrypted (using device public key) secret value.")
  encryptedSecret?: AsymmetricEncryptedSecret;

  @doc("Id of the Key-Vault where secret is stored (ex: secrets/AuthClientSecret/82ef4346187a4033a10d629cde07d740).")
  keyVaultId?: string;
}

@doc("Represent the secrets intended for encryption with asymmetric key pair.")
model AsymmetricEncryptedSecret {
  @doc("The value of the secret.")
  value: string;

  @doc("Thumbprint certificate used to encrypt \\\"Value\\\". If the value is unencrypted, it will be null.")
  encryptionCertThumbprint?: string;

  @doc("The algorithm used to encrypt \"Value\".")
  encryptionAlgorithm: EncryptionAlgorithm;
}

@doc("The job error information containing the list of job errors.")
model JobErrorDetails {
  @doc("The error details.")
  @visibility("read")
  errorDetails?: JobErrorItem[];

  @doc("The code intended for programmatic access.")
  @visibility("read")
  code?: string;

  @doc("The message that describes the error in detail.")
  @visibility("read")
  message?: string;
}

@doc("The job error items.")
model JobErrorItem {
  @doc("The recommended actions.")
  @visibility("read")
  recommendations?: string[];

  @doc("The code intended for programmatic access.")
  @visibility("read")
  code?: string;

  @doc("The message that describes the error in detail.")
  @visibility("read")
  message?: string;
}

@doc("The properties for the job.")
model JobProperties {
  @doc("The type of the job.")
  @visibility("read")
  jobType?: JobType;

  @doc("Current stage of the update operation.")
  @visibility("read")
  currentStage?: UpdateOperationStage;

  @doc("The download progress.")
  @visibility("read")
  downloadProgress?: UpdateDownloadProgress;

  @doc("The install progress.")
  @visibility("read")
  installProgress?: UpdateInstallProgress;

  @doc("Total number of errors encountered during the refresh process.")
  @visibility("read")
  totalRefreshErrors?: int32;

  @doc("Local share/remote container relative path to the error manifest file of the refresh.")
  @visibility("read")
  errorManifestFile?: string;

  @doc("ARM ID of the entity that was refreshed.")
  @visibility("read")
  refreshedEntityId?: string;

  @doc("If only subfolders need to be refreshed, then the subfolder path inside the share or container. (The path is empty if there are no subfolders.)")
  folder?: string;
}

@doc("Details about the download progress of update.")
model UpdateDownloadProgress {
  @doc("The download phase.")
  @visibility("read")
  downloadPhase?: DownloadPhase;

  @doc("Percentage of completion.")
  @visibility("read")
  percentComplete?: int32;

  @doc("Total bytes to download.")
  @visibility("read")
  totalBytesToDownload?: float32;

  @doc("Total bytes downloaded.")
  @visibility("read")
  totalBytesDownloaded?: float32;

  @doc("Number of updates to download.")
  @visibility("read")
  numberOfUpdatesToDownload?: int32;

  @doc("Number of updates downloaded.")
  @visibility("read")
  numberOfUpdatesDownloaded?: int32;
}

@doc("Progress details during installation of updates.")
model UpdateInstallProgress {
  @doc("Percentage completed.")
  @visibility("read")
  percentComplete?: int32;

  @doc("Number of updates to install.")
  @visibility("read")
  numberOfUpdatesToInstall?: int32;

  @doc("Number of updates installed.")
  @visibility("read")
  numberOfUpdatesInstalled?: int32;
}

@doc("The network settings of a device.")
model NetworkSettings extends ARMBaseModel {
  @doc("The properties of network settings of a device.")
  @visibility("read")
  properties?: NetworkSettingsProperties;

  @doc("Metadata pertaining to creation and last modification of NetworkSettings")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The properties of network settings.")
model NetworkSettingsProperties {
  @doc("The network adapter list on the device.")
  @visibility("read")
  networkAdapters?: NetworkAdapter[];
}

@doc("Represents the networkAdapter on a device.")
model NetworkAdapter {
  @doc("Instance ID of network adapter.")
  @visibility("read")
  adapterId?: string;

  @doc("Hardware position of network adapter.")
  @visibility("read")
  adapterPosition?: NetworkAdapterPosition;

  @doc("Logical index of the adapter.")
  @visibility("read")
  index?: int32;

  @doc("Node ID of the network adapter.")
  @visibility("read")
  nodeId?: string;

  @doc("Network adapter name.")
  @visibility("read")
  networkAdapterName?: string;

  @doc("Hardware label for the adapter.")
  @visibility("read")
  label?: string;

  @doc("MAC address.")
  @visibility("read")
  macAddress?: string;

  @doc("Link speed.")
  @visibility("read")
  linkSpeed?: int32;

  @doc("Value indicating whether this adapter is valid.")
  @visibility("read")
  status?: NetworkAdapterStatus;

  @doc("Value indicating whether this adapter is RDMA capable.")
  rdmaStatus?: NetworkAdapterRdmaStatus;

  @doc("Value indicating whether this adapter has DHCP enabled.")
  dhcpStatus?: NetworkAdapterDhcpStatus;

  @doc("The IPv4 configuration of the network adapter.")
  @visibility("read")
  ipv4Configuration?: Ipv4Config;

  @doc("The IPv6 configuration of the network adapter.")
  @visibility("read")
  ipv6Configuration?: Ipv6Config;

  @doc("The IPv6 local address.")
  @visibility("read")
  ipv6LinkLocalAddress?: string;

  @doc("The list of DNS Servers of the device.")
  @visibility("read")
  dnsServers?: string[];
}

@doc("The network adapter position.")
model NetworkAdapterPosition {
  @doc("The network group.")
  @visibility("read")
  networkGroup?: NetworkGroup;

  @doc("The port.")
  @visibility("read")
  port?: int32;
}

@doc("Details related to the IPv4 address configuration.")
model Ipv4Config {
  @doc("The IPv4 address of the network adapter.")
  @visibility("read")
  ipAddress?: string;

  @doc("The IPv4 subnet of the network adapter.")
  @visibility("read")
  subnet?: string;

  @doc("The IPv4 gateway of the network adapter.")
  @visibility("read")
  gateway?: string;
}

@doc("Details related to the IPv6 address configuration.")
model Ipv6Config {
  @doc("The IPv6 address of the network adapter.")
  @visibility("read")
  ipAddress?: string;

  @doc("The IPv6 prefix of the network adapter.")
  @visibility("read")
  prefixLength?: int32;

  @doc("The IPv6 gateway of the network adapter.")
  @visibility("read")
  gateway?: string;
}

@doc("Collection of Nodes.")
model NodeList is Azure.Core.Page<Node>;

@doc("""
Represents a single node in a Data box Edge/Gateway device
Gateway devices, standalone Edge devices and a single node cluster Edge device will all have 1 node
Multi-node Edge devices will have more than 1 nodes
""")
model Node extends ARMBaseModel {
  @doc("The properties of the node")
  @visibility("read")
  properties?: NodeProperties;
}

@doc("This class represents the nodes in a highly available cluster")
model NodeProperties {
  @doc("The current status of the individual node")
  @visibility("read")
  nodeStatus?: NodeStatus;

  @doc("Serial number of the Chassis")
  @visibility("read")
  nodeChassisSerialNumber?: string;

  @doc("Serial number of the individual node")
  @visibility("read")
  nodeSerialNumber?: string;

  @doc("Display Name of the individual node")
  @visibility("read")
  nodeDisplayName?: string;

  @doc("Friendly software version name that is currently installed on the node")
  @visibility("read")
  nodeFriendlySoftwareVersion?: string;

  @doc("HCS version that is currently installed on the node")
  @visibility("read")
  nodeHcsVersion?: string;

  @doc("Guid instance id of the node")
  @visibility("read")
  nodeInstanceId?: string;
}

@doc("Order properties.")
model OrderProperties {
  @doc("It specify the order resource id.")
  @visibility("read")
  orderId?: string;

  @doc("The contact details.")
  contactInformation: ContactDetails;

  @doc("The shipping address.")
  shippingAddress?: Address;

  @doc("Current status of the order.")
  @visibility("read")
  currentStatus?: OrderStatus;

  @doc("List of status changes in the order.")
  @visibility("read")
  orderHistory?: OrderStatus[];

  @doc("Serial number of the device.")
  @visibility("read")
  serialNumber?: string;

  @doc("Tracking information for the package delivered to the customer whether it has an original or a replacement device.")
  @visibility("read")
  deliveryTrackingInfo?: TrackingInfo[];

  @doc("Tracking information for the package returned from the customer whether it has an original or a replacement device.")
  @visibility("read")
  returnTrackingInfo?: TrackingInfo[];

  @doc("ShipmentType of the order")
  shipmentType?: ShipmentType;
}

@doc("Contains all the contact details of the customer.")
model ContactDetails {
  @doc("The contact person name.")
  contactPerson: string;

  @doc("The name of the company.")
  companyName: string;

  @doc("The phone number.")
  phone: string;

  @doc("The email list.")
  emailList: string[];
}

@doc("The shipping address of the customer.")
model Address {
  @doc("The address line1.")
  addressLine1?: string;

  @doc("The address line2.")
  addressLine2?: string;

  @doc("The address line3.")
  addressLine3?: string;

  @doc("The postal code.")
  postalCode?: string;

  @doc("The city name.")
  city?: string;

  @doc("The state name.")
  state?: string;

  @doc("The country name.")
  country: string;
}

@doc("Represents a single status change.")
model OrderStatus {
  @doc("Status of the order as per the allowed status types.")
  status: OrderState;

  @doc("Time of status update.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updateDateTime?: utcDateTime;

  @doc("Comments related to this status change.")
  comments?: string;

  @doc("Tracking information related to the state in the ordering flow")
  @visibility("read")
  trackingInformation?: TrackingInfo;

  @doc("""
Dictionary to hold generic information which is not stored
by the already existing properties
""")
  @visibility("read")
  additionalOrderDetails?: Record<string>;
}

@doc("Tracking courier information.")
model TrackingInfo {
  @doc("Serial number of the device being tracked.")
  serialNumber?: string;

  @doc("Name of the carrier used in the delivery.")
  carrierName?: string;

  @doc("Tracking ID of the shipment.")
  trackingId?: string;

  @doc("Tracking URL of the shipment.")
  trackingUrl?: string;
}

@doc("DC Access code in the case of Self Managed Shipping.")
model DCAccessCode {
  @doc("DCAccessCode properties.")
  properties?: DCAccessCodeProperties;
}

@doc("DCAccessCode Properties.")
model DCAccessCodeProperties {
  @doc("DCAccess Code for the Self Managed shipment.")
  authCode?: string;
}

@doc("Metrics properties")
model MonitoringMetricConfigurationProperties {
  @doc("The metrics configuration details")
  metricConfigurations: MetricConfiguration[];
}

@doc("Metric configuration.")
model MetricConfiguration {
  @doc("The Resource ID on which the metrics should be pushed.")
  resourceId: string;

  @doc("The MDM account to which the counters should be pushed.")
  mdmAccount?: string;

  @doc("The MDM namespace to which the counters should be pushed. This is required if MDMAccount is specified")
  metricNameSpace?: string;

  @doc("Host name for the IoT hub associated to the device.")
  counterSets: MetricCounterSet[];
}

@doc("The metric counter set")
model MetricCounterSet {
  @doc("The counters that should be collected in this set.")
  counters: MetricCounter[];
}

@doc("The metric counter")
model MetricCounter {
  @doc("The counter name.")
  name: string;

  @doc("The instance from which counter should be collected.")
  instance?: string;

  @doc("The dimension filter.")
  dimensionFilter?: MetricDimension[];

  @doc("The additional dimensions to be added to metric.")
  additionalDimensions?: MetricDimension[];
}

@doc("The metric dimension")
model MetricDimension {
  @doc("The dimension type.")
  sourceType: string;

  @doc("The dimension value.")
  sourceName: string;
}

@doc("The security settings of a device.")
model SecuritySettings extends ARMBaseModel {
  @doc("Properties of the security settings.")
  properties: SecuritySettingsProperties;
}

@doc("The properties of security settings.")
model SecuritySettingsProperties {
  @doc("Device administrator password as an encrypted string (encrypted using RSA PKCS #1) is used to sign into the  local web UI of the device. The Actual password should have at least 8 characters that are a combination of  uppercase, lowercase, numeric, and special characters.")
  deviceAdminPassword: AsymmetricEncryptedSecret;
}

@doc("The share properties.")
model ShareProperties {
  @doc("Description for the share.")
  description?: string;

  @doc("Current status of the share.")
  shareStatus: ShareStatus;

  @doc("Current monitoring status of the share.")
  monitoringStatus: MonitoringStatus;

  @doc("Azure container mapping for the share.")
  azureContainerInfo?: AzureContainerInfo;

  @doc("Access protocol to be used by the share.")
  accessProtocol: ShareAccessProtocol;

  @doc("Mapping of users and corresponding access rights on the share (required for SMB protocol).")
  userAccessRights?: UserAccessRight[];

  @doc("List of IP addresses and corresponding access rights on the share(required for NFS protocol).")
  clientAccessRights?: ClientAccessRight[];

  @doc("Details of the refresh job on this share.")
  refreshDetails?: RefreshDetails;

  @doc("Share mount point to the role.")
  @visibility("read")
  shareMappings?: MountPointMap[];

  @doc("Data policy of the share.")
  dataPolicy?: DataPolicy;
}

@doc("Azure container mapping of the endpoint.")
model AzureContainerInfo {
  @doc("ID of the storage account credential used to access storage.")
  storageAccountCredentialId: string;

  @doc("Container name (Based on the data format specified, this represents the name of Azure Files/Page blob/Block blob).")
  containerName: string;

  @doc("Storage format used for the file represented by the share.")
  dataFormat: AzureContainerDataFormat;
}

@doc("The mapping between a particular user and the access type on the SMB share.")
model UserAccessRight {
  @doc("User ID (already existing in the device).")
  userId: string;

  @doc("Type of access to be allowed for the user.")
  accessType: ShareAccessType;
}

@doc("The mapping between a particular client IP and the type of access client has on the NFS share.")
model ClientAccessRight {
  @doc("IP of the client.")
  client: string;

  @doc("Type of access to be allowed for the client.")
  accessPermission: ClientPermissionType;
}

@doc("Fields for tracking refresh job on the share or container.")
model RefreshDetails {
  @doc("If a refresh job is currently in progress on this share or container, this field indicates the ARM resource ID of that job. The field is empty if no job is in progress.")
  inProgressRefreshJobId?: string;

  @doc("Indicates the completed time for the last refresh job on this particular share or container, if any.This could be a failed job or a successful job.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCompletedRefreshJobTimeInUTC?: utcDateTime;

  @doc("Indicates the relative path of the error xml for the last refresh job on this particular share or container, if any. This could be a failed job or a successful job.")
  errorManifestFile?: string;

  @doc("Indicates the id of the last refresh job on this particular share or container,if any. This could be a failed job or a successful job.")
  lastJob?: string;
}

@doc("The share mount point.")
model MountPointMap {
  @doc("ID of the share mounted to the role VM.")
  shareId: string;

  @doc("ID of the role to which share is mounted.")
  @visibility("read")
  roleId?: string;

  @doc("Mount point for the share.")
  @visibility("read")
  mountPoint?: string;

  @doc("Mounting type.")
  @visibility("read")
  mountType?: MountType;

  @doc("Role type.")
  @visibility("read")
  roleType?: RoleTypes;
}

@doc("The storage account credential properties.")
model StorageAccountCredentialProperties {
  @doc("Alias for the storage account.")
  `alias`: string;

  @doc("Username for the storage account.")
  userName?: string;

  @doc("Encrypted storage key.")
  accountKey?: AsymmetricEncryptedSecret;

  @doc("Connection string for the storage account. Use this string if username and account key are not specified.")
  connectionString?: string;

  @doc("Signifies whether SSL needs to be enabled or not.")
  sslStatus: SSLStatus;

  @doc("Blob end point for private clouds.")
  blobDomainName?: string;

  @doc("Type of storage accessed on the storage account.")
  accountType: AccountType;

  @doc("Id of the storage account.")
  storageAccountId?: string;
}

@doc("The storage account properties.")
model StorageAccountProperties {
  @doc("Description for the storage Account.")
  description?: string;

  @doc("Current status of the storage account")
  storageAccountStatus?: StorageAccountStatus;

  @doc("Data policy of the storage Account.")
  dataPolicy: DataPolicy;

  @doc("Storage Account Credential Id")
  storageAccountCredentialId?: string;

  @doc("BlobEndpoint of Storage Account")
  @visibility("read")
  blobEndpoint?: string;

  @doc("The Container Count. Present only for Storage Accounts with DataPolicy set to Cloud.")
  @visibility("read")
  containerCount?: int32;
}

@doc("The container properties.")
model ContainerProperties {
  @doc("Current status of the container.")
  @visibility("read")
  containerStatus?: ContainerStatus;

  @doc("DataFormat for Container")
  dataFormat: AzureContainerDataFormat;

  @doc("Details of the refresh job on this container.")
  @visibility("read")
  refreshDetails?: RefreshDetails;

  @doc("The UTC time when container got created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime?: utcDateTime;
}

@doc("The request object for trigger support package.")
model TriggerSupportPackageRequest extends ARMBaseModel {
  @doc("The TriggerSupportPackageRequest properties.")
  properties: SupportPackageRequestProperties;
}

@doc("The share properties.")
model SupportPackageRequestProperties {
  @doc("MinimumTimeStamp from where logs need to be collected")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  minimumTimeStamp?: utcDateTime;

  @doc("Start of the timespan of the log collection")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  maximumTimeStamp?: utcDateTime;

  @doc("""
Type of files, which need to be included in the logs
This will contain the type of logs (Default/DefaultWithDumps/None/All/DefaultWithArchived)
or a comma separated list of log types that are required
""")
  include?: string;
}

@doc("The Data Box Edge/Gateway device extended info patch.")
model DataBoxEdgeDeviceExtendedInfoPatch {
  @doc("The Key Vault ARM Id for client secrets")
  clientSecretStoreId?: string;

  @doc("The url to access the Client Key Vault")
  clientSecretStoreUrl?: string;

  @doc("The name for Channel Integrity Key stored in the Client Key Vault")
  channelIntegrityKeyName?: string;

  @doc("The version of Channel Integrity Key stored in the Client Key Vault")
  channelIntegrityKeyVersion?: string;

  @doc("For changing or to initiate the resync to key-vault set the status to KeyVaultSyncPending, rest of the status will not be applicable.")
  syncStatus?: KeyVaultSyncStatus;
}

@doc("Details about ongoing updates and availability of updates on the device.")
model UpdateSummary extends ARMBaseModel {
  @doc("The device update information summary.")
  properties?: UpdateSummaryProperties;

  @doc("Metadata pertaining to creation and last modification of UpdateSummary")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The device update information summary.")
model UpdateSummaryProperties {
  @doc("The current version of the device in format: 1.2.17312.13.\",")
  deviceVersionNumber?: string;

  @doc("The current version of the device in text format.")
  friendlyDeviceVersionName?: string;

  @doc("The last time when a scan was done on the device.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deviceLastScannedDateTime?: utcDateTime;

  @doc("The time when the last scan job was completed (success/cancelled/failed) on the appliance.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCompletedScanJobDateTime?: utcDateTime;

  @doc("Time when the last scan job is successfully completed.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulScanJobTime?: utcDateTime;

  @doc("The time when the last Download job was completed (success/cancelled/failed) on the appliance.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCompletedDownloadJobDateTime?: utcDateTime;

  @doc("JobId of the last ran download job.(Can be success/cancelled/failed)")
  @visibility("read")
  lastCompletedDownloadJobId?: string;

  @doc("JobStatus of the last ran download job.")
  @visibility("read")
  lastDownloadJobStatus?: JobStatus;

  @doc("The time when the Last Install job was completed successfully on the appliance")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulInstallJobDateTime?: utcDateTime;

  @doc("The time when the last Install job was completed (success/cancelled/failed) on the appliance.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCompletedInstallJobDateTime?: utcDateTime;

  @doc("JobId of the last ran install job.(Can be success/cancelled/failed)")
  @visibility("read")
  lastCompletedInstallJobId?: string;

  @doc("JobStatus of the last ran install job.")
  @visibility("read")
  lastInstallJobStatus?: JobStatus;

  @doc("The number of updates available for the current device version as per the last device scan.")
  @visibility("read")
  totalNumberOfUpdatesAvailable?: int32;

  @doc("The total number of items pending download.")
  @visibility("read")
  totalNumberOfUpdatesPendingDownload?: int32;

  @doc("The total number of items pending install.")
  @visibility("read")
  totalNumberOfUpdatesPendingInstall?: int32;

  @doc("Indicates if updates are available and at least one of the updates needs a reboot.")
  @visibility("read")
  rebootBehavior?: InstallRebootBehavior;

  @doc("The current update operation.")
  @visibility("read")
  ongoingUpdateOperation?: UpdateOperation;

  @doc("The job ID of the download job in progress.")
  @visibility("read")
  inProgressDownloadJobId?: string;

  @doc("The job ID of the install job in progress.")
  @visibility("read")
  inProgressInstallJobId?: string;

  @doc("The time when the currently running download (if any) started.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  inProgressDownloadJobStartedDateTime?: utcDateTime;

  @doc("The time when the currently running install (if any) started.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  inProgressInstallJobStartedDateTime?: utcDateTime;

  @doc("The list of updates available for install.")
  @visibility("read")
  updateTitles?: string[];

  @doc("The list of updates available for install.")
  @visibility("read")
  updates?: UpdateDetails[];

  @doc("The total size of updates available for download in bytes.")
  @visibility("read")
  totalUpdateSizeInBytes?: float32;

  @doc("The total time in Minutes")
  @visibility("read")
  totalTimeInMinutes?: int32;
}

@doc("Update Specific attributes")
model UpdateDetails {
  @doc("Title of the Update")
  updateTitle?: string;

  @doc("Size of the update(In Bytes)")
  updateSize?: float32;

  @doc("Type of the Update")
  updateType?: UpdateType;

  @doc("Target Version number")
  targetVersion?: string;

  @doc("Friendly Version Number")
  friendlyVersionNumber?: string;

  @doc("Estimated Install Time for the update")
  estimatedInstallTimeInMins?: int32;

  @doc("Indicates if updates are available and at least one of the updates needs a reboot.")
  rebootBehavior?: InstallRebootBehavior;

  @doc("Impact of Installing an updateType")
  installationImpact?: InstallationImpact;

  @doc("Status of the update.")
  status?: UpdateStatus;
}

@doc("The upload certificate request.")
model UploadCertificateRequest {
  @doc("The Base 64 encoded certificate raw data.")
  properties: RawCertificateData;
}

@doc("Raw Certificate Data.")
model RawCertificateData {
  @doc("The authentication type.")
  authenticationType?: AuthenticationType;

  @doc("The base64 encoded certificate raw data.")
  certificate: string;
}

@doc("The upload registration certificate response.")
model UploadCertificateResponse {
  @doc("Specifies authentication type.")
  authType?: AuthenticationType;

  @doc("The resource ID of the Data Box Edge/Gateway device.")
  @visibility("read")
  resourceId?: string;

  @doc("Azure Active Directory tenant authority.")
  @visibility("read")
  aadAuthority?: string;

  @doc("Azure Active Directory tenant ID.")
  @visibility("read")
  aadTenantId?: string;

  @doc("Azure Active Directory service principal client ID.")
  @visibility("read")
  servicePrincipalClientId?: string;

  @doc("Azure Active Directory service principal object ID.")
  @visibility("read")
  servicePrincipalObjectId?: string;

  @doc("The azure management endpoint audience.")
  @visibility("read")
  azureManagementEndpointAudience?: string;

  @doc("Identifier of the target resource that is the recipient of the requested token.")
  @visibility("read")
  aadAudience?: string;
}

@doc("The user properties.")
model UserProperties {
  @doc("The password details.")
  encryptedPassword?: AsymmetricEncryptedSecret;

  @doc("List of shares that the user has rights on. This field should not be specified during user creation.")
  @visibility("read")
  shareAccessRights?: ShareAccessRight[];

  @doc("Type of the user.")
  userType: UserType;
}

@doc("Specifies the mapping between this particular user and the type of access he has on shares on this device.")
model ShareAccessRight {
  @doc("The share ID.")
  shareId: string;

  @doc("Type of access to be allowed on the share for this user.")
  accessType: ShareAccessType;
}

@doc("Arc Addon.")
model ArcAddon extends Addon {
  @doc("Properties specific to Arc addon.")
  properties: ArcAddonProperties;

  @doc("Addon type.")
  kind: "ArcForKubernetes";
}

@doc("Arc addon properties.")
model ArcAddonProperties {
  @doc("Arc resource subscription Id")
  subscriptionId: string;

  @doc("Arc resource group name")
  resourceGroupName: string;

  @doc("Arc resource Name")
  resourceName: string;

  @doc("Arc resource location")
  resourceLocation: string;

  @doc("Arc resource version")
  @visibility("read")
  version?: string;

  @doc("Host OS supported by the Arc addon.")
  @visibility("read")
  hostPlatform?: PlatformType;

  @doc("Platform where the runtime is hosted.")
  @visibility("read")
  hostPlatformType?: HostPlatformType;

  @doc("Addon Provisioning State")
  @visibility("read")
  provisioningState?: AddonState;
}

@doc("Authentication mechanism for IoT devices.")
model Authentication {
  @doc("Symmetric key for authentication.")
  symmetricKey?: SymmetricKey;
}

@doc("Symmetric key for authentication.")
model SymmetricKey {
  @doc("Connection string based on the symmetric key.")
  connectionString?: AsymmetricEncryptedSecret;
}

@doc("""
The preview of Virtual Machine Cloud Management from the Azure supports deploying and managing VMs on your Azure Stack Edge device from Azure Portal. 
For more information, refer to: https://docs.microsoft.com/en-us/azure/databox-online/azure-stack-edge-gpu-virtual-machine-overview
By using this feature, you agree to the preview legal terms. See the https://azure.microsoft.com/en-us/support/legal/preview-supplemental-terms/ for additional details.
""")
model CloudEdgeManagementRole extends Role {
  @doc("Properties specific to CloudEdgeManagementRole role.")
  properties?: CloudEdgeManagementRoleProperties;

  @doc("Role type.")
  kind: "CloudEdgeManagement";
}

@doc("CloudEdgeManagement Role properties.")
model CloudEdgeManagementRoleProperties {
  @doc("Local Edge Management Status")
  @visibility("read")
  localManagementStatus?: RoleStatus;

  @doc("Edge Profile of the resource")
  @visibility("read")
  edgeProfile?: EdgeProfile;

  @doc("Role status.")
  roleStatus: RoleStatus;
}

@doc("Cni configuration")
model CniConfig {
  @doc("Cni type")
  @visibility("read")
  type?: string;

  @doc("Cni version")
  @visibility("read")
  version?: string;

  @doc("Pod Subnet")
  @visibility("read")
  podSubnet?: string;

  @doc("Service subnet")
  @visibility("read")
  serviceSubnet?: string;
}

@doc("Compute infrastructure Resource")
model ComputeResource {
  @doc("Processor count")
  processorCount: int32;

  @doc("Memory in GB")
  memoryInGB: int32;
}

@doc("Resource Move details")
model DataBoxEdgeMoveRequest {
  @doc("Target resource group ARMId")
  targetResourceGroup: string;

  @doc("List of resources to be moved")
  resources: string[];
}

@doc("Etcd configuration")
model EtcdInfo {
  @doc("Etcd type")
  @visibility("read")
  type?: string;

  @doc("Etcd version")
  @visibility("read")
  version?: string;
}

@doc("Trigger details.")
model FileEventTrigger extends Trigger {
  @doc("File trigger properties.")
  properties: FileTriggerProperties;

  @doc("Trigger Kind.")
  kind: "FileEvent";
}

@doc("File trigger properties.")
model FileTriggerProperties {
  @doc("File event source details.")
  sourceInfo: FileSourceInfo;

  @doc("Role sink info.")
  sinkInfo: RoleSinkInfo;

  @doc("A custom context tag typically used to correlate the trigger against its usage. For example, if a periodic timer trigger is intended for certain specific IoT modules in the device, the tag can be the name or the image URL of the module.")
  @maxLength(192)
  customContextTag?: string;
}

@doc("File source details.")
model FileSourceInfo {
  @doc("File share ID.")
  shareId: string;
}

@doc("Compute role against which events will be raised.")
model RoleSinkInfo {
  @doc("Compute role ID.")
  roleId: string;
}

@doc("Image repository credential.")
model ImageRepositoryCredential {
  @doc("Image repository url (e.g.: mcr.microsoft.com).")
  imageRepositoryUrl: string;

  @doc("Repository user name.")
  userName: string;

  @doc("Repository user password.")
  password?: AsymmetricEncryptedSecret;
}

@doc("IoT Addon.")
model IoTAddon extends Addon {
  @doc("Properties specific to IOT addon.")
  properties: IoTAddonProperties;

  @doc("Addon type.")
  kind: "IotEdge";
}

@doc("IoT addon properties.")
model IoTAddonProperties {
  @doc("IoT device metadata to which appliance needs to be connected.")
  ioTDeviceDetails: IoTDeviceInfo;

  @doc("IoT edge device to which the IoT Addon needs to be configured.")
  ioTEdgeDeviceDetails: IoTDeviceInfo;

  @doc("Version of IoT running on the appliance.")
  @visibility("read")
  version?: string;

  @doc("Host OS supported by the IoT addon.")
  @visibility("read")
  hostPlatform?: PlatformType;

  @doc("Platform where the runtime is hosted.")
  @visibility("read")
  hostPlatformType?: HostPlatformType;

  @doc("Addon Provisioning State")
  @visibility("read")
  provisioningState?: AddonState;
}

@doc("Metadata of IoT device/IoT Edge device to be configured.")
model IoTDeviceInfo {
  @doc("ID of the IoT device/edge device.")
  deviceId: string;

  @doc("Host name for the IoT hub associated to the device.")
  ioTHostHub: string;

  @doc("Id for the IoT hub associated to the device.")
  ioTHostHubId?: string;

  @doc("Encrypted IoT device/IoT edge device connection string.")
  authentication?: Authentication;
}

@doc("IoT edge agent details is optional, this will be used for download system Agent module while bootstrapping IoT Role if specified.")
model IoTEdgeAgentInfo {
  @doc("Name of the IoT edge agent image.")
  imageName: string;

  @doc("Image Tag.")
  tag: string;

  @doc("Image repository details.")
  imageRepository?: ImageRepositoryCredential;
}

@doc("Compute role.")
model IoTRole extends Role {
  @doc("Properties specific to IoT role.")
  properties?: IoTRoleProperties;

  @doc("Role type.")
  kind: "IOT";
}

@doc("IoT role properties.")
model IoTRoleProperties {
  @doc("Host OS supported by the IoT role.")
  hostPlatform: PlatformType;

  @doc("IoT device metadata to which data box edge device needs to be connected.")
  ioTDeviceDetails: IoTDeviceInfo;

  @doc("IoT edge device to which the IoT role needs to be configured.")
  ioTEdgeDeviceDetails: IoTDeviceInfo;

  @doc("Mount points of shares in role(s).")
  shareMappings?: MountPointMap[];

  @doc("Iot edge agent details to download the agent and bootstrap iot runtime.")
  ioTEdgeAgentInfo?: IoTEdgeAgentInfo;

  @doc("Platform where the Iot runtime is hosted.")
  @visibility("read")
  hostPlatformType?: HostPlatformType;

  @doc("Resource allocation")
  computeResource?: ComputeResource;

  @doc("Role status.")
  roleStatus: RoleStatus;
}

@doc("Kubernetes cluster configuration")
model KubernetesClusterInfo {
  @doc("Etcd configuration")
  @visibility("read")
  etcdInfo?: EtcdInfo;

  @doc("Kubernetes cluster nodes")
  @visibility("read")
  nodes?: NodeInfo[];

  @doc("Kubernetes cluster version")
  version: string;
}

@doc("Kubernetes node info")
model NodeInfo {
  @doc("Node name.")
  @visibility("read")
  name?: string;

  @doc("Node type - Master/Worker")
  @visibility("read")
  type?: KubernetesNodeType;

  @doc("IP Configuration of the Kubernetes node.")
  ipConfiguration?: KubernetesIPConfiguration[];
}

@doc("Kubernetes node IP configuration")
model KubernetesIPConfiguration {
  @doc("Port of the Kubernetes node.")
  @visibility("read")
  port?: string;

  @doc("IP address of the Kubernetes node.")
  ipAddress?: string;
}

@doc("""
The limited preview of Kubernetes Cluster Management from the Azure supports:
1. Using a simple turn-key option in Azure Portal, deploy a Kubernetes cluster on your Azure Stack Edge device. 
2. Configure Kubernetes cluster running on your device with Arc enabled Kubernetes with a click of a button in the Azure Portal. 
 Azure Arc enables organizations to view, manage, and govern their on-premises Kubernetes clusters using the Azure Portal, command line tools, and APIs.
3. Easily configure Persistent Volumes using SMB and NFS shares for storing container data. 
 For more information, refer to the document here: https://databoxupdatepackages.blob.core.windows.net/documentation/Microsoft-Azure-Stack-Edge-K8-Cloud-Management-20210323.pdf 
 Or Demo: https://databoxupdatepackages.blob.core.windows.net/documentation/Microsoft-Azure-Stack-Edge-K8S-Cloud-Management-20210323.mp4
 By using this feature, you agree to the preview legal terms. See the https://azure.microsoft.com/en-us/support/legal/preview-supplemental-terms/
""")
model KubernetesRole extends Role {
  @doc("Properties specific to Kubernetes role.")
  properties?: KubernetesRoleProperties;

  @doc("Role type.")
  kind: "Kubernetes";
}

@doc("Kubernetes role properties.")
model KubernetesRoleProperties {
  @doc("Host OS supported by the Kubernetes role.")
  hostPlatform: PlatformType;

  @doc("State of Kubernetes deployment")
  @visibility("read")
  provisioningState?: KubernetesState;

  @doc("Platform where the runtime is hosted.")
  @visibility("read")
  hostPlatformType?: HostPlatformType;

  @doc("Kubernetes cluster configuration")
  kubernetesClusterInfo: KubernetesClusterInfo;

  @doc("Kubernetes role resources")
  kubernetesRoleResources: KubernetesRoleResources;

  @doc("Role status.")
  roleStatus: RoleStatus;
}

@doc("Kubernetes role resources")
model KubernetesRoleResources {
  @doc("Kubernetes role storage resource")
  storage?: KubernetesRoleStorage;

  @doc("Kubernetes role compute resource")
  compute: KubernetesRoleCompute;

  @doc("Kubernetes role network resource")
  @visibility("read")
  network?: KubernetesRoleNetwork;
}

@doc("Kubernetes role storage resource")
model KubernetesRoleStorage {
  @doc("Kubernetes storage class info.")
  @visibility("read")
  storageClasses?: KubernetesRoleStorageClassInfo[];

  @doc("Mount points of shares in role(s).")
  endpoints?: MountPointMap[];
}

@doc("Kubernetes storage class info.")
model KubernetesRoleStorageClassInfo {
  @doc("Storage class name.")
  @visibility("read")
  name?: string;

  @doc("Storage class type.")
  @visibility("read")
  type?: string;

  @doc("If provisioned storage is posix compliant.")
  @visibility("read")
  posixCompliant?: PosixComplianceStatus;
}

@doc("Kubernetes role compute resource")
model KubernetesRoleCompute {
  @doc("VM profile")
  vmProfile: string;

  @doc("Memory in bytes")
  @visibility("read")
  memoryInBytes?: int32;

  @doc("Processor count")
  @visibility("read")
  processorCount?: int32;
}

@doc("Kubernetes role network resource")
model KubernetesRoleNetwork {
  @doc("Cni configuration")
  @visibility("read")
  cniConfig?: CniConfig;

  @doc("Load balancer configuration")
  @visibility("read")
  loadBalancerConfig?: LoadBalancerConfig;
}

@doc("Load balancer configuration")
model LoadBalancerConfig {
  @doc("Load balancer type")
  @visibility("read")
  type?: string;

  @doc("Load balancer version")
  @visibility("read")
  version?: string;
}

@doc("MEC role.")
model MECRole extends Role {
  @doc("Properties specific to MEC role.")
  properties?: MECRoleProperties;

  @doc("Role type.")
  kind: "MEC";
}

@doc("MEC role properties.")
model MECRoleProperties {
  @doc("Activation key of the MEC.")
  connectionString?: AsymmetricEncryptedSecret;

  @doc("Controller Endpoint.")
  controllerEndpoint?: string;

  @doc("Unique Id of the Resource.")
  resourceUniqueId?: string;

  @doc("Role status.")
  roleStatus: RoleStatus;
}

@doc("Trigger details.")
model PeriodicTimerEventTrigger extends Trigger {
  @doc("Periodic timer trigger properties.")
  properties: PeriodicTimerProperties;

  @doc("Trigger Kind.")
  kind: "PeriodicTimerEvent";
}

@doc("Periodic timer trigger properties.")
model PeriodicTimerProperties {
  @doc("Periodic timer details.")
  sourceInfo: PeriodicTimerSourceInfo;

  @doc("Role Sink information.")
  sinkInfo: RoleSinkInfo;

  @doc("A custom context tag typically used to correlate the trigger against its usage. For example, if a periodic timer trigger is intended for certain specific IoT modules in the device, the tag can be the name or the image URL of the module.")
  @maxLength(192)
  customContextTag?: string;
}

@doc("Periodic timer event source.")
model PeriodicTimerSourceInfo {
  @doc("The time of the day that results in a valid trigger. Schedule is computed with reference to the time specified upto seconds. If timezone is not specified the time will considered to be in device timezone. The value will always be returned as UTC time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime: utcDateTime;

  @doc("Periodic frequency at which timer event needs to be raised. Supports daily, hourly, minutes, and seconds.")
  schedule: string;

  @doc("Topic where periodic events are published to IoT device.")
  topic?: string;
}
