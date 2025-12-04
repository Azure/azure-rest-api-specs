import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

/**
 * Details of a GPU Job on an Edge Machine GPU.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
@parentResource(EdgeMachineGpu)
model EdgeMachineGpuJob
  is Azure.ResourceManager.ProxyResource<EdgeMachineGpuJobProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachineGpuJob,
    KeyName = "jobsName",
    SegmentName = "jobs",
    NamePattern = "^[a-zA-Z0-9-_]{3,63}$"
  >;
}

/**
 * CRUD + List operations for Edge Machine GPU Jobs.
 */
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
@discriminator("jobType")
model EdgeMachineGpuJobProperties {
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
}

/**
 * GPU Job Type supported for Edge Machine GPU operations.
 */
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
model CreatePartitionGpuJobProperties extends EdgeMachineGpuJobProperties {
  /**
   * Type of GPU job to be performed.
   */
  jobType: EdgeMachineGpuJobType.CreatePartition;
}

/**
 * Properties for switching GPU mode between DDA and GPU-P for different workload requirements.
 */
model SwitchModeGpuJobProperties extends EdgeMachineGpuJobProperties {
  /**
   * Type of GPU job to be performed.
   */
  jobType: EdgeMachineGpuJobType.SwitchMode;
}

/**
 * Properties for assigning GPU partition to a specific workload or virtual machine.
 */
model AssignPartitionGpuJobProperties extends EdgeMachineGpuJobProperties {
  /**
   * Type of GPU job to be performed.
   */
  jobType: EdgeMachineGpuJobType.AssignPartition;
}

/**
 * Properties for removing GPU partition and freeing up resources for other workloads.
 */
model RemovePartitionGpuJobProperties extends EdgeMachineGpuJobProperties {
  /**
   * Type of GPU job to be performed.
   */
  jobType: EdgeMachineGpuJobType.RemovePartition;
}
