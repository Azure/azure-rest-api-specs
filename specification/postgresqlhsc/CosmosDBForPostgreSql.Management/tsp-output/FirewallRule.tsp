import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;
/**
 * Represents a cluster firewall rule.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Cluster)
@Azure.ResourceManager.Private.armResourceInternal(FirewallRuleProperties)
@includeInapplicableMetadataInPayload(false)
model FirewallRule extends ProxyResourceBase {
  /**
   * The name of the cluster firewall rule.
   */
  @pattern("^[-\\w\\._]+$")
  @path
  @key("firewallRuleName")
  @segment("firewallRules")
  name: string;

  /**
   * The properties of a firewall rule.
   */
  @extension("x-ms-client-flatten", true)
  properties: FirewallRuleProperties;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FirewallRule,
    BaseParameters<FirewallRule>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a cluster firewall rule.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    FirewallRule,
    BaseParameters<FirewallRule>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all the firewall rules on cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FirewallRules_ListByCluster")
  listByCluster is ArmResourceListByParent<FirewallRule>;
}

@@projectedName(FirewallRules.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(FirewallRules.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(FirewallRules.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating a firewall rule."
);
