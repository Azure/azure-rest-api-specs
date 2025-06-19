import "./LiftrBase.Storage/main.tsp";
import "@typespec/openapi";

@armProviderNamespace
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@useLibraryNamespace(LiftrBase.Storage)
@service(#{ title: "PureStorage.Block" })
@versioned(PureStorage.Block.Versions)
namespace PureStorage.Block;

using Azure.ResourceManager;
using LiftrBase;
using LiftrBase.Storage;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@doc("Supported versions for PureStorage.Block.")
enum Versions {
  @doc("Version 1 preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v1_preview)
  @useDependency(LiftrBase.Storage.Versions.v1_preview)
  v1_preview: "2024-10-01-preview",

  @doc("Version 2 preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v2_preview)
  @useDependency(LiftrBase.Storage.Versions.v1_preview)
  v2_preview: "2024-11-01-preview",

  @doc("Version 1 stable")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v1_stable)
  @useDependency(LiftrBase.Storage.Versions.v1_preview)
  v1_stable: "2024-11-01",
}

interface Operations extends Azure.ResourceManager.Operations {}

alias BaseResourceProperties = LiftrBase.BaseResourceProperties;
alias ReservationProperties = LiftrBase.Storage.ReservationProperties<BaseResourceProperties>;
alias Reservation = LiftrBase.Storage.Reservation<ReservationProperties>;

@armResourceOperations
interface Reservations
  extends LiftrBase.Storage.Reservations<Reservation, ReservationProperties> {
  @doc("Limits constraining certain resource properties.")
  @armResourceAction(Reservation)
  @action("getResourceLimits")
  @post
  getResourceLimits(
    ...ResourceInstanceParameters<Reservation>,
  ): ArmResponse<LimitDetails> | ErrorResponse;

  @added(Versions.v2_preview)
  @doc("Provides various statistics about resources billed via given reservation.")
  @armResourceAction(Reservation)
  @action("getBillingStatus")
  @post
  getBillingStatus(
    ...ResourceInstanceParameters<Reservation>,
  ): ArmResponse<ReservationBillingStatus> | ErrorResponse;

  @added(Versions.v2_preview)
  @doc("Provides a summarized report along with actions for resources billed via given reservation")
  @armResourceAction(Reservation)
  @action("getBillingReport")
  @post
  getBillingReport(
    ...ResourceInstanceParameters<Reservation>,
  ): ArmResponse<ReservationBillingUsageReport> | ErrorResponse;
}

@added(Versions.v2_preview)
@doc("Represents a billing usage report, including overall status and detailed properties")
model ReservationBillingUsageReport {
  @doc("Latest formatted billing report for this reservation")
  timestamp: string;

  @doc("A list of detailed billing usage properties")
  @identifiers(#[])
  billingUsageProperties: BillingUsageProperty[];

  @doc("Overall status message of the billing usage report")
  overallStatusMessage: string;
}

@added(Versions.v2_preview)
@doc("Represents an individual billing usage property")
model BillingUsageProperty {
  @doc("Unique identifier for the billing usage property")
  propertyId: string;

  @doc("Name of the billing usage property")
  propertyName: string;

  @doc("Current value of the billing usage property")
  currentValue: string;

  @doc("Previous value of the billing usage property")
  previousValue?: string;

  @doc("Severity level of the usage")
  severity: UsageSeverity;

  @doc("Status message for the billing usage against a property")
  statusMessage?: string;

  @doc("Optional list of sub-properties providing additional details")
  @identifiers(#[])
  subProperties?: BillingUsageProperty[];
}

@added(Versions.v2_preview)
@doc("Severity levels for billing usage properties")
union UsageSeverity {
  @doc("Indicates an alert condition")
  ALERT: "alert",

  @doc("Provides informational details")
  INFORMATION: "information",

  @doc("Indicates a warning condition")
  WARNING: "warning",

  @doc("Indicates no severity")
  NONE: "none",

  string,
}

@added(Versions.v2_preview)
@doc("Latest billing status for this reservation")
model ReservationBillingStatus {
  @doc("Timestamp for the latest update of this billing status, in RFC 3339 format")
  timestamp: string;

  @doc("Total used capacity as reported by associated storage pools. In bytes")
  totalUsedCapacityReported: int64;

  @doc("How many associated storage pools reported low data reduction ratio (DRR)")
  lowDrrPoolCount: int32;

  @doc("Weighted average of the data-reduction ratio for all associated pools")
  drrWeightedAverage: float64;

  @doc("The sum of total used capacity for all pools with low DRR, if the DRR penalty applies. In bytes")
  totalNonReducibleReported: int64;

  @doc("Extra capacity added because of low DRR storage pools; In bytes")
  extraUsedCapacityNonReducible: int64;

  @doc("Extra capacity added when rounding up low-usage pools to 30TiB. In bytes")
  extraUsedCapacityLowUsageRounding: int64;

  @doc("Extra capacity discounted due to plan forgiving some low-DRR usage. In bytes")
  extraUsedCapacityNonReduciblePlanDiscount: int64;

  @doc("Total used capacity actually billed. In bytes")
  totalUsedCapacityBilled: int64;

  @doc("Total used capacity included in plan. In bytes")
  totalUsedCapacityIncludedPlan: int64;

  @doc("Total used capacity reported at on-demand price. In bytes")
  totalUsedCapacityOverage: int64;

  @doc("The sum of all performance settings across the pools under this reservation. In MB per second")
  totalPerformanceReported: int64;

  @doc("Total performance amount included in plan. In bytes per second")
  totalPerformanceIncludedPlan: int64;

  @doc("Total performance amount reported at on-demand price. In MB per second")
  totalPerformanceOverage: int64;
}

@doc("Storage pool resource")
model StoragePool is TrackedResource<StoragePoolProperties> {
  @doc("Name of the storage pool")
  @segment("storagePools")
  @key("storagePoolName")
  @visibility(Lifecycle.Read)
  @path
  @minLength(1)
  @maxLength(127)
  @pattern("^[a-zA-Z0-9\\-_]{1,127}$")
  name: string;

  ...ManagedServiceIdentityProperty;
}

@doc("Properties of a storage pool")
model StoragePoolProperties {
  @doc("Pure Storage's internal ID of the storage pool")
  @visibility(Lifecycle.Read)
  storagePoolInternalId?: string;

  @doc("Azure Availability Zone the Pool is located in")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  availabilityZone: string;

  @doc("Network properties of the storage pool")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vnetInjection: VnetInjection;

  @doc("How long a destroyed object is kept before being eradicated, in seconds")
  @visibility(Lifecycle.Read)
  dataRetentionPeriod?: int64;

  @doc("Total bandwidth provisioned for the pool, in MB/s")
  provisionedBandwidthMbPerSec: int64;

  @doc("Total I/O operations per second (IOPS) provisioned for the pool")
  @visibility(Lifecycle.Read)
  provisionedIops?: int64;

  @doc("AVS connection state summary")
  @visibility(Lifecycle.Read)
  avs?: AzureVmwareService;

  @doc("Provisioning state of the resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Azure resource ID of the Pure Storage Cloud service (reservation resource) this storage pool belongs to")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  reservationResourceId: string;
}

@doc("Network in which the storage pool will be made available")
model VnetInjection {
  @doc("Azure resource ID of the Virtual Network subnet where the storage pool will be connected")
  subnetId: string;

  @doc("Azure resource ID of the Virtual Network in which the subnet is located")
  vnetId: string;
}

@doc("Connected AVS status")
model AzureVmwareService {
  @doc("If true, an AVS SDDC is successfully connected to the storage pool")
  avsEnabled: boolean;

  @doc("Azure resource ID of the AVS SDDC the storage pool is connected to")
  sddcResourceId?: string;

  @removed(Versions.v1_preview)
  @doc("Immutable identifier for the vSpherePlugin provided by Pure Storage. The value is available if the vSpherePlugin has been enabled for the storage pool.")
  vSpherePluginKey?: string;
}

@armResourceOperations
interface StoragePools {
  @doc("Get a storage pool")
  get is ArmResourceRead<StoragePool>;
  @doc("Create a storage pool")
  create is ArmResourceCreateOrUpdateAsync<StoragePool>;
  @doc("Update a storage pool")
  update is ArmCustomPatchAsync<
    StoragePool,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      StoragePool,
      StoragePoolProperties
    >
  >;
  @doc("Delete a storage pool")
  delete is ArmResourceDeleteWithoutOkAsync<StoragePool>;
  @doc("List storage pools by resource group")
  listByResourceGroup is ArmResourceListByParent<StoragePool>;
  @doc("List storage pools by Azure subscription ID")
  listBySubscription is ArmListBySubscription<StoragePool>;

  @doc("Retrieve health metrics of a storage pool")
  @armResourceAction(StoragePool)
  @action("getHealthStatus")
  @post
  getHealthStatus(
    ...ResourceInstanceParameters<StoragePool>,
  ): ArmResponse<HealthResponse> | ErrorResponse;

  @doc("Returns current information about an on-going connection to an AVS instance")
  @armResourceAction(StoragePool)
  @action("getAvsConnection")
  @post
  getAvsConnection(
    ...ResourceInstanceParameters<StoragePool>,
  ): ArmResponse<AvsConnection> | ErrorResponse;

  @doc("Returns the status of the storage pool connection to AVS")
  @armResourceAction(StoragePool)
  @action("getAvsStatus")
  @post
  getAvsStatus(
    ...ResourceInstanceParameters<StoragePool>,
  ): ArmResponse<AvsStatus> | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO - Migrate to LRO pattern"
  @doc("Initiate a connection between the storage pool and a specified AVS SDDC resource")
  @armResourceAction(StoragePool)
  @action("enableAvsConnection")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "azure-async-operation" }
  )
  @post
  enableAvsConnection(
    ...ResourceInstanceParameters<StoragePool>,

    @doc("Storage pool EnableAvsConnection properties")
    @body
    properties: StoragePoolEnableAvsConnectionPost,
  ): ArmAcceptedLroResponse<
    "Resource Operation accepted",
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO - Migrate to LRO pattern"
  @doc("Disable the existing AVS connection")
  @armResourceAction(StoragePool)
  @action("disableAvsConnection")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "azure-async-operation" }
  )
  @post
  disableAvsConnection(
    ...ResourceInstanceParameters<StoragePool>,
  ): ArmAcceptedLroResponse<
    "Resource Operation accepted",
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO - Migrate to LRO pattern"
  @doc("Finalize an already started AVS connection to a specific AVS SDDC")
  @armResourceAction(StoragePool)
  @action("finalizeAvsConnection")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "azure-async-operation" }
  )
  @post
  finalizeAvsConnection(
    ...ResourceInstanceParameters<StoragePool>,

    @doc("Storage pool FinalizeAvsConnection properties")
    @body
    properties: StoragePoolFinalizeAvsConnectionPost,
  ): ArmAcceptedLroResponse<
    "Resource Operation accepted",
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO - Migrate to LRO pattern"
  @doc("Test and repair, if needed, all configuration elements of the storage pool connection to the AVS instance")
  @armResourceAction(StoragePool)
  @action("repairAvsConnection")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "azure-async-operation" }
  )
  @post
  repairAvsConnection(
    ...ResourceInstanceParameters<StoragePool>,
  ): ArmAcceptedLroResponse<
    "Resource Operation accepted",
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;
}

@doc("Limits constraining certain resource properties")
model LimitDetails {
  @doc("Limits used for storage pool resources")
  storagePool: StoragePoolLimits;

  @doc("Limits used for volume resources")
  volume: VolumeLimits;

  @doc("internal")
  protectionPolicy: ProtectionPolicyLimits;

  @doc("internal")
  performancePolicy: PerformancePolicyLimits;
}

@doc("Limits used for storage pool creation")
model StoragePoolLimits {
  @doc("Allowed provisioned bandwidth range for a storage pool, in MB/s")
  provisionedBandwidthMbPerSec: RangeLimits;

  @doc("Allowed provisioned IOPS range for a storage pool, as a number of operations")
  provisionedIops: RangeLimits;

  @doc("List of physical availability zones in the region in which storage pools can be deployed; some Azure regions do not support the necessary resources in all availability zones")
  physicalAvailabilityZones: string[];
}
@doc("Limits used for volumes")
model VolumeLimits {
  @doc("Provisioned size limits for a volume, in bytes")
  provisionedSize: RangeLimits;
}

@doc("internal")
model ProtectionPolicyLimits {
  @doc("internal")
  frequency: RangeLimits;

  @doc("internal")
  retention: RangeLimits;
}

@doc("internal")
model PerformancePolicyLimits {
  @doc("internal")
  iopsLimit: RangeLimits;

  @doc("internal")
  bandwidthLimit: RangeLimits;
}

@doc("Minimum and maximum values for a property")
model RangeLimits {
  @doc("Minimum value of the property")
  min: int64;

  @doc("Maximum value of the property")
  max: int64;
}

@doc("Health information for a storage pool")
model HealthResponse {
  @doc("Health metrics")
  health: HealthDetails;

  @doc("List of health alerts")
  @identifiers(#[])
  alerts: Alert[];
}

@doc("Health metrics for a storage pool")
model HealthDetails {
  @doc("How full the pool is right now, in %, compared to the maximum size it can grow to; estimated based on current usage and data reduction ratio")
  usedCapacityPercentage: float64;

  @doc("Bandwidth usage metrics")
  bandwidthUsage: BandwidthUsage;

  @doc("IOPS usage metrics")
  iopsUsage: IopsUsage;

  @doc("Storage space usage")
  space: Space;

  @doc("Data reduction ratio achieved on this pool")
  dataReductionRatio: float64;

  @doc("Estimated maximum capacity of the pool, in bytes, based on current usage and data reduction ratio")
  estimatedMaxCapacity: int64;
}

@doc("Bandwidth usage metrics")
model BandwidthUsage {
  @doc("Number of bytes written and read per second (maximum value over the last 10 minutes)")
  current: int64;

  @doc("Bandwidth value currently provisioned for the storage pool, in MB/s")
  provisioned: int64;

  @doc("Maximum bandwidth value that can be provisioned for the storage pool")
  max: int64;
}

@doc("IOPS usage metrics")
model IopsUsage {
  @doc("Current number of IOPS (maximum value over the last 10 minutes)")
  current: int64;

  @doc("IOPS value currently provisioned for the storage pool")
  provisioned: int64;

  @doc("Maximum IOPS value that can be provisioned for the storage pool")
  max: int64;
}

@doc("Health alerts")
model Alert {
  @doc("Severity level")
  level: AlertLevel;

  @doc("A short description of the alert")
  message: string;
}

@doc("Severity level of the alert")
union AlertLevel {
  /** Information level */
  Info: "info",

  /** Warning level */
  Warning: "warning",

  /** Error level */
  Error: "error",

  string,
}

@doc("Initialization handle used to configure the AVS SDDC to communicate with the storage pool")
model ServiceInitializationHandle {
  @doc("Azure resource ID of the AVS SDDC the pool is connecting to")
  sddcResourceId?: string;

  @doc("Requested service account username")
  serviceAccountUsername?: string;
}

@doc("Transient information about an on-going connection to an AVS instance")
model AvsConnection {
  @doc("Indicates whether service initialization is complete")
  serviceInitializationCompleted: boolean;

  @doc("Encoded service account credentials alongside connection information")
  serviceInitializationHandleEnc?: string;

  @doc("Explicit service account credentials")
  serviceInitializationHandle?: ServiceInitializationHandle;
}

@doc("Status of storage pool / AVS connection")
model AvsStatus {
  @doc("If true, an AVS connection has been successfully completed")
  avsEnabled: boolean;

  @doc("Human-readable current AVS connection status")
  currentConnectionStatus: string;

  @doc("Azure resource ID of the AVS SDDC the pool is connected to")
  sddcResourceId?: string;
}

@doc("EnableAvsConnection payload information")
model StoragePoolEnableAvsConnectionPost {
  @doc("Azure resource ID of the AVS SDDC to connect to")
  sddcResourceId: string;
}

@doc("Explicit service initialization data")
model ServiceInitializationData {
  @doc("Service account username")
  serviceAccountUsername?: string;

  @doc("Service account password")
  @secret
  serviceAccountPassword?: string;

  @doc("AVS instance's vSphere IP address")
  vSphereIp?: string;

  @doc("AVS instance's vSphere certificate")
  vSphereCertificate?: string;
}

@doc("FinalizeAvsConnection payload information, either encoded or explicit")
model StoragePoolFinalizeAvsConnectionPost {
  @doc("Encoded AVS connection information")
  serviceInitializationDataEnc?: string;

  @doc("Explicit AVS connection information")
  serviceInitializationData?: ServiceInitializationData;
}

@doc("AVS storage container resource type, representing a VMware storage container in a storage pool, which can be associated to and mounted as a datastore")
@parentResource(StoragePool)
model AvsStorageContainer is ProxyResource<AvsStorageContainerProperties> {
  @doc("Name of the storage container")
  @segment("avsStorageContainers")
  @key("storageContainerName")
  @visibility(Lifecycle.Read)
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-]{0,62}[a-zA-Z0-9]$")
  name: string;
}

@doc("AVS storage container properties")
model AvsStorageContainerProperties {
  @doc("Storage space usage")
  @visibility(Lifecycle.Read)
  space?: Space;

  @doc("Name of the storage used.")
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-]{0,62}[a-zA-Z0-9]$")
  @visibility(Lifecycle.Read)
  @removed(Versions.v2_preview)
  storageName?: string;

  @doc("Name of the storage container")
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-]{0,62}[a-zA-Z0-9]$")
  @visibility(Lifecycle.Read)
  resourceName: string;

  @doc("Maximum amount of bytes that can be provisioned in this storage container; it must be a multiple of 512; each time a volume is provisioned in this container, its provisionedSize will be counted against the provisionLimit and the provisioning will fail if it goes over (minimum: 1048576 (1MiB), maximum: 4503599627370496 (4PiB)); by default it is unrestricted")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  provisionedLimit?: int64;

  @doc("VMware datastore associated with this storage container (if any)")
  @pattern("(^[a-zA-Z][a-zA-Z0-9\\-]{0,62}[a-zA-Z0-9])?$")
  @visibility(Lifecycle.Read)
  datastore?: string;

  @doc("Whether the datastore is mounted in VMware or not")
  @visibility(Lifecycle.Read)
  mounted?: boolean;

  @removed(Versions.v1_preview)
  @doc("Provisioning state of the resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState; // TODO: the type of this property should be changed to `ProvisioningState`
}

@armResourceOperations
interface AvsStorageContainers {
  @doc("Get an AVS storage container")
  get is ArmResourceRead<AvsStorageContainer>;
  @doc("Delete an AVS storage container")
  delete is ArmResourceDeleteWithoutOkAsync<AvsStorageContainer>;
  @doc("List AVS storage containers by storage pool")
  listByStoragePool is ArmResourceListByParent<AvsStorageContainer>;
}

@doc("A volume contained in an AVS storage container")
@parentResource(AvsStorageContainer)
model AvsStorageContainerVolume is ProxyResource<VolumeProperties> {
  /** Id of Storage Container Volume */
  ...ResourceNameParameter<
    AvsStorageContainerVolume,
    "volumeId",
    "volumes",
    NamePattern = "^[a-fA-F0-9\\-]{1,64}$"
  >;
}
@@doc(AvsStorageContainerVolume.name,
  "ID of the volume in the storage container"
);

@doc("Volume properties")
model VolumeProperties {
  @doc("Pure Storage's internal ID for the storage pool containing the volume")
  @visibility(Lifecycle.Read)
  storagePoolInternalId?: string;

  @doc("Azure Resource ID of the storage pool containing this volume")
  @visibility(Lifecycle.Read)
  storagePoolResourceId?: string;

  @doc("Pure Storage's internal ID for the volume")
  @visibility(Lifecycle.Read)
  volumeInternalId?: string;

  @doc("Human-readable name of the volume")
  @visibility(Lifecycle.Read)
  displayName?: string;

  @doc("Storage space usage")
  @visibility(Lifecycle.Read)
  space?: Space;

  @doc("Volume's soft-deletion state")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  softDeletion: SoftDeletion;

  @doc("Volume creation date, as an RFC 3339 timestamp")
  @visibility(Lifecycle.Read)
  createdTimestamp?: string;

  @doc("Currently provisioned size of the volume, in bytes")
  @visibility(Lifecycle.Read)
  provisionedSize?: int64;

  @doc("Specify which control plane handles the lifecycle of the volume")
  @visibility(Lifecycle.Read)
  volumeType?: VolumeType;

  @doc("AVS-specific volume information")
  @visibility(Lifecycle.Read)
  avs?: AvsDiskDetails;

  @doc("Provisioning state of the resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState; // TODO: the type of this property should be changed to `ProvisioningState`
}

@doc("Soft-deletion state")
model SoftDeletion {
  @doc("If false, the resource is active; if true, the resource has been destroyed; resources can be soft-deleted by setting destroyed to true, and recovered by setting it to false")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  destroyed: boolean;

  @doc("Date at which the resource will be eradicated and impossible to recover, as an RFC 3339 timestamp; invalid if destroyed is false;")
  @visibility(Lifecycle.Read)
  eradicationTimestamp?: string;
}

@doc("Specify which control plane handles the lifecycle of the volume")
union VolumeType {
  /** AVS/VMware */
  AVS: "avs",

  string,
}

@doc("AVS disk/volume information")
model AvsDiskDetails {
  @doc("VMware ID of the disk/volume")
  diskId: string;

  @doc("VMware name of the disk/volume")
  diskName: string;

  @doc("Name of the top-level folder in the datastore that contains the disk/volume")
  folder: string;

  @doc("VMware ID assigned to the disk/volume")
  avsVmInternalId: string;

  @doc("Azure resource ID of the AVS VM connected to this disk/volume")
  avsVmResourceId: string;

  @doc("Name of the AVS VM connected to this disk/volume")
  avsVmName: string;

  @doc("Azure resource ID of the AVS storage container containing this disk/volume")
  avsStorageContainerResourceId: string;
}

@armResourceOperations
interface AvsStorageContainerVolumes {
  @doc("Update a volume in an AVS storage container")
  update is ArmCustomPatchAsync<
    AvsStorageContainerVolume,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      AvsStorageContainerVolume,
      VolumeProperties
    >
  >;
  @doc("Get a volume in an AVS storage container")
  get is ArmResourceRead<AvsStorageContainerVolume>;
  @doc("Delete a volume in an AVS storage container")
  delete is ArmResourceDeleteWithoutOkAsync<AvsStorageContainerVolume>;
  @doc("List volumes in an AVS storage container")
  listByAvsStorageContainer is ArmResourceListByParent<AvsStorageContainerVolume>;
}

@parentResource(StoragePool)
@doc("AVS VM resource type, representing all the volumes associated to an AVS VM as defined by VMware")
model AvsVm is ProxyResource<AvsVmProperties> {
  /** Id of AVS VM */
  ...ResourceNameParameter<
    AvsVm,
    "avsVmId",
    "avsVms",
    NamePattern = "^[a-fA-F0-9\\-]{1,64}$"
  >;
}
@@doc(AvsVm.name, "ID of the AVS VM");

@doc("AVS VM properties")
model AvsVmProperties {
  @doc("Pure Storage's internal ID for the storage pool")
  @visibility(Lifecycle.Read)
  storagePoolInternalId?: string;

  @doc("Azure resource ID of the storage pool")
  @visibility(Lifecycle.Read)
  storagePoolResourceId?: string;

  @doc("Human-readable name of the AVS VM")
  @visibility(Lifecycle.Read)
  displayName?: string;

  @doc("Date at which the AVS VM was created, as an RFC 3339 timestamp")
  @visibility(Lifecycle.Read)
  createdTimestamp?: string;

  @doc("AVS VM's soft-deletion state")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  softDeletion?: SoftDeletion;

  @doc("Specify which control plane handles the lifecycle of the volume container")
  @visibility(Lifecycle.Read)
  volumeContainerType?: VolumeContainerType;

  @doc("AVS VM details")
  @visibility(Lifecycle.Read)
  avs?: AvsVmDetails;

  @doc("Contains properties related to used Flash space")
  @visibility(Lifecycle.Read)
  space?: Space;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState; // TODO: the type of this property should be changed to `ProvisioningState`
}

@doc("Storage space usage")
model Space {
  @doc("Total space occupied by customer data (i.e., being billed for), in bytes")
  totalUsed: int64;

  @doc("Unique space occupied by customer data, in bytes; for a volume, this is the amount of storage that would be freed by deleting the volume, since snapshot and shared data would be kept")
  unique: int64;

  @doc("Space occupied by data unique to one or more snapshots, in bytes")
  snapshots: int64;

  @doc("Space occupied by duplicated data, meaning data shared with other volumes and snapshots as a result of data deduplication, in bytes")
  shared: int64;
}

@doc("AVS VM details")
model AvsVmDetails {
  @doc("ID of the AVS VM using this set of volumes")
  vmId: string;

  @doc("Name of the VMware VM using this set of volumes")
  vmName: string;

  @doc("Type of the VMware VM using this set of volumes")
  vmType: VmType;

  @doc("Pure Storage's internal ID for this AVS VM")
  avsVmInternalId: string;
}

@doc("AVS VM storage types")
union VmType {
  /** VM using vVols as underlying storage */
  vVol: "vvol",

  string,
}

@doc("Specify which control plane handles the lifecycle of the volume container")
union VolumeContainerType {
  /** AVS/VMware */
  AVS: "avs",

  string,
}

@armResourceOperations
interface AvsVms {
  @doc("Update an AVS VM")
  update is ArmCustomPatchAsync<
    AvsVm,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      AvsVm,
      AvsVmProperties
    >
  >;
  @doc("Get an AVS VM")
  get is ArmResourceRead<AvsVm>;
  @doc("Delete an AVS VM")
  delete is ArmResourceDeleteWithoutOkAsync<AvsVm>;
  @doc("List AVS VMs by storage pool")
  listByStoragePool is ArmResourceListByParent<AvsVm>;
}

@doc("Any volume associated to a particular AVS VM")
@parentResource(AvsVm)
model AvsVmVolume is ProxyResource<VolumeProperties> {
  /** Id of AVS VM Volume */
  ...ResourceNameParameter<
    AvsVmVolume,
    "volumeId",
    "avsVmVolumes",
    NamePattern = "^[a-fA-F0-9\\-]{1,64}$"
  >;
}
@@doc(AvsVmVolume.name, "ID of the volume in the AVS VM");

@armResourceOperations
interface AvsVmVolumes {
  @doc("Update a volume in an AVS VM")
  update is ArmCustomPatchAsync<
    AvsVmVolume,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      AvsVmVolume,
      VolumeProperties
    >
  >;
  @doc("Get a volume in an AVS VM")
  get is ArmResourceRead<AvsVmVolume>;
  @doc("Delete a volume in an AVS VM")
  delete is ArmResourceDeleteWithoutOkAsync<AvsVmVolume>;
  @doc("List volumes in an AVS VM")
  listByAvsVm is ArmResourceListByParent<AvsVmVolume>;
}

@removed(Versions.v2_preview)
@doc("Azure Volume Group assigned to the volume.")
model AzureProperties {
  @doc("Azure Volume Group ID assigned to the volume.")
  volumeGroupInternalId: string;
}
