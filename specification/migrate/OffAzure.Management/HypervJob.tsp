import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HypervSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * A job resource belonging to a site resource.
 */
@parentResource(HypervSite)
model HypervJob is Azure.ResourceManager.ProxyResource<JobProperties> {
  ...ResourceNameParameter<
    Resource = HypervJob,
    KeyName = "jobName",
    SegmentName = "jobs"
  >;
}

@armResourceOperations
interface HypervJobs {
  /**
   * Get a HypervJob
   */
  get is ArmResourceRead<HypervJob>;

  /**
   * List HypervJob resources by HypervSite
   */
  listByHypervSite is ArmResourceListByParent<HypervJob>;
}

@@doc(HypervJob.name, " Job name");
@@doc(HypervJob.properties,
  "The resource-specific properties for this resource."
);
