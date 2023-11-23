import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./LocalRulestackResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace PaloAltoNetworks.Cloudngfw;
@doc("LocalRulestack fqdnList")
@parentResource(LocalRulestackResource)
model FqdnListLocalRulestackResource is ProxyResource<FqdnObject> {
  @doc("fqdn list name")
  @path
  @key("name")
  @segment("fqdnlists")
  name: string;
}

@armResourceOperations
interface FqdnListLocalRulestackResources {
  @doc("Get a FqdnListLocalRulestackResource")
  get is ArmResourceRead<FqdnListLocalRulestackResource>;
  @doc("Create a FqdnListLocalRulestackResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<FqdnListLocalRulestackResource>;
  @doc("Delete a FqdnListLocalRulestackResource")
  delete is ArmResourceDeleteAsync<FqdnListLocalRulestackResource>;
  @doc("List FqdnListLocalRulestackResource resources by LocalRulestacks")
  listByLocalRulestacks is ArmResourceListByParent<FqdnListLocalRulestackResource>;
}
