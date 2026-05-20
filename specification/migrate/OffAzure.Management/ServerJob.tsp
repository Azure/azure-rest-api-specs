import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServerSiteResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * A host resource belonging to a site resource.
 */
@parentResource(ServerSiteResource)
model ServerJob is Azure.ResourceManager.ProxyResource<JobProperties> {
  ...ResourceNameParameter<
    Resource = ServerJob,
    KeyName = "jobName",
    SegmentName = "jobs"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface ServerJobs {
  /**
   * Get a ServerJob
   */
  @tag("ServerJobsController")
  get is ArmResourceRead<ServerJob>;

  /**
   * List ServerJob resources by ServerSiteResource
   */
  @tag("ServerJobsController")
  listByServerSiteResource is ArmResourceListByParent<ServerJob>;
}

@@doc(ServerJob.name, " Jobs name");
@@doc(ServerJob.properties,
  "The resource-specific properties for this resource."
);
