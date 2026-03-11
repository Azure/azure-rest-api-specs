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

@@doc(ClusterJob.name, "Name of ClusterJob");
