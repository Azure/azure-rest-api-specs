import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EdgeMachine.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.AzureStackHCI;

// ==================== Disk Resource ====================

/**
 * Disk resource representing a physical disk on an Edge Machine.
 */
@added(Versions.v2026_03_15_preview)
@parentResource(EdgeMachine)
model EdgeMachineDisk
  is Azure.ResourceManager.ProxyResource<EdgeMachineDiskProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachineDisk,
    KeyName = "diskName",
    SegmentName = "disks",
    NamePattern = "^[a-zA-Z0-9-_]{3,63}$"
  >;
}

/**
 * Operations for Edge Machine Disks.
 */
@added(Versions.v2026_03_15_preview)
@armResourceOperations
interface EdgeMachineDisks {
  /** Get a specific disk on an Edge Machine. */
  get is ArmResourceRead<EdgeMachineDisk>;

  /** List all disks on an Edge Machine. */
  list is ArmResourceListByParent<EdgeMachineDisk>;

  /** Create or update a disk on an Edge Machine. */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeMachineDisk>;

  /** Delete a disk from an Edge Machine. */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachineDisk>;
}

// ==================== Volume Resource ====================

/**
 * Volume resource representing a storage volume on an Edge Machine.
 */
@added(Versions.v2026_03_15_preview)
@parentResource(EdgeMachine)
model EdgeMachineVolume
  is Azure.ResourceManager.ProxyResource<EdgeMachineVolumeProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachineVolume,
    KeyName = "volumeName",
    SegmentName = "volumes",
    NamePattern = "^[a-zA-Z0-9-_]{3,63}$"
  >;
}

/**
 * Operations for Edge Machine Volumes.
 */
@added(Versions.v2026_03_15_preview)
@armResourceOperations
interface EdgeMachineVolumes {
  /** Get a specific volume on an Edge Machine. */
  get is ArmResourceRead<EdgeMachineVolume>;

  /** List all volumes on an Edge Machine. */
  list is ArmResourceListByParent<EdgeMachineVolume>;

  /** Create or update a volume on an Edge Machine. */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeMachineVolume>;

  /** Delete a volume from an Edge Machine. */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachineVolume>;
}

// ==================== DiskJobs Resource ====================

/**
 * Disk Job resource for managing operations on disks.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
@added(Versions.v2026_03_15_preview)
@parentResource(EdgeMachineDisk)
model EdgeMachineDiskJob
  is Azure.ResourceManager.ProxyResource<EdgeMachineDiskJobProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachineDiskJob,
    KeyName = "jobName",
    SegmentName = "jobs",
    NamePattern = "^[a-zA-Z0-9-_]{3,63}$"
  >;
}

/**
 * Operations for Edge Machine Disk Jobs.
 */
@added(Versions.v2026_03_15_preview)
@armResourceOperations
interface EdgeMachineDiskJobs {
  /** Get a specific disk job. */
  get is ArmResourceRead<EdgeMachineDiskJob>;

  /** List all jobs for a disk. */
  list is ArmResourceListByParent<EdgeMachineDiskJob>;

  /** Create or update a disk job. */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeMachineDiskJob>;

  /** Delete a disk job. */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachineDiskJob>;
}

// ==================== Disk Models ====================

/**
 * Properties of a disk.
 */
@added(Versions.v2026_03_15_preview)
model EdgeMachineDiskProperties {
  /** The authoritative desired configuration for this disk. */
  diskConfiguration?: DiskConfiguration;

  /** The actual state of the disk as reported by the device. */
  @visibility(Lifecycle.Read)
  reportedProperties?: DiskReportedProperties;

  /** Provisioning state of the disk resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Desired configuration for a disk.
 */
@added(Versions.v2026_03_15_preview)
model DiskConfiguration {
  /** List of desired volumes on this disk. */
  @identifiers(#["path"])
  volumes?: DiskVolumeConfiguration[];
}

/**
 * Configuration for a volume on a disk.
 */
@added(Versions.v2026_03_15_preview)
model DiskVolumeConfiguration {
  /** Size of the volume in bytes. */
  sizeInBytes: int64;

  /** Mount path for the volume (e.g., /data or D:\data). */
  path: string;

  /** File system type to format the volume with. */
  fileSystem?: DiskFileSystemType;
}

/**
 * File system types supported for volumes.
 */
@added(Versions.v2026_03_15_preview)
union DiskFileSystemType {
  string,

  /** ext4 file system (Linux). */
  ext4: "ext4",

  /** xfs file system (Linux). */
  xfs: "xfs",

  /** NTFS file system (Windows). */
  NTFS: "NTFS",

  /** ReFS file system (Windows). */
  ReFS: "ReFS",
}

/**
 * The actual state of the disk as reported by the device.
 */
@added(Versions.v2026_03_15_preview)
model DiskReportedProperties {
  /** The actual disk name as reported by the OS. */
  @visibility(Lifecycle.Read)
  diskName?: string;

  /** Model number of the hardware. */
  @visibility(Lifecycle.Read)
  `model`?: string;

  /** The manufacturer of the disk. */
  @visibility(Lifecycle.Read)
  manufacturer?: string;

  /** Serial number. */
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  /** Firmware version. */
  @visibility(Lifecycle.Read)
  firmwareVersion?: string;

  /** Size in bytes. */
  @visibility(Lifecycle.Read)
  sizeInBytes?: int64;

  /** Type of the disk. */
  @visibility(Lifecycle.Read)
  diskType?: DiskType;

  /** Bus location of the disk. */
  @visibility(Lifecycle.Read)
  busLocation?: string;

  /** Unallocated space on the disk in bytes. */
  @visibility(Lifecycle.Read)
  unallocatedSizeInBytes?: int64;

  /** Current state of the disk. */
  @visibility(Lifecycle.Read)
  state?: DiskState;

  /** List of volumes on this disk. */
  @visibility(Lifecycle.Read)
  @identifiers(#["volumeId"])
  volumes?: DiskVolumeReportedProperties[];
}

/**
 * Type of disk.
 */
@added(Versions.v2026_03_15_preview)
union DiskType {
  string,

  /** Unknown disk type. */
  Unknown: "Unknown",

  /** Storage Class Memory disk. */
  SCM: "SCM",

  /** NVMe disk. */
  NVMe: "NVMe",

  /** SATA disk. */
  SATA: "SATA",

  /** Solid State Drive. */
  SSD: "SSD",

  /** Hard Disk Drive. */
  HDD: "HDD",

  /** Virtual disk. */
  Virtual: "Virtual",

  /** Other disk type. */
  Other: "Other",
}

/**
 * State of the disk.
 */
@added(Versions.v2026_03_15_preview)
union DiskState {
  string,

  /** Disk is online and available. */
  Online: "Online",

  /** Disk is offline. */
  Offline: "Offline",

  /** Disk has failed. */
  Failed: "Failed",

  /** Disk is missing. */
  Missing: "Missing",

  /** Disk state is unknown. */
  Unknown: "Unknown",
}

/**
 * Reported properties of a volume on the disk.
 */
@added(Versions.v2026_03_15_preview)
model DiskVolumeReportedProperties {
  /** Unique identifier for the volume. */
  @visibility(Lifecycle.Read)
  volumeId?: string;

  /** Volume/partition number. */
  @visibility(Lifecycle.Read)
  volumeNumber?: int32;

  /** Size of the volume in bytes. */
  @visibility(Lifecycle.Read)
  sizeInBytes?: int64;

  /** Mount path for the volume. */
  @visibility(Lifecycle.Read)
  path?: string;

  /** File system type. */
  @visibility(Lifecycle.Read)
  fileSystem?: string;
}

// ==================== Volume Models ====================

/**
 * Properties of a volume.
 */
@added(Versions.v2026_03_15_preview)
model EdgeMachineVolumeProperties {
  /** Desired configuration for this volume. */
  volumeConfiguration?: VolumeConfiguration;

  /** The actual state of the volume as reported by the device. */
  @visibility(Lifecycle.Read)
  reportedProperties?: VolumeReportedProperties;

  /** Provisioning state of the volume resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Desired configuration for a volume. Reserved for future use.
 */
@added(Versions.v2026_03_15_preview)
model VolumeConfiguration {
  /** Reserved for future volume configuration options. */
  reserved?: string;
}

/**
 * The actual state of the volume as reported by the device.
 */
@added(Versions.v2026_03_15_preview)
model VolumeReportedProperties {
  /** Unique identifier for the partition. */
  @visibility(Lifecycle.Read)
  partitionId?: string;

  /** Byte offset of the partition start. */
  @visibility(Lifecycle.Read)
  offsetInBytes?: int64;

  /** Label of the volume. */
  @visibility(Lifecycle.Read)
  name?: string;

  /** Access path for the volume. */
  @visibility(Lifecycle.Read)
  path?: string;

  /** ARM resource ID of the parent disk. */
  @visibility(Lifecycle.Read)
  parentDiskId?: string;

  /** Indicates if this volume is a boot volume. */
  @visibility(Lifecycle.Read)
  isBoot?: boolean;

  /** Total size of the volume in bytes. */
  @visibility(Lifecycle.Read)
  sizeInBytes?: int64;

  /** Available space on the volume in bytes. */
  @visibility(Lifecycle.Read)
  sizeRemainingInBytes?: int64;

  /** File system on the volume. */
  @visibility(Lifecycle.Read)
  fileSystem?: string;
}

// ==================== DiskJob Models ====================

/**
 * Disk Job properties.
 */
@added(Versions.v2026_03_15_preview)
@discriminator("jobType")
model EdgeMachineDiskJobProperties {
  /** Job Type to support polymorphic resource. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  jobType: DiskJobType;

  /** Job provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** Unique, immutable job id. */
  @visibility(Lifecycle.Read)
  jobId?: string;

  /** The UTC date and time at which the job started. */
  @visibility(Lifecycle.Read)
  startTimeUtc?: utcDateTime;

  /** The UTC date and time at which the job completed. */
  @visibility(Lifecycle.Read)
  endTimeUtc?: utcDateTime;

  /** Status of disk job. */
  @visibility(Lifecycle.Read)
  status?: DiskJobStatus;

  /** Error details if job failed. */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.Foundations.ErrorDetail;

  /** Properties reported by the job execution. */
  @visibility(Lifecycle.Read)
  reportedProperties?: DiskJobReportedProperties;
}

/**
 * Job Type supported for disk operations.
 */
@added(Versions.v2026_03_15_preview)
union DiskJobType {
  string,

  /** Job to create a volume on the disk. */
  CreateVolume: "CreateVolume",

  /** Job to delete a volume from the disk. */
  DeleteVolume: "DeleteVolume",

  /** Job to resolve configuration drift between desired and reported state. */
  SyncConfiguration: "SyncConfiguration",
}

/**
 * Status of the job execution.
 */
@added(Versions.v2026_03_15_preview)
union DiskJobStatus {
  string,

  /** Job has not started. */
  NotStarted: "NotStarted",

  /** Job is currently running. */
  Running: "Running",

  /** Job completed successfully. */
  Succeeded: "Succeeded",

  /** Job failed. */
  Failed: "Failed",

  /** Job was canceled. */
  Canceled: "Canceled",
}

/**
 * Reported properties of a disk job.
 */
@added(Versions.v2026_03_15_preview)
model DiskJobReportedProperties {
  /** Percentage of job completion. */
  @visibility(Lifecycle.Read)
  percentComplete?: int32;
}

/**
 * Properties for creating a volume on a disk.
 */
@added(Versions.v2026_03_15_preview)
model CreateVolumeJobProperties extends EdgeMachineDiskJobProperties {
  /** Job type. */
  jobType: DiskJobType.CreateVolume;

  /** Size of the volume to create in bytes. */
  sizeInBytes: int64;

  /** Absolute path where the volume should be mounted. */
  path: string;

  /** File system type to format the volume with. */
  @visibility(Lifecycle.Create)
  fileSystem?: DiskFileSystemType;

  /** ARM resource ID of the created volume. */
  @visibility(Lifecycle.Read)
  createdVolumeId?: string;
}

/**
 * Properties for deleting a volume from a disk.
 */
@added(Versions.v2026_03_15_preview)
model DeleteVolumeJobProperties extends EdgeMachineDiskJobProperties {
  /** Job type. */
  jobType: DiskJobType.DeleteVolume;

  /** The mount path of the volume to delete. */
  volumePath: string;

  /** Confirmation flag that must be set to true to proceed with deletion. */
  confirmDeletion?: boolean = false;
}

/**
 * Properties for resolving configuration drift.
 */
@added(Versions.v2026_03_15_preview)
model SyncConfigurationJobProperties extends EdgeMachineDiskJobProperties {
  /** Job type. */
  jobType: DiskJobType.SyncConfiguration;

  /** The strategy to use for resolving the configuration drift. */
  @visibility(Lifecycle.Create)
  resolutionStrategy: ResolutionStrategy;

  /** Details of the detected drift. */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  driftDetails?: DriftDetail[];
}

/**
 * Strategy for resolving configuration drift.
 */
@added(Versions.v2026_03_15_preview)
union ResolutionStrategy {
  string,

  /** Trust Cloud. Push the desiredConfiguration down to the device. */
  ApplyDesired: "ApplyDesired",

  /** Trust Device. Update the desiredConfiguration in ARM to match the reported state. */
  AcceptReported: "AcceptReported",
}

/**
 * Describes a single drift discrepancy between desired and reported state.
 */
@added(Versions.v2026_03_15_preview)
model DriftDetail {
  /** The type of drift detected. */
  @visibility(Lifecycle.Read)
  driftType?: DriftType;

  /** Property name that has drifted (for PropertyMismatch). */
  @visibility(Lifecycle.Read)
  propertyName?: string;

  /** Desired value (for PropertyMismatch). */
  @visibility(Lifecycle.Read)
  desiredValue?: string;

  /** Reported value (for PropertyMismatch). */
  @visibility(Lifecycle.Read)
  reportedValue?: string;
}

/**
 * Type of drift detected.
 */
@added(Versions.v2026_03_15_preview)
union DriftType {
  string,

  /** A volume exists in desiredConfiguration but is not present on the device. */
  MissingOnDevice: "MissingOnDevice",

  /** A volume exists on the device but is not present in desiredConfiguration. */
  ExtraOnDevice: "ExtraOnDevice",

  /** A property value differs between desired and reported state. */
  PropertyMismatch: "PropertyMismatch",
}
