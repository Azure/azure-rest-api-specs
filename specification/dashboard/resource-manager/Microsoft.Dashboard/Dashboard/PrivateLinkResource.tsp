import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedGrafana.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Dashboard;
/**
 * A private link resource
 */
@parentResource(ManagedGrafana)
model PrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResource,
    KeyName = "privateLinkResourceName",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Get specific private link resource information for this grafana resource
   */
  get is ArmResourceRead<PrivateLinkResource>;

  /**
   * List all private link resources information for this grafana resource
   */
  list is ArmResourceListByParent<PrivateLinkResource>;
}

@@doc(PrivateLinkResource.name, "");
@@doc(PrivateLinkResource.properties, "Resource properties.");
