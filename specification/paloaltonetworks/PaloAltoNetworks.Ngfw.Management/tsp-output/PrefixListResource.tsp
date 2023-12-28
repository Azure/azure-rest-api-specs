import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./LocalRulestackResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.PaloAltoNetworks.Ngfw;
@doc("LocalRulestack prefixList")
@parentResource(LocalRulestackResource)
model PrefixListResource is ProxyResource<PrefixObject> {
  @doc("Local Rule priority")
  @key("name")
  @segment("prefixlists")
  name: string;
}

@armResourceOperations
interface PrefixListLocalRulestack {
  @doc("Get a PrefixListResource")
  get is ArmResourceRead<PrefixListResource>;
  @doc("Create a PrefixListResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PrefixListResource>;
  @doc("Delete a PrefixListResource")
  delete is ArmResourceDeleteAsync<PrefixListResource>;
  @doc("List PrefixListResource resources by LocalRulestacks")
  listByLocalRulestacks is ArmResourceListByParent<PrefixListResource>;
}
