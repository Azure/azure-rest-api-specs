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
@doc("Represents a cluster firewall rule.")
@parentResource(Cluster)
model FirewallRule is ProxyResource<FirewallRuleProperties> {
  @doc("The name of the cluster firewall rule.")
  @pattern("^[-\\w\\._]+$")
  @path
  @key("firewallRuleName")
  @segment("firewallRules")
  name: string;
}

@armResourceOperations
interface FirewallRules {
  @doc("Gets information about a cluster firewall rule.")
  get is ArmResourceRead<FirewallRule>;

  @doc("Creates a new cluster firewall rule or updates an existing cluster firewall rule.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    FirewallRule,
    BaseParameters<FirewallRule>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes a cluster firewall rule.")
  delete is ArmResourceDeleteWithoutOkAsync<
    FirewallRule,
    BaseParameters<FirewallRule>,
    ArmLroLocationHeader
  >;

  @doc("Lists all the firewall rules on cluster.")
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
