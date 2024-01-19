import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FirewallResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PaloAltoNetworks.Cloudngfw;
@doc("Firewall Status")
@singleton("default")
@parentResource(FirewallResource)
model FirewallStatusResource is ProxyResource<FirewallStatusProperty> {
  @key("status")
  @segment("statuses")
  name: string;
}

@armResourceOperations
interface FirewallStatusResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a FirewallStatusResource")
  @operationId("FirewallStatus_Get")
  get is ArmResourceRead<FirewallStatusResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List FirewallStatusResource resources by Firewalls")
  @operationId("FirewallStatus_ListByFirewalls")
  listByFirewalls is ArmResourceListByParent<FirewallStatusResource>;
}
