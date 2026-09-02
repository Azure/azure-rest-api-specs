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

namespace Microsoft.DBforPostgreSQL;
/**
 * A private link resource.
 */
@parentResource(Cluster)
model PrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResource,
    KeyName = "privateLinkResourceName",
    SegmentName = "privateLinkResources",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Gets a private link resource for cluster.
   */
  get is ArmResourceRead<PrivateLinkResource>;

  /**
   * Gets the private link resources for cluster.
   */
  listByCluster is ArmResourceListByParent<
    PrivateLinkResource,
    Response = ArmResponse<ResourceListResult<PrivateLinkResource>>
  >;
}

@@doc(PrivateLinkResource.name, "The name of the private link resource.");
@@doc(PrivateLinkResource.properties, "Resource properties.");
