import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./LocalRulestack.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.PaloAltoNetworks.Ngfw;
@doc("LocalRulestack fqdnList")
@parentResource(LocalRulestack)
model LocalRulestackFqdn is ProxyResource<FqdnObject> {
  @doc("fqdn list name")
  @path
  @key("name")
  @segment("fqdnlists")
  name: string;
}

@armResourceOperations
interface LocalRulestackFqdns {
  @doc("Get a FqdnListLocalRulestackResource")
  get is ArmResourceRead<LocalRulestackFqdn>;
  @doc("Create a FqdnListLocalRulestackResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LocalRulestackFqdn>;
  @doc("Delete a FqdnListLocalRulestackResource")
  delete is ArmResourceDeleteAsync<LocalRulestackFqdn>;
  @doc("List FqdnListLocalRulestackResource resources by LocalRulestacks")
  listByLocalRulestacks is ArmResourceListByParent<LocalRulestackFqdn>;
}
