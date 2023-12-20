import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./GlobalRulestack.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.PaloAltoNetworks.Ngfw;
@doc("GlobalRulestack fqdnList")
@parentResource(GlobalRulestack)
model GlobalRulestackFqdn is ProxyResource<FqdnObject> {
  @doc("fqdn list name")
  @path
  @key("name")
  @segment("fqdnlists")
  name: string;
}

@armResourceOperations
interface GlobalRulestackFqdns {
  @doc("Get a FqdnListGlobalRulestackResource")
  get is ArmResourceRead<GlobalRulestackFqdn>;
  @doc("Create a FqdnListGlobalRulestackResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GlobalRulestackFqdn>;
  @doc("Delete a FqdnListGlobalRulestackResource")
  delete is ArmResourceDeleteAsync<GlobalRulestackFqdn>;
  @doc("List FqdnListGlobalRulestackResource resources by Tenant")
  list is ArmResourceListByParent<GlobalRulestackFqdn>;
}
