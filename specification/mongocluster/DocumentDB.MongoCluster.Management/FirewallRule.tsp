import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./common.tsp";
import "./MongoCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DocumentDB;
@doc("Represents a mongo cluster firewall rule.")
@parentResource(MongoCluster)
model FirewallRule is ProxyResource<FirewallRuleProperties> {
  @doc("The name of the mongo cluster firewall rule.")
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z0-9][-_.a-zA-Z0-9]*")
  @key("firewallRuleName")
  @segment("firewallRules")
  @visibility("read")
  @path
  name: string;
}

@doc("The properties of a mongo cluster firewall rule.")
model FirewallRuleProperties {
  @doc("The provisioning state of the firewall rule.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The start IP address of the mongo cluster firewall rule. Must be IPv4 format.")
  @pattern("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$")
  startIpAddress: string;

  @doc("The end IP address of the mongo cluster firewall rule. Must be IPv4 format.")
  @pattern("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$")
  endIpAddress: string;
}

@armResourceOperations
interface FirewallRules {
  @doc("Gets information about a mongo cluster firewall rule.")
  get is ArmResourceRead<FirewallRule>;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Need to support existing 202 response for PUT operations"
  @doc("Creates a new firewall rule or updates an existing firewall rule on a mongo cluster.")
  createOrUpdate is Operations.ArmResourceCreateOrUpdateWithAcceptedAsync<FirewallRule>;
  @doc("Deletes a mongo cluster firewall rule.")
  delete is ArmResourceDeleteWithoutOkAsync<FirewallRule>;
  @doc("List all the firewall rules in a given mongo cluster.")
  listByParent is ArmResourceListByParent<FirewallRule>;
}
