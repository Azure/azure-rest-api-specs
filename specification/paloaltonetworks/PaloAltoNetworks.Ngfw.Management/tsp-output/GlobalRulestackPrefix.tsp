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
@doc("GlobalRulestack prefixList")
@parentResource(GlobalRulestack)
model GlobalRulestackPrefix is ProxyResource<PrefixObject> {
  @doc("Local Rule priority")
  @path
  @key("name")
  @segment("prefixlists")
  name: string;
}

@armResourceOperations
interface GlobalRulestackPrefixes {
  @doc("Get a PrefixListGlobalRulestackResource")
  get is ArmResourceRead<GlobalRulestackPrefix>;
  @doc("Create a PrefixListGlobalRulestackResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GlobalRulestackPrefix>;
  @doc("Delete a PrefixListGlobalRulestackResource")
  delete is ArmResourceDeleteAsync<GlobalRulestackPrefix>;
  @doc("List PrefixListGlobalRulestackResource resources by Tenant")
  list is ArmResourceListByParent<GlobalRulestackPrefix>;
}
