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
@added(Versions.v2026_03_01_preview)
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
@added(Versions.v2026_03_01_preview)
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

/** Cluster Job properties */
@added(Versions.v2026_03_01_preview)
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
@added(Versions.v2026_03_01_preview)
model ClusterJobListResult is Azure.Core.Page<ClusterJob>;
