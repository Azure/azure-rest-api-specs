import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Cdn;
@doc("Defines web application firewall policy for Azure CDN.")
model CdnWebApplicationFirewallPolicy
  is TrackedResource<CdnWebApplicationFirewallPolicyProperties> {
  @doc("The name of the CdnWebApplicationFirewallPolicy.")
  @maxLength(128)
  @path
  @key("policyName")
  @segment("cdnWebApplicationFirewallPolicies")
  name: string;

  @doc("Gets a unique read-only string that changes whenever the resource is updated.")
  etag?: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Policies {
  @doc("Retrieve protection policy with specified name within a resource group.")
  get is ArmResourceRead<CdnWebApplicationFirewallPolicy>;
  @doc("Create or update policy with specified rule set name within a resource group.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CdnWebApplicationFirewallPolicy>;
  @doc("Update an existing CdnWebApplicationFirewallPolicy with the specified policy name under the specified subscription and resource group")
  update is ArmTagsPatchAsync<CdnWebApplicationFirewallPolicy>;
  @doc("Deletes Policy")
  delete is ArmResourceDeleteSync<CdnWebApplicationFirewallPolicy>;
  @doc("Lists all of the protection policies within a resource group.")
  list is ArmResourceListByParent<CdnWebApplicationFirewallPolicy>;
}
