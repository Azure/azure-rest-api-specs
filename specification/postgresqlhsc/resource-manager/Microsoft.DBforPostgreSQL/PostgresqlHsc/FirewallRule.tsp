import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;
/**
 * Represents a cluster firewall rule.
 */
@parentResource(Cluster)
model FirewallRule
  is Azure.ResourceManager.ProxyResource<FirewallRuleProperties, false> {
  ...ResourceNameParameter<
    Resource = FirewallRule,
    KeyName = "firewallRuleName",
    SegmentName = "firewallRules",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface FirewallRules {
  /**
   * Gets information about a cluster firewall rule.
   */
  get is ArmResourceRead<FirewallRule>;

  /**
   * Creates a new cluster firewall rule or updates an existing cluster firewall rule.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FirewallRule,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = FirewallRule> &
      ArmLroLocationHeader<FinalResult = FirewallRule>
  >;

  /**
   * Deletes a cluster firewall rule.
   */
  @Azure.Core.useFinalStateVia("location")
  delete is ArmResourceDeleteWithoutOkAsync<
    FirewallRule,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = FirewallRule> &
      ArmLroLocationHeader<FinalResult = FirewallRule>
  >;

  /**
   * Lists all the firewall rules on cluster.
   */
  listByCluster is ArmResourceListByParent<
    FirewallRule,
    Response = ArmResponse<ResourceListResult<FirewallRule>>
  >;
}

@@doc(FirewallRule.name, "The name of the cluster firewall rule.");
@@doc(FirewallRule.properties, "The properties of a firewall rule.");
@@doc(FirewallRules.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating a firewall rule."
);
