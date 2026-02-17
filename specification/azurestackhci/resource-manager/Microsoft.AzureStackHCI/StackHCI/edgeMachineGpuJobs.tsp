import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./edgeMachineGpu.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.AzureStackHCI;

/**
 * Details of a GPU Job on an Edge Machine GPU.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
@added(Versions.v2026_03_15_preview)
@parentResource(EdgeMachineGpu)
model EdgeMachineGpuJob
  is Azure.ResourceManager.ProxyResource<EdgeMachineGpuJobProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachineGpuJob,
    KeyName = "jobsName",
    SegmentName = "jobs",
    NamePattern = "^[a-zA-Z0-9-_]{3,512}$"
  >;
}

/**
 * CRUD + List operations for Edge Machine GPU Jobs.
 */
@added(Versions.v2026_03_15_preview)
@armResourceOperations
interface EdgeMachineGpuJobs {
  /**
   * Get a specific GPU Job on an Edge Machine GPU.
   */
  get is ArmResourceRead<EdgeMachineGpuJob>;

  /**
   * Create or update a GPU Job on an Edge Machine GPU.
   */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeMachineGpuJob>;

  /**
   * Delete a specific GPU Job on an Edge Machine GPU.
   */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachineGpuJob>;

  /**
   * List EdgeMachineGpuJob resources by EdgeMachineGpu
   */
  list is ArmResourceListByParent<EdgeMachineGpuJob>;
}

@@doc(EdgeMachineGpuJob.name, "Name of EdgeMachineGpuJob");

////////////////////models////////////////////

/**
 *EdgeMachine GPU Job properties
 */
@added(Versions.v2026_03_15_preview)
@discriminator("jobType")
model EdgeMachineGpuJobProperties {
  /**
   * The ID of the GPU on which the job is to be performed.
   */
  @visibility(Lifecycle.Read)
  gpuId?: string;

  /**
   * Type of GPU job to be performed.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  jobType: EdgeMachineGpuJobType;

  /**
   * Deployment mode for the GPU job.
   */
  deploymentMode?: DeploymentMode;

  /**
   * Job provisioning state
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Unique, immutable job id.
   */
  @visibility(Lifecycle.Read)
  jobId?: string;

  /**
   * The UTC date and time at which the job started.
   */
  @visibility(Lifecycle.Read)
  startTimeUtc?: utcDateTime;

  /**
   * The UTC date and time at which the job completed.
   */
  @visibility(Lifecycle.Read)
  endTimeUtc?: utcDateTime;

  /**
   * Status of GPU job.
   */
  @visibility(Lifecycle.Read)
  status?: JobStatus;

  /**
   * Error details.
   */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.Foundations.ErrorDetail;

  /**
   * Reported properties specific to the GPU job.
   */
  @visibility(Lifecycle.Read)
  reportedProperties?: JobReportedProperties;
}

/**
 * GPU Job Type supported for Edge Machine GPU operations.
 */
@added(Versions.v2026_03_15_preview)
union EdgeMachineGpuJobType {
  string,

  /**
   * Create GPU partitions for virtualization and workload isolation.
   */
  CreatePartition: "CreatePartition",

  /**
   * Switch GPU mode between DDA and GPU-P for different workload requirements.
   */
  SwitchMode: "SwitchMode",

  /**
   * Assign GPU partition to a specific workload or virtual machine.
   */
  AssignPartition: "AssignPartition",

  /**
   * Remove GPU partition and free up resources for other workloads.
   */
  RemovePartition: "RemovePartition",
}

/**
 * Properties for creating GPU partitions for virtualization and workload isolation.
 */
@added(Versions.v2026_03_15_preview)
model CreatePartitionGpuJobProperties extends EdgeMachineGpuJobProperties {
  /**
   * Type of GPU job to be performed.
   */
  jobType: EdgeMachineGpuJobType.CreatePartition;

  /**
   * Number of partitions to be created on the GPU.
   */
  partitionCount: int32;
}

/**
 * Properties for switching GPU mode between DDA and GPU-P for different workload requirements.
 */
@added(Versions.v2026_03_15_preview)
model SwitchModeGpuJobProperties extends EdgeMachineGpuJobProperties {
  /**
   * Type of GPU job to be performed.
   */
  jobType: EdgeMachineGpuJobType.SwitchMode;

  /**
   * Desired GPU mode to switch to.
   */
  mode: GpuMode;
}

/**
 * Properties for assigning GPU partition to a specific workload or virtual machine.
 */
@added(Versions.v2026_03_15_preview)
model AssignPartitionGpuJobProperties extends EdgeMachineGpuJobProperties {
  /**
   * Type of GPU job to be performed.
   */
  jobType: EdgeMachineGpuJobType.AssignPartition;

  /**
   * Virtual machine ID to which the GPU partition is assigned.
   */
  vmId: string;
}

/**
 * Properties for removing GPU partition and freeing up resources for other workloads.
 */
@added(Versions.v2026_03_15_preview)
model RemovePartitionGpuJobProperties extends EdgeMachineGpuJobProperties {
  /**
   * Type of GPU job to be performed.
   */
  jobType: EdgeMachineGpuJobType.RemovePartition;

  /**
   * Virtual machine ID from which the GPU partition is removed.
   */
  vmId: string;
}
