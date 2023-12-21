import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataLakeStoreAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataLakeStore;
@doc("Data Lake Store firewall rule information.")
@parentResource(DataLakeStoreAccount)
model FirewallRule is ProxyResource<FirewallRuleProperties> {
  @doc("The name of the firewall rule to retrieve.")
  @path
  @key("firewallRuleName")
  @segment("firewallRules")
  name: string;
}

@armResourceOperations
interface FirewallRules {
  @doc("Gets the specified Data Lake Store firewall rule.")
  get is ArmResourceRead<FirewallRule>;
  @doc("Creates or updates the specified firewall rule. During update, the firewall rule with the specified name will be replaced with this new firewall rule.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<FirewallRule>;
  @doc("Updates the specified firewall rule.")
  update is ArmResourcePatchSync<FirewallRule, FirewallRuleProperties>;
  @doc("Deletes the specified firewall rule from the specified Data Lake Store account.")
  delete is ArmResourceDeleteSync<FirewallRule>;
  @doc("Lists the Data Lake Store firewall rules within the specified Data Lake Store account.")
  listByAccount is ArmResourceListByParent<FirewallRule>;
}
