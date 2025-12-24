import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.AzureStackHCI;

/**
 * Cluster Jobs resource
 */
@removed(Versions.v2025_12_01_preview)
@parentResource(Cluster)
model ClusterJob is Azure.ResourceManager.ProxyResource<ClusterJobProperties> {
  ...ResourceNameParameter<
    Resource = ClusterJob,
    KeyName = "jobsName",
    SegmentName = "jobs",
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;
}

/**
 * ClusterJobs operations
 */
@removed(Versions.v2025_12_01_preview)
@armResourceOperations
interface ClusterJobs {
  /** Get a ClusterJob */
  get is ArmResourceRead<ClusterJob>;

  /** Create a ClusterJob */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ClusterJob>;

  /** Delete a ClusterJob */
  delete is ArmResourceDeleteWithoutOkAsync<ClusterJob>;

  /** List ClusterJob resources by Clusters */
  list is ArmResourceListByParent<
    ClusterJob,
    Response = ArmResponse<ClusterJobListResult>
  >;
}

/** ClusterJob Type supported. */
@removed(Versions.v2025_12_01_preview)
union HciJobType {
  string,

  /** Job to configure arc gateway for the cluster. */
  ConfigureArcGateway: "ConfigureArcGateway",

  GpuCreatePartition: "GpuCreatePartition",
  GpuSwitchMode: "GpuSwitchMode",
}

/** Cluster Job properties */
@removed(Versions.v2025_12_01_preview)
@discriminator("jobType")
model ClusterJobProperties {
  /** Job Type to support polymorphic resource. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  jobType: HciJobType;

  /** Deployment mode to trigger job. */
  deploymentMode?: DeploymentMode = DeploymentMode.Deploy;

  /** Job provisioning state */
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

  /** Status of Cluster job. */
  @visibility(Lifecycle.Read)
  status?: JobStatus;

  /** Reported properties for job */
  @visibility(Lifecycle.Read)
  reportedProperties?: JobReportedProperties;
}

@@doc(ClusterJob.name, "Name of ClusterJob");

/**
 * List of Cluster Job resources for the HCI cluster.
 */
@removed(Versions.v2025_12_01_preview)
model ClusterJobListResult is Azure.Core.Page<ClusterJob>;

/** Properties for configuring arc gateway to a cluster. */
@removed(Versions.v2025_12_01_preview)
model HciConfigureArcGatewayJobProperties extends ClusterJobProperties {
  /** ClusterJob Type to support polymorphic resource. */
  jobType: HciJobType.ConfigureArcGateway;
}

/**
 * Properties for creating GPU partitions for virtualization and workload isolation.
 */
@removed(Versions.v2025_12_01_preview)
model GpuCreatePartitionJobProperties extends ClusterJobProperties {
  /** ClusterJob Type to support polymorphic resource. */
  jobType: HciJobType.GpuCreatePartition;

  /**
   * Number of partitions to be created on the GPU.
   */
  partitionCount: int32;
}

/**
 * Properties for switching GPU mode between DDA and GPU-P for different workload requirements.
 */
@removed(Versions.v2025_12_01_preview)
model GpuSwitchModeJobProperties extends ClusterJobProperties {
  /** ClusterJob Type to support polymorphic resource. */
  jobType: HciJobType.GpuSwitchMode;

  /**
   * Desired GPU mode to switch to.
   */
  mode: GpuMode;
}

/**
 * GPU modes supported.
 */
@removed(Versions.v2025_12_01_preview)
union GpuMode {
  string,

  /** Unknown mode. */
  Unknown: "Unknown",

  /** GPU-P mode. */
  GPUP: "GPUP",

  /** DDA mode. */
  DDA: "DDA",
}
