import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataLakeAnalyticsAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataLakeAnalytics;
@doc("Data Lake Analytics firewall rule information.")
@parentResource(DataLakeAnalyticsAccount)
model DataLakeAnalyticsFirewallRule is ProxyResource<FirewallRuleProperties> {
  @doc("The name of the firewall rule to retrieve.")
  @path
  @key("firewallRuleName")
  @segment("firewallRules")
  name: string;
}

@armResourceOperations
interface DataLakeAnalyticsFirewallRules {
  @doc("Gets the specified Data Lake Analytics firewall rule.")
  get is ArmResourceRead<DataLakeAnalyticsFirewallRule>;
  @doc("Creates or updates the specified firewall rule. During update, the firewall rule with the specified name will be replaced with this new firewall rule.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DataLakeAnalyticsFirewallRule>;
  @doc("Updates the specified firewall rule.")
  update is ArmResourcePatchSync<
    DataLakeAnalyticsFirewallRule,
    FirewallRuleProperties
  >;
  @doc("Deletes the specified firewall rule from the specified Data Lake Analytics account")
  delete is ArmResourceDeleteSync<DataLakeAnalyticsFirewallRule>;
  @doc("Lists the Data Lake Analytics firewall rules within the specified Data Lake Analytics account.")
  listByAccount is ArmResourceListByParent<DataLakeAnalyticsFirewallRule>;
}
