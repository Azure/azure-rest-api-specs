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
