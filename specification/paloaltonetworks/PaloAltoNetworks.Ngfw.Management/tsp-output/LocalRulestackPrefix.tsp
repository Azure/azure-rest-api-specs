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
@doc("LocalRulestack prefixList")
@parentResource(LocalRulestack)
model LocalRulestackPrefix is ProxyResource<PrefixObject> {
  @doc("Local Rule priority")
  @path
  @key("name")
  @segment("prefixlists")
  name: string;
}

@armResourceOperations
interface LocalRulestackPrefixes {
  @doc("Get a PrefixListResource")
  get is ArmResourceRead<LocalRulestackPrefix>;
  @doc("Create a PrefixListResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LocalRulestackPrefix>;
  @doc("Delete a PrefixListResource")
  delete is ArmResourceDeleteAsync<LocalRulestackPrefix>;
  @doc("List PrefixListResource resources by LocalRulestacks")
  listByLocalRulestacks is ArmResourceListByParent<LocalRulestackPrefix>;
}
