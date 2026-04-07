import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FirewallResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PaloAltoNetworks.Cloudngfw;
/**
 * Firewall Status
 */
@singleton("default")
@parentResource(FirewallResource)
model FirewallStatusResource
  is Azure.ResourceManager.ProxyResource<FirewallStatusProperty, false> {
  ...ResourceNameParameter<
    Resource = FirewallStatusResource,
    KeyName = "status",
    SegmentName = "statuses",
    NamePattern = ""
  >;
}

@armResourceOperations
interface FirewallStatusResources {
  /**
   * Get a FirewallStatusResource
   */
  get is ArmResourceRead<FirewallStatusResource>;

  /**
   * List FirewallStatusResource resources by Firewalls
   */
  listByFirewalls is ArmResourceListByParent<FirewallStatusResource>;
}

@@doc(FirewallStatusResource.name, "");
@@doc(FirewallStatusResource.properties,
  "The resource-specific properties for this resource."
);
