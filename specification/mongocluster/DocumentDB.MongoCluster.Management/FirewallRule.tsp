using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DocumentDB;

/** Represents a mongo cluster firewall rule. */
@parentResource(MongoCluster)
model FirewallRule is ProxyResource<FirewallRuleProperties> {
  /** The name of the mongo cluster firewall rule. */
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z0-9][-_.a-zA-Z0-9]*")
  @key("firewallRuleName")
  @segment("firewallRules")
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

/** The properties of a mongo cluster firewall rule. */
model FirewallRuleProperties {
  /** The provisioning state of the firewall rule. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The start IP address of the mongo cluster firewall rule. Must be IPv4 format. */
  @pattern("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$")
  startIpAddress: string;

  /** The end IP address of the mongo cluster firewall rule. Must be IPv4 format. */
  @pattern("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$")
  endIpAddress: string;
}

@armResourceOperations
interface FirewallRules {
  /** Gets information about a mongo cluster firewall rule. */
  get is ArmResourceRead<FirewallRule>;
  /** Creates a new firewall rule or updates an existing firewall rule on a mongo cluster. */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST REMOVE AT NEXT API VERSION UPDATE"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Need to support existing 202 response for PUT operations"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FirewallRule,
    Response = ArmResourceUpdatedResponse<FirewallRule> | ArmResourceCreatedResponse<
      FirewallRule,
      LroHeaders = {}
    > | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = FirewallRule> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;
  /** Deletes a mongo cluster firewall rule. */
  delete is ArmResourceDeleteWithoutOkAsync<FirewallRule>;
  /** List all the firewall rules in a given mongo cluster. */
  listByMongoCluster is ArmResourceListByParent<FirewallRule>;
}
