import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.FrontDoor;
@doc("Defines web application firewall policy.")
model WebApplicationFirewallPolicy
  is TrackedResource<WebApplicationFirewallPolicyProperties> {
  @doc("The name of the Web Application Firewall Policy.")
  @maxLength(128)
  @key("policyName")
  @segment("FrontDoorWebApplicationFirewallPolicies")
  name: string;

  @doc("Gets a unique read-only string that changes whenever the resource is updated.")
  etag?: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Policies {
  @doc("Retrieve protection policy with specified name within a resource group.")
  get is ArmResourceRead<WebApplicationFirewallPolicy>;
  @doc("Create or update policy with specified rule set name within a resource group.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<WebApplicationFirewallPolicy>;
  @doc("Patch a specific frontdoor webApplicationFirewall policy for tags update under the specified subscription and resource group.")
  update is ArmCustomPatchAsync<WebApplicationFirewallPolicy, TagsObject>;
  @doc("Deletes Policy")
  delete is ArmResourceDeleteAsync<WebApplicationFirewallPolicy>;
  @doc("Lists all of the protection policies within a resource group.")
  list is ArmResourceListByParent<WebApplicationFirewallPolicy>;
}
