import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CosmosDBForPostgreSql;
@doc("Represents a cluster firewall rule.")
@parentResource(Cluster)
model FirewallRule is ProxyResource<FirewallRuleProperties> {
  @doc("The name of the cluster firewall rule.")
  @pattern("^[-\\w\\._]+$")
  @key("firewallRuleName")
  @segment("firewallRules")
  name: string;
}

@armResourceOperations
interface FirewallRules {
  @doc("Gets information about a cluster firewall rule.")
  get is ArmResourceRead<FirewallRule>;
  @doc("Creates a new cluster firewall rule or updates an existing cluster firewall rule.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<FirewallRule>;
  @doc("Deletes a cluster firewall rule.")
  delete is ArmResourceDeleteWithoutOkAsync<FirewallRule>;
  @doc("Lists all the firewall rules on cluster.")
  listByCluster is ArmResourceListByParent<FirewallRule>;
}
