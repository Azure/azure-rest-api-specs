import "./LiftrBase.Storage/main.tsp";

import "@typespec/openapi";

@armProviderNamespace
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
}

interface Operations extends Azure.ResourceManager.Operations {}

alias BaseResourceProperties = LiftrBase.BaseResourceProperties;
alias ReservationProperties = LiftrBase.Storage.ReservationProperties<BaseResourceProperties>;
alias Reservation = LiftrBase.Storage.Reservation<ReservationProperties>;

@armResourceOperations
interface Reservations
  extends LiftrBase.Storage.Reservations<Reservation, ReservationProperties> {}

@doc("Storage Pool resource type.")
model StoragePool is TrackedResource<StoragePoolProperties> {
  @doc("Name of the Storage Pool.")
  @segment("storagePools")
  @key("storagePoolName")
  @visibility("read")
  @path
  @minLength(4)
  @maxLength(20)
  @pattern("^[a-zA-Z0-9_]*$")
  name: string;

  ...ManagedServiceIdentity;
}

@doc("Properties of a Storage Pool resource.")
model StoragePoolProperties {
  @doc("ID of StoragePool in Pure Storage systems.")
  @visibility("read")
  storagePooInternalId?: string;

  @doc("Azure Availability Zone the Pool is located in.")
  @visibility("read", "create")
  availabilityZone: string;

  @doc("Full Azure Resource ID of the Virtual Network subnet to make the Pool visible in.")
  @visibility("read", "create")
  delegatedSubnetId: string;

  @doc("How long a deleted object is kept before eradication (time in seconds).")
  @visibility("read")
  dataRetentionPeriod?: int64;

  @doc("if true, VASA support is enabled and the AVS configuration parameters below may be passed to change the current password. if false, VASA support will be disabled (but previous password configuration is not lost).")
  avsEnabled: boolean;

  @doc("Total bandwidth provisioned for the pool (in MB/s).")
  provisionedBandwidthMbPerSec: int64;

  @doc("Total IOPS provisioned for the pool (in MB/s).")
  @visibility("read")
  provisionedIops?: int64;

  @doc("Presented if avsEnabled is true.")
  avs?: AzureVmwareService;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  @doc("Resource id of the reservation resource. The RP should make sure this is a valid resource before allowing StoragePool creation to continue.")
  @visibility("create", "read")
  reservationResourceId: string;
}

@doc("Azure VmWare Service properties. VASA is vSphere Storage APIs for Storage Awareness.")
model AzureVmwareService {
  @doc("Internal VMware id identifying this StoragePool as a storage provider.")
  storageProviderId: string;

  @doc("Resource id pointing at the AVS SDDC the pool is configured with (used by AVS Resource Provider to keep track of attached pools).")
  sddc?: string;

  @doc("Password for VASA service login, disabled if omitted or set to null.")
  @visibility("create", "update")
  @secret
  vasaProviderPassword?: string;
}

@armResourceOperations
interface StoragePools {
  get is ArmResourceRead<StoragePool>;
  create is ArmResourceCreateOrUpdateAsync<StoragePool>;
  update is ArmResourcePatchAsync<StoragePool, StoragePoolProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<StoragePool>;
  listByResourceGroup is ArmResourceListByParent<StoragePool>;
  listBySubscription is ArmListBySubscription<StoragePool>;

  @doc("Lists health metadata for specific Storage Pool.")
  listHealthMetadata is ArmResourceActionSync<StoragePool, {}, HealthResponse>;

  @doc("Lists AVS properties for specific Storage Pool.")
  listAvsDetails is ArmResourceActionSync<StoragePool, {}, AvsDetails>;
}

@doc("AVS (Azure VMware Solution) related properties.")
model AvsDetails {
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
  bandwidthUsage: string;

  @doc("IOPS usage metrics reported for a given resource.")
  iopsUsage: string;
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
enum AlertLevel {
  @doc("Information level.")
  Info: "info",

  @doc("Warning level.")
  Warning: "warning",

  @doc("Error level.")
  Error: "error",
}

@doc("The AVS Storage Container resource type.")
@parentResource(StoragePool)
model AvsStorageContainer is ProxyResource<AvsStorageContainerProperties> {
  @doc("The name of the storage container.")
  @segment("avsStorageContainers")
  @key("storageContainerName")
  @visibility("read")
  @path
  @pattern("^[a-zA-Z\\-_]{1,32}$")
  name: string;
}

@doc("The properties of an AVS Storage Container resource.")
model AvsStorageContainerProperties {
  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@armResourceOperations
interface AvsStorageContainers {
  create is ArmResourceCreateOrUpdateAsync<AvsStorageContainer>;
  get is ArmResourceRead<AvsStorageContainer>;
  delete is ArmResourceDeleteWithoutOkAsync<AvsStorageContainer>;
  listByParent is ArmResourceListByParent<AvsStorageContainer>;
}

@doc("The AVS Storage Container Volume resource type.")
@parentResource(AvsStorageContainer)
model AvsStorageContainerVolume is ProxyResource<VolumeProperties> {
  @doc("Name of the Volume.")
  @segment("volumes")
  @key("volumeName")
  @visibility("read")
  @path
  @minLength(4)
  @maxLength(20)
  @pattern("^[a-zA-Z0-9_]*$")
  name: string;
}

@doc("Volume properties.")
model VolumeProperties {
  @doc("Pure Storage's internal Id for the StoragePool.")
  @visibility("read")
  storagePoolInternalId?: string;

  @doc("Pure Storage's internal Id for the Volume.")
  @visibility("read")
  volumeInternalId?: string;

  @doc("Human readable name for that Volume.")
  @visibility("read")
  displayName?: string;

  @doc("Shows if Resource is destroyed and when eradication will happen.")
  @visibility("read", "update")
  softDeletion: SoftDeletion;

  @doc("Consistency Group the Volume belongs to.")
  @visibility("read")
  consistencyGroup?: VolumeConsistencyGroup;

  @doc("Unix Timestamp when Volume Group was created (in seconds).")
  @visibility("read")
  createdTimestamp?: int64;

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

  // TODO: check if it is required since only update/read is allowed
  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("Shows if Resource is destroyed and when eradication will happen.")
model SoftDeletion {
  @doc("Shows if Resource is destroyed.")
  @visibility("read", "update")
  destroyed: boolean;

  @doc("Unix Timestamp when Resource will be eradicated (in seconds). Present only if `destroyed` is true.")
  @visibility("read")
  eradicationTimestamp?: int64;

  @doc("Set to the previous volumeResourceId for this volume if destroyed is true, and this used to be a VolumeGroup/Volume, the former Azure resourceId for that VolumeGroup/Volume before it was delete.")
  @visibility("read")
  previousVolumeResourceId?: string;
}

@doc("Consistency Group the Volume belongs to.")
model VolumeConsistencyGroup {
  @doc("Internal ID for the Consistency Group the Volume belongs to.")
  consistencyGroupId: string;
}

@doc("Enum of possible Volume types.")
enum VolumeType {
  @doc("Azure Volume Type.")
  Azure: "azure",

  @doc("AVS Volume Type.")
  AVS: "avs",
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

  @doc("AVS storage container name that contains exact volume.")
  avsStorageContainerName: string;
}

@doc("Azure Volume Group assigned to the volume.")
model AzureProperties {
  @doc("Azure Volume Group ID assigned to the volume.")
  volumeGroupInternalId: string;
}

@armResourceOperations
interface AvsStorageContainerVolumes {
  update is ArmResourcePatchAsync<AvsStorageContainerVolume, VolumeProperties>;
  get is ArmResourceRead<AvsStorageContainerVolume>;
  delete is ArmResourceDeleteWithoutOkAsync<AvsStorageContainerVolume>;
  listByParent is ArmResourceListByParent<AvsStorageContainerVolume>;
}

@parentResource(StoragePool)
model AvsVm is ProxyResource<AvsVmProperties> {
  @doc("Name of the AVS VM.")
  @segment("avsVms")
  @key("avsVmName")
  @visibility("read")
  @path
  @minLength(4)
  @maxLength(20)
  @pattern("^[a-zA-Z0-9_]*$")
  name: string;
}

@doc("AVS VM properties.")
model AvsVmProperties {
  @doc("Name to use in UI for this AVS VM.")
  @visibility("read")
  displayName?: string;

  @doc("Unix Timestamp when AVS VM was created (in seconds).")
  @visibility("read")
  createdTimestamp?: int64;

  @doc("Shows if Resource is destroyed and when eradication will happen.")
  @visibility("read", "update")
  softDeletion?: SoftDeletion;

  @doc("Which system is responsible for the lifecycle of that Volume.")
  @visibility("read")
  volumeContainerType?: VolumeContainerType;

  @doc("AVS VM details.")
  @visibility("read")
  avs?: AvsVmDetails;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
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

@doc("Enum of possible VM types.")
enum VmType {
  @doc("vvol Vm Type.")
  vVol: "vvol",
}

@doc("Enum of possible Volume container types.")
enum VolumeContainerType {
  @doc("Azure Volume Container Type.")
  Azure: "azure",

  @doc("AVS Volume Container Type.")
  AVS: "avs",
}

@armResourceOperations
interface AvsVms {
  update is ArmResourcePatchAsync<AvsVm, AvsVmProperties>;
  get is ArmResourceRead<AvsVm>;
  delete is ArmResourceDeleteWithoutOkAsync<AvsVm>;
  listByParent is ArmResourceListByParent<AvsVm>;
}

@doc("The AVS VM Volume resource type.")
@parentResource(AvsVm)
model AvsVmVolume is ProxyResource<VolumeProperties> {
  @doc("Name of the AVS VM Volume.")
  @segment("avsVmVolumes")
  @key("avsVmVolumeName")
  @visibility("read")
  @path
  @minLength(4)
  @maxLength(20)
  @pattern("^[a-zA-Z0-9_]*$")
  name: string;
}

@armResourceOperations
interface AvsVmVolumes {
  update is ArmResourcePatchAsync<AvsVmVolume, VolumeProperties>;
  get is ArmResourceRead<AvsVmVolume>;
  delete is ArmResourceDeleteWithoutOkAsync<AvsVmVolume>;
  listByParent is ArmResourceListByParent<AvsVmVolume>;
}
