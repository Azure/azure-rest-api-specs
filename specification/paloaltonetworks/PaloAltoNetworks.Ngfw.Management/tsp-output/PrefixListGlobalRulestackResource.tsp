import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./GlobalRulestackResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.PaloAltoNetworks.Ngfw;
@doc("GlobalRulestack prefixList")
@parentResource(GlobalRulestackResource)
model PrefixListGlobalRulestackResource is ProxyResource<PrefixObject> {
  @doc("Local Rule priority")
  @key("name")
  @segment("prefixlists")
  name: string;
}

@armResourceOperations
interface PrefixListGlobalRulestack {
  @doc("Get a PrefixListGlobalRulestackResource")
  get is ArmResourceRead<PrefixListGlobalRulestackResource>;
  @doc("Create a PrefixListGlobalRulestackResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PrefixListGlobalRulestackResource>;
  @doc("Delete a PrefixListGlobalRulestackResource")
  delete is ArmResourceDeleteAsync<PrefixListGlobalRulestackResource>;
  @doc("List PrefixListGlobalRulestackResource resources by Tenant")
  list is ArmResourceListByParent<PrefixListGlobalRulestackResource>;
}
