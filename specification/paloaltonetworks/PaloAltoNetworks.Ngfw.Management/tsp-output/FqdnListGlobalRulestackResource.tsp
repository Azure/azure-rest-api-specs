import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./GlobalRulestackResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace PaloAltoNetworks.Cloudngfw;
@doc("GlobalRulestack fqdnList")
@parentResource(GlobalRulestackResource)
model FqdnListGlobalRulestackResource is ProxyResource<FqdnObject> {
  @doc("fqdn list name")
  @path
  @key("name")
  @segment("fqdnlists")
  name: string;
}

@armResourceOperations
interface FqdnListGlobalRulestackResources {
  @doc("Get a FqdnListGlobalRulestackResource")
  get is ArmResourceRead<FqdnListGlobalRulestackResource>;
  @doc("Create a FqdnListGlobalRulestackResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<FqdnListGlobalRulestackResource>;
  @doc("Delete a FqdnListGlobalRulestackResource")
  delete is ArmResourceDeleteAsync<FqdnListGlobalRulestackResource>;
  @doc("List FqdnListGlobalRulestackResource resources by Tenant")
  list is ArmResourceListByParent<FqdnListGlobalRulestackResource>;
}
