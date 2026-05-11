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
 * A cluster resource belonging to a site resource.
 */
@parentResource(HypervSite)
model HypervCluster
  is Azure.ResourceManager.ProxyResource<HypervClusterProperties> {
  ...ResourceNameParameter<
    Resource = HypervCluster,
    KeyName = "clusterName",
    SegmentName = "clusters"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface HypervClusters {
  /**
   * Method to get a Hyper-V cluster.
   */
  @tag("HypervClusterController")
  getCluster is ArmResourceRead<HypervCluster>;

  /**
   * Method to create or update a Hyper-V cluster.
   */
  @tag("HypervClusterController")
  createCluster is ArmResourceCreateOrReplaceAsync<
    HypervCluster,
    LroHeaders = ArmLroLocationHeader<FinalResult = HypervCluster> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a HypervCluster
   */
  @tag("HypervClusterController")
  delete is ArmResourceDeleteSync<HypervCluster>;

  /**
   * List HypervCluster resources by HypervSite
   */
  @tag("HypervClusterController")
  listByHypervSite is ArmResourceListByParent<
    HypervCluster,
    Parameters = {
      /**
       * filter query
       */
      @query("filter")
      filter?: string;
    }
  >;
}

@@doc(HypervCluster.name, " Cluster ARM name");
@@doc(HypervCluster.properties,
  "The resource-specific properties for this resource."
);
