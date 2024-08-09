import "./LiftrBase.Storage/main.tsp";
import "@typespec/openapi";

@armProviderNamespace
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@useLibraryNamespace(LiftrBase.Storage)
@service({
  title: "PureStorage.Block",
})
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
  v1_preview: "2023-06-01-preview",

  @doc("Version 2 preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v2_preview)
  @useDependency(LiftrBase.Storage.Versions.v1_preview)
  v2_preview: "2024-06-01-preview",

  @doc("Version 3 preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v3_preview)
  @useDependency(LiftrBase.Storage.Versions.v1_preview)
  v3_preview: "2024-08-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

alias BaseResourceProperties = LiftrBase.BaseResourceProperties;
alias ReservationProperties = LiftrBase.Storage.ReservationProperties<BaseResourceProperties>;
alias Reservation = LiftrBase.Storage.Reservation<ReservationProperties>;

@armResourceOperations
interface Reservations
  extends LiftrBase.Storage.Reservations<Reservation, ReservationProperties> {
  @doc("Limits used for creation of resources.")
  @armResourceAction(Reservation)
  @action("getResourceLimits")
  @post
  getResourceLimits(
    ...ResourceInstanceParameters<Reservation>,
  ): ArmResponse<LimitDetails> | ErrorResponse;

  @added(Versions.v2_preview)
  @doc("Change the marketplace plan of the reservation.")
  @armResourceAction(Reservation)
  @action("changePlan")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  @post
  changePlan(
    ...ResourceInstanceParameters<Reservation>,

    /** The payload containing change plan parameters */
    @body
    changePlanParameters: MarketplacePlanUpdate,
  ): ArmAcceptedLroResponse<
    "Resource Operation accepted",
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;
}

@doc("Storage Pool resource type.")
model StoragePool is TrackedResource<StoragePoolProperties> {
  @doc("Name of the Storage Pool.")
  @segment("storagePools")
  @key("storagePoolName")
  @visibility("read")
  @path
  @minLength(1)
  @maxLength(127)
  @pattern("^[a-zA-Z0-9\\-_]{1,127}$")
  name: string;

  ...ManagedServiceIdentityProperty;
}

@doc("Properties of a Storage Pool resource.")
model StoragePoolProperties {
  @doc("ID of StoragePool in Pure Storage systems.")
  @visibility("read")
  storagePoolInternalId?: string;

  @doc("Azure Availability Zone the Pool is located in.")
  @visibility("read", "create")
  availabilityZone: string;

  @doc("Full Azure Resource ID of the Virtual Network subnet to make the Pool visible in.")
  @visibility("read", "create")
  vnetInjection: VnetInjection;

  @doc("How long a deleted object is kept before eradication (time in seconds).")
  @visibility("read")
  dataRetentionPeriod?: int64;

  @doc("Total bandwidth provisioned for the pool (in MB/s).")
  provisionedBandwidthMbPerSec: int64;

  @doc("Total IOPS provisioned for the pool (in MB/s).")
  @visibility("read")
  provisionedIops?: int64;

  @doc("Presented if avsEnabled is true.")
  @visibility("read")
  avs?: AzureVmwareService;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Resource id of the reservation resource. The RP should make sure this is a valid resource before allowing StoragePool creation to continue.")
  @visibility("create", "read")
  reservationResourceId: string;
}

@doc("Describes Virtual Network Subnet the Pool is visible in.")
model VnetInjection {
  @doc("Full Azure Resource ID of the Virtual Network subnet to inject pool in.")
  subnetId: string;

  @doc("Full Azure Resource ID of the Virtual Network to inject pool in.")
  vnetId: string;
}

@doc("Azure VmWare Service properties. VASA is vSphere Storage APIs for Storage Awareness.")
model AzureVmwareService {
  @doc("if true, VASA support is enabled and the AVS configuration parameters below may be passed to change the current password. if false, VASA support will be disabled (but previous password configuration is not lost).")
  avsEnabled: boolean;

  @doc("Resource id pointing at the AVS SDDC the pool is configured with.")
  sddcResourceId?: string;

  @doc("Immutable identifier for the vSpherePlugin provided by Pure Storage. The value is available if the vSpherePlugin has been enabled for the storage pool.")
  vSpherePluginKey?: string;
}

@armResourceOperations
interface StoragePools {
  get is ArmResourceRead<StoragePool>;
  create is ArmResourceCreateOrUpdateAsync<StoragePool>;
  update is ArmCustomPatchAsync<
    StoragePool,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      StoragePool,
      StoragePoolProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<StoragePool>;
  listByResourceGroup is ArmResourceListByParent<StoragePool>;
  listBySubscription is ArmListBySubscription<StoragePool>;

  @doc("Lists health metadata for specific Storage Pool.")
  @armResourceAction(StoragePool)
  @action("getHealthStatus")
  @post
  getHealthStatus(
    ...ResourceInstanceParameters<StoragePool>,
  ): ArmResponse<HealthResponse> | ErrorResponse;

  @doc("Lists AVS properties for specific Storage Pool.")
  @armResourceAction(StoragePool)
  @action("getAvsParameters")
  @post
  getAvsParameters(
    ...ResourceInstanceParameters<StoragePool>,
  ): ArmResponse<AvsDetails> | ErrorResponse;

  @added(Versions.v3_preview)
  @doc("Returns the information about the on-going connection of the storage pool to AVS")
  @armResourceAction(StoragePool)
  @action("getAvsConnection")
  @post
  getAvsConnection(
    ...ResourceInstanceParameters<StoragePool>,
  ): ArmResponse<AvsConnection> | ErrorResponse;

  @added(Versions.v3_preview)
  @doc("Returns the status of the storage pool connection to AVS")
  @armResourceAction(StoragePool)
  @action("getAvsConnectionStatus")
  @post
  getAvsConnectionStatus(
    ...ResourceInstanceParameters<StoragePool>,
  ): ArmResponse<AvsConnectionStatus> | ErrorResponse;

  @doc("Enable AVS on storage pool")
  @armResourceAction(StoragePool)
  @action("enableAvs")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  @post
  enableAvs(
    ...ResourceInstanceParameters<StoragePool>,

    @doc("Storage pool enable Avs properties")
    @body
    properties: StoragePoolEnableAvs,
  ): ArmAcceptedLroResponse<
    "Resource Operation accepted",
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;

  @added(Versions.v3_preview)
  @doc("Enables the AVS connection support for a specific Storage Pool")
  @armResourceAction(StoragePool)
  @action("enableAvsConnection")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  @post
  enableAvsConnection(
    ...ResourceInstanceParameters<StoragePool>,

    @doc("Storage pool enable Avs connection properties")
    @body
    properties: StoragePoolEnableAvsConnectionPost,
  ): ArmAcceptedLroResponse<
    "Resource Operation accepted",
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;

  @doc("Disable AVS on storage pool")
  @armResourceAction(StoragePool)
  @action("disableAvs")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  @post
  disableAvs(
    ...ResourceInstanceParameters<StoragePool>,
  ): ArmAcceptedLroResponse<
    "Resource Operation accepted",
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;

  @added(Versions.v3_preview)
  @doc("Disables the AVS connection support for a specific Storage Pool")
  @armResourceAction(StoragePool)
  @action("disableAvsConnection")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  @post
  disableAvsConnection(
    ...ResourceInstanceParameters<StoragePool>,
  ): ArmAcceptedLroResponse<
    "Resource Operation accepted",
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;

  @doc("Finalize AVS on storage pool")
  @armResourceAction(StoragePool)
  @action("finalizeAvs")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  @post
  finalizeAvs(
    ...ResourceInstanceParameters<StoragePool>,
  ): ArmAcceptedLroResponse<
    "Resource Operation accepted",
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;

  @added(Versions.v3_preview)
  @doc("Finalize the AVS connection for a specific Storage Pool")
  @armResourceAction(StoragePool)
  @action("finalizeAvsConnection")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  @post
  finalizeAvsConnection(
    ...ResourceInstanceParameters<StoragePool>,

    @doc("Storage pool finalize Avs connection properties")
    @body
    properties: StoragePoolFinalizeAvsConnectionPost,
  ): ArmAcceptedLroResponse<
    "Resource Operation accepted",
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;

  @added(Versions.v3_preview)
  @doc("Make sure that all steps necessary to enable this storage pool to be connected to the AVS instance are fully working, and fix them if not")
  @armResourceAction(StoragePool)
  @action("repairAvsConnection")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  @post
  repairAvsConnection(
    ...ResourceInstanceParameters<StoragePool>,
  ): ArmAcceptedLroResponse<
    "Resource Operation accepted",
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;

  @doc("Enable VSphere plugin on storage pool")
  @armResourceAction(StoragePool)
  @action("enableVspherePlugin")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  @post
  enableVspherePlugin(
    ...ResourceInstanceParameters<StoragePool>,

    @doc("VSphere plugin properties")
    @body
    properties: StoragePoolEnableVspherePlugin,
  ): ArmAcceptedLroResponse<
    "Resource Operation accepted",
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;

  @doc("Disable VSphere plugin on storage pool")
  @armResourceAction(StoragePool)
  @action("disableVspherePlugin")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  @post
  disableVspherePlugin(
    ...ResourceInstanceParameters<StoragePool>,
  ): ArmAcceptedLroResponse<
    "Resource Operation accepted",
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;

  @doc("Upgrade VSphere plugin on storage pool")
  @armResourceAction(StoragePool)
  @action("upgradeVspherePlugin")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  @post
  upgradeVspherePlugin(
    ...ResourceInstanceParameters<StoragePool>,
  ): ArmAcceptedLroResponse<
    "Resource Operation accepted",
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;
}

@doc("Limits used for creation of resources.")
model LimitDetails {
  @doc("Limits used for Storage Pool")
  storagePool: StoragePoolLimits;

  @doc("Limits used for Volumes")
  volume: VolumeLimits;

  @doc("Limits used for Protection Policies")
  protectionPolicy: ProtectionPolicyLimits;

  @doc("Limits used for Performance Policies")
  performancePolicy: PerformancePolicyLimits;
}

@doc("Limits used for Storage Pool")
model StoragePoolLimits {
  @doc("Total bandwidth provisioned by customer across all volumes (in MB/s)")
  provisionedBandwidthMbPerSec: RangeLimits;

  @doc("Range allowed for the provisioned IOPS of a StoragePool (in I/O operation per second).")
  provisionedIops: RangeLimits;

  @doc("The list of physical availability zones in the region in which StoragePools can be deployed.")
  physicalAvailabilityZones: string[];
}
@doc("Limits used for Volumes")
model VolumeLimits {
  @doc("Provisioned size of the volume, that is, how large the volume can grow (in GB).")
  provisionedSize: RangeLimits;
}

@doc("Limits used for Protection Policies")
model ProtectionPolicyLimits {
  @doc("How often snapshots are taken (in seconds).")
  frequency: RangeLimits;

  @doc("How long snapshots are kept (in seconds).")
  retention: RangeLimits;
}

@doc("Limits used for Performance Policies")
model PerformancePolicyLimits {
  @doc("How often snapshots are taken (in IOPS).")
  iopsLimit: RangeLimits;

  @doc("How long snapshots are taken (in MB/s).")
  bandwidthLimit: RangeLimits;
}

@doc("Minimum and maximum values for a range.")
model RangeLimits {
  @doc("Minimum value for the range.")
  min: int64;

  @doc("Maximum value for the range.")
  max: int64;
}

@doc("AVS (Azure VMware Solution) related properties.")
model AvsDetails {
  @doc("Flag which tells if the AVS support is enabled.")
  avsEnabled: boolean;

  @doc("AVS configuration properties")
  avs?: Avs;

  @doc("vSphere configuration properties")
  vSphere?: Vsphere;

  @doc("tells if the plugin has been enabled or not")
  vSpherePluginEnabled: boolean;

  @doc("vSpherePluginKey associated with the plugin")
  vSpherePluginKey?: string;

  @doc("vSphere plugin configuration properties")
  vSpherePlugin?: VspherePlugin;
}

@doc("vSphere plugin configuration properties")
model VspherePlugin {
  @doc("URL for registration of vSphere plugin")
  registrationUrl: string;

  @doc("Company name for vSphere plugin")
  companyName: string;

  @doc("Description of vSphere plugin")
  description: string;

  @doc("Protocol used by vSphere plugin")
  protocol: string;

  @doc("Admin email for vSphere plugin")
  adminEmail: string;

  @doc("Version of vSphere plugin")
  version: string;

  @doc("Certificate for vSphere plugin")
  certificate: string;
}

@doc("vSphere configuration properties")
model Vsphere {
  @doc("Resource id pointing at the AVS SDDC the pool is configured with")
  sddcResourceId: string;

  @doc("IP address of the vSphere software installed in the SDDC")
  vSphereIp: string;
}

@doc("AVS (Azure VMware Solution) related properties.")
model Avs {
  @doc("Username for VMware VASA service login.")
  vasaProviderUsername: string;

  @doc("URLs to use for VMware VASA.")
  vasaProviderUrls: string[];

  @doc("Array of iSCSI endpoint and IQN.")
  @extension("x-ms-identifiers", [])
  vasaIscsiEndpoints: VasaIscsiEndpoints[];
}

@doc("iSCSI endpoint and IQN.")
model VasaIscsiEndpoints {
  @doc("IP address of the iSCSI endpoint.")
  address: string;

  @doc("Port of the iSCSI endpoint.")
  port: int32;

  @doc("IQN the Volume Group is available under.")
  iqn: string;
}

@doc("Health metadata reported for a given resource.")
model HealthResponse {
  @doc("Health metrics reported for a given resource.")
  health: HealthDetails;

  @doc("Array of health alerts for a given pool.")
  @extension("x-ms-identifiers", [])
  alerts: Alert[];
}

@doc("Health metrics reported for a given resource.")
model HealthDetails {
  @doc("How full the pool is right now, in %, compared to the maximum size it can grow to.")
  usedCapacityPercentage: float64;

  @doc("Bandwidth usage metrics reported for a given resource.")
  bandwidthUsage: BandwidthUsage;

  @doc("IOPS usage metrics reported for a given resource.")
  iopsUsage: IopsUsage;

  @doc("Contains properties related to used Flash space.")
  space: Space;

  @doc("Data reduction ratio achieved on this pool")
  dataReductionRatio: float64;

  @added(Versions.v3_preview)
  @doc("The estimated maximum capacity of the pool. Measured in bytes.")
  estimatedMaxCapacity: int64;
}

@doc("Bandwidth usage metrics reported for a given resource.")
model BandwidthUsage {
  @doc("The number of bytes written and read per second. Max over 10 mins.")
  current: int64;

  @doc("Bandwidth rating of the currently provisioned SKU in bytes per second.")
  provisioned: int64;

  @doc("Bandwidth rating of the highest available SKU in bytes per second.")
  max: int64;
}

@doc("IOPS usage metrics reported for a given resource.")
model IopsUsage {
  @doc("The number of operations per second. Max over 10 mins.")
  current: int64;

  @doc("IOPS rating of the currently provisioned SKU.")
  provisioned: int64;

  @doc("IOPS rating of the highest available SKU.")
  max: int64;
}

@doc("Health alerts for a given pool.")
model Alert {
  @doc("The severity level of the alert.")
  level: AlertLevel;

  @doc("A short description of the alert.")
  message: string;
}

@doc("The severity level of the alert.")
union AlertLevel {
  /** Information level */
  Info: "info",

  /** Warning level */
  Warning: "warning",

  /** Error level */
  Error: "error",

  string,
}

@doc("Storage Pool enable AVS")
model StoragePoolEnableAvs {
  @doc("Resource id pointing at the AVS SDDC the pool is configured with.")
  sddcResourceId: string;

  @doc("Password for VASA service login.")
  @secret
  vasaProviderPassword: string;
}

@added(Versions.v3_preview)
@doc("Explicit service initialization payload, with no encoding or signing; may be null if completed is true, or if serviceInitializationHandleEnc is not null")
model ServiceInitializationHandle {
  @doc("Resource id pointing at the AVS SDDC the pool is configured with.")
  sddcResourceId?: string;

  @doc("Service account username")
  serviceAccountUsername?: string;
}

@added(Versions.v3_preview)
@doc("Information about the connection of the storage pool to AVS")
model AvsConnection {
  @doc("Indicates whether service initialization is complete")
  serviceInitializationCompleted: boolean;

  @doc("Encoded service account credentials alongside connection information, encrypted with the ephemeral public key")
  serviceInitializationHandleEnc?: string;

  @doc("Explicit service account credentials")
  serviceInitializationHandle?: ServiceInitializationHandle;
}

@added(Versions.v3_preview)
@doc("The status of the storage pool connection to AVS")
model AvsConnectionStatus {
  @doc("If true, a sequence of enable/finalize has been completed successfully, and disable hasn't been called successfully since.")
  avsEnabled: boolean;

  @doc("Human-readable current connection status")
  currentConnectionStatus: string;

  @doc("Resource id pointing at the AVS SDDC the pool is configured with")
  sddcResourceId?: string;
}

@added(Versions.v3_preview)
@doc("Storage Pool enable AVS Connection")
model StoragePoolEnableAvsConnectionPost {
  @doc("Resource id pointing at the AVS SDDC the pool is configured with.")
  sddcResourceId: string;
}

@added(Versions.v3_preview)
@doc("Explicit service account credentials")
model ServiceInitializationData {
  @doc("Service account username")
  serviceAccountUsername?: string;

  @doc("Service account password")
  @secret
  serviceAccountPassword?: string;

  @doc("Storage Pool Vsphere IP")
  vSphereIp?: string;

  @doc("Storage Pool Vsphere Certificate")
  vSphereCertificate?: string;
}

@added(Versions.v3_preview)
@doc("Storage Pool finalize AVS Connection")
model StoragePoolFinalizeAvsConnectionPost {
  @doc("Encoded service account credentials alongside connection information, encrypted with the ephemeral public key")
  serviceInitializationDataEnc?: string;

  @doc("Explicit service account credentials")
  serviceInitializationData?: ServiceInitializationData;
}

@doc("Storage Pool enable VSphere plugins")
model StoragePoolEnableVspherePlugin {
  @doc("Storage Pool Vsphere IP")
  vSphereIp: string;

  @doc("Storage Pool Vsphere cert thumb print")
  vSphereCertThumbprint?: string;
}

@doc("The AVS Storage Container resource type.")
@parentResource(StoragePool)
model AvsStorageContainer is ProxyResource<AvsStorageContainerProperties> {
  @doc("The name of the storage container.")
  @segment("avsStorageContainers")
  @key("storageContainerName")
  @visibility("read")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-]{0,62}[a-zA-Z0-9]$")
  name: string;
}

@doc("The properties of an AVS Storage Container resource.")
model AvsStorageContainerProperties {
  @doc("Contains properties related to used Flash space")
  @visibility("read")
  space?: Space;

  @doc("Name of the storage used.")
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-]{0,62}[a-zA-Z0-9]$")
  @visibility("read")
  storageName?: string;

  @added(Versions.v3_preview)
  @doc("Name of the storage container.")
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-]{0,62}[a-zA-Z0-9]$")
  @visibility("read")
  resourceName: string;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  @doc("Maximum amount of bytes that can be provisioned in this storage container. It must be a multiple of 512. Each time a volume is provisioned in this container, its provisionedSize will be counted against the provisionLimit and the provisioning will fail if it goes over (minimum: 1048576 (1Mi), maximum: 4503599627370496 (4Pi)). By default it is unrestricted.")
  @visibility("create", "update", "read")
  provisionedLimit?: int64;
}

@armResourceOperations
interface AvsStorageContainers {
  create is ArmResourceCreateOrUpdateAsync<AvsStorageContainer>;
  get is ArmResourceRead<AvsStorageContainer>;
  delete is ArmResourceDeleteWithoutOkAsync<AvsStorageContainer>;
  update is ArmCustomPatchAsync<
    AvsStorageContainer,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      AvsStorageContainer,
      AvsStorageContainerProperties
    >
  >;
  listByStoragePool is ArmResourceListByParent<AvsStorageContainer>;
}

@doc("The AVS Storage Container Volume resource type.")
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
@@doc(AvsStorageContainerVolume.name, "Id of Storage Container Volume.");

@doc("Volume properties.")
model VolumeProperties {
  @doc("Pure Storage's internal Id for the StoragePool.")
  @visibility("read")
  storagePoolInternalId?: string;

  @doc("Resource Id for the StoragePool.")
  @visibility("read")
  storagePoolResourceId?: string;

  @doc("Pure Storage's internal Id for the Volume.")
  @visibility("read")
  volumeInternalId?: string;

  @doc("Human readable name for that Volume.")
  @visibility("read")
  displayName?: string;

  @doc("Contains properties related to used Flash space")
  @visibility("read")
  space?: Space;

  @doc("Name of the Performance Policy applied to the Volume.")
  @visibility("read")
  performancePolicy?: VolumePerformancePolicy;

  @doc("Shows if Resource is destroyed and when eradication will happen.")
  @visibility("read", "update")
  softDeletion: SoftDeletion;

  @doc("Consistency Group the Volume belongs to.")
  @visibility("read")
  consistencyGroup?: VolumeConsistencyGroup;

  @doc("RFC 3339 Timestamp when Volume was created.")
  @visibility("read")
  createdTimestamp?: string;

  @doc("Provisioned size of the volume, that is, how large the volume can grow. In bytes.")
  @visibility("read")
  provisionedSize?: int64;

  @doc("Which system is responsible for the lifecycle of that Volume.")
  @visibility("read")
  volumeType?: VolumeType;

  @doc("AVS details.")
  @visibility("read")
  avs?: AvsDiskDetails;

  @doc("Azure Volume Group assigned to the volume.")
  @visibility("read")
  azure?: AzureProperties;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("Name of the Performance Policy applied to the Volume")
model VolumePerformancePolicy {
  @doc("Resource id of the Performance Policy")
  policyResourceId: string;
}

@doc("Shows if Resource is destroyed and when eradication will happen.")
model SoftDeletion {
  @doc("Shows if Resource is destroyed.")
  @visibility("read", "update")
  destroyed: boolean;

  @doc("Timestamp when Resource will be eradicated. Present only if `destroyed` is true.")
  @visibility("read")
  eradicationTimestamp?: string;

  @doc("Set to the previous volumeResourceId for this volume if destroyed is true, and this used to be a VolumeGroup/Volume, the former Azure resourceId for that VolumeGroup/Volume before it was delete.")
  @visibility("read")
  previousResourceId?: string;
}

@doc("Consistency Group the Volume belongs to.")
model VolumeConsistencyGroup {
  @doc("ID for the Consistency Group the Volume belongs to.")
  consistencyGroupId: string;
}

@doc("Volume types.")
union VolumeType {
  /** Azure Volume Type */
  Azure: "azure",

  /** AVS Volume Type */
  AVS: "avs",

  string,
}

@doc("AVS disk details.")
model AvsDiskDetails {
  @doc("Id of the disk.")
  diskId: string;

  @doc("Name of the disk.")
  diskName: string;

  @doc("Name of the top-level folder in which the Volume is located.")
  folder: string;

  @doc("VMware id assigned to the volume.")
  avsVmInternalId: string;

  @doc("Resource id of the avs vm.")
  avsVmResourceId: string;

  @doc("Name of the avs vm.")
  avsVmName: string;

  @doc("Resource id of AVS storage container")
  avsStorageContainerResourceId: string;
}

@doc("Azure Volume Group assigned to the volume.")
model AzureProperties {
  @doc("Azure Volume Group ID assigned to the volume.")
  volumeGroupInternalId: string;
}

@armResourceOperations
interface AvsStorageContainerVolumes {
  update is ArmCustomPatchAsync<
    AvsStorageContainerVolume,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      AvsStorageContainerVolume,
      VolumeProperties
    >
  >;
  get is ArmResourceRead<AvsStorageContainerVolume>;
  delete is ArmResourceDeleteWithoutOkAsync<AvsStorageContainerVolume>;
  listByAvsStorageContainer is ArmResourceListByParent<AvsStorageContainerVolume>;
}

@parentResource(StoragePool)
model AvsVm is ProxyResource<AvsVmProperties> {
  /** Id of AVS VM */
  ...ResourceNameParameter<
    AvsVm,
    "avsVmId",
    "avsVms",
    NamePattern = "^[a-fA-F0-9\\-]{1,64}$"
  >;
}
@@doc(AvsVm.name, "Id of AVS VM.");

@doc("AVS VM properties.")
model AvsVmProperties {
  @doc("Pure Storage's internal Id for the StoragePool.")
  @visibility("read")
  storagePoolInternalId?: string;

  @doc("Resource Id for the StoragePool.")
  @visibility("read")
  storagePoolResourceId?: string;

  @doc("Name to use in UI for this AVS VM.")
  @visibility("read")
  displayName?: string;

  @doc("Timestamp when AVS VM was created")
  @visibility("read")
  createdTimestamp?: string;

  @doc("Shows if Resource is destroyed and when eradication will happen.")
  @visibility("read", "update")
  softDeletion?: SoftDeletion;

  @doc("Which system is responsible for the lifecycle of that Volume.")
  @visibility("read")
  volumeContainerType?: VolumeContainerType;

  @doc("AVS VM details.")
  @visibility("read")
  avs?: AvsVmDetails;

  @doc("Contains properties related to used Flash space")
  @visibility("read")
  space?: Space;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("Contains properties related to used Flash space")
model Space {
  @doc("The total space used by customer data. Measured in bytes")
  totalUsed: int64;

  @doc("The unique physical space occupied by customer data. Unique physical space does not include shared space or snapshots. Measured in bytes.")
  unique: int64;

  @doc("The physical space occupied by data unique to one or more snapshots. Measured in bytes.")
  snapshots: int64;

  @doc("The physical space occupied by duplicated data, meaning that the space is shared with other volumes and snapshots as a result of data deduplication. Measured in bytes.")
  shared: int64;
}

@doc("AVS VM details.")
model AvsVmDetails {
  @doc("VMware VM id using this set of volumes.")
  vmId: string;

  @doc("VMware VM name using this set of volumes.")
  vmName: string;

  @doc("VMware VM type using this set of volumes.")
  vmType: VmType;

  @doc("Pure Storage's internal Id for this AVS VM.")
  avsVmInternalId: string;
}

@doc("VM types.")
union VmType {
  /** vvol Vm Type */
  vVol: "vvol",

  string,
}

@doc("Volume container types.")
union VolumeContainerType {
  /** Azure Volume Container Type */
  Azure: "azure",

  /** AVS Volume Container Type */
  AVS: "avs",

  string,
}

@armResourceOperations
interface AvsVms {
  update is ArmCustomPatchAsync<
    AvsVm,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      AvsVm,
      AvsVmProperties
    >
  >;
  get is ArmResourceRead<AvsVm>;
  delete is ArmResourceDeleteWithoutOkAsync<AvsVm>;
  listByStoragePool is ArmResourceListByParent<AvsVm>;
}

@doc("The AVS VM Volume resource type.")
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
@@doc(AvsVmVolume.name, "Id of AVS VM Volume.");

@armResourceOperations
interface AvsVmVolumes {
  update is ArmCustomPatchAsync<
    AvsVmVolume,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      AvsVmVolume,
      VolumeProperties
    >
  >;
  get is ArmResourceRead<AvsVmVolume>;
  delete is ArmResourceDeleteWithoutOkAsync<AvsVmVolume>;
  listByAvsVm is ArmResourceListByParent<AvsVmVolume>;
}
